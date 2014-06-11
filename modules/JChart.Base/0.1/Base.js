;(function(define, _win) { 'use strict'; define( [ 'JC.BaseMVC', 'Raphael', 'JChart.Event', 'JChart.Graphics', 'JChart.Group', 'JChart.IconLine' ], function(){
window.JChart = window.JChart || {};
/**
 * 组件用途简述
 *
 *<p><b>require</b>:
 *   <a href='JC.BaseMVC.html'>JC.BaseMVC</a>
 *   , <a href='Raphael.html'>RaphaelJS</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Base.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.Base/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 div class="js_compBase"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       Base
 * @extends     JC.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-02-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.Base 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Base = Base;

    function Base( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, Base ) ) 
            return JC.BaseMVC.getInstance( _selector, Base );

        JC.BaseMVC.getInstance( _selector, Base, this );

        this._model = new Base.Model( _selector );
        this._view = new Base.View( this._model );

        this._init();

        //JC.log( Base.Model._instanceName, 'all inited', new Date().getTime() );
    }
    JC.BaseMVC.build( Base );

    var _oldInit = Base.prototype._init;

    JC.f.extendObject( Base.prototype, {
        _init:
            function(){
                _oldInit.call( this );

                this.on( 'update', function( _evt, _data ){
                    this._view.update( _data );
                });

                this._initData();
            }

        , _beforeInit:
            function(){
            }

        , _initHanlderEvent:
            function(){
            }

        , _inited:
            function(){
                _p._initData();
            }

        /**
         * 初始化数据
         */
        , _initData:
            function(){
                var _data;
                if( this.selector().attr( 'chartScriptData' ) ){
                    _data = JC.f.scriptContent( this._model.selectorProp( 'chartScriptData' ) );
                    _data = eval( '(' + _data + ')' );
                    this.trigger( 'update', [ _data ] );
                }
                return this;
            }
    });

    Base.Model._instanceName = 'JChartBase';
    Base.Model.LABEL_RATE = [ 1, .75, .5, .25, 0 ];

    JC.f.extendObject( Base.Model.prototype, {
        init:
            function(){
                //JC.log( 'Base.Model.init:', new Date().getTime() );
            }
        /**
         * 图表宽度
         */
        , width:
            function(){
                var _r = this.selector().prop( 'offsetWidth' );
                this.is( '[chartWidth]' ) && ( _r = this.intProp( 'chartWidth' ) || _r );
                return _r;
            }
        /**
         * 图表高度
         */
        , height:
            function(){
                var _r = this.selector().prop( 'offsetHeight' );
                this.is( '[chartHeight]' ) && ( _r = this.intProp( 'chartHeight' ) || _r );
                return _r;
            }
        /**
         * 图表画布
         */
        , stage:
            function(){

                if( !this._stage ){
                    this._stage = Raphael( this.selector()[0], this.width(), this.height() );
                    this._stage.selector = this._stage.canvas;
                }

                return this._stage;
            }
        /**
         * 画布圆角弧度 
         */
        , stageCorner: function(){ return 18; }
        /**
         * 图表背景
         */
        , background:
            function( _c ){
                if( _c && _c.stage ){
                    this._background =
                        this.stage().rect( _c.stage.x, _c.stage.y, _c.stage.width, _c.stage.height, _c.stage.corner )
                            .attr( { 
                                'fill-opacity': .08 
                                , 'fill': '#ccc'
                                , 'stroke-opacity': .0
                                , 'stroke-width': 1   
                                , 'stroke': '#fff'    
                            } );
                }
                return this._background;
            }
        /**
         * 图表数据背景
         */
        , dataBackground:
            function( _x, _y, _width, _height ){
                if( typeof this._dataBackground == 'undefined' ){
                    this._dataBackground = this.stage().rect( _x, _y, _width, _height );
                    this._dataBackground.attr( { 'fill': '#fff', 'fill-opacity': .01, 'stroke-width': 0 } );
                }
                return this._dataBackground;
            }
        /**
         * 保存图表数据
         */
        , data:
            function( _data ){
                typeof _data != 'undefined' && ( this._data = _data );
                return this._data;
            }
        /**
         * 清除图表数据
         */
        , clear: function(){}
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
                        case 'line':
                            {
                                var _text = [], _minX = 8, _x = _minX, _y = 0, _maxX = 0, _legend, _text, _spad = 2, _pad = 8, _bx = 100, _by = 100, _tb, _lb, _h = 30;
                                _x += _bx;
                                $.each( _data.series, function( _k, _item ){
                                    if( !_item.name ) return;
                                    var _style = _p.itemStyle( _k );
                                    _legend = new JChart.IconLine( _p.stage(), _x, 0 + _by, 18, 3, 1, 4 );
                                    _lb = _legend.getBBox();
                                    _text = _p.stage().text( _lb.x + 18 + _spad, 0 + _by, _item.name ).attr( 'text-anchor', 'start');
                                    _tb = _text.getBBox();
                                    _p._legend.addChild( _legend, 'legend_' + _k, { padX: _x - _bx, padY: _tb.height / 2  + 2  } );
                                    _legend.attr( _style );
                                    _legend.attr( 'fill', _style.stroke );
                                    _p._legend.addChild( _text, 'text_' + _k );
                                    _x = _tb.x + _tb.width + _pad;
                                    _h = _tb.height * 1.8;
                                });

                                var _box = _p.stage().rect( _bx, _by - _h / 2, _x - _bx, _h, 8 )
                                        .attr( { 'stroke-opacity': .99, 'fill-opacity': .99, 'stroke-width': 1, 'stroke': '#909090' } );
                                _p._legend.addChild( _box, 'box' );

                                break;
                            }
                    }
                }
                    
                return this._legend;
            }
        /**
         * 图表标题
         */
        , title:
            function( _data ){
                _data && _data.title && _data.title.text 
                    && !this._title 
                    && ( this._title = this.stage().text( -9999, 0, _data.title.text ) )
                    && ( this._title.node.setAttribute( 'class', 'jcc_title' ) )
                    ;

                return this._title;
            }
        /**
         * 图表子标题
         */
        , subtitle:
            function( _data ){
                _data && _data.subtitle && _data.subtitle.text 
                    && !this._subtitle 
                    && ( this._subtitle = this.stage().text( 0, 0, _data.subtitle.text ) )
                    && ( this._subtitle.node.setAttribute( 'class', 'jcc_subtitle' ) )
                    ;
                return this._subtitle;
            }
        /**
         * 图表垂直标题
         */
        , vtitle:
            function( _data ){
                _data && _data.yAxis && _data.yAxis.title && _data.yAxis.title.text
                    && !this._vtitle 
                    && ( this._vtitle = this.stage().text( -9999, 0, _data.yAxis.title.text )
                          , this._vtitle.node.setAttribute( 'class', 'jcc_vtitle' )   
                        )
                    ;
                return this._vtitle;
            }
        /**
         * 图表版权 */
        , credits:
            function( _data ){

                if( _data ){
                    _data.credits && _data.credits.enabled && ( _data.credits.text || _data.credits.href )
                        && ! this._credits 
                        && ( this._credits = this.stage().text( -9999, 0, _data.credits.text || _data.credits.href ) )
                        && ( this._credits.node.setAttribute( 'class', 'jcc_credit' ) )
                        ;
                    this._credits && _data.credits.href
                        && ( 
                                this._credits.node.setAttribute( 'href', _data.credits.href ) 
                                , this._credits.node.setAttribute( 'class', 'jcc_credit jcc_pointer jcc_link' ) 
                                , this._credits.click( function(){ location.href = _data.credits.href; } )
                            );
                }
                return this._credits;
            }
        /**
         * 图表
         */
        , hlen:
            function( _data ){
                var _p = this;
                _data = _data || _p.data();

                if( typeof this._hlen == 'undefined' ){
                    _data.xAxis && _data.xAxis.categories && ( this._hlen = _data.xAxis.categories.length );
                    _data.series && _data.series.data && ( this._hlen = _data.series.data.length );
                }
                return this._hlen;
            }

        , vlen:
            function( _data ){
                var _p = this;
                _data = _data || _p.data();

                if( typeof this._vlen == 'undefined' ){
                    this._vlen = _p.labelRate().length;
                    
                }
                return this._vlen;
            }

        , maxNum:
            function( _data ){

                var _tmp, _p = this;

                if( _data ){
                    _p._maxNum = 0;

                    if( _data ){
                        $.each( _data.series, function( _ix, _item ){
                            _tmp = Math.max.apply( null, _item.data );
                            _tmp > _p._maxNum && ( _p._maxNum = _tmp );
                        });

                    }
                    var _tmp = [];
                        _tmp.push( _p._maxNum );
                    _p._maxNum && ( _p._maxNum = numberUp( _p._maxNum ) );
                        _tmp.push( _p._maxNum );
                    _p._maxNum === 0 && ( _p._maxNum = 10 );
                        _tmp.push( _p._maxNum );
                        //JC.log( ['maxNum', _tmp ] );
                }

                return _p._maxNum;
            }

        , maxNNum:
            function( _data ){
                var _tmp, _p = this;

                if( _data ){
                    _p._maxNNum = 0;

                    if( _data ){
                        $.each( _data.series, function( _ix, _item ){
                            _tmp = Math.min.apply( null, _item.data );
                            _tmp < 0 && _tmp < _p._maxNNum && ( _p._maxNNum = _tmp );
                        });

                    }
                }

                return _p._maxNNum;
            }

        , labelRate:
            function( _data ){
                var _p = this;
                
                if( _data && hasNegative( _data ) ){
                    this._labelRate = [ 1, .5, 0, -.5, -1 ];
                }else if( _data ){
                    this._labelRate = Base.Model.LABEL_RATE;
                }

                return this._labelRate;
            }

        , rateInfo:
            function( _data, _labelRate ){

                var _p = this, _maxNum, _maxNNum, _absNNum, _finalMaxNum
                    , _zeroIndex
                    ;

                if( _data && _labelRate ){

                    _maxNum = _p.maxNum( _data );
                    _maxNNum = _p.maxNNum( _data );
                    _absNNum = Math.abs( _maxNNum );
                    _finalMaxNum = Math.max( _maxNum, _absNNum );

                    _zeroIndex = 0;

                    $.each( _labelRate, function( _ix, _item ){
                        if( _item === 0 ){
                            _zeroIndex = _ix;
                            return false;
                        }
                    });

                    this._rateInfo = {
                        rates: _labelRate
                        , zeroIndex: _zeroIndex
                        , finalMaxNum: _finalMaxNum
                        , maxNum: _maxNum
                        , maxNNum: -_finalMaxNum
                        , length: _labelRate.length
                    };
                }

                return this._rateInfo;
            }

        , vlables:
            function( _data ){
                if( _data && !this._vlabels ){
                    var _p = this
                        , _maxNum = _p.maxNum( _data )
                        , _rate = _p.labelRate( _data )
                        , _eles = []
                        ;

                    $.each( _rate, function( _ix, _item ){
                        _eles.push( {
                            type: 'text'
                            , text: ( _maxNum * _item ).toString()
                            , x: -10000
                        });
                    });

                    _eles.length && ( _p._vlabels = _p.stage().add( _eles ) );
                }
                return this._vlabels;
            }

        , hlables:
            function( _data ){
                if( _data && !this._hlabels ){
                    var _p = this
                        , _eles = []
                        , _tmp
                        , _match = _p.labelDisplayIndex( _data )
                        ;

                    $.each( _data.xAxis.categories, function( _ix, _item ){
                        _tmp = _p.stage().text( 10000, 0, _item || '' );
                        _match && _match.length && !_match[ _ix ] && _tmp.hide();
                        _eles.push( _tmp );
                    });

                    _eles.length && ( _p._hlabels = _eles );
                }
                return this._hlabels;
            }

        , labelDisplayIndex:
            function( _data ){
                var _p = this, _tmp, _len;
                if( typeof _p._labelDisplayIndex == 'undefined' ){
                    _len = _p.hlen( _data );
                    if( !_p.displayAllLabel( _data ) ){
                        _p._labelDisplayIndex = [];
                        _p._labelDisplayIndex[ 0 ] = true;
                        _p._labelDisplayIndex[ _len - 1 ] = true;

                        _tmp = Math.ceil( _len / 3 );

                        _p._labelDisplayIndex[ Math.floor( _tmp * 1 ) - 1 ] = true;
                        _p._labelDisplayIndex[ Math.floor( _tmp * 2 ) - 1 ] = true;
                    }

                    !_p._labelDisplayIndex && ( _p._labelDisplayIndex = null );
                }
                return _p._labelDisplayIndex;
            }
        
        , varrowSize: function(){ return 8; }
        , harrowSize: function(){ return 8; }

        , vlabelMaxWidth:
            function( _data ){
                var _r = 0, _p = this, _tmp;

                _p.vlables( _data ) && $.each( _p.vlables( _data ), function( _k, _item ){
                    _tmp = _item.getBBox();
                    _tmp.width > _r && ( _r = _tmp.width );
                });

                return _r;
            }

        , hlabelMaxHeight:
            function( _data ){
                var _r = 0, _p = this, _tmp;

                _p.hlables( _data ) && $.each( _p.hlables(), function( _k, _item ){
                    _tmp = _item.getBBox();
                     _tmp.height > _r && ( _r = _tmp.height );
                });

                return _r;
            }

        , vlines:
            function( _data ){
                var _p = this, _items;
                if( !_p._vlines ){
                    _p._vlines = [];

                    _data && _data.xAxis && _data.xAxis.categories && ( _items = _data.xAxis.categories );
                    _data 
                        && _data.series 
                        && _data.series[0]
                        && _data.series[0].data
                        && _data.series[0].data.length
                        && ( _items = _data.series[0].data );

                    _items && 
                        $.each( _items, function( _k, _item ){
                        //var _tmp = _p.stage().path( 'M0 0' ).attr( _p.lineStyle( _k ) );
                        var _tmp = new JChart.IconVLine( 
                            _p.stage()
                            , ['M0 0'].join(' ' )
                            , JC.f.extendObject( _p.lineStyle( _k ), { 'stroke': '#999', 'stroke-width': 1 } )
                            , JC.f.extendObject( _p.lineStyle( _k ), { 'stroke': '#000', 'stroke-width': 1 } )
                        );
                        _p._vlines.push( _tmp );
                    });
                }
                return _p._vlines;
            }

        , hlines:
            function( _data ){
                var _p = this;
                if( !_p._hlines ){
                    _p._hlines = [];
                    $.each( _p.labelRate(), function( _k, _item ){
                        var _tmp = _p.stage().path( 'M0 0' ).attr( _p.lineStyle( _k ) );
                        _p._hlines.push( _tmp );
                    });
                }
                return _p._hlines;
            }

        , calcCoordinate:
            function(){
            }

        , coordinate: 
            function( _setter ){ 
                typeof _setter != 'undefined' && ( this._coordinate = _setter );
                return this._coordinate; 
            }

        , itemStyle:
            function( _ix ){
                var _r = {};
                return _r;
            }

        , itemHoverStyle:
            function( _ix ){
                var _r = {};
                return _r;
            }

        , pathStyle:
            function( _ix ){
                var _r = {};
                return _r;
            }

        , lineStyle:
            function( _ix ){
                var _r = {};
                return _r;
            }

        , indexAt:
            function( _srcEvt ){
                return 0;
            }

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
                            , 'fill-opacity': .94
                        } )
                    , 'rect' );

                    _p._tips.addChild( _p.stage().text( 10 + _initOffset.x, 14 + _initOffset.y, 'tips' )
                            .attr( { 'font-weight': 'bold', 'fill': '#999', 'text-anchor': 'start' } )
                            , 'title' );

                    $.each( _p.data().series, function( _k, _item ){
                        _strokeColor = _p.itemStyle( _k ).stroke;
                        _tmp = _p.stage().text( _offsetX + _initOffset.x, _offsetY + _initOffset.y, _item.name || 'empty' )
                                .attr( { 'text-anchor': 'start', 'fill': _strokeColor } );
                        _tmpBox = _tmp.getBBox();
                        _p._tips.addChild( _tmp, 'label_' + _k );
                        _offsetY += _tmpBox.height + 5;
                        _tmpBox.width > _maxWidth && ( _maxWidth = _tmpBox.width );
                    });

                    $.each( _p.data().series, function( _k, _item ){
                        _strokeColor = _p.itemStyle( _k ).stroke;
                        _tmpItem = _p._tips.getChildByName( 'label_' + _k );
                        _tmpBox = _tmpItem.getBBox();
                        _tmp = _p.stage().text( _maxWidth + _offsetX + 10 + _initOffset.x, _tmpItem.attr( 'y' ) + _initOffset.y, '012345678901.00' )
                                .attr( { 'text-anchor': 'start', 'fill': _strokeColor } );
                        _p._tips.addChild( _tmp, 'val_' + _k );
                    });

                    $.each( _p.data().series, function( _k, _item ){
                        _tmpItem = _p._tips.getChildByName( 'val_' + _k );
                        _tmpItem.attr( 'text', '0.00' );
                    });
                }
                if( typeof _ix != 'undefined' ){
                    _p._tips.getChildByName( 'title' ).attr( 'text', _p.tipsTitle( _ix ) );
                    $.each( _p.data().series, function( _k, _item ){
                        _p._tips.getChildByName( 'val_' + _k ).attr( 'text', JC.f.moneyFormat( _item.data[ _ix ] ) );
                    });
                }
                _p._tips.getChildByName( 'rect' ).attr( { width: 80, height: 50 } );
                _tmpBox = _p._tips.getBBox();
                _p._tips.getChildByName( 'rect' ).attr( { 'width': _tmpBox.width + _padWidth, 'height': _tmpBox.height + _padHeight } );

                return _p._tips;
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

        , globalEventToLocalOffset:
            function( _evt ){
                var _p = this, _srcOffset = $( _p.stage().canvas ).offset(), _r = { x: 0, y: 0 }, _c = _p.coordinate();
                _r.x = _evt.pageX  - _srcOffset.left;
                _r.y = _evt.pageY - _srcOffset.top;
                return _r;
            }

        , preItems:
            function( _setter ){
                typeof _setter != 'undefined' && ( this._preItems = _setter );
                return this._preItems;
            }

        , displayAllLabel: function(){ return this.data().displayAllLabel; }
    });

    JC.f.extendObject( Base.View.prototype, {
        init:
            function(){
                //JC.log( 'Base.View.init:', new Date().getTime() );
            }

        , width: function(){ return this._model.width(); }
        , height: function(){ return this._model.height(); }

        , selector:
            function(){
                return this._model.selector();
            }

        , clear: 
            function(){
                this.selector().find( 'canvas' ).remove();
            }

        , update: 
            function( _data ){
                this.clear();
                this._model.clear();
                this._model.data( _data );
                this.draw( _data );
            }

        , draw: 
            function( _data ){
            }

        , stage: function(){ return this._model.stage(); }

    });

    Base.numberUp = numberUp;
    Base.isFloat = isFloat;
    Base.isNegative = isNegative;
    Base.hasNegative = hasNegative;

    function isNegative( _num ){
        return _num < 0;
    }

    function hasNegative( _data ){
        var _r = false;

        if( _data && _data.series ){
            $.each( _data.series, function( _ix, _item ){
                var _tmp = Math.min.apply( null, _item.data );
                if( _tmp < 0 ){
                    _r = true;
                    return false;
                }
            });
        }

        return _r;
    }

    function isFloat( _num ){
        return ( _num - parseInt( _num ) ) > 0;
    }

    function numberUp( _in, _floatLen ){
        _floatLen = _floatLen || 5;
        var _out = 0, _inStr = _in.toFixed( _floatLen )
            , _part = _inStr.split( '.' )
            , _int = _part[0], _float = parseFloat( '0.' + _part[ 1 ] )
            , _ar 
            , i, j, tmp
            ;
        
        if( /[1-9]/.test( _int ) ){
            tmp = Math.pow( 10, _int.length - 1  ), _out = tmp * ( parseInt( _int[0] ) +  1);
            if( _out < _in ){
                _out = tmp * 10;
            }

        }else{						
            for( _ar = _float.toFixed( _floatLen ).split(''), i = 0, j = _ar.length; i < j; i++ ){
                if( _ar[i] != '0' && _ar[i] != '.' ){
                    tmp = parseFloat( _ar.slice( 0, i ).join('') + '1'  )
                    , _out = tmp + parseFloat( _ar.slice( 0, i ).join('') + parseInt( _ar[i] )  )
                    ;
                    if( _out < _float ){
                        _out = tmp * 10;
                    }
                    
                    break;
                }
            }
        }
        
        return _out;
    }

    return JChart.Base;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
