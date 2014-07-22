;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.GraphicRect.html' target='_blank'>API docs</a>
 *  
 * @namespace   JChart
 * @class       GraphicRect
 * @extends     JChart.GraphicBase
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-23
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.GraphicRect 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.GraphicRect = GraphicRect;

    function GraphicRect( _stage, _x, _y, _width, _height, _style, _hoverStyle  ){

        this._model = new GraphicRect.Model( _stage, _x, _y, _width, _height, _style, _hoverStyle );
        this._view = new GraphicRect.View( this._model );

        this._init();

        //JC.log( GraphicRect.Model._instanceName, 'all inited', new Date().getTime() );
    }

    GraphicRect.Model = 
        function( _stage, _x, _y, _width, _height, _style, _hoverStyle ){
            this._stage = _stage;
            this._x = _x;
            this._y = _y;
            this._width = _width;
            this._height = _height;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
        };

    JC.PureMVC.build( GraphicRect, JChart.GraphicBase );

    JC.f.extendObject( GraphicRect.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'GraphicRect _beforeInit', new Date().getTime() );
            }
    });

    GraphicRect.Model._instanceName = 'JCGraphicRect';
    JC.f.extendObject( GraphicRect.Model.prototype, {
        init:
            function(){
                //JC.log( 'GraphicRect.Model.init:', new Date().getTime() );
            }
    });

    JC.f.extendObject( GraphicRect.View.prototype, {
        init:
            function(){
                //JC.log( 'GraphicRect.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _rect = _p._model.stage().rect( _p._model._x, _p._model._y, _p._model._width, _p._model._height )
                    ;
                _p._model.add( _rect.attr( { 'stroke-width': 0 } ), 'element' );
                _p.unhover();
            }
    });

    return JC.GraphicRect;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
