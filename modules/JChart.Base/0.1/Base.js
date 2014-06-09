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

        , width:
            function(){
                var _r = this.selector().prop( 'offsetWidth' );
                this.is( '[chartWidth]' ) && ( _r = this.intProp( 'chartWidth' ) || _r );
                return _r;
            }

        , height:
            function(){
                var _r = this.selector().prop( 'offsetHeight' );
                this.is( '[chartHeight]' ) && ( _r = this.intProp( 'chartHeight' ) || _r );
                return _r;
            }

        , root:
            function(){

                if( !this._root ){
                    this._root = Raphael( this.selector()[0], this.width(), this.height() );
                }

                return this._root;
            }

        , background:
            function( _c ){
                if( _c && _c.stage ){
                    this._background =
                        this.root().rect( _c.stage.x, _c.stage.y, _c.stage.width, _c.stage.height, _c.stage.corner )
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

        , stageCorner: function(){ return 18; }
        
        , data:
            function( _data ){
                typeof _data != 'undefined' && ( this._data = _data );
                return this._data;
            }

        , clear: function(){}

        , legend:
            function( _data, _type, _cb ){
                var _p = this, _tmp = true, _type;

                /*
                var _legend = new JChart.IconLine( _p.root(), 0, 0, 18, 3, 1, 4 );
                return;
                */
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
                                    var _style = _p.seriesStyle( _k );
                                    _legend = new JChart.IconLine( _p.root(), _x, 0 + _by, 18, 3, 1, 4 );
                                    _lb = _legend.getBBox();
                                    _text = _p.root().text( _lb.x + 18 + _spad, 0 + _by, _item.name ).attr( 'text-anchor', 'start');
                                    _tb = _text.getBBox();
                                    _p._legend.addChild( _legend, 'legend_' + _k, { padX: _x - _bx, padY: _tb.height / 2  + 2  } );
                                    _legend.attr( _style );
                                    _legend.attr( 'fill', _style.stroke );
                                    _p._legend.addChild( _text, 'text_' + _k );
                                    _x = _tb.x + _tb.width + _pad;
                                    _h = _tb.height * 1.8;
                                });

                                var _box = _p.root().rect( _bx, _by - _h / 2, _x - _bx, _h, 8 )
                                        .attr( 'stroke-opacity', 1 )
                                        .attr( 'stroke-width', 1 )
                                        .attr( 'stroke', '#909090' )
                                        ;
                                _p._legend.addChild( _box, 'box' );

                                break;
                            }
                    }
                }
                    
                return this._legend;
            }

        , seriesStyle:
            function( _k ){
                var _r = {};
                return _r;
            }

        , title:
            function( _data ){
                _data && _data.title && _data.title.text 
                    && !this._title 
                    && ( this._title = this.root().text( -9999, 0, _data.title.text ) )
                    && ( this._title.node.setAttribute( 'class', 'jcc_title' ) )
                    ;

                return this._title;
            }

        , subtitle:
            function( _data ){
                _data && _data.subtitle && _data.subtitle.text 
                    && !this._subtitle 
                    && ( this._subtitle = this.root().text( 0, 0, _data.subtitle.text ) )
                    && ( this._subtitle.node.setAttribute( 'class', 'jcc_subtitle' ) )
                    ;
                return this._subtitle;
            }

        , vtitle:
            function( _data ){
                _data && _data.yAxis && _data.yAxis.title && _data.yAxis.title.text
                    && !this._vtitle 
                    && ( this._vtitle = this.root().text( -9999, 0, _data.yAxis.title.text )
                          , this._vtitle.node.setAttribute( 'class', 'jcc_vtitle' )   
                        )
                    ;
                return this._vtitle;
            }

        , credits:
            function( _data ){

                if( _data ){
                    _data.credits && _data.credits.enabled && ( _data.credits.text || _data.credits.href )
                        && ! this._credits 
                        && ( this._credits = this.root().text( -9999, 0, _data.credits.text || _data.credits.href ) )
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
                    /*
                    var _tmp = [];
                        _tmp.push( _p._maxNNum );
                        _tmp.push( _p._maxNNum );
                        JC.log( ['maxNNum', _tmp ] );
                    */
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
                    //_finalMaxNum += _finalMaxNum * .2;

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

                    _eles.length && ( _p._vlabels = _p.root().add( _eles ) );
                }
                return this._vlabels;
            }

        , hlables:
            function( _data ){
                if( _data && !this._hlabels ){
                    var _p = this
                        , _eles = []
                        , _tmp
                        ;

                    $.each( _data.xAxis.categories, function( _ix, _item ){
                        _eles.push( {
                            type: 'text'
                            , text: _item || ''
                            , x: -10000
                        });
                    });


                    _eles.length && ( _p._hlabels = _p.root().add( _eles ) );
                }
                return this._hlabels;
            }
        
        , varrowSize: function(){ return 5; }
        , harrowSize: function(){ return 5; }

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
                var _p = this;
                if( !_p._vlines ){
                    _p._vlines = [];
                    $.each( _data.series[0].data, function( _k, _item ){
                        var _tmp = _p.root().path( 'M0 0' );
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
                        var _tmp = _p.root().path( 'M0 0' );
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

        , root: function(){ return this._model.root(); }

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
