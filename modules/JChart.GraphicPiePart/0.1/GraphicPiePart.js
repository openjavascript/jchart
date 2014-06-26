;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.GraphicPiePart.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.GraphicPiePart/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 * @namespace   JChart
 * @class       GraphicPiePart
 * @extends     JChart.GraphicBase
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-26
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.GraphicPiePart 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.GraphicPiePart = GraphicPiePart;

    function GraphicPiePart( _stage, _pieCor, _style, _hoverStyle  ){

        this._model = new GraphicPiePart.Model( _stage, _pieCor, _style, _hoverStyle );
        this._view = new GraphicPiePart.View( this._model );

        this._init();

        //JC.log( GraphicPiePart.Model._instanceName, 'all inited', new Date().getTime() );
    }

    GraphicPiePart.Model = 
        function( _stage, _pieCor, _style, _hoverStyle ){
            this._stage = _stage;
            this._pieCor = _pieCor;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
        };

    JC.PureMVC.build( GraphicPiePart, JChart.GraphicBase );

    JC.f.extendObject( GraphicPiePart.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'GraphicPiePart _beforeInit', new Date().getTime() );
            }
    });

    GraphicPiePart.Model._instanceName = 'JCGraphicPiePart';
    JC.f.extendObject( GraphicPiePart.Model.prototype, {
        init:
            function(){
                //JC.log( 'GraphicPiePart.Model.init:', new Date().getTime() );
            }
    });

    JC.f.extendObject( GraphicPiePart.View.prototype, {
        init:
            function(){
                //JC.log( 'GraphicPiePart.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _item, _corText
                    , _pie = _p._model._pieCor
                    ;
                _corText = 
                    [
                        "M", _pie.cx, _pie.cy
                    , "L"
                    , _pie.endPoint.x, _pie.endPoint.y
                    , "A"
                        , _pie.radius, _pie.radius
                        , 0
                        , 0
                        , 0
                        , _pie.startPoint.x, _pie.startPoint.y
                        , "z"
                ];
                _item = _p._model.stage().path( _corText );
                _p._model.add( _item, 'element' );
                _p.unhover();
            }
        /*
        function drawPiePart( _stage, _pie ) {
            return _stage.path();
        }

        _tmp = drawPiePart( _p.stage(), _pieC );

        if( _k === 6 ){
            var _tmp2 = JChart.Geometry.distanceAngleToPoint( 5, _pieC.midAngle );
                _tmp.transform( JC.f.printf( 't{0} {1}', _tmp2.x, _tmp2.y ) );
        }
        */

    });

    return JC.GraphicPiePart;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
