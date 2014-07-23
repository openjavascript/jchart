;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.IconVLine', 'JChart.GraphicRect' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href="widnow.jQuery.html">jQuery</a>
 *      , <a href='JC.BaseMVC.html'>JC.BaseMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.HistogramLateral.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChar.HistogramLateral/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *  <h2>页面只要引用本脚本, 默认会处理 div class="JCharHistogramLateral"</h2>
 *
 *  <h2>可用的 HTML attribute</h2>
 *
 *  <dl>
 *      <dt></dt>
 *      <dd><dd>
 *  </dl> 
 *
 * @namespace   JChar
 * @class       HistogramLateral
 * @extends     JChar.Base
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.HistogramLateral 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.HistogramLateral = HistogramLateral;

    function HistogramLateral( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, HistogramLateral ) ) 
            return JC.BaseMVC.getInstance( _selector, HistogramLateral );

        JC.BaseMVC.getInstance( _selector, HistogramLateral, this );

        this._model = new HistogramLateral.Model( _selector );
        this._view = new HistogramLateral.View( this._model );
        this._init();

        JC.log( HistogramLateral.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 HistogramLateral 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of HistogramLateralInstance}
     */
    HistogramLateral.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jcharHistogramLateral' )  ){
                    _r.push( new HistogramLateral( _selector ) );
                }else{
                    JChart.Base.init( HistogramLateral, $( 'div.jcharHistogramLateral' ), 0, 1 );
                }
            }
            return _r;
        };

    JC.BaseMVC.build( HistogramLateral, JChart.Base);

    JC.f.extendObject( HistogramLateral.prototype, {
        _beforeInit:
            function(){
                JC.log( 'HistogramLateral _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                });
            }

        , _inited:
            function(){
                JC.log( 'HistogramLateral _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }
    });

    HistogramLateral.Model._instanceName = 'JCHistogramLateral';
    JC.f.extendObject( HistogramLateral.Model.prototype, {
        init:
            function(){
                JC.log( 'HistogramLateral.Model.init:', new Date().getTime() );
            }
        , coordinate :
            function( _data ) {
                var _c = {};
                var _p = this,
                    _bbox, 
                    _offsetY = _p.height(),
                    _offsetX = _p.width(),
                    _y = 0, _x = 0;
                
                /* title */
                var _title = _p.title( _data );
                if( _title ) {
                    _bbox = JChart.f.getBBox( _title );
                    _c.title = {
                        x : _offsetX / 2,
                        y : _y + _bbox.height / 2 + 5,
                        ele : _title
                    }
                    _y = _c.title.y + _bbox.height / 2;
                }

                /* subTitle */
                var _subTitle = _p.subtitle( _data );
                if( _subTitle ) {
                    _bbox = JChart.f.getBBox( _subTitle );
                    _c.subTitle = {
                        x : _offsetX / 2,
                        y : _y + _bbox.height / 2 + 5,
                        ele : _subTitle
                    }
                }

                /* line */


                _c.line = [];
                return _c;
            }
    });

    JC.f.extendObject( HistogramLateral.View.prototype, {
        init :
            function() {

                JC.log( 'HistogramLateral.View.init:', new Date().getTime() );
    
                var _p = this;
            }
        , draw :
            function( _data ) {
                var _p = this,
                    _c = _p._model.coordinate( _data );
                console.log( _c );
                _p.setStaticPosition( _c );
            }
        , setStaticPosition :
            function( _coordinate ) {
                var _p = this,
                    _c = _coordinate;
                console.log(_c.title);
                if( _c.title ) {
                    _p._model.title().attr( _c.title );
                }
                if( _c.subTitle ) {
                    _p._model.subtitle().attr( _c.subTitle );
                }
            }
    });

    _jdoc.ready( function(){
        var _insAr = 0;
        HistogramLateral.autoInit
            && ( _insAr = HistogramLateral.init() )
            && $( '<h2>HistogramLateral total ins: ' 
                + _insAr.length + '<br/>' + new Date().getTime() + '</h2>' ).appendTo( document.body )
            ;
    });

    return JC.HistogramLateral;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);

