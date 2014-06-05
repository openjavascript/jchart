;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.IconPoint', 'JChart.IconVLine' ], function(){
/**
 * 组件用途简述
 *
 *<p><b>require</b>:
 *   <a href='JChart.Base.html'>JChart.Base</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Line.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.Line/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 span class="jchartLine"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       Line
 * @extends     JChart.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-02-12
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JChart.Line 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Line = Line;

    function Line( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, Line ) ) 
            return JC.BaseMVC.getInstance( _selector, Line );

        JC.BaseMVC.getInstance( _selector, Line, this );

        this._model = new Line.Model( _selector );
        this._view = new Line.View( this._model );

        this._init();

        JC.log( Line.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 Line 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of LineInstance}
     */
    Line.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jchartLine' )  ){
                    _r.push( new Line( _selector ) );
                }else{
                    _selector.find( 'div.jchartLine' ).each( function(){
                        _r.push( new Line( this ) );
                    });
                }
            }
            return _r;
        };

    Line.CURRENT_INS = null;
    Line.DEFAULT_MOVE =
        function( _evt ){
            if( !Line.CURRENT_INS ){
                _jdoc.off( 'mousemove', Line.DEFAULT_MOVE );
                return;
            }
            var _p = Line.CURRENT_INS;
            //JC.log( 'Line.DEFAULT_MOVE', _evt.pageX, _evt.pageY, JC.f.ts(), _selector.length, _src.nodeName );
            _p.trigger( 'update_moving_status', [ _evt ] );
        };

    JC.BaseMVC.build( Line, JChart.Base );

    JC.f.extendObject( Line.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Line _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'update_moving_status', function( _evt, _srcEvt, _srcEle ){
                    //JC.log( 'update_tips', JC.f.ts() );
                    var _index = _p._model.indexAt( _srcEvt );
                    if( typeof _index == 'undefined' ) return;
                    _p._view.updateStatus( _index );
                });

                _p.on( 'moving_start', function( _evt ){
                    //JC.log( 'show', JC.f.ts(), _p._model.tips() );
                    _p._view.clearStatus();
                    _p._model.tips() && _p._model.tips().show();
                });

                _p.on( 'moving_done', function( _evt ){
                    //JC.log( 'hide', JC.f.ts(), _p._model.tips() );
                    _p._view.clearStatus();
                });
            }

        , _inited:
            function(){
                //JC.log( 'Line _inited', new Date().getTime() );
            }
    });

    Line.Model._instanceName = 'JChartLine';

    Line.Model.DATA_LINE_STYLE = {
        common: {
            'stroke-width': 2
        }
        , data: [
            { 'stroke': '#ff0619' }
            , { 'stroke': '#09c100' }
            , { 'stroke': '#ff7100' }

            , { 'stroke': '#FFBF00' }
            , { 'stroke': '#ff06b3' }
            , { 'stroke': '#c3e2a4' }

            , { 'stroke': '#0c76c4' }
            , { 'stroke': '#41e2e6' }
            , { 'stroke': '#ffb2bc' }

            , { 'stroke': '#dbb8fd' }
        ]
        , pointCommon: {
            radius: 4
            , 'iconType': 'circle'
        }
    };

    var _oldWorkspaceOffset = Line.Model.prototype.workspaceOffset;

    JC.f.extendObject( Line.Model.prototype, {
        init:
            function(){
                //JC.log( 'Line.Model.init:', new Date().getTime() );
            }

        , vlables:
            function( _data ){
                if( _data ){
                    var _p = this
                        , _maxNum = _p.maxNum( _data )
                        , _rate = _p.labelRate( _data )
                        , _eles = []
                        ;

                    $.each( _rate, function( _ix, _item ){
                        _eles.push( {
                            type: 'text'
                            , text: ( _maxNum * _item ).toString()
                        });
                    });

                    _p._vlabels = _p.root().add( _eles );

                    _p._hasVLabels = true;
                }
                return this._vlabels;
            }

        , lineColor:
            function( _ix ){
                var _r = '#000';

                _r = Line.Model.DATA_LINE_STYLE.data[ _ix % ( Line.Model.DATA_LINE_STYLE.data.length - 1 ) ].stroke || _r;

                this.data()
                    && this.data().series
                    && this.data().series[ _ix ]
                    && this.data().series[ _ix ].style
                    && this.data().series[ _ix ].style.stroke
                    && ( _r = this.data().series[ _ix ].style.stroke )
                    ;

                return _r;
            }

        , workspaceOffset:
            function( _data ){
                _oldWorkspaceOffset.call( this, _data );

                if( _data ){
                    this._workspaceOffset.height -= 18;
                }

                return this._workspaceOffset;
            }

        , chartWorkspaceOffset:
            function( _data ){

                if( _data ){
                    this._chartWorkspaceOffset = JC.f.cloneObject( this.workspaceOffset() );

                    if( this.vlables() && this.vlables().length ){
                        var _maxWidth = 0;
                        $.each( this.vlables(), function( _ix, _item ){
                            _item.getBBox().width > _maxWidth 
                                && ( _maxWidth = _item.getBBox().width );
                        });
                        _maxWidth > 0 && ( _maxWidth += 10 );
                        this._chartWorkspaceOffset.x += _maxWidth;
                        this._chartWorkspaceOffset.width -= _maxWidth;
                    }
                }

                return this._chartWorkspaceOffset;
            }

        , hlines:
            function( _data ){
                if( _data ){
                    var _p = this
                        , _eles = []
                        ;

                    $.each( _p.vlables(), function( _x, _item ){
                        _eles.push( {
                            'type': 'path'
                            , 'path': 'M0,0'
                        });
                    });

                    _p._hlines = _p.root().add( _eles );

                }
                return this._hlines;
            }

        , vlines:
            function( _data ){
                var _p = this, _eles, _tmp;
                if( _data && _data.xAxis && _data.xAxis.categories ){
                    _eles = [];
                    _p._vlines = [];

                    $.each( _data.xAxis.categories, function( _x, _item ){
                        _tmp = new JChart.IconVLine( 
                            _p.root()
                            , ['M0 0'].join(' ' )
                            , { 'stroke': '#999', 'stroke-width': 1 }
                            , { 'stroke': '#000', 'stroke-width': 1 } 
                        );
                        _p._vlines.push( _tmp );
                    });
                }
                return _p._vlines;
            }

        , dataLine:
            function( _data ){
                var _p = this, _eles;
                if( _data && _data.series ){
                    _eles = [];

                    $.each( _data.series, function( _x, _item ){
                        _eles.push( {
                            'type': 'path'
                            , 'path': 'M0,0'
                        });
                    });

                    _p._dataLine = _p.root().add( _eles );

                }

                return this._dataLine;
            }

        , dataPoint:
            function( _setter ){
                _setter && ( this._dataPoint = _setter );
                return this._dataPoint;
            }

        , vlinePoint:
            function( _setter ){
                _setter && ( this._vlinePoint = _setter );
                return this._vlinePoint;
            }

        , hlinePoint:
            function( _setter ){
                _setter && ( this._hlinePoint = _setter );
                return this._hlinePoint;
            }

        , tips:
            function( _dataIx ){
                var _p = this, _items, _text, _val;

                if( typeof _dataIx == 'undefined' ) return _p._tips;

                var _len = _p.data().series.length, _count = 0, _offsetY = 34, _tmp, _tmpBox, _tmpItem, _maxWidth = 0, _offsetX = 20
                    , _padWidth = 14
                    , _padHeight = 8
                    , _strokeColor = '#000'
                    ;

                if( !_p._tips ){
                    _p._tips = new JChart.Group();
                    _p._tips.addChild( 
                            _p.root().rect( 0, 0, 50, 30, 5 ).attr( { 'stroke': '#999'
                                                                        , 'fill': '#fff' 
                                                                        , 'fill-opacity': .94
                                                                    } )
                    , 'rect' );
                    _p._tips.addChild( _p.root().text( 10, 14, 'title' )
                            .attr( 'font-weight', 'bold' )
                            .attr( 'fill', '#999' )
                            , 'title' );
                    _p._tips.getChildByName( 'title' ).attr( 'text-anchor', 'start' );


                    $.each( _p.data().series, function( _k, _item ){
                        _strokeColor = _p.lineColor( _k );
                        _tmp = _p.root().text( _offsetX, _offsetY, _item.name || 'empty' ).attr( 'text-anchor', 'start' ).attr( 'fill', _strokeColor );
                        _tmpBox = _tmp.getBBox();
                        _p._tips.addChild( _tmp, 'label_' + _k );
                        _offsetY += _tmpBox.height + 5;
                        _tmpBox.width > _maxWidth && ( _maxWidth = _tmpBox.width );
                    });

                    $.each( _p.data().series, function( _k, _item ){
                        _strokeColor = _p.lineColor( _k );
                        _tmpItem = _p._tips.getChildByName( 'label_' + _k );
                        _tmpBox = _tmpItem.getBBox();
                        _tmp = _p.root().text( _maxWidth + _offsetX + 10, _tmpItem.attr( 'y' ), '012345678901.00' ).attr( 'text-anchor', 'start' ).attr( 'fill', _strokeColor );
                        _p._tips.addChild( _tmp, 'val_' + _k );
                    });

                    $.each( _p.data().series, function( _k, _item ){
                        _tmpItem = _p._tips.getChildByName( 'val_' + _k );
                        _tmpItem.attr( 'text', '0.00' );
                    });
                }

                _p._tips.getChildByName( 'title' ).attr( 'text', _p.tipsTitle( _dataIx ) );

                $.each( _p.data().series, function( _k, _item ){
                    _p._tips.getChildByName( 'val_' + _k ).attr( 'text', JC.f.moneyFormat( _item.data[ _dataIx ] ) );
                });


                _p._tips.getChildByName( 'rect' ).attr( { width: 80, height: 50 } );
                _tmpBox = _p._tips.getBBox();

                _p._tips.getChildByName( 'rect' )
                    .attr( 'width', _tmpBox.width + _padWidth )
                    .attr( 'height', _tmpBox.height + _padHeight )
                    ;

                _tmpBox = _p._tips.getBBox();

                var _newPoint = _p.tipsPoint( _dataIx, _tmpBox );

                _p._tips.setPosition( _newPoint.x, _newPoint.y );

                return _p._tips;
            }

        , tipsPoint:
            function( _dataIx, _bbox ){
                var _p = this, _r = { 'x': 0, 'y': 10000 };

                _r.x = _p.dataPoint()[0][_dataIx ].x + 4 ;

                if( ( _r.x + _bbox.width ) > _p.width() ){
                    _r.x = _r.x - _bbox.width - 8;
                }

                $.each( _p.dataPoint(), function( _k, _item ){
                    _item[ _dataIx ].y < _r.y && ( _r.y = _item[_dataIx].y );
                });

                _r.y -= _bbox.height / 2;

                _r.y < 0 && ( _r.y = 0 );
                ( _r.y + _bbox.height ) > _p.height() && ( _r.y = _p.height() - _bbox.height );

                return _r;
            }

        , tipsTitle:
            function( _ix ){
                var _p = this, _r = '';

                _p.data().xAxis
                    && _p.data().xAxis.categories
                    && ( _r = _p.data().xAxis.categories[ _ix ] );

                _p.data().xAxis
                    && _p.data().xAxis.tipTitlePostfix
                    && ( _r = JC.f.printf(  _p.data().xAxis.tipTitlePostfix, _r ) );

                return _r;
            }

        , dataLineStyle:
            function( _ix, _data ){
                var _r = { line: {}, point: {} }
                    , _itemStyle = Line.Model.DATA_LINE_STYLE.data[ _ix ]
                    ;

                JC.f.extendObject( _r.line, Line.Model.DATA_LINE_STYLE.common );
                JC.f.extendObject( _r.point, Line.Model.DATA_LINE_STYLE.pointCommon );

                _itemStyle && JC.f.extendObject( _r.line, _itemStyle );
                _itemStyle && (
                    _r.point.stroke = _itemStyle.stroke
                    , _r.point.fill = _itemStyle.stroke
                );

                if( _data && _data.series && _data.series[ _ix] && _data.series[ _ix ].style ){
                    JC.f.extendObject( _r.line, _data.series[ _ix ].style );
                }

                if( _data && _data.series && _data.series[ _ix] && _data.series[ _ix ].pointStyle ){
                    JC.f.extendObject( _r.point, _data.series[ _ix ].pointStyle );
                }

                return _r;
            }

        , indexAt:
            function( _srcEvt ){
                var _srcEle = this.chartWorkspace().node;
                var _p = this
                    , _x = _srcEvt.pageX
                    , _y = _srcEvt.pageY
                    , _srcBox = _srcEle.getBBox()
                    ,  _srcOffset = $( _srcEle ).offset()
                    , _realX = _x - _srcOffset.left 
                    , _realY = _y - _srcOffset.top
                    , _maxX = _srcBox.width
                    , _maxY = _srcBox.height
                    , _itemLen, _partWidth
                    , _partWhat = 0;
                    ;

                if( _realX <= 0 || _realY <= 0 || _realX >= _maxX || _realY >= _maxY ){
                    return undefined;
                }
                if( !( _p.data() 
                        && _p.data().series 
                        && _p.data().series.length 
                        && _p.data().series[0].data 
                        && _p.data().series[0].data.length 
                 )) return undefined;
                _itemLen = ( _p.data().series[0].data.length - 1 ) * 2;
                _partWidth = _srcBox.width / _itemLen;
                !_partWidth && ( _partWidth = _srcBox.width );
                _partWhat = Math.floor( _realX / _partWidth  );
                _partWhat > 1 && ( _partWhat = Math.round( _partWhat / 2 ) );

                return _partWhat;
            }

        , pointItems:
            function( _setter ){
                typeof _setter != 'undefined' && ( this._pointItems = _setter );
                return this._pointItems;
            }

    });

    JC.f.extendObject( Line.View.prototype, {
        _inited:
            function(){
            }

        , draw: 
            function( _data ){
                var _p = this;

                _p.root();

                _p.drawBackground();
                _p.drawTitle( _data );
                _p.drawSubTitle( _data );
                _p.drawVTitle( _data );

                _p.drawCredit( _data );
                _p.drawLegendBox( _data, 'line', function( _ix, _legend, _text, _data ){
                    var _color = _data.stroke 
                                    || Line.Model.DATA_LINE_STYLE.data[ _ix % Line.Model.DATA_LINE_STYLE.data.length ].stroke 
                                    || '#fff';
                    _legend.attr( 'fill', _color ).attr( 'stroke', _color );;
                });

                _p.drawWorkspace( _data );

                _p._model.maxNum( _data );

                _p.drawHLabels( _data );

                _p.drawChartWorkspace( _data );

                _p.drawChartHLines( _data );
                _p.drawChartVLines( _data );

                _p.drawDataLine( _data );
                _p.drawDataPoint( _data, _p._model.dataPoint() );

                _p.drawVLabels( _data, _p._model.vlinePoint() );

                /*
                _p._model.chartWorkspace().mouseover( function( _evt ){
                    JC.log( 'mouseover', new Date().getTime() );
                    JC.dir( _evt );
                });

                _p._model.chartWorkspace().mouseout( function( _evt ){
                    //JC.log( 'mouseout', new Date().getTime() );
                });
                */

                _p._model.chartWorkspace().mouseenter( function( _evt ){
                    Line.CURRENT_INS = _p;
                    _jdoc.on( 'mousemove', Line.DEFAULT_MOVE );
                    _p.trigger( 'moving_start' );
                });

                _p._model.chartWorkspace().mouseleave( function( _evt ){
                    Line.CURRENT_INS = null;
                    _jdoc.off( 'mousemove', Line.DEFAULT_MOVE );
                    _p.trigger( 'moving_done' );
                });

                //JC.log( 'xxxxxxxxxxx', _p._model.chartWorkspace().attr( 'x' ), _p._model.chartWorkspace().attr('width') );

                //this._model.root().legendLine( 100, 200, 18, 1, 9 );
            }
        
        , drawVLabels:
            function( _data, _hlinePoint ){

                var _p = this, _len = _hlinePoint.length, _isAll = _len < 8, _match = {}, _tmp;
                _data.displayAllLabel && ( _isAll = true );

                if( !_isAll ){
                    _match[ 0 ] = true;
                    _match[ _hlinePoint.length - 1 ] = true;

                    _tmp = Math.ceil( _len / 3 );

                    _match[ Math.floor( _tmp * 1 ) - 1 ] = true;
                    _match[ Math.floor( _tmp * 2 ) - 1 ] = true;
                }

                $.each( _hlinePoint, function( _ix, _item ){
                    if( !_isAll && !( _ix in _match ) ) return;

                    var _point = _hlinePoint[ _ix ]
                        , _path = JC.f.printf( 'M{0},{1}L{2},{3}', 
                        Math.round( _point.end.x ), Math.floor( _point.end.y  )
                        , Math.round( _point.end.x ), Math.floor( _point.end.y  ) + 6
                    );
                    _p.root().path( _path ).translate( .5, .5 ).attr( 'stroke', '#9c9c9c' );

                    var _x = _point.end.x
                        , _y = _point.end.y + 6 + 8
                        ;

                    var _text = _p.root().text( _x, _y, _data.xAxis.categories[ _ix ] );
                    if( _ix === 0 ){
                        _text.attr( 'x', _x + _text.getBBox().width / 2 - 2 );
                    }else if( _ix > 0 && _ix == ( _len - 1 ) ){
                        _text.attr( 'x', _x - _text.getBBox().width / 2 + 2 );
                    }
                });
            }

        , drawDataPoint:
            function( _data, _dataPoint ){
                var _p = this, _pointItems = [];
                $.each( _dataPoint, function( _ix, _path ){
                    var _lineStyle = _p._model.dataLineStyle( _ix, _data )
                        , _tmp = [];
                        ;
                    $.each( _path, function( _six, _point ){
                        var _item;

                        switch( _lineStyle.iconType ){
                            default: 
                                {
                                    //_item = _p.root().circle( _point.x, _point.y, _lineStyle.point.radius );
                                    //_p.implmentStyle( _item, _lineStyle.point );
                                    //JC.dir( _lineStyle.point, _point );
                                    var _hoverStyle = JC.f.cloneObject( _lineStyle.point );
                                        _hoverStyle.radius = 8;
                                        _hoverStyle.fill = '#fff';
                                    _item = new JChart.IconPoint( 
                                        _p.root()
                                        , _point.x
                                        , _point.y
                                        , _lineStyle.point.radius 
                                        , _lineStyle.point 
                                        , _hoverStyle
                                    );
                                    _tmp.push( _item );
                                    break;
                                }
                        }
                    });

                    _pointItems.push( _tmp );
                });

                _p._model.pointItems( _pointItems );
            }

        , drawDataLine:
            function( _data ){
                if( !( _data && _data.series ) ) return;
                var _p = this
                    , _dataLine = _p._model.dataLine( _data )
                    , _labelRate = _p._model.labelRate()
                    , _rateInfo = _p._model.rateInfo( _data, _labelRate )
                    , _chartOffset = _p._model.chartWorkspaceOffset()
                    , _partWidth = _chartOffset.width / ( _p._model.vlines().length - 1 )
                    , _partHeight = _chartOffset.height / ( _labelRate.length - 1 )
                    ;

                //JC.log( JC.f.printf( '_partWidth: {0}, _partHeight: {1}', _partWidth, _partHeight ) );

                var _dataPoint = [];
                $.each( _data.series, function( _ix, _items ){
                    var _pathPoints = [], _purePoint = [], _x, _y, _dataHeight, _dataY, _maxNum;
                    $.each( _items.data, function( _six, _num ){
                        //if( _num < 0 ) return;

                        _pathPoints.push( _six === 0 ? 'M' : 'L' );
                        _x = _chartOffset.x + _partWidth * _six;
                        _y = 0;

                        if( JChart.Base.isNegative( _num ) ){
                            _dataHeight = _partHeight * ( _rateInfo.length - _rateInfo.zeroIndex );
                            _dataY = _chartOffset.y + _partHeight * _rateInfo.zeroIndex;
                            _maxNum = Math.abs( _rateInfo.finalMaxNum );

                            _y = _dataY + Math.abs( _num ) / _maxNum * _dataHeight;
                        }else{
                            _dataHeight = _partHeight * _rateInfo.zeroIndex;
                            _dataY = _chartOffset.y;
                            _maxNum = _rateInfo.finalMaxNum;
                            _y = _dataY + _dataHeight - _num / _maxNum * _dataHeight;
                            //JC.log( [ _dataY, _dataHeight ] );
                        }

                        _pathPoints.push( [ _x, _y ] );
                        _purePoint.push( { 'x': _x, 'y': _y, 'num': _num, 'maxNum': _maxNum } );
                    });
                    //JC.log( JSON.stringify( _purePoint ) );
                    _dataPoint.push( _purePoint );
                    _p.setDataLineStyle( _ix, _data );
                    _dataLine[ _ix ] = _dataLine[ _ix ].attr( 'path', _pathPoints.join('') );
                });
                _p._model.dataPoint( _dataPoint );
            }

        , setDataLineStyle:
            function( _ix, _data ){
                var _p = this
                    , _dataLine = _p._model.dataLine()
                    , _item = _dataLine[ _ix ]
                    , _style = _p._model.dataLineStyle( _ix, _data )
                    ;

                for( var _k in _style.line ){
                    _item.attr( _k, _style.line[ _k ] );
                }
            }

        , drawDataLineNegative:
            function( _data ){
            }

        , drawDataLineNormal:
            function( _data ){
            }

        , drawChartVLines:
            function( _data ){
                var _p = this
                    , _vlines = _p._model.vlines( _data )
                    , _wkOffset = _p._model.chartWorkspaceOffset()
                    , _len, _partWidth, _x, _y, _h
                    ;

                if( _vlines && _vlines.length ){
                    _len = _vlines.length - 1;
                    _partWidth = _wkOffset.width / _len;
                    var _vlinePoint = [];

                    $.each( _vlines, function( _ix, _item ){
                        var _linePoint = {};
                        _linePoint.start = { x: Math.floor( _wkOffset.x + _partWidth * _ix ), y: Math.floor( _wkOffset.y ) };
                        _linePoint.end = { x: Math.floor( _wkOffset.x + _partWidth * _ix )
                            , y: Math.floor( _wkOffset.y )  + _wkOffset.height };

                    _item.update(
                        JC.f.printf( 
                            'M{0},{1}L{2},{3}'
                            , _linePoint.start.x, _linePoint.start.y
                            , _linePoint.end.x, _linePoint.end.y
                        )
                        , !JChart.Base.isFloat( _linePoint.start.x )
                    );

                    /*
                        _item.attr( 'path', JC.f.printf( 
                            'M{0},{1}L{2},{3}'
                            , _linePoint.start.x, _linePoint.start.y
                            , _linePoint.end.x, _linePoint.end.y
                        )).data( 'x', _linePoint.start.x ).data( 'y', _linePoint.start.y )
                        .attr( 'stroke', '#9c9c9c' )
                        //.attr( 'opacity', .1 )
                        ;

                        !JChart.Base.isFloat( _linePoint.start.x ) && _item.translate( .5, .5 );
                        */
                        _vlinePoint.push( _linePoint );
                    });
                    _p._model.vlinePoint( _vlinePoint );
                }
            }

        , drawChartHLines:
            function( _data ){
                var _p = this
                    , _hlines = _p._model.hlines( _data )

                    , _vlabels = _p._model.vlables()
                    , _len = _vlabels.length
                    , _wkOffset = _p._model.chartWorkspaceOffset()
                    , _partHeight = _wkOffset.height / ( _len - 1 )
                    , _hlinePoint = []
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    var _bbox = _item.getBBox(), _path, _linePoint = {};

                    _linePoint.start = { x: _wkOffset.x, y: Math.floor( _wkOffset.y + _partHeight * _ix ) };
                    _linePoint.end = { x: _wkOffset.x + _wkOffset.width,  y: _linePoint.start.y };
                    _path = JC.f.printf( 'M{0},{1}L{2},{3}'
                        , _linePoint.start.x, _linePoint.start.y
                        , _linePoint.end.x, _linePoint.end.y
                    );
                    _hlines[ _ix ].attr( 'stroke', '#9c9c9c' )
                        .attr( 'path', _path )
                        .data( 'x', _linePoint.start.x )
                        .data( 'y', _linePoint.start.y )
                        ;

                    !JChart.Base.isFloat( _linePoint.start.y ) && _hlines[ _ix ].translate( .5, .5 );
                    _hlinePoint.push( _linePoint );
                });

                _p._model.hlinePoint( _hlinePoint );
            }

        , drawHLabels:
            function( _data ){
                var _p = this
                    , _vlabels = _p._model.vlables( _data )

                    , _maxNum = _p._model.maxNum( _data )
                    , _rate = JChart.Base.Model.LABEL_RATE
                    , _len = _rate.length
                    , _workspaceOffset = _p._model.workspaceOffset()
                    , _partHeight = _workspaceOffset.height / ( _len - 1 )
                    , _maxItemWidth = 0
                    , _bbox, _y 
                    , _chartWorkspaceOffset = _p._model.chartWorkspaceOffset( _data )
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    _bbox = _item.getBBox();
                    _bbox.width > _maxItemWidth && ( _maxItemWidth = _bbox.width )
                    _y = _workspaceOffset.y + _partHeight * _ix;

                    var _path = JC.f.printf( 'M{0},{1}L{2},{3}', 
                        Math.round( _chartWorkspaceOffset.x - 6 ), Math.floor( _y )
                        , Math.round( _chartWorkspaceOffset.x ), Math.floor( _y )
                    );
                    _p.root().path( _path ).translate( .5, .5 ).attr( 'stroke', '#9c9c9c' );

                    if( _ix === 0 ){
                        _y += _bbox.height / 2 - 4;
                    }else if( _ix === ( _len - 1 ) ){
                        _y -= _bbox.height / 2 - 4;
                    }

                    _item.attr( 'y', _y );
                });

                $.each( _vlabels, function( _ix, _item ){
                    _item.attr( 'x', _workspaceOffset.x - _item.getBBox().width / 2 + _maxItemWidth );
                });
            }
        
        , updateStatus:
            function( _index ){
                var _p = this, _tmp = [];
                _p.clearPointItemStatus();
                _p._model.tips( _index );

                $.each( _p._model.pointItems(), function( _k, _item ){
                    if( _item[ _index ] ){
                        _tmp.push( _item[ _index ] );
                        _item[ _index ].hover();
                    }
                });
                _p._model._prePointItems = _tmp;

                _p._model._preVLineItem = _p._model.vlines()[ _index ].hover();

            }

        , clearPointItemStatus:
            function(){
                var _p = this;
                if( _p._model._prePointItems ){
                    $.each( _p._model._prePointItems, function( _k, _item ){
                        _item.unhover();
                    });
                    _p._model._prePointItems = null;
                }
                if( _p._model._preVLineItem ){
                    _p._model._preVLineItem.unhover();
                    _p._model._preVLineItem = null;
                }

            }

        , clearStatus:
            function(){
                var _p = this;
                _p._model.tips() && _p._model.tips().hide();
                _p.clearPointItemStatus();
            }
    });

    _jdoc.ready( function(){
        Line.autoInit && Line.init();
    });

    return Line;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
