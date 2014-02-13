;(function(define, _win) { 'use strict'; define( [ 'JChart.Stage' ], function(){
/**
 * 组件用途简述
 *
 *<p><b>require</b>:
 *   <a href='JChart.Stage.html'>JChart.Stage</a>
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

        , stage:
            function(){

                if( !this._stage ){
                    this._stage = new JChart.Stage( this.width(), this.height(), true );
                    this._stage.selector().appendTo( this.selector() );
                    this._stage.roundedRect( 0, 0, this.width(), this.height() );
                }

                return this._stage;
            }
        
        , data:
            function( _data ){
                typeof _data != 'undefined' && ( this._data = _data );
                return this._data;
            }

        , clear: function(){}

        , htitle:
            function( _setter ){
                if( typeof _setter != 'undefined' ){
                    this._htitle && this._htitle.remove();
                    this._htitle =  _setter;
                    this.stage().add( _setter );
                    _setter.selector().appendTo( this.selector() );
                }
                return this._htitle;
            }

        , vtitle:
            function( _setter ){
                if( typeof _setter != 'undefined' ){
                    this._vtitle && this._vtitle.remove();
                    this._vtitle =  _setter;
                    this.stage().add( _setter );
                    _setter.selector().appendTo( this.selector() );
                }
                return this._vtitle;
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

        , drawCTitle:
            function( _title, _font ){
                if( !_title ) return;
                !_font && ( _font = '16px sans-serif' );
                var _htitle = new JChart.Stage( this.width(), this.height() )
                    , _textSize = _htitle.textSize( _title, _font )
                    , _x = this.width() / 2 - _textSize.width / 2
                    , _y = _textSize.height + 10
                    ;

                //JC.log( 'width:', _textSize.width, 'height:', _textSize.height, _htitle.context().font );

                this._model.htitle( _htitle );
                this._model.htitle().context().fillText( _title, _x, _y );
                this._model.htitle().graphicRect( _x, _y, _textSize.width, _textSize.height );
            }

        , drawVTitle:
            function( _title, _font ){
                if( !_title ) return;
                !_font && ( _font = '16px 宋体' );
                var _vtitle = new JChart.Stage( this.width(), this.height() )
                    , _textSize = _vtitle.textSize( _title, _font )
                    , _x = 0
                    , _offsetY = 5
                    , _y = _textSize.height + _offsetY
                    ;

                _vtitle.context().translate( _x, _textSize.width + ( this.height() - _textSize.width ) / 2 );
                _vtitle.rotate( -90 );
                this._model.vtitle( _vtitle );
                _vtitle.context().fillText( _title, _x, _y );
                _vtitle.graphicRect( _x, _y, _textSize.width, _textSize.height );

            }
    });

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
