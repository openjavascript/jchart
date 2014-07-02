;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.GraphicPoint', 'JChart.IconVLine' ], function(){
/**
 * 曲线图
 *
 *<p><b>require</b>:
 *   <a href='JChart.Base.html'>JChart.Base</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.CurveGram.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.CurveGram/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 span class="jchartCurveGram"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       CurveGram
 * @extends     JChart.Base
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-11
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JChart.CurveGram 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.CurveGram = CurveGram;

    function CurveGram( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, CurveGram ) ) 
            return JC.BaseMVC.getInstance( _selector, CurveGram );

        JC.BaseMVC.getInstance( _selector, CurveGram, this );

        this._model = new CurveGram.Model( _selector );
        this._view = new CurveGram.View( this._model );

        this._init();

        //JC.log( CurveGram.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 CurveGram 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of CurveGramInstance}
     */
    CurveGram.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jchartCurveGram' )  ){
                    _r.push( new CurveGram( _selector ) );
                }else{
                    JChart.Base.init( CurveGram, $( 'div.jchartCurveGram' ), 0, 1 );
                }
            }
            return _r;
        };

    CurveGram.CURRENT_INS = null;
    CurveGram.DEFAULT_MOVE =
        function( _evt ){
            if( !CurveGram.CURRENT_INS ){
                _jdoc.off( 'mousemove', CurveGram.DEFAULT_MOVE );
                return;
            }
            var _p = CurveGram.CURRENT_INS;
            //JC.log( 'CurveGram.DEFAULT_MOVE', _evt.pageX, _evt.pageY, JC.f.ts(), _selector.length, _src.nodeName );
            _p.trigger( 'update_moving_status', [ _evt ] );
        };

    JC.BaseMVC.build( CurveGram, JChart.Base );

    JC.f.extendObject( CurveGram.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'CurveGram _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'update_moving_status', function( _evt, _srcEvt, _srcEle ){
                    var _offset = _p._model.globalEventToLocalOffset( _srcEvt )
                        , _index = _p._model.indexAt( _offset );

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
                    //JC.log( _index, _offset.x, _offset.y, JC.f.ts() );
                    _p._view.updateTips( _index, _offset );
                    _p._view.updatePoint( _index );
                    _p._view.updateVLine( _index );
                });
            }

        , _inited:
            function(){
                //JC.log( 'CurveGram _inited', new Date().getTime() );
            }
    });

    CurveGram.Model._instanceName = 'JChartCurveGram';

    CurveGram.Model.STYLE = {
        lineStyle: {
            'stroke': '#999'
            , 'opacity': '.35'
        }
        , style: [
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
        , pathStyle: {
            'stroke-width': 2
        }
        , radius: 4
    };

    var _oldWorkspaceOffset = CurveGram.Model.prototype.workspaceOffset;

    JC.f.extendObject( CurveGram.Model.prototype, {
        init:
            function(){
                //JC.log( 'CurveGram.Model.init:', new Date().getTime() );
            }

        , path:
            function(){
                var _p = this, _tmp, _style;
                if( typeof _p._path == 'undefined' ){
                    _p._path = [];
                    $.each( _p.data().series, function( _k, _item ){
                        _tmp = _p.stage().path( 'M0 0' ).attr(_p.pathStyle( _k ) );
                        _p._path.push( _tmp );
                    });
                }

                return _p._path;
            }

        , point:
            function(){
                var _p = this, _tmp;

                if( typeof _p._point == 'undefined' ){
                    _p._point = [];

                    $.each( _p.data().series, function( _k, _item ){
                        var _items = [];
                        $.each( _item.data, function( _sk, _sitem ){
                            _tmp = new JChart.GraphicPoint( 
                                _p.stage()
                                , 0, 0
                                , CurveGram.Model.STYLE.radius 
                                , _p.itemStyle( _k )
                                , _p.itemHoverStyle( _k )
                            );
                            _items.push( _tmp );
                        });

                        _p._point.push( _items );
                    });
                }

                return _p._point;
            }

        , itemStyle:
            function( _ix ){
                var _r = {}, _p = this
                    , _len = CurveGram.Model.STYLE.style.length
                    , _ix = _ix % ( _len - 1 )
                    ;
                _r = JC.f.cloneObject( CurveGram.Model.STYLE.style[ _ix ] );

                _p.data().series[ _ix ].style
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ _ix ].style ) );

                !_r.fill && _r.stroke && ( _r.fill = _r.stroke );

                return _r;
            }

        , itemHoverStyle:
            function( _ix ){
                var _r = {}, _p = this
                    , _len = CurveGram.Model.STYLE.style.length
                    , _ix = _ix % ( _len - 1 )
                    ;
                _r = JC.f.cloneObject( CurveGram.Model.STYLE.style[ _ix ] );

                _p.data().series[ _ix ].style
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ _ix ].style ) );

                _p.data().series[ _ix ].hoverStyle
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ _ix ].hoverStyle ) );

                !_r.fill && _r.stroke && ( _r.fill = '#fff' );

                return _r;
            }

        , pathStyle:
            function( _ix ){
                var _r = {}, _p = this
                    , _len = CurveGram.Model.STYLE.style.length
                    , _ix = _ix % ( _len - 1 )
                _r = JC.f.cloneObject( CurveGram.Model.STYLE.pathStyle );
                _r.stroke = CurveGram.Model.STYLE.style[ _ix ].stroke;
                return _r;
            }

        , lineStyle:
            function( _ix ){
                var _r = JC.f.cloneObject( CurveGram.Model.STYLE.lineStyle );
                return _r;
            }

        , indexAt:
            function( _offset ){
                var _p = this
                    , _c = _p.coordinate()
                    , _realX = _offset.x - _c.wsX
                    , _realY = _offset.y - _c.wsY
                    , _maxX = _c.wsWidth
                    , _maxY = _c.wsHeight
                    , _itemLen, _partWidth
                    , _partWhat = 0;
                    ;

                if( _realX <= 0 || _realY <= 0 || _realX >= _maxX || _realY >= _maxY ){
                    return undefined;
                }

                _itemLen = ( _c.hlen - 1 ) * 2;
                _partWidth = _c.wsWidth / _itemLen;
                _partWhat = Math.floor( _realX / _partWidth  );
                _partWhat > 1 && ( _partWhat = Math.round( _partWhat / 2 ) );

                //JC.log( _partWhat, _realX, _realY, JC.f.ts() );
                //JC.log( _partWhat );

                return _partWhat;
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

                //JC.log( 'xxxxxxxxxxx', _p.width(), _p.height() );

                _c.stage = { x: 0, y: 0, width: _p.width(), height: _p.height(), corner: _p.stageCorner()  };
                _p.background( _c );
                _x = 2, _y = 2;

                var _title = _p.title( _data );
                if( _title ){
                    _bbox = JChart.Base.getBBox( _title );
                    _c.title = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                        , ele: _title
                    }
                    _y = _c.title.y + _bbox.height / 2;
                }

                var _subtitle = _p.subtitle( _data );
                if( _subtitle ){
                    _bbox = JChart.Base.getBBox( _subtitle );
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
                    _bbox = JChart.Base.getBBox( _vtitle );
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
                    _bbox = JChart.Base.getBBox( _credits );
                    _c.credits = {
                        x: _maxX - _bbox.width / 2
                        , y: _maxY - _bbox.height / 2
                        , ele: _credits
                    }
                    _maxY = _c.credits.y - 8;
                }

                if( _p.showInLegend() ){
                    var _legend = _p.legend( _data, 'line', function( _ix, _legend, _text, _data ){
                        var _color = _data.stroke 
                                        || CurveGram.Model.STYLE.data[ _ix % CurveGram.Model.STYLE.data.length ].stroke 
                                        || '#fff';
                        _legend.attr( 'fill', _color ).attr( 'stroke', _color );;
                    } );
                    if( _legend ){
                        _bbox = JChart.Base.getBBox( _legend );
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

                var _hlabelMaxHeight = _p.hlabelMaxHeight( _data );
                var _vlabelMaxWidth = _p.vlabelMaxWidth( _data );
                var _vx = _x, _hy = _y;

                if( _vlabelMaxWidth ){
                    _x += _vlabelMaxWidth;
                    _vx = _x - _p.harrowSize();
                    _x += 5;
                }

                if( _hlabelMaxHeight ){
                    _maxY -= 2;
                    _maxY -= _hlabelMaxHeight;
                    _hy = _maxY + _p.varrowSize() + 4;
                    _maxY -= 5;
                }

                //JC.log( _x, _maxX, _maxX - _x );

                _c.vlen = _p.vlen();
                _c.hlen = _p.hlen();

                _c.vpart = ( _maxY - _y ) / ( _c.vlen - 1 );
                _c.hpart = ( _maxX - _x ) / ( _c.hlen - 1 );

                _c.wsHeight = _maxY - _y;
                _c.wsY = _y;
                _c.wsMaxY = _maxY;

                _c.wsWidth = _maxX - _x;
                _c.wsX = _x;
                _c.wsMaxX = _maxX;

                var _dataBackground = _p.dataBackground( _c.wsX, _c.wsY, _c.wsWidth, _c.wsHeight );
                if( _dataBackground ){
                    _c.dataBackground = {
                        x: _c.wsX, y: _c.wsY, width: _c.wsWidth, height: _c.wsHeight, item: _dataBackground
                    };
                }

                var _vlines = _p.vlines( _data );
                if( _vlines && _vlines.length ){
                    _tmpA = [];
                    _tmpA1 = [];
                    _tmp = _p.labelDisplayIndex( _data );
                    $.each( _vlines, function( _ix, _item ){
                        _tmpX = _x + _c.hpart * _ix;
                        _padX = _p.varrowSize();
                        if( _tmp && _tmp.length ){
                            !_tmp[ _ix ] && ( _padX = 0 );
                        }
                        _tmpA.push( {  start: { 'x': _tmpX, 'y': _y }
                            , end: { 'x': _tmpX, 'y': _maxY + _padX }
                            , 'item': _item  } );
                        _tmpA1.push( {  start: { 'x': _tmpX, 'y': _y }
                            , end: { 'x': _tmpX, 'y': _maxY }
                            , 'item': _item  } );
                    });
                    _tmpA.length && ( _c.vlines = _tmpA );
                    _tmpA1.length && ( _c.vlinePoint = _tmpA1 );
                }

                var _hlines = _p.hlines( _data );
                if( _hlines && _hlines.length ){
                    _tmpA = [];
                    _tmpA1 = [];
                    $.each( _hlines, function( _ix, _item ){
                        _tmpY = _y + _c.vpart * _ix;
                        _tmpA.push( {  start: { 'x': _x - _p.harrowSize(), 'y': _tmpY }
                            , end: { 'x': _maxX , 'y': _tmpY }
                            , 'item': _item  } );
                        _tmpA1.push( {  start: { 'x': _x, 'y': _tmpY }
                            , end: { 'x': _maxX , 'y': _tmpY }
                            , 'item': _item  } );
                    });
                    _tmpA.length && ( _c.hlines = _tmpA );
                    _tmpA1.length && ( _c.hlinePoint = _tmpA1 );
                }

                if( _vlabelMaxWidth ){
                    var _vlabels = _p.vlables( _data );
                    _tmp = 0;
                    _tmpA = [];
                    $.each( _vlabels, function( _ix, _item ){
                        _bbox = JChart.Base.getBBox( _item );
                        _tmpX = _vx - _bbox.width / 2;
                        _tmpY = parseInt( _y + ( _maxY - _y ) * _tmp );
                        _tmp += .25;
                        _tmpA.push( { 'x': _tmpX, 'y': _tmpY, 'item': _item  } );
                    });
                    _tmpA.length && ( _c.vlables = _tmpA );
                }

                if( _hlabelMaxHeight ){
                    var _hlabels = _p.hlables( _data );
                    _tmp = 0;
                    _tmpA = [];
                    $.each( _c.vlinePoint, function( _ix, _lineItem ){
                        var _item = _hlabels[_ix ], _bbox;
                        if( !_item ) return;
                        _tmpX = _lineItem.end.x;
                        _bbox = JChart.Base.getBBox( _item );
                        if( _ix === ( _c.vlinePoint.length - 1 ) ){
                            _tmpX = _lineItem.end.x - _bbox.width / 2 + 2;
                        }else if( _ix === 0 ){
                            _tmpX = _lineItem.end.x + _bbox.width / 2 - 2;
                        }
                        _tmpY = _hy;
                        _tmpA.push( { 'x': _tmpX, 'y': _tmpY, 'item': _item  } );
                    });
                    _tmpA.length && ( _c.hlables = _tmpA );
                }

                //get data point
                _c.point = [];
                _c.path = [];

                var _rateInfo = _p.rateInfo( _data, _p.rate( _data ) );
                $.each( _data.series, function( _ix, _items ){
                    var _x, _y, _dataHeight, _pathPoint = [], _purePoint = [], _dataY, _maxNum;
                    $.each( _items.data, function( _six, _num ){

                        _pathPoint.push( _six === 0 ? 'M' : 'L' );
                        _x = _c.wsX + _c.hpart * _six;
                        _y = _c.lnieY;

                        if( JChart.Base.isNegative( _num ) ){
                            _num = Math.abs( _num );
                            _dataY = _c.wsY + _c.vpart * _rateInfo.zeroIndex;
                            _dataHeight = _c.vpart * Math.abs( _rateInfo.length - _rateInfo.zeroIndex - 1 );
                            _maxNum = Math.abs( _rateInfo.finalMaxNum * _p.rate()[ _p.rate().length - 1 ] );
                            _y = _dataY + Math.abs( _num ) / _maxNum * _dataHeight;

                        }else{
                            _dataHeight = _c.vpart * _rateInfo.zeroIndex;
                            _dataY = _c.wsY;
                            _maxNum = _rateInfo.finalMaxNum;
                            _y = _dataY + _dataHeight - _num / _maxNum * _dataHeight;
                        }
                        _x > _c.wsMaxX && ( _x = _c.wsMaxX );
                        _y > _c.wsMaxY && ( _y = _c.wsMaxY );

                        _pathPoint.push( [ _x, _y ] );
                        _purePoint.push( { 'x': _x, 'y': _y, 'num': _num, 'maxNum': _maxNum } );
                    });
                    _c.point.push( _purePoint );
                    _c.path.push( _pathPoint );
                });

                var _tips = _p.tips();

                return this._coordinate;
            }
    });

    JC.f.extendObject( CurveGram.View.prototype, {
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
                if( _c.vtitle ){
                    _p._model.vtitle().attr( _c.vtitle );
                    _c.vtitle.rotate && _p._model.vtitle().rotate( _c.vtitle.rotate );
                }
                if( _c.credits ){
                    _p._model.credits().attr( _c.credits );
                }
                if( _c.legend ){
                    _p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                }
                if( _c.vlables ){
                    $.each( _c.vlables, function( _k, _item ){
                        _item.item.attr( { 'x': _item.x, 'y': _item.y } );
                    });
                }
                if( _c.hlables ){
                    $.each( _c.hlables, function( _k, _item ){
                        _item.item.attr( { 'x': _item.x, 'y': _item.y } );
                    });
                }
                if( _c.vlines ){
                    $.each( _c.vlines, function( _k, _item ){
                        _item.item.attr( 'path', JC.f.printf('M{0} {1}L{2} {3}', _item.start.x, _item.start.y, _item.end.x, _item.end.y ) );
                    });
                }
                if( _c.hlines ){
                    $.each( _c.hlines, function( _k, _item ){
                        _item.item && _item.item.attr( 'path', JC.f.printf('M{0} {1}L{2} {3}', _item.start.x, _item.start.y, _item.end.x, _item.end.y ) );
                    });
                }
                if( _c.path && _p._model.path() && _c.path.length == _p._model.path().length ){
                    _tmp = _p._model.path();
                    $.each( _c.path, function( _k, _item ){
                        _tmp[ _k ].attr( 'path', _item.join('') );
                    });
                }
                if( _c.point && _p._model.point() && _c.point.length == _p._model.point().length ){
                    _tmp = _p._model.point();
                    $.each( _c.point, function( _k, _item ){
                        $.each( _item, function( _sk, _sitem ){
                            _tmp[ _k ][ _sk ].attr( { 'cx': _sitem.x, 'cy': _sitem.y } );
                        });
                    });
                }

                _p._model.tips().toFront();
            }

        , draw: 
            function( _data ){
                var _p = this, _coordinate;

                _p.setStaticPosition( _p._model.coordinate( _data ) );

                _p._model.dataBackground().mouseenter( function( _evt ){
                    CurveGram.CURRENT_INS = _p;
                    //JC.log( 'mouseenter', JC.f.ts() );
                    _jwin.on( 'mousemove', CurveGram.DEFAULT_MOVE );
                    _p.trigger( 'moving_start' );
                });

                _p._model.dataBackground().mouseleave( function( _evt ){
                    //JC.log( 'mouseleave', JC.f.ts() );
                    _p.trigger( 'moving_done' );
                    _jwin.off( 'mousemove', CurveGram.DEFAULT_MOVE );
                    CurveGram.CURRENT_INS = null;
                });
                //JC.dir( _p.stage() );
            }

        , updateTips:
            function( _ix, _offset ){
                var _p = this
                    , _tips = _p._model.tips( _ix )
                    , _bbox = JChart.Base.getBBox( _tips )
                    , _c = _p._model.coordinate()
                    , _x = _offset.x + 15, _y = _offset.y + 18
                    , _point = _c.vlinePoint[ _ix ]
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

        , updatePoint:
            function( _ix ){
                var _p = this, _r = [], _preItems = _p._model.preItems() || {};
                $.each( _p._model.point(), function( _k, _item ){
                    _r.push( _item[ _ix ].hover() );
                });

                _preItems.point = _r;
                _p._model.preItems( _preItems );
            }

        , updateVLine:
            function( _ix ){
                var _p = this, _r = [], _preItems = _p._model.preItems() || {};

                _p._model.vlines() 
                    && ( _preItems.vlines = _p._model.vlines()[ _ix ].hover() )
                    && _p._model.preItems( _preItems );
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
        CurveGram.autoInit && CurveGram.init();
    });

    _jwin.on( JChart.Base.RESIZE_UPDATE, function( _evt ){
        JChart.Base.reset( 'div.jchartCurveGram', JChart.CurveGram );
    });

    return CurveGram;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
