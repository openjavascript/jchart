;(function(define, _win) { 'use strict'; define( [ 
            'JChart.Base'
            , 'JChart.Group'
            , 'JChart.IconVLine'
            , 'JChart.IconCircle'
            , 'JChart.GraphicPiePart'
            , 'JChart.PieLabel'
            ], function(){
/**
 * 柱状图
 *
 *<p><b>require</b>:
 *   <a href='JChart.Base.html'>JChart.Base</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.PieGraph.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.PieGraph/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 span class="jchartPieGraph"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       PieGraph
 * @extends     JChart.Base
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-20
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.PieGraph = PieGraph;

    function PieGraph( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, PieGraph ) ) 
            return JC.BaseMVC.getInstance( _selector, PieGraph );

        JC.BaseMVC.getInstance( _selector, PieGraph, this );

        this._model = new PieGraph.Model( _selector );
        this._view = new PieGraph.View( this._model );

        this._init();

        //JC.dir( this );

        //JC.log( PieGraph.Model._instanceName, 'all inited', new Date().getTime() );
    }
    PieGraph.FLASH_PATH = "{0}/flash/pub/charts/PieGraph.swf";
    /**
     * 初始化可识别的 PieGraph 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of PieGraphInstance}
     */
    PieGraph.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jchartPieGraph' )  ){
                    _r.push( new PieGraph( _selector ) );
                }else{
                    JChart.Base.init( PieGraph, $( 'div.jchartPieGraph' ), 0, 1 );
                }
            }
            return _r;
        };

    PieGraph.CURRENT_INS = null;
    PieGraph.DEFAULT_MOVE =
        function( _evt ){
            if( !PieGraph.CURRENT_INS ){
                _jdoc.off( 'mousemove', PieGraph.DEFAULT_MOVE );
                return;
            }
            var _p = PieGraph.CURRENT_INS;
            _p.trigger( 'update_moving_status', [ _evt ] );
        };

    JC.BaseMVC.build( PieGraph, JChart.Base );

    JC.f.extendObject( PieGraph.prototype, {
        _beforeInit:
            function(){
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'update_moving_status', function( _evt, _srcEvt, _srcEle ){
                    var _offset = _p._model.globalEventToLocalOffset( _srcEvt )
                        , _index = _p._model.indexAt();

                    _p.trigger( 'clear_status' );
                    if( typeof _index == 'undefined' ) return;

                    _p.trigger( 'update_status', [ _index, _offset  ] );
                });

                _p.on( 'moving_start', function( _evt ){
                    _p.trigger( 'clear_status' );
                    _p._model.tips() && _p._model.tips().show();
                });

                _p.on( 'moving_done', function( _evt ){
                    _p.trigger( 'clear_status' );
                    _p._model.tips() && _p._model.tips().hide();
                });

                _p.on( 'clear_status', function(){
                    _p._view.clearStatus();
                });

                _p.on( 'update_status', function( _evt, _index, _offset ){
                    if( !_offset ) return;
                    if( typeof _index == 'undefined' ) return;
                    _p._view.updateTips( _index, _offset );
                });

                _p.on( 'unselected_piepart', function( _evt, _isSelected, _id ){
                    _p._model.piePart() && _p._model.piePart().length &&
                        $.each( _p._model.piePart(), function( _k, _item ){
                            if( _item.id() == _id ) return;
                            _item.selected( false );
                        });
                });

                _p.on( 'update_default_selected', function( _evt ){
                    var _ix;
                    _p._model.getDisplaySeries() && _p._model.getDisplaySeries().length
                        && $.each( _p._model.getDisplaySeries(), function( _k, _item ){
                            _item.selected && ( _ix = _k );
                        });

                    typeof _ix != 'undefined' 
                        && _p._model.piePart() 
                        && _p._model.piePart()[ _ix ]
                        && _p._model.piePart()[ _ix ].selected( true )
                        ;
                });

                _p.on( JChart.Base.Model.RESET_DISPLAY_SERIES, function( _evt, _data ){
                    _p._model.resetDisplaySeries( _data );
                    //JC.log( JChart.Base.Model.RESET_DISPLAY_SERIES, JC.f.ts() );
                });

                _p.on( JChart.Base.Model.LEGEND_UPDATE, function( _evt, _ix ){
                    _p._model.updateLegend( _ix );
                    //JC.log( JChart.Base.Model.LEGEND_UPDATE, _ix, JC.f.ts() );
                });

            }

        , _inited:
            function(){
            }
    });

    PieGraph.Model._instanceName = 'JChartPieGraph';

    var _oldWorkspaceOffset = PieGraph.Model.prototype.workspaceOffset;

    JC.f.extendObject( PieGraph.Model.prototype, {
        init:
            function(){
                JChart.Base.Model.prototype.init.call( this );
            }

        , dataLabelEnabled:
            function(){
                var _p = this, _r = true;

                _p.data() 
                    && _p.data().plotOptions 
                    && _p.data().plotOptions.pie
                    && _p.data().plotOptions.pie.dataLabels
                    && ( 'enabled' in _p.data().plotOptions.pie.dataLabels )
                    && ( _r = _p.data().plotOptions.pie.dataLabels.enabled )
                    ;

                return _r;
            }

        , lineStyle:
            function( _ix ){
                var _r = JC.f.cloneObject( PieGraph.Model.STYLE.lineStyle );
                return _r;
            }

        , indexAt:
            function( _setter ){
                typeof _setter != 'undefined' && ( this._index = _setter );
                return this._index;
            }
        /**
         * 保存图表数据
         */
        , data:
            function( _data ){
                var _p = this;
                if( typeof _data != 'undefined' ){
                    _p._data = _data;
                    //JC.dir( _p._data );
                    _p._data.series && _p._data.series.length && 
                        $.each( _p._data.series[0].data, function( _k, _item ){
                            if( JChart.f.isArray( _item ) ){
                                _p._data.series[0].data[ _k ] = { 'name': _item[0], 'y': _item[1] };
                                _p.getDisplaySeries()[ _k ] = { 'name': _item[0], 'y': _item[1] };
                            }
                        });
                }
                return _p._data;
            }
        , piePart:
            function( _parts ){
                var _p = this;
                if( _parts && typeof this._piePart == 'undefined' ){
                    _p._piePart = [];
                    var _tmp;
                    $.each( _parts, function( _k, _pieCor ){
                        var _ix = _p.displayLegendMap[ _k ]
                            , _style = _p.itemStyle( _ix )
                            , _hoverStyle = _p.itemHoverStyle( _ix )
                            ;

                        _style.stroke = '#fff';
                        _hoverStyle.stroke = '#fff';

                        _tmp = new JChart.GraphicPiePart( _p.stage(), _pieCor, _style, _hoverStyle, _k );
                        _tmp.index( _k );
                        _tmp.on( 'selected_changed', function( _evt, _isSelected, _id ){
                            _p.trigger( 'unselected_piepart', [ _isSelected, _id ] );
                        });

                       _tmp.on( 'mouseenter', function( _evt, _srcEvt, _id, _index ){
                            //JC.log( 'mouseenter', _id, JC.f.ts() );
                            _jdoc.off( 'mousemove', PieGraph.DEFAULT_MOVE );
                            _jdoc.on( 'mousemove', PieGraph.DEFAULT_MOVE );
                            PieGraph.CURRENT_INS = _p;
                            _p.indexAt( _index );
                            _p.trigger( 'moving_start' );
                       });

                       _tmp.on( 'mouseleave', function( _evt, _srcEvt, _id, _index ){
                            //JC.log( 'mouseleaveout', _id, JC.f.ts() );
                            _jdoc.off( 'mousemove', PieGraph.DEFAULT_MOVE );
                            _p.trigger( 'moving_done' );
                            PieGraph.CURRENT_INS = null;
                       });

                        _p._piePart.push( _tmp );
                    });
                }
                return _p._piePart;
            }

        , pieLabel:
            function( _lines ){
                var _p = this;

                //return;

                if( _lines && typeof _p._pieLabel == 'undefined' ){

                    _p._pieLabel = new JChart.PieLabel( _p.stage(), _lines, _p );
                    _p._pieLabel.draw();
                    return _p._pieLabel;

                    _p._pieLabel = [];
                    _p._pieLabelText = [];
                    var _tmp, _path, _style, _text;
                    $.each( _lines, function( _k, _item ){
                        var _ix = _p.displayLegendMap[ _k ];
                        _style = _p.itemStyle( _ix );
                        _tmp = _p.stage().path( _item.path )
                            .attr( { 'stroke': _style.fill } )
                            .translate( .5, .5 )
                            ;
                        _p._pieLabel.push( _tmp );
                        _text = _p.stage().text( 0, 0, _item.data.name )
                            .attr( { 'fill': '#999' } )
                            ;
                        switch( _item.direction ){
                            case 'top':
                                {
                                    _text.attr( { x: _item.end.x, y: _item.end.y - 5 } );
                                    break;
                                }
                            case 'left_top':
                                {
                                    _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                    break;
                                }
                            case 'right_top':
                                {
                                    _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                    break;
                                }
                            case 'left_bottom':
                                {
                                    _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                    break;
                                }
                            case 'right_bottom':
                                {
                                    _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                    break;
                                }
                            case 'right':
                                {
                                    _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                    break;
                                }
                            case 'bottom':
                                {
                                    _text.attr( { x: _item.end.x, y: _item.end.y + 5 } );
                                    break;
                                }
                            case 'left':
                                {
                                    _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                    break;
                                }
                        }
                    });
                }

                return _p._pieLabel;
            }

        , coordinate:
            function( _data ){

                if( typeof this._coordinate != 'undefined' || !_data ){
                    return this._coordinate;
                }else{
                    this._coordinate = {};
                }

                var _p = this
                    , _c = {}
                    , _bbox
                    , _x = 0, _maxX = _p.width() - 10
                    , _y = 0, _maxY = _p.height() - 5
                    , _tmp, _tmpX, _tmpY, _padX, _tmpA, _tmpA1
                    ;
                this._coordinate = _c;

                _p.stage();

                _c.stage = { x: 0, y: 0, width: _p.width(), height: _p.height(), corner: _p.stageCorner()  };
                _p.background( _c );
                _x = 2, _y = 2;

                var _title = _p.title( _data );
                if( _title ){
                    _bbox = JChart.f.getBBox( _title );
                    _c.title = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                        , ele: _title
                    }
                    _y = _c.title.y + _bbox.height / 2;
                }

                var _subtitle = _p.subtitle( _data );
                if( _subtitle ){
                    _bbox = JChart.f.getBBox( _subtitle );
                    _c.subtitle = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                        , ele: _subtitle
                    }
                    _y = _c.subtitle.y + _bbox.height / 2 + 5;
                }

                !( _title && _subtitle ) && ( _y += 10 );

                var _vtitle = _p.vtitle( _data );
                if( _vtitle ){
                    _bbox = JChart.f.getBBox( _vtitle );
                    _c.vtitle = {
                        x: _x + _bbox.height / 2 + 5
                        , y: _p.height() / 2
                        , rotate: -90
                        , ele: _vtitle
                    }
                    _x = _c.vtitle.x + 5 + 10;
                }

                var _credits = _p.credits( _data );
                if( _credits ){
                    _bbox = JChart.f.getBBox( _credits );
                    _c.credits = {
                        x: _maxX - _bbox.width / 2
                        , y: _maxY - _bbox.height / 2
                        , ele: _credits
                    }
                    _maxY = _c.credits.y - 8;
                }

                if( _p.legendEnable() ){

                    var _legend = _p.legend( _data, 'circle' );
                    if( _legend ){
                        _bbox = _legend.set().getBBox();
                        _c.legend = {
                            x: ( _maxX - _bbox.width ) / 2
                            , y: _maxY - _bbox.height - 2
                            , ele: _legend
                        }
                        _maxY = _c.legend.y;
                    }
                }

                _maxY -= _p.varrowSize();
                _x += _p.harrowSize();

                var _vx = _x, _hy = _y;

                _c.chartHeight = _c.wsHeight = _maxY - _y;
                _c.chartY = _c.wsY = _y;
                _c.chartMaxY = _c.wsMaxY = _maxY;

                _c.chartWidth = _c.wsWidth = _maxX - _x;
                _c.chartX = _c.wsX = _x;
                _c.chartMaxX = _c.wsMaxX = _maxX;

                _c.cx = _c.wsX + _c.wsWidth / 2;
                _c.cy = _c.wsY + _c.wsHeight / 2;

                _c.radius = _p.calcRadius( _c.wsWidth, _c.wsHeight );

                var _dataBackground = _p.dataBackground( _c.wsX, _c.wsY, _c.wsWidth, _c.wsHeight );
                if( _dataBackground ){
                    _dataBackground.attr( { 
                        'fill': '#fff'
                        , 'fill-opacity': 1
                        , 'stroke': '#999' 
                        , 'stroke-width': 1
                        , 'stroke-opacity': .35
                    } );
                    _dataBackground.translate( .5, .5 );

                    _c.dataBackground = {
                        x: _c.wsX, y: _c.wsY, width: _c.wsWidth, height: _c.wsHeight, item: _dataBackground
                    };
                }

                //_p.stage().circle( _c.cx, _c.cy, _c.radius );

                if( _p.getDisplaySeries() && _p.getDisplaySeries().length ){
                    var _angle = 360
                        , _angleCount = 0
                        , _offsetAngle = _p.offsetAngle()
                        , _partSize = _p.partSize()
                        , _tmpPoint
                        ;

                    _c.piePart = [];
                    _p.dataLabelEnabled() && ( _c.pieLabel = [] );

                    //JC.log( '_p.dataLabelEnabled:', _p.dataLabelEnabled() );
                    /*
                    JC.dir( _p.series() );
                    JC.dir( _p.getDisplaySeries() );
                    */

                    $.each( _p.getDisplaySeries(), function( _k, _item ){
                        var _pieP = { cx: _c.cx, cy: _c.cy, radius: _c.radius, data: _item }, _pieL = { data: _item };

                        _pieP.radians = Math.PI / 180;
                        _pieP.offsetAngle = _offsetAngle;
                        
                        if( _item.y === _partSize ){
                            _pieP.angle = 360;
                            _pieP.percent = 100;
                        }else{
                            _pieP.percent = _item.y / _partSize * 100;
                            _pieP.angle = _item.y / _partSize * _angle;

                        }
                        _pieP.startAngle = ( _angleCount + _offsetAngle ) % _angle;
                        _pieP.midAngle = _pieP.startAngle + _pieP.angle / 2 % _angle;
                        _pieP.endAngle = ( ( _angleCount += _pieP.angle ) + _offsetAngle ) % _angle;

                        _pieP.startPoint = JChart.Geometry.distanceAngleToPoint( _pieP.radius, _pieP.startAngle );
                        _pieP.endPoint = JChart.Geometry.distanceAngleToPoint( _pieP.radius, _pieP.endAngle );
                        _pieP.exPoint = JChart.Geometry.distanceAngleToPoint( _pieP.radius + 10, _pieP.endAngle );

                        _pieP.startPoint.x += _pieP.cx;
                        _pieP.startPoint.y += _pieP.cy;
                        _pieP.endPoint.x += _pieP.cx;
                        _pieP.endPoint.y += _pieP.cy;

                        _pieL.cx = _c.cx;
                        _pieL.cy = _c.cy;

                        _pieL.start = JChart.Geometry.distanceAngleToPoint( _pieP.radius - _p.lineStart(), _pieP.midAngle );
                        _pieL.end = JChart.Geometry.distanceAngleToPoint( _pieP.radius + _p.lineLength(), _pieP.midAngle );

                        _pieL.start.x += _pieL.cx;
                        _pieL.start.y += _pieL.cy;
                        _pieL.end.x += _pieL.cx;
                        _pieL.end.y += _pieL.cy;
                        _pieL.ex = { x: _pieP.exPoint.x + _pieL.cx, y: _pieP.exPoint.y + _pieL.cy };

                        //JC.log( _k, _pieP.midAngle );

                        var _tmpPath, _controlX = _pieL.end.x, _controlY = _pieL.end.y, _minAngle = 5;

                        if( Math.abs( 270 - _pieP.midAngle ) <= _minAngle ){
                            _pieL.direction = "top";
                        }else if( ( Math.abs( 360 - _pieP.midAngle ) <= _minAngle ) || _pieP.midAngle <= _minAngle ){
                            _pieL.direction = "right";
                        }else if( Math.abs( 90 - _pieP.midAngle ) <= _minAngle ){
                            _pieL.direction = "bottom";
                        }else if( Math.abs( 180 - _pieP.midAngle ) <= _minAngle ){
                            _pieL.direction = "left";
                        }else{
                            //left top
                            if( _pieL.end.x < _pieL.cx && _pieL.end.y < _pieL.cy ){
                                _controlY -= 5;
                                _controlX += 5;
                                _pieL.direction = "left_top";
                            }
                            //right top
                            if( _pieL.end.x > _pieL.cx && _pieL.end.y < _pieL.cy ){
                                _controlY -= 5;
                                _controlX -= 5;
                                _pieL.direction = "right_top";
                            }
                            //left bottom
                            if( _pieL.end.x < _pieL.cx && _pieL.end.y > _pieL.cy ){
                                _controlY += 5;
                                _controlX += 5;
                                _pieL.direction = "left_bottom";
                            }
                            //right bottom
                            if( _pieL.end.x > _pieL.cx && _pieL.end.y > _pieL.cy ){
                                _controlY += 5;
                                _controlX -= 5;
                                _pieL.direction = "right_bottom";
                            }
                        }
                        _pieL.control = { x: _controlX, y: _controlY };

                        _tmpPath = JC.f.printf( 'M{0} {1}S{2} {3} {4} {5}'
                            , _pieL.start.x, _pieL.start.y
                            , _controlX, _controlY 
                            , _pieL.end.x, _pieL.end.y
                        );
                        //_p.stage().path( _tmpPath ).attr( { 'stroke': '#999' } ).translate( .5, .5 );
                        _pieL.path = _tmpPath;

                        _c.piePart.push( _pieP );
                        _p.dataLabelEnabled() && _c.pieLabel.push( _pieL );
                    });
                }

                /*
                JC.dir( _p._coordinate );
                JC.dir( _p.data() );
                */

                var _tips = _p.tips();

                return _p._coordinate;
            }

        , partSize:
            function(){
                var _p = this;
                typeof _p._partSize == 'undefined' 
                    &&_p.getDisplaySeries() 
                    && _p.getDisplaySeries().length && (
                            _p._partSize = 0
                            , $.each( _p.getDisplaySeries(), function( _k, _item ){
                                _p._partSize += _item.y
                            })
                       );
                return this._partSize || 100;
            }

        , lineStart: function(){ return 10; }
        , lineLength: function(){ return 40; }

        , offsetAngle:
            function(){
                var _r = 270;
                this.data() && 'offsetAngle' in this.data() && ( _r = this.data().offsetAngle );
                return _r;
            }

        , calcRadius:
            function( _w, _h ){
                var _p = this, _r = Math.min( _w, _h );
                //_r = parseInt( _r / 5 * 3 / 2 );
                if( _p.legendEnable() ){
                    _r -= 30;
                }
                if( _p.dataLabelEnabled() ){
                    _r -= ( _p.lineLength() - _p.lineStart() + 40 ) * 2;
                }else{
                    _r -= 40;
                }
                _r /= 2;
                return _r;
            }

        , series:
            function(){
                var _p = this;

                typeof _p._series == 'undefined' && _p.data() && _p.data().series 
                    && _p.data().series.length 
                    && _p.data().series[0].data
                    && _p.data().series[0].data.length
                    && ( _p._series = _p.data().series[0].data )
                return _p._series;
            }

        , resetDisplaySeries:
            function( _data ){
                var _p = this;
                _p.displayLegend = {};
                _p.displayLegendMap = {};
                _p.displaySeries = [];

                if( _data && _data.series && _data.series.length ){
                    $.each( _data.series[0].data, function( _k, _item ){
                        _p.displayLegend[ _k ] = _k;
                        _p.displayLegendMap[ _k ] = _k;
                        _p.displaySeries.push( _item );
                    });
                }
            }

        , updateLegend:
            function( _ix ){
                var _p = this;
                if( !( _p.legendSet() && _p.legendSet().length ) ) return;
                var _set = _p.legendSet()[ _ix ];
                if( !_set ) return;

                if( _set.items.length ){

                    var _selected = !JC.f.parseBool( _set.items[0].data( 'selected' ) ); 
                    _set.data( 'selected', _selected );
                    if( _selected ){
                        _set.attr( { opacity: .35 } );
                    }else{
                        _set.attr( { opacity: 1 } );
                        _p.displayLegend[ _ix ] = _ix;
                    }

                    _p.displayLegend = {};
                    _p.displayLegendMap = {};
                    var _count = 0;
                    $.each( _p.legendSet(), function( _k, _item ){
                        if( !JC.f.parseBool( _item.items[0].data( 'selected' ) ) ){
                            _p.displayLegend[ _k ] = _count;
                            _p.displayLegendMap[ _count ] = _k;
                            //JC.log( _k, _count );
                            _count++;
                        }
                    });

                    //JC.dir( _p.displayLegend );
                    _p.displaySeries = [];
                    if( _p.series() && _p.series().length ){
                        $.each( _p.series(), function( _k, _item ){
                            if( _k in _p.displayLegend ){
                                _p.displaySeries.push( _item );
                            }
                        });
                    }
                    _p.trigger( JChart.Base.Model.UPDATE_CHART_DATA, [ _p.data() ] );
                    //JC.dir( _p._model.displaySeries );
                }
            }

        , legendDataFilter:
            function( _data ){
                var _r;
                _data 
                    && _data.series 
                    && _data.series.length 
                    && _data.series[0].data
                    && _data.series[0].data.length
                    && ( _r = _data.series[0].data )
                    ;
                return _r;
            }
        /**
         * 获取 tips 标题文本
         */
        , tipsTitle:
            function( _ix ){
                var _p = this, _r = '';
                _p.displaySeries && _p.displaySeries.length && _p.displaySeries[ _ix ] &&
                    ( _r = _p.displaySeries[ _ix ].name );
                return _r;
            }

        , tipsLabel:
            function(){
                var _p = this, _r = '';
                _p.data() && _p.data().series && _p.data().series.length &&
                    ( _r = _p.data().series[ 0 ].name );
                return _r;
            }

        , tipsData: 
            function(){
                var _p = this, _r;

                _r = [
                    { 'name': _p.tipsLabel() }
                ]
                return _r;
            }
        , updateTipsData:
            function( _ix ){
                var _p = this, _r, _color =  _p.colors()[ _p.displayLegendMap[ _ix ] % (_p.colors().length - 1) ];
                _r = {
                    title: _p.tipsTitle( _ix )
                    , tipsData: [ JC.f.moneyFormat( _p.displaySeries[ _ix ].y, 3, _p.floatLen() ) ]
                    , color: _color
                }; 
                return _r;
            }
    });

    JC.f.extendObject( PieGraph.View.prototype, {
        _inited:
            function(){
            }

        , setStaticPosition:
            function( _coordinate ){
                var _p = this, _c = _coordinate, _tmp;
                if( _c.title ){
                    _p._model.title().attr( _c.title );
                }
                if( _c.subtitle ){
                    _p._model.subtitle().attr( _c.subtitle );
                }
                if( _c.credits ){
                    _p._model.credits().attr( _c.credits );
                }
                if( _c.legend ){
                    //_p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                    JChart.moveSet( _p._model.legend().set(), _c.legend.x, _c.legend.y );
                }
                if( _c.pieLabel ){
                    _p._model.pieLabel( _c.pieLabel );
                }
                if( _c.piePart ){
                    _p._model.piePart( _c.piePart );
                    _p.trigger( 'update_default_selected' );
                }
                _p._model.tips().set().toFront();
            }
        /**
         * 从给出的数据显示图表
         * @param   {object}  _data
         */
        , draw: 
            function( _data ){
                var _p = this, _coordinate;
                var _detect = _p._model.displayDetect();
                //JC.log( 'draw displayDetect', _detect, JC.f.ts() );
                //_detect = 1;

                if( _detect === JChart.Base.Model.FLASH && PieGraph.FLASH_PATH ){
                    _p.drawFlash( _data, PieGraph.FLASH_PATH ); 
                }else{
                    _p.drawSVG( _data );
                }
             }
        , drawSVG:
            function( _data ){
                var _p = this, _coordinate;
                _p.setStaticPosition( _p._model.coordinate( _data ) );
            }

        , clearStatus:
            function(){
                var _p = this, _preItems = _p._model.preItems();

                if( _preItems ){
                    _preItems.point && $.each( _preItems.point, function( _k, _item ){
                        _item.unhover();
                    });
                    _preItems.vlines && _preItems.vlines.unhover();
                }

                _p._model.preItems( null );
            }
    });

    _jdoc.ready( function(){
        PieGraph.autoInit && PieGraph.init();
    });

    _jwin.on( JChart.Base.RESIZE_UPDATE, function( _evt ){
        JChart.Base.reset( 'div.jchartPieGraph', JChart.PieGraph );
    });

    return PieGraph;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
