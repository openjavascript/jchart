;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.GraphicPoint', 'JChart.IconVLine', 'JChart.IconLine'  ], function(){
/**
 * 曲线图
 *
 *<p><b>require</b>:
 *   <a href='JChart.Base.html'>JChart.Base</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Demo.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.Demo/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 span class="jchartDemo"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       Demo
 * @extends     JChart.Base
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-11
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JChart.Demo 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Demo = Demo;

    function Demo( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, Demo ) ) 
            return JC.BaseMVC.getInstance( _selector, Demo );

        JC.BaseMVC.getInstance( _selector, Demo, this );

        this._model = new Demo.Model( _selector );
        this._view = new Demo.View( this._model );

        this._init();

        //JC.log( Demo.Model._instanceName, 'all inited', new Date().getTime() );
    }
    Demo.FLASH_PATH = '{0}/flash/pub/charts/Demo.swf';
    /**
     * 初始化可识别的 Demo 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of DemoInstance}
     */
    Demo.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jchartDemo' )  ){
                    _r.push( new Demo( _selector ) );
                }else{
                    JChart.Base.init( Demo, $( 'div.jchartDemo' ), 0, 1 );
                }
            }
            return _r;
        };

    Demo.CURRENT_INS = null;
    Demo.DEFAULT_MOVE =
        function( _evt ){
            /*
            if( !Demo.CURRENT_INS ){
                _jdoc.off( 'mousemove', Demo.DEFAULT_MOVE );
                return;
            }
            var _p = Demo.CURRENT_INS;
            _p.trigger( 'update_moving_status', [ _evt ] );
            */
        };

    JC.BaseMVC.build( Demo, JChart.Base );

    JC.f.extendObject( Demo.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Demo _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                /*
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
                */

                _p.on( JChart.Base.Model.RESET_DISPLAY_SERIES, function( _evt, _data ){
                    _p._model.resetDisplaySeries( _data );
                });

                _p.on( JChart.Base.Model.LEGEND_UPDATE, function( _evt, _ix ){
                    _p._model.updateLegend( _ix );
                });

            }

        , _inited:
            function(){
                //JC.log( 'Demo _inited', new Date().getTime() );
            }
    });

    Demo.Model._instanceName = 'JChartDemo';

    var _oldWorkspaceOffset = Demo.Model.prototype.workspaceOffset;

    JC.f.extendObject( Demo.Model.prototype, {
        init:
            function(){
                //JC.log( 'Demo.Model.init:', new Date().getTime() );
                JChart.Base.Model.prototype.init.call( this );
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
                    var _legend = _p.legend( _data, 'line' );
                    if( _legend ){
                        _bbox = _legend.set().getBBox()
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
                        _bbox = JChart.f.getBBox( _item );
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
                        _bbox = JChart.f.getBBox( _item );
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

                //var _tips = _p.tips();

                return this._coordinate;
            }
    });

    JC.f.extendObject( Demo.View.prototype, {
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
                    //_p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                    JChart.moveSet( _p._model.legend().set(), _c.legend.x, _c.legend.y );
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

                //_p._model.tips().set().toFront();
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

                if( _detect === JChart.Base.Model.FLASH && Demo.FLASH_PATH ){
                    _p.drawFlash( _data, Demo.FLASH_PATH ); 
                }else{
                    _p.drawSVG( _data );
                }
             }
        , drawSVG:
            function( _data ){
                var _p = this, _coordinate;

                _p.setStaticPosition( _p._model.coordinate( _data ) );

                _p._model.dataBackground().mouseenter( function( _evt ){
                    Demo.CURRENT_INS = _p;
                    //JC.log( 'mouseenter', JC.f.ts() );
                    _jwin.on( 'mousemove', Demo.DEFAULT_MOVE );
                    _p.trigger( 'moving_start' );
                });

                _p._model.dataBackground().mouseleave( function( _evt ){
                    //JC.log( 'mouseleave', JC.f.ts() );
                    _p.trigger( 'moving_done' );
                    _jwin.off( 'mousemove', Demo.DEFAULT_MOVE );
                    Demo.CURRENT_INS = null;
                });
                //JC.dir( _p.stage() );
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
        Demo.autoInit && Demo.init();
    });

    _jwin.on( JChart.Base.RESIZE_UPDATE, function( _evt ){
        JChart.Base.reset( 'div.jchartDemo', JChart.Demo );
    });

    return Demo;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
