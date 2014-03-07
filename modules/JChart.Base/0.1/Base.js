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

        , stage:
            function(){

                if( !this._stage ){
                    this._stage = new JChart.Stage( this.selector()[0], this.width(), this.height() );
                    this._stage.selector();

                    this.background();

                }

                return this._stage;
            }

        , background:
            function(){
                var _corner = 8
                    , _rect = this._stage.selector().roundedRectangle( 0, 0, this.width(), this.height()
                        , _corner, _corner, _corner, _corner 
                    );

                //this.stage().selector().attr( 'stroke', '#ff0' );
                _rect.attr( 'stroke', '#f00' );
                /*
                var _rect = this._stage.selector().rect( 0, 0, this.width(), this.height() );
                    //_rect.attr( 'fill', '#000' );
                    _rect.attr( 'stroke', '#000' );
                */
            }
        
        , data:
            function( _data ){
                typeof _data != 'undefined' && ( this._data = _data );
                return this._data;
            }

        , clear: function(){}

        , ctitle:
            function( _title ){
                typeof _title != 'undefined' 
                    && !this._ctitle 
                    && ( this._ctitle = this.stage().selector().text( 0, 0, _title ) )
                    && ( this._ctitle.node.className = 'jcc_ctitle' )
                    && ( this._ctitle.node.setAttribute( 'class', 'jcc_ctitle' ) )
                    ;
                return this._ctitle;
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
                if( !_title ) return this;
                var _rp = this._model.ctitle( _title )
                    , _bbox = _rp.getBBox()
                    , _x = ( this._model.width()  ) / 2
                    ;
                //JC.dir( _bbox );
                _rp.attr( 'x', _x );
                _rp.attr( 'y', 20 );

                return this;
              }

        , drawVTitle:
            function( _title, _font ){
                if( !_title ) return;
            }

        , stage: function(){ return this._model.stage(); }
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
