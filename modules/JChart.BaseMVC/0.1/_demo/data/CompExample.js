;(function(define, _win) { 'use strict'; define( [ 'JChart.BaseMVC' ], function(){
    var _jdoc = $( document ), _jwin = $( window );

    JChart.CompExample = CompExample;

    function CompExample( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JChart.BaseMVC.getInstance( _selector, CompExample ) ) 
            return JChart.BaseMVC.getInstance( _selector, CompExample );

        JChart.BaseMVC.getInstance( _selector, CompExample, this );

        this._model = new CompExample.Model( _selector );
        this._view = new CompExample.View( this._model );

        this._init();

        JChart.log( CompExample.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 CompExample 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of CompExampleInstance}
     */
    CompExample.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'js_compCompExample' )  ){
                    _r.push( new CompExample( _selector ) );
                }else{
                    _selector.find( 'span.js_compCompExample' ).each( function(){
                        _r.push( new CompExample( this ) );
                    });
                }
            }
            return _r;
        };

    JChart.BaseMVC.build( CompExample );
    CompExample.Model._instanceName = 'JCCompExample';

    _jdoc.ready( function(){
        var _insAr = 0;
        CompExample.autoInit
            && ( _insAr = CompExample.init() )
            && $( '<h2>CompExample total ins: ' 
                + _insAr.length + '<br/>' + new Date().getTime() + '</h2>' ).appendTo( document.body )
            ;
    });

    return CompExample;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
