;(function(define, _win) { 'use strict'; define( [ 'JChart.BaseMVC' ], function(){
/**
 * 组件用途简述
 *
 *<p><b>require</b>:
 *   <a href='JChart.BaseMVC.html'>JChart.BaseMVC</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jc2.openjavascript.org/docs_api/classes/Bizs.BizExampleMoreAdvance.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/Bizs.BizExampleMoreAdvance/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会自动处理 span class="jchartBizBizExampleMoreAdvance" </h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   window.Bizs
 * @class       BizExampleMoreAdvance
 * @extends     JChart.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-02-12
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>Bizs.BizExampleMoreAdvance 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    Bizs.BizExampleMoreAdvance = BizExampleMoreAdvance;

    function BizExampleMoreAdvance( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JChart.BaseMVC.getInstance( _selector, BizExampleMoreAdvance ) ) 
            return JChart.BaseMVC.getInstance( _selector, BizExampleMoreAdvance );

        JChart.BaseMVC.getInstance( _selector, BizExampleMoreAdvance, this );

        this._model = new BizExampleMoreAdvance.Model( _selector );
        this._view = new BizExampleMoreAdvance.View( this._model );

        this._init();

        JChart.log( BizExampleMoreAdvance.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 BizExampleMoreAdvance 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of BizExampleMoreAdvanceInstance}
     */
    BizExampleMoreAdvance.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jchartBizBizExampleMoreAdvance' )  ){
                    _r.push( new BizExampleMoreAdvance( _selector ) );
                }else{
                    _selector.find( 'span.jchartBizBizExampleMoreAdvance' ).each( function(){
                        _r.push( new BizExampleMoreAdvance( this ) );
                    });
                }
            }
            return _r;
        };

    JChart.BaseMVC.build( BizExampleMoreAdvance );

    JChart.f.extendObject( BizExampleMoreAdvance.prototype, {
        _beforeInit:
            function(){
                JChart.log( 'BizExampleMoreAdvance _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
            }

        , _inited:
            function(){
                JChart.log( 'BizExampleMoreAdvance _inited', new Date().getTime() );
            }
    });

    BizExampleMoreAdvance.Model._instanceName = 'JCBizExampleMoreAdvance';
    JChart.f.extendObject( BizExampleMoreAdvance.Model.prototype, {
        init:
            function(){
                JChart.log( 'BizExampleMoreAdvance.Model.init:', new Date().getTime() );
            }
    });

    JChart.f.extendObject( BizExampleMoreAdvance.View.prototype, {
        init:
            function(){
                JChart.log( 'BizExampleMoreAdvance.View.init:', new Date().getTime() );
            }
    });

    _jdoc.ready( function(){
        var _insAr = 0;
        BizExampleMoreAdvance.autoInit
            && ( _insAr = BizExampleMoreAdvance.init() )
            && $( '<h2>BizExampleMoreAdvance total ins: ' 
                + _insAr.length + '<br/>' + new Date().getTime() + '</h2>' ).appendTo( document.body )
            ;
    });

    return Bizs.BizExampleMoreAdvance;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
