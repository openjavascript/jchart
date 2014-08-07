;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.IconCircle.html' target='_blank'>API docs</a>
 *  
 * @namespace   JChart
 * @name IconCircle
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-24
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.IconCircle 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.IconCircle = IconCircle;

    function IconCircle( _stage, _cx, _cy, _radius, _style ){

        this._model = new IconCircle.Model( _stage, _cx, _cy, _radius, _style );
        this._view = new IconCircle.View( this._model );

        this._init();

        //JC.log( IconCircle.Model._instanceName, 'all inited', new Date().getTime() );
    }

    IconCircle.Model = 
        function( _stage, _cx, _cy, _radius, _style ){
            this._stage = _stage;
            this._cx = _cx;
            this._cy = _cy;
            this._radius = _radius;
            this._style = _style;
        };

    JC.PureMVC.build( IconCircle, JChart.GraphicBase );

    JC.f.extendObject( IconCircle.prototype, {
    });

    IconCircle.Model._instanceName = 'JCIconCircle';
    JC.f.extendObject( IconCircle.Model.prototype, {
        init:
            function(){
                //JC.log( 'IconCircle.Model.init:', new Date().getTime() );
                this._group = new JChart.Group();
            }

    });

    JC.f.extendObject( IconCircle.View.prototype, {
        init:
            function(){
                //JC.log( 'IconCircle.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _rect = _p._model.stage().circle( 
                        _p._model._cx 
                        , _p._model._cy
                        , _p._model._radius
                        )
                this._model._group.addChild( _rect, 'rect' );
                this._model.add( _rect, 'element' );
            }
    });

    return JC.IconCircle;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
