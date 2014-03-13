;(function(define, _win) { 'use strict'; define( [ 'JC.BaseMVC', 'Raphael' ], function(){
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
                var _r = this.selector().prop( 'ffsetWidth' );
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
                    this.background();
                }

                return this._root;
            }

        , background:
            function(){
                var _corner = 18;
                    
                if( !this._background ){
                    this._background = 
                        this.root().rect( 0, 0, this.width(), this.height(), _corner );

                    this.root().stage = this._background;
                    this.root().selector = this.selector();
                }

                return this._background;
            }
        
        , data:
            function( _data ){
                typeof _data != 'undefined' && ( this._data = _data );
                return this._data;
            }

        , clear: function(){}

        , legendBox:
            function( _data ){
                if( _data ){
                    var _corner = 5;
                    this._legendBox = this.root().rect( 0, 0, 300, 28, _corner );

                    this._legendBox
                        .attr( 'stroke-opacity', 1 )
                        .attr( 'stroke-width', 1 )
                        .attr( 'stroke', '#909090' )
                        .translate( .5, .5 )
                        ;

                    this._hasLegendBox = true;
                }

                return this._legendBox;
            }
        , hasLegendBox: function(){ return this._legendBox; }


        , title:
            function( _title ){
                typeof _title != 'undefined' 
                    && ( this._hasTitle = true )
                    && !this._title 
                    && ( this._title = this.root().text( 0, 0, _title ) )
                    && ( this._title.node.setAttribute( 'class', 'jcc_title' ) )
                    ;

                return this._title;
            }
        , hasTitle: function(){ return this._hasTitle; }

        , subtitle:
            function( _title ){
                typeof _title != 'undefined' 
                    && ( this._hasSubTitle = true )
                    && !this._subtitle 
                    && ( this._subtitle = this.root().text( 0, 0, _title ) )
                    && ( this._subtitle.node.setAttribute( 'class', 'jcc_subtitle' ) )
                    ;
                return this._subtitle;
            }
        , hasSubTitle: function(){ return this._hasSubTitle; }

        , vtitle:
            function( _title ){
                typeof _title != 'undefined' 
                    && ( this._hasVTitle= true )
                    && !this._vtitle 
                    && ( this._vtitle = this.root().text( 0, 0, _title ) )
                    && ( this._vtitle.node.setAttribute( 'class', 'jcc_vtitle' ) )
                    ;
                return this._vtitle;
            }
        , hasVTitle: function(){ return this._hasVTitle; }

        , credit:
            function( _title, _href ){
                typeof _title != 'undefined' 
                    && ( this._hasCredit = true )
                    && !this._credit 
                    && ( this._credit = this.root().text( 0, 0, _title ) )
                    && ( this._credit.node.setAttribute( 'class', 'jcc_credit' ) )
                    ;

                this._credit && _href 
                    && ( 
                            this._credit.node.setAttribute( 'href', _href ) 
                            , this._credit.node.setAttribute( 'class', 'jcc_credit jcc_pointer jcc_link' ) 
                            , this._credit.click( function(){ location.href = _href; } )
                        );
                return this._credit;
            }
        , hasCredit: function(){ return this._hasCredit; }

        , workspaceOffset:
            function( _new ){

                if( _new ){
                    this._workspaceOffset = { x: 0, y: 0, width: this.width(), height: this.height() };
                    var _tmp, _bbox;

                    if( this.hasVTitle() ){
                        _tmp = 10;
                        _bbox = this.vtitle().getBBox();
                        _tmp += _bbox.x + _bbox.width;
                        
                        this._workspaceOffset.x = _tmp;
                        this._workspaceOffset.width = this._workspaceOffset.width - _tmp - 20;
                    }else{
                        _tmp = 15;
                        
                        this._workspaceOffset.x = _tmp;
                        this._workspaceOffset.width = this._workspaceOffset.width - _tmp - 20;
                    }

                    if( this.hasTitle() || this.hasSubTitle() ){
                        _tmp = 5;
                        _bbox = ( this.subtitle() || this.title() ).getBBox();
                        _tmp += _bbox.y + _bbox.height;

                        this._workspaceOffset.y = _tmp;
                        this._workspaceOffset.height = this._workspaceOffset.height - _tmp - 10;
                    }else{
                        _tmp = 15;
                        this._workspaceOffset.y = _tmp;
                        this._workspaceOffset.height = this._workspaceOffset.height - _tmp - 10;
                    }

                    if( this.hasLegendBox() || this.hasCredit() ){
                        _bbox = ( this.legendBox() || this.credit() ).getBBox();
                        _tmp = this.height() - _bbox.y;

                        this._workspaceOffset.height -= _tmp;
                    }
                }

                return this._workspaceOffset;
            }

        , workspace:
            function( _offset ){

                if( _offset ){
                    this._workspace && this._workspace.remove();
                    this._workspace = this.root().add( [ _offset ] )[0];
                }

                return this._workspace;
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

        , chartWorkspaceOffset:
            function( _data ){

                if( _data ){
                    this._chartWorkspaceOffset = JC.f.cloneObject( this.workspaceOffset() );
                }

                return this._chartWorkspaceOffset;
            }

        , chartWorkspace:
            function( _offset ){

                if( _offset ){
                    this._chartWorkspace && this._chartWorkspace.remove();
                    this._chartWorkspace = this.root().add( [ _offset ] )[0];
                }

                return this._chartWorkspace;
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

        , drawChartWorkspace:
            function( _data ){
                var _wkOffset = this._model.chartWorkspaceOffset( _data )
                    , _rp
                    ;

                _rp = this._model.chartWorkspace( _wkOffset );
                /*
                _rp.attr( 'fill-opacity', 1 )
                    .attr( 'fill', '#000' )
                    ;
                */
            }

        , drawWorkspace:
            function( _data ){
                var _wkOffset = this._model.workspaceOffset( _data )
                    , _rp
                    ;

                if( !_wkOffset ){
                    _wkOffset = {
                        x: 0, y: 0
                        , width: this._model.width()
                        , height: this._model.height()
                    };
                }

                JC.f.extendObject( _wkOffset, {
                    type: 'rect'
                    , fill: '#fff'
                    , stroke: '#fff'
                    , 'fill-opacity': .0
                    , 'stroke-opacity': .0
                });

                _rp = this._model.workspace( _wkOffset );
            }

        , drawLegendBox:
            function( _data ){
                var _rp = this._model.legendBox( _data )
                    , _bbox = _rp.getBBox()
                    , _x = this._model.width() / 2 - 150
                    , _y = this._model.height() - 10 - 28
                    ;
                        ;
                    if( this._model.hasCredit() ){
                        _y -= 18;
                    }

                _rp.attr( 'x', _x ).attr( 'y', _y );
            }

        , drawCredit:
            function( _data, _font ){
                if( !( _data && _data.credits && _data.credits.enabled &&
                        ( _data.credits.text || _data.credits.href  )
                    ) ) return;

                var _text = _data.credits.text || _data.credits.href
                    , _rp = this._model.credit( _text, _data.credits.href )
                    , _bbox = _rp.getBBox()
                    , _x = this._model.width() - _bbox.width / 2 - 20
                    , _y = ( this._model.height() ) - 15
                    ;

                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                return;
            }

        , drawVTitle:
            function( _data, _font ){
                if( !( _data && _data.yAxis && _data.yAxis.title && _data.yAxis.title.text ) ) return;
                var _rp = this._model.vtitle( _data.yAxis.title.text )
                    , _bbox = _rp.getBBox()
                    , _x = 20
                    , _y = ( this._model.height() ) / 2
                    ;

                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                _rp.rotate( -90 ); 

                return;
            }

        , drawSubTitle:
            function( _data, _font ){
                if( !( _data && _data.subtitle && _data.subtitle.text ) ) return;
                var _rp = this._model.subtitle( _data.subtitle.text )
                    , _bbox = _rp.getBBox()
                    , _x = ( this._model.width()  ) / 2
                    , _y = 20
                    ;
                if( this._model.hasTitle() ){
                    var _titleRp = this._model.title().getBBox();
                    _y = _titleRp.y2 + 10;
                }
                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                return;
              }

        , drawTitle:
            function( _data, _font ){
                if( !( _data && _data.title && _data.title.text) ) return;
                var _rp = this._model.title( _data.title.text )
                    , _bbox = _rp.getBBox()
                    , _x = ( this._model.width()  ) / 2
                    , _y = 20
                    ;
                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                return;
              }

        , root: function(){ return this._model.root(); }

        , implmentStyle:
            function( _item, _style ){
                if( _style ){
                    for( var _k in _style ){
                        _item.attr( _k, _style[ _k ] );
                    }
                }
                return _item;
            }

        , drawBackground:
            function(){

                this._model._background
                    .attr( 'fill-opacity', .08 )
                    .attr( 'fill', '#ccc' )

                    .attr( 'stroke-opacity', .0 )
                    .attr( 'stroke-width', 1 )
                    .attr( 'stroke', '#fff' )
                    ;
            }
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

        Raphael.fn.triangle = function(x, y, size) {
          var half = size / 2, path = ["M", x, y - size ];
          path = path.concat(["L", (x + size), (y + half)]);
          path = path.concat(["L", (x - size), (y + half)]);
          return this.path(path.concat(["z"]).join(" ")).attr( 'fill', '#fff' );
        };

        function pointRectangleIntersection(p, r) {
            return p.x >= r.x && p.x <= r.x2 && p.y > r.y && p.y < r.y2;
        }

        Raphael.el.mouseenter =
            function( _handler ){
                var _p = this, _bbox, _doc = $( document ), _rect;
                if( !_p.paper.stage ) return;

                _p.mouseover( function( _evt ){
                    if( _p.IS_ENTER ) return;
                    var _offset;
                    _handler && _handler.call( _p, _evt );
                    _bbox = _p.getBBox();
                    _p.IS_ENTER = true;
                    _offset = $( _p.paper.selector ).offset();
                    _offset.x = _offset.left;
                    _offset.y = _offset.top;
                    _rect = {
                        x: _offset.x + _bbox.x
                        , x2: _offset.x + _bbox.x2
                        , y: _offset.y + _bbox.y
                        , y2: _offset.y + _bbox.y2
                    };
                    _doc.on( 'mousemove', _innerMousemove );
                });

                function _innerMousemove( _evt ){
                    if( !_bbox ) return;
                    var _offset = { x: _evt.pageX, y : _evt.pageY };
                    if( pointRectangleIntersection( _offset, _rect ) ){
                    }else{
                        _bbox = null;
                        _p.IS_ENTER = false;
                        _doc.off( 'mousemove', _innerMousemove );
                    }
                }
            };

        Raphael.el.mouseleave =
            function( _handler ){
                var _p = this, _bbox, _doc = $( document ), _rect;
                if( !_p.paper.stage ) return;

                _p.mouseover( function( _evt ){
                    if( _p.IS_LEAVE ) return;
                    var _offset;
                    _bbox = _p.getBBox();
                    _p.IS_LEAVE = true;
                    _offset = $( _p.paper.selector ).offset();
                    _offset.x = _offset.left;
                    _offset.y = _offset.top;
                    _rect = {
                        x: _offset.x + _bbox.x
                        , x2: _offset.x + _bbox.x2
                        , y: _offset.y + _bbox.y
                        , y2: _offset.y + _bbox.y2
                    };
                    _doc.on( 'mousemove', _innerMousemove );
                });

                function _innerMousemove( _evt ){
                    if( !_bbox ) return;
                    var _offset = { x: _evt.pageX, y : _evt.pageY };
                    if( pointRectangleIntersection( _offset, _rect ) ){
                    }else{
                        _bbox = null;
                        _p.IS_LEAVE = false;
                        _handler && _handler.call( _p, _evt );
                        _doc.off( 'mousemove', _innerMousemove );
                    }
                }
            };
        
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
