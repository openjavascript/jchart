 ;(function(define, _win) { 'use strict'; define( [ 'JC.BaseMVC' ], function(){
/**
 * 切换 Flash 图表与 SVG 图表
 *
 *  <p><b>require</b>:
 *      <a href='JC.BaseMVC.html'>JC.BaseMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jchart.openjavascript.org/docs_api/classes/JC.Test.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.Test/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *  <h2>页面只要引用本脚本, 默认会处理 div class="js_compTest"</h2>
 *
 *  <h2>可用的 HTML attribute</h2>
 *
 *  <dl>
 *      <dt></dt>
 *      <dd><dd>
 *  </dl> 
 *
 * @namespace   JChart
 * @class       Test
 * @extends     JC.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.Test 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JC.Test = Test;

    function Test( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, Test ) ) 
            return JC.BaseMVC.getInstance( _selector, Test );

        JC.BaseMVC.getInstance( _selector, Test, this );

        this._model = new Test.Model( _selector );
        this._view = new Test.View( this._model );

        this._init();

        //JC.log( Test.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 Test 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of TestInstance}
     */
    Test.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'js_jchartTest' )  ){
                    _r.push( new Test( _selector ) );
                }else{
                    _selector.find( 'div.js_jchartTest' ).each( function(){
                        _r.push( new Test( this ) );
                    });
                }
            }
            return _r;
        };

    JC.BaseMVC.build( Test );

    JC.f.extendObject( Test.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Test _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                    var _selected = JC.f.getUrlParam( 'jchart_display' );
                    if( _selected === '1' ){
                        $( 'button.js_jchartTestFlash' ).css( { 'font-weight': 'bold' } );
                    }else if( _selected === '2' ){
                        $( 'button.js_jchartTestSvg' ).css( { 'font-weight': 'bold' } );
                    }
                });

                _p.selector().delegate( '.js_jchartTestFlash', 'click', function(){
                    JC.f.reloadPage( JC.f.addUrlParams( { 'jchart_display': 1 } ) );
                });

                _p.selector().delegate( '.js_jchartTestSvg', 'click', function(){
                    JC.f.reloadPage( JC.f.addUrlParams( { 'jchart_display': 2 } ) );
                });
            }

        , _inited:
            function(){
                //JC.log( 'Test _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }
    });

    Test.Model._instanceName = 'JCTest';
    JC.f.extendObject( Test.Model.prototype, {
        init:
            function(){
                //JC.log( 'Test.Model.init:', new Date().getTime() );
            }
    });

    JC.f.extendObject( Test.View.prototype, {
        init:
            function(){
                //JC.log( 'Test.View.init:', new Date().getTime() );

                var _p = this;

                    _p.selector().css( {
                        'position': 'fixed'
                        , 'right': '20px'
                        , 'top': '20px'
                    });

                    _p.selector().html(
                        JC.f.printf( 
                            '{0}&nbsp;{2}&nbsp;{3}'
                            , '<a href="{1}">back</a>'
                            , JC.f.delUrlParam( 'jchart_display' )
                            , '<button type="button" class="js_jchartTestFlash">flash chart</button>'
                            , '<button type="button" class="js_jchartTestSvg">svg chart</button>'
                        )
                    );
            }
    });

    _jdoc.ready( function(){
        Test.autoInit && Test.init();
    });

    return JC.Test;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
