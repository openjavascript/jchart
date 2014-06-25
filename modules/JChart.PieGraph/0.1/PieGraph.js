;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.IconVLine', 'JChart.GraphicRect' ], function(){
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
                    //_p._view.updateTips( _index, _offset );
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
            { 'stroke': '#09c100', 'stroke-opacity': 0 }
            , { 'stroke': '#FFBF00', 'stroke-opacity': 0 }
            , { 'stroke': '#0c76c4', 'stroke-opacity': 0 }
            , { 'stroke': '#41e2e6', 'stroke-opacity': 0 }

            , { 'stroke': '#ffb2bc', 'stroke-opacity': 0 }

            , { 'stroke': '#dbb8fd', 'stroke-opacity': 0 }

            , { 'stroke': '#ff06b3', 'stroke-opacity': 0 }
            , { 'stroke': '#ff7100', 'stroke-opacity': 0 }
            , { 'stroke': '#c3e2a4', 'stroke-opacity': 0 }

            , { 'stroke': '#ff0619', 'stroke-opacity': 0 }

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

                _p.data().series[ _ix ].style
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ _ix ].style ) );

                _p.data().series[ _ix ].hoverStyle
                    && ( _r = JC.f.extendObject( _r, _p.data().series[ _ix ].hoverStyle ) );

                _r[ 'fill-opacity' ] = .65;

                return _r;
            }

        , lineStyle:
            function( _ix ){
                var _r = JC.f.cloneObject( PieGraph.Model.STYLE.lineStyle );
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
                                    _legend.attr( 'fill', _style.stroke );
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
                    JC.dir( _p._data );
                    _p._data.series && _p._data.series.length && 
                        $.each( _p._data.series[0].data, function( _k, _item ){
                            if( JC.f.isArray( _item ) ){
                                _p._data.series[0].data[ _k ] = { 'name': _item[0], 'y': _item[1] };
                            }
                        });
                }
                return _p._data;
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

                var _tips = _p.tips();

                //JC.dir( this._coordinate );

                return this._coordinate;
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

                _p._model.tips().toFront();

            }

        , draw: 
            function( _data ){
                var _p = this, _coordinate;

                _p.setStaticPosition( _p._model.coordinate( _data ) );

                _p._model.dataBackground().mouseenter( function( _evt ){
                    PieGraph.CURRENT_INS = _p;
                    //JC.log( 'mouseenter', JC.f.ts() );
                    _jdoc.on( 'mousemove', PieGraph.DEFAULT_MOVE );
                    _p.trigger( 'moving_start' );
                });

                _p._model.dataBackground().mouseleave( function( _evt ){
                    //JC.log( 'mouseleave', JC.f.ts() );
                    _p.trigger( 'moving_done' );
                    _jdoc.off( 'mousemove', PieGraph.DEFAULT_MOVE );
                    PieGraph.CURRENT_INS = null;
                });
                //JC.dir( _p.stage() );
            }

        , updateTips:
            function( _ix, _offset ){
                var _p = this
                    , _tips = _p._model.tips( _ix )
                    , _bbox = _tips.getBBox()
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