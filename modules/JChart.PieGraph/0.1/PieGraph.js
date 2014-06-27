;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.IconVLine', 'JChart.IconRect', 'JChart.GraphicPiePart' ], function(){
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
 * @extends     JChart.BaseMVC
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

        //JC.log( PieGraph.Model._instanceName, 'all inited', new Date().getTime() );
    }
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
                    _selector.find( 'div.jchartPieGraph' ).each( function(){
                        _r.push( new PieGraph( this ) );
                    });
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
            //JC.log( 'PieGraph.DEFAULT_MOVE', _evt.pageX, _evt.pageY, JC.f.ts(), _selector.length, _src.nodeName );
            _p.trigger( 'update_moving_status', [ _evt ] );
        };

    JC.BaseMVC.build( PieGraph, JChart.Base );

    JC.f.extendObject( PieGraph.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'PieGraph _beforeInit', new Date().getTime() );
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
                    //JC.log( 'moving_start', JC.f.ts() );
                });

                _p.on( 'moving_done', function( _evt ){
                    _p.trigger( 'clear_status' );
                    _p._model.tips() && _p._model.tips().hide();
                    //JC.log( 'moving_done', JC.f.ts() );
                });

                _p.on( 'clear_status', function(){
                    _p._view.clearStatus();
                });

                _p.on( 'update_status', function( _evt, _index, _offset ){
                    if( !_offset ) return;
                    if( typeof _index == 'undefined' ) return;
                    //JC.log( _index, _offset.x, _offset.y, JC.f.ts() );
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
                    _p._model.pieData() && _p._model.pieData().length
                        && $.each( _p._model.pieData(), function( _k, _item ){
                            _item.selected && ( _ix = _k );
                        });

                    typeof _ix != 'undefined' 
                        && _p._model.piePart() 
                        && _p._model.piePart()[ _ix ]
                        && _p._model.piePart()[ _ix ].selected( true )
                        ;
                });
            }

        , _inited:
            function(){
                //JC.log( 'PieGraph _inited', new Date().getTime() );
            }
    });

    PieGraph.Model._instanceName = 'JChartPieGraph';

    PieGraph.Model.STYLE = {
        lineStyle: {
            'stroke': '#999'
            , 'opacity': '.35'
        }
        , style: [
              { 'fill': '#09c100', 'stroke': '#fff'}
            , { 'fill': '#FFBF00', 'stroke': '#fff'}
            , { 'fill': '#0c76c4', 'stroke': '#fff'}
            , { 'fill': '#41e2e6', 'stroke': '#fff'}
            , { 'fill': '#ffb2bc', 'stroke': '#fff'}
            , { 'fill': '#dbb8fd', 'stroke': '#fff'}
            , { 'fill': '#ff06b3', 'stroke': '#fff'}
            , { 'fill': '#ff7100', 'stroke': '#fff'}
            , { 'fill': '#c3e2a4', 'stroke': '#fff'}
            , { 'fill': '#ff0619', 'stroke': '#fff'}

        ]
        , pathStyle: {
            'stroke-width': 2
        }
        , radius: 4
    };

    var _oldWorkspaceOffset = PieGraph.Model.prototype.workspaceOffset;

    JC.f.extendObject( PieGraph.Model.prototype, {
        init:
            function(){
                //JC.log( 'PieGraph.Model.init:', new Date().getTime() );
            }

        , pieData:
            function(){
                var _p = this;

                typeof _p._pieData == 'undefined' && _p.data() && _p.data().series 
                    && _p.data().series.length 
                    && _p.data().series[0].data
                    && _p.data().series[0].data.length
                    && ( _p._pieData = _p.data().series[0].data )
                return _p._pieData;
            }

        , itemStyle:
            function( _ix ){
                var _r = {}, _p = this
                    , _len = PieGraph.Model.STYLE.style.length
                    , _ix = _ix % ( _len - 1 )
                    ;

                _r = JC.f.cloneObject( PieGraph.Model.STYLE.style[ _ix ] );

                _p.data().series
                    && _p.data().series.length
                    && _p.data().series[ 0 ].style
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ 0 ].style ) );

                !_r.fill && _r.stroke && ( _r.fill = _r.stroke );

                _r[ 'fill-opacity' ] = 1;

                return _r;
            }

        , itemHoverStyle:
            function( _ix ){
                var _r = {}, _p = this
                    , _len = PieGraph.Model.STYLE.style.length
                    , _ix = _ix % ( _len - 1 )
                    ;
                _r = JC.f.cloneObject( PieGraph.Model.STYLE.style[ _ix ] );

                _p.data().series
                    && _p.data().series.length
                    && _p.data().series[ 0 ].style
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ 0 ].style ) );

                _p.data().series
                    && _p.data().series.length
                    && _p.data().series[ 0 ].hoverStyle
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ 0 ].hoverStyle ) );

                _r[ 'fill-opacity' ] = .65;

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
         * 数据图例图标
         */
        , legend:
            function( _data, _type, _cb ){
                var _p = this, _tmp = true, _type;

                if( !this._legend && _data && 
                        ( ( _data.legend && ( 'enabled' in _data.legend ) && ( _tmp = _data.legend.enabled ) ) ||
                          _tmp
                        )
                    ){
                    this._legend =  new JChart.Group();
                    _type = _type || 'line';
                    switch( _type ){
                        case 'rect':
                            {
                                var _text = [], _minX = 8, _x = _minX, _y = 0, _maxX = 0, _legend, _text, _spad = 2, _pad = 8, _bx = 100, _by = 100, _tb, _lb, _h = 30;
                                _x += _bx;

                                _data.series && _data.series.length &&
                                $.each( _data.series[0].data, function( _k, _item ){
                                    if( !_item.name ) return;
                                    var _style = _p.itemStyle( _k );
                                    _legend = new JChart.IconRect( _p.stage(), _x, 0 + _by, 18, 10, 1, 4 );
                                    _lb = _legend.getBBox();
                                    _text = _p.stage().text( _lb.x + 18 + _spad, 0 + _by, _item.name ).attr( 'text-anchor', 'start');
                                    _tb = _text.getBBox();
                                    _p._legend.addChild( _legend, 'legend_' + _k, { padX: _x - _bx, padY: _tb.height / 2 + 1 } );
                                    _legend.attr( _style );
                                    _legend.attr( 'fill', _style.fill );
                                    _p._legend.addChild( _text, 'text_' + _k );
                                    _x = _tb.x + _tb.width + _pad;
                                    _h = _tb.height * 1.8;
                                });

                                var _box = _p.stage().rect( _bx, _by - _h / 2, _x - _bx, _h, 8 )
                                        .attr( { 'stroke-opacity': .99, 'fill-opacity': .99, 'stroke-width': 1, 'stroke': '#909090' } );
                                _p._legend.addChild( _box, 'box' );
                            }
                    }
                }
                    
                return this._legend;
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
                            if( JC.f.isArray( _item ) ){
                                _p._data.series[0].data[ _k ] = { 'name': _item[0], 'y': _item[1] };
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
                        _tmp = new JChart.GraphicPiePart( _p.stage(), _pieCor, _p.itemStyle( _k ), _p.itemHoverStyle( _k ), _k );
                        _tmp.index( _k );
                        _tmp.on( 'selected_changed', function( _evt, _isSelected, _id ){
                            //JC.log( 'selected_changed', _id, JC.f.ts() );
                            _p.trigger( 'unselected_piepart', [ _isSelected, _id ] );
                        });

                       _tmp.on( 'hover_in', function( _evt, _srcEvt, _id, _index ){
                            //JC.log( 'hover in', _id, JC.f.ts() );
                            JC.f.safeTimeout( function(){}, _p, 'asdfawsef_hide_tips', 200 );
                            _jdoc.on( 'mousemove', PieGraph.DEFAULT_MOVE );
                            PieGraph.CURRENT_INS = _p;
                            _p.indexAt( _index );
                            _p.trigger( 'moving_start' );
                       });

                       _tmp.on( 'hover_out', function( _evt, _srcEvt, _id, _index ){
                            //JC.log( 'hover out', _id, JC.f.ts() );
                            JC.f.safeTimeout( function(){
                                _jdoc.off( 'mousemove', PieGraph.DEFAULT_MOVE );
                                _p.trigger( 'moving_done' );
                                PieGraph.CURRENT_INS = null;
                            }, _p, 'asdfawsef_hide_tips', 200 );
                       });

                        _p._piePart.push( _tmp );
                    });
                }
                return _p._piePart;
            }

        , pieLine:
            function( _lines ){
                var _p = this;

                if( _lines && typeof this._pieLine == 'undefined' ){
                    _p._pieLine = [];
                    _p._pieLineText = [];
                    var _tmp, _path, _style, _text;
                    $.each( _lines, function( _k, _item ){
                        _style = _p.itemStyle( _k );
                        _tmp = _p.stage().path( _item.path )
                            .attr( { 'stroke': _style.fill } )
                            .translate( .5, .5 )
                            ;
                        _p._pieLine.push( _tmp );
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

                return _p._pieLine;
            }

        , pieLineText: function(){ return this._pieLineText; }

        /**
         * 获取 tips 对象
         */
        , tips:
            function( _ix ){
                var _p = this, _c = _p.coordinate(), _items, _text, _val
                    , _len = _c.hlen, _count = 0
                    , _offsetY = 34
                    , _offsetX = 20
                    , _padWidth = 14
                    , _padHeight = 8
                    , _strokeColor = '#000'
                    , _tmp, _tmpBox, _tmpItem, _maxWidth = 0
                    ;

                if( !_p._tips ){
                    var _initOffset = { x: 10000, y: 0 };
                    //_initOffset.x = 0;
                    _p._tips = new JChart.Group();

                    _p._tips.addChild( 
                        _p.stage().rect( 0 + _initOffset.x, 0 + _initOffset.y, 50, 30, 5 ).attr( { 
                            'stroke': '#999'
                            , 'fill': '#fff' 
                            , 'fill-opacity': .98
                        } )
                    , 'rect' );

                    _p._tips.addChild( _p.stage().text( 10 + _initOffset.x, 14 + _initOffset.y, 'tips' )
                            .attr( { 'font-weight': 'bold', 'fill': '#999', 'text-anchor': 'start' } )
                    , 'title' );

                    _tmp = _p.stage().text( _offsetX + _initOffset.x, _offsetY + _initOffset.y, _p.data().series[0].name || 'empty' ).attr( { 'text-anchor': 'start' } );
                    _tmpBox = _tmp.getBBox();
                    _offsetY += _tmpBox.height + 5;
                    _tmpBox.width > _maxWidth && ( _maxWidth = _tmpBox.width );
                    _p._tips.addChild( _tmp, 'label_0' );

                    _tmpItem = _p._tips.getChildByName( 'label_0' );
                    _tmpBox = _tmpItem.getBBox();
                    _tmp = _p.stage().text( _maxWidth + _offsetX + 10 + _initOffset.x, _tmpItem.attr( 'y' ) + _initOffset.y, '012345678901.00' ).attr( { 'text-anchor': 'start' } );
                    _p._tips.addChild( _tmp, 'val_0' );

                    _tmpItem = _p._tips.getChildByName( 'val_0' );
                    _tmpItem.attr( 'text', '0.00' );

                    _p._tipLabelMaxWidth = _maxWidth;
                }
                if( typeof _ix != 'undefined' ){
                    _p._tips.getChildByName( 'title' ).attr( 'text', _p.tipsTitle( _ix ) );

                    var _maxTextWidth = 0, _tmpLabel;
                    _maxTextWidth = _p._tips.getChildByName( 'val_' + 0 ).attr( 'text', JC.f.moneyFormat( _p.pieData()[ _ix ].y, 3, _p.floatLen() ) ).getBBox().width;

                    _p._tips.getChildByName( 'title' ).attr( 'fill', _p.itemStyle( _ix ).fill );

                    $.each( _p.data().series, function( _k, _item ){
                        _tmp = _p._tips.getChildByName( 'val_' + _k );
                        _tmpLabel = _p._tips.getChildByName( 'label_' + _k );
                        _tmpBox = _tmpLabel.getBBox();
                        _tmp.attr( 'x', _tmpBox.x + _p._tipLabelMaxWidth + 10 + _maxTextWidth - _tmp.getBBox().width );
                    });
                }
                _p._tips.getChildByName( 'rect' ).attr( { width: 80, height: 50 } );
                _tmpBox = _p._tips.getBBox();
                _p._tips.getChildByName( 'rect' ).attr( { 'width': _tmpBox.width + _padWidth, 'height': _tmpBox.height + _padHeight } );

                return _p._tips;
            }
        /**
         * 获取 tips 标题文本
         */
        , tipsTitle:
            function( _ix ){
                var _p = this, _r = '';
                _p.pieData() && _p.pieData().length && _p.pieData()[ _ix ] &&
                    ( _r = _p.pieData()[ _ix ].name );
                return _r;
            }

        , tipsLabel:
            function(){
                var _p = this, _r = '';
                _p.data() && _p.data().series && _p.data().series.length &&
                    ( _r = _p.data().series[ 0 ].name );
                return _r;
            }

        , coordinate:
            function( _data ){
                if( typeof this._coordinate != 'undefined' || !_data ){
                    return this._coordinate;
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
                    _bbox = _title.getBBox();
                    _c.title = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                        , ele: _title
                    }
                    _y = _c.title.y + _bbox.height / 2;
                }

                var _subtitle = _p.subtitle( _data );
                if( _subtitle ){
                    _bbox = _subtitle.getBBox();
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
                    _bbox = _vtitle.getBBox();
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
                    _bbox = _credits.getBBox();
                    _c.credits = {
                        x: _maxX - _bbox.width / 2
                        , y: _maxY - _bbox.height / 2
                        , ele: _credits
                    }
                    _maxY = _c.credits.y - 8;
                }

                var _legend = _p.legend( _data, 'rect', function( _ix, _legend, _text, _data ){
                    var _color = _data.stroke 
                                    || Histogram.Model.STYLE.data[ _ix % Histogram.Model.STYLE.data.length ].stroke 
                                    || '#fff';
                    _legend.attr( 'fill', _color ).attr( 'stroke', _color );;
                } );
                if( _legend ){
                    _bbox = _legend.getBBox();
                    _c.legend = {
                        x: ( _maxX - _bbox.width ) / 2
                        , y: _maxY - _bbox.height - 2
                        , ele: _legend
                    }
                    _maxY = _c.legend.y;
                }

                _maxY -= _p.varrowSize();
                _x += _p.harrowSize();

                var _vx = _x, _hy = _y;

                _c.wsHeight = _maxY - _y;
                _c.wsY = _y;
                _c.wsMaxY = _maxY;

                _c.wsWidth = _maxX - _x;
                _c.wsX = _x;
                _c.wsMaxX = _maxX;

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

                if( _p.pieData() && _p.pieData().length ){
                    var _angle = 360
                        , _angleCount = 0
                        , _offsetAngle = _p.offsetAngle()
                        , _partSize = 100
                        , _tmpPoint
                        ;

                    _c.piePart = [];
                    _c.pieLine = [];

                    $.each( _p.pieData(), function( _k, _item ){
                        var _pieC = { cx: _c.cx, cy: _c.cy, radius: _c.radius }, _pieL = {};

                        _pieC.radians = Math.PI / 180;
                        _pieC.angle = _item.y / _partSize * _angle;

                        _pieC.startAngle = ( _angleCount + _offsetAngle ) % _angle;
                        _pieC.midAngle = _pieC.startAngle + _pieC.angle / 2;
                        _pieC.endAngle = ( ( _angleCount += _pieC.angle ) + _offsetAngle ) % _angle;

                        _pieC.startPoint = JChart.Geometry.distanceAngleToPoint( _pieC.radius, _pieC.startAngle );
                        _pieC.endPoint = JChart.Geometry.distanceAngleToPoint( _pieC.radius, _pieC.endAngle );

                        _pieC.startPoint.x += _pieC.cx;
                        _pieC.startPoint.y += _pieC.cy;
                        _pieC.endPoint.x += _pieC.cx;
                        _pieC.endPoint.y += _pieC.cy;
                        _pieC.data = _item;

                        _pieL.start = JChart.Geometry.distanceAngleToPoint( _pieC.radius - 10, _pieC.midAngle );
                        _pieL.end = JChart.Geometry.distanceAngleToPoint( _pieC.radius + 40, _pieC.midAngle );
                        _pieL.cx = _c.cx, _pieL.cy = _c.cy;
                        _pieL.start.x += _pieL.cx;
                        _pieL.start.y += _pieL.cy;
                        _pieL.end.x += _pieL.cx;
                        _pieL.end.y += _pieL.cy;
                        _pieL.data = _item;

                        //JC.log( _k, _pieC.midAngle );

                        var _tmpPath, _controlX = _pieL.end.x, _controlY = _pieL.end.y, _minAngle = 5;

                        if( Math.abs( 270 - _pieC.midAngle ) <= _minAngle ){
                            _pieL.direction = "top";
                        }else if( ( Math.abs( 360 - _pieC.midAngle ) <= _minAngle ) || _pieC.midAngle <= _minAngle ){
                            _pieL.direction = "right";
                        }else if( Math.abs( 90 - _pieC.midAngle ) <= _minAngle ){
                            _pieL.direction = "bottom";
                        }else if( Math.abs( 180 - _pieC.midAngle ) <= _minAngle ){
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

                        _c.piePart.push( _pieC );
                        _c.pieLine.push( _pieL );
                    });
                }
                //JC.log();

                JC.dir( _p._coordinate );
                JC.dir( _p.data() );

                var _tips = _p.tips();
                return _p._coordinate;
            }

        , offsetAngle:
            function(){
                var _r = 270;
                this.data() && 'offsetAngle' in this.data() && ( _r = this.data().offsetAngle );
                return _r;
            }

        , calcRadius:
            function( _w, _h ){
                var _r = _w;
                _h < _r && ( _r = _h );
                _r = parseInt( _r / 5 * 3 / 2 );
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
                    _p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                }
                if( _c.pieLine ){
                    _p._model.pieLine( _c.pieLine );
                }
                if( _c.piePart ){
                    _p._model.piePart( _c.piePart );
                    _p.trigger( 'update_default_selected' );
                }
                _p._model.tips().toFront();
            }

        , draw: 
            function( _data ){
                var _p = this, _coordinate;

                _p.setStaticPosition( _p._model.coordinate( _data ) );
            }

        , updateTips:
            function( _ix, _offset ){
                var _p = this
                    , _tips = _p._model.tips( _ix )
                    , _bbox = _tips.getBBox()
                    , _c = _p._model.coordinate()
                    , _x = _offset.x + 15, _y = _offset.y + 18
                    ;

                if( ( _y + _bbox.height ) > _c.stage.height ){
                    _y = _offset.y - _bbox.height + 8;
                }
                _y < 0 && ( _y = 0 );

                if( ( _x + _bbox.width ) > _c.stage.width ){
                    _x = _offset.x - _bbox.width;
                }
                _x < 0 && ( _x = 0 );

                _tips.setPosition( _x, _y );
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
