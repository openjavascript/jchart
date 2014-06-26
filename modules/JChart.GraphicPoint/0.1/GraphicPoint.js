;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.GraphicPoint.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.GraphicPoint/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 * @namespace   JChart
 * @class       GraphicPoint
 * @extends     JChart.GraphicBase
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.GraphicPoint 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.GraphicPoint = GraphicPoint;

    function GraphicPoint( _stage, _x, _y, _radius, _style, _hoverStyle  ){

        this._model = new GraphicPoint.Model( _stage, _x, _y, _radius, _style, _hoverStyle );
        this._view = new GraphicPoint.View( this._model );

        this._init();

        //JC.log( GraphicPoint.Model._instanceName, 'all inited', new Date().getTime() );
    }

    GraphicPoint.Model = 
        function( _stage, _x, _y, _radius, _style, _hoverStyle ){
            this._stage = _stage;
            this._x = _x;
            this._y = _y;
            this._radius = _radius;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
        };

    JC.PureMVC.build( GraphicPoint, JChart.GraphicBase );

    JC.f.extendObject( GraphicPoint.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'GraphicPoint _beforeInit', new Date().getTime() );
            }
    });

    GraphicPoint.Model._instanceName = 'JCGraphicPoint';
    JC.f.extendObject( GraphicPoint.Model.prototype, {
        init:
            function(){
                //JC.log( 'GraphicPoint.Model.init:', new Date().getTime() );
            }
    });

    JC.f.extendObject( GraphicPoint.View.prototype, {
        init:
            function(){
                //JC.log( 'GraphicPoint.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _element = _p._model.stage().circle( _p._model._x, _p._model._y, _p._model._radius )
                    ;
                _p._model.add( _element, 'element' );
                _p.unhover();
            }
    });

    return JC.GraphicPoint;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
