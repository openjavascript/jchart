;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.IconRect.html' target='_blank'>API docs</a>
 *  
 * @namespace   JChart
 * @name IconRect
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-24
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.IconRect 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.IconRect = IconRect;

    function IconRect( _stage, _rx, _ry, _rw, _rh, _radius, _style ){

        this._model = new IconRect.Model( _stage, _rx, _ry, _rw, _rh, _radius, _style );
        this._view = new IconRect.View( this._model );

        this._init();

        //JC.log( IconRect.Model._instanceName, 'all inited', new Date().getTime() );
    }

    IconRect.Model = 
        function( _stage, _rx, _ry, _rw, _rh, _rcorner, _radius, _style ){
            this._stage = _stage;
            this._rx = _rx;
            this._ry = _ry;
            this._rw = _rw;
            this._rh = _rh;
            this._rcorner = _rcorner;
            this._radius = _radius;
            this._style = _style;
        };

    JC.PureMVC.build( IconRect, JChart.GraphicBase );

    JC.f.extendObject( IconRect.prototype, {
    });

    IconRect.Model._instanceName = 'JCIconRect';
    JC.f.extendObject( IconRect.Model.prototype, {
        init:
            function(){
                //JC.log( 'IconRect.Model.init:', new Date().getTime() );
                this._group = new JChart.Group();
            }

    });

    JC.f.extendObject( IconRect.View.prototype, {
        init:
            function(){
                //JC.log( 'IconRect.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _rect = _p._model.stage().rect( 
                        _p._model._rx 
                        , _p._model._ry 
                        , _p._model._rw
                        , _p._model._rh
                        )
                this._model._group.addChild( _rect, 'rect' );
                this._model.add( _rect, 'element' );
            }
    });

    return JC.IconRect;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
