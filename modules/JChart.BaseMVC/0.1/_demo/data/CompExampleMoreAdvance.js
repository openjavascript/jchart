;(function(define, _win) { 'use strict'; define( [ 'JChart.BaseMVC' ], function(){
/**
 * 组件用途简述
 *
 *<p><b>require</b>:
 *   <a href="widnow.jQuery.html">jQuery</a>
 *   , <a href="JChart.common.html">JChart.common</a>
 *   , <a href='JChart.BaseMVC.html'>JChart.BaseMVC</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.CompExampleMoreAdvance.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.CompExampleMoreAdvance/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 div class="js_compCompExampleMoreAdvance"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       CompExampleMoreAdvance
 * @extends     JChart.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JChart.CompExampleMoreAdvance 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.CompExampleMoreAdvance = CompExampleMoreAdvance;

    function CompExampleMoreAdvance( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JChart.BaseMVC.getInstance( _selector, CompExampleMoreAdvance ) ) 
            return JC.BaseMVC.getInstance( _selector, CompExampleMoreAdvance );

        JChart.BaseMVC.getInstance( _selector, CompExampleMoreAdvance, this );

        this._model = new CompExampleMoreAdvance.Model( _selector );
        this._view = new CompExampleMoreAdvance.View( this._model );

        this._init();

        JChart.log( CompExampleMoreAdvance.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 CompExampleMoreAdvance 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of CompExampleMoreAdvanceInstance}
     */
    CompExampleMoreAdvance.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'js_compCompExampleMoreAdvance' )  ){
                    _r.push( new CompExampleMoreAdvance( _selector ) );
                }else{
                    _selector.find( 'div.js_compCompExampleMoreAdvance' ).each( function(){
                        _r.push( new CompExampleMoreAdvance( this ) );
                    });
                }
            }
            return _r;
        };

    JChart.BaseMVC.build( CompExampleMoreAdvance );

    JChart.f.extendObject( CompExampleMoreAdvance.prototype, {
        _beforeInit:
            function(){
                JChart.log( 'CompExampleMoreAdvance _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
            }

        , _inited:
            function(){
                JChart.log( 'CompExampleMoreAdvance _inited', new Date().getTime() );
            }
    });

    CompExampleMoreAdvance.Model._instanceName = 'JCCompExampleMoreAdvance';
    JChart.f.extendObject( CompExampleMoreAdvance.Model.prototype, {
        init:
            function(){
                JChart.log( 'CompExampleMoreAdvance.Model.init:', new Date().getTime() );
            }
    });

    JChart.f.extendObject( CompExampleMoreAdvance.View.prototype, {
        init:
            function(){
                JChart.log( 'CompExampleMoreAdvance.View.init:', new Date().getTime() );
            }
    });

    _jdoc.ready( function(){
        var _insAr = 0;
        CompExampleMoreAdvance.autoInit
            && ( _insAr = CompExampleMoreAdvance.init() )
            && $( '<h2>CompExampleMoreAdvance total ins: ' 
                + _insAr.length + '<br/>' + new Date().getTime() + '</h2>' ).appendTo( document.body )
            ;
    });

    return CompExampleMoreAdvance;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
