;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.IconLine.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.IconLine/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 * @namespace   JChart
 * @class       IconLine
 * @extends     JChart.GraphicBase
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-26
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.IconLine 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.IconLine = IconLine;

    function IconLine( _stage, _rx, _ry, _rw, _rh, _radius, _style ){

        this._model = new IconLine.Model( _stage, _rx, _ry, _rw, _rh, _radius, _style );
        this._view = new IconLine.View( this._model );

        this._init();

        //JC.log( IconLine.Model._instanceName, 'all inited', new Date().getTime() );
    }

    IconLine.Model = 
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

    JC.PureMVC.build( IconLine, JChart.GraphicBase );

    JC.f.extendObject( IconLine.prototype, {
    });

    IconLine.Model._instanceName = 'JCIconLine';
    JC.f.extendObject( IconLine.Model.prototype, {
        init:
            function(){
                //JC.log( 'IconLine.Model.init:', new Date().getTime() );
                this._group = new JChart.Group();
            }
    });

    JC.f.extendObject( IconLine.View.prototype, {
        init:
            function(){
                //JC.log( 'IconLine.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _rect = _p._model.stage().rect( 
                        _p._model._rx , _p._model._ry + _p._model._rh , _p._model._rw, _p._model._rh, _p._model._rcorner )

                    , _circle = _p._model.stage().circle( 
                        _p._model._rx + _p._model._rw / 2
                        , _p._model._ry + _p._model._rh + _p._model._rh / 2
                        , _p._model._radius 
                        )
                    ;
                this._model._group.addChild( _rect, 'rect' );
                this._model._group.addChild( _circle, 'circle' );

                this._model.add( _rect, 'rect' );
                this._model.add( _circle, 'circle' );
            }
    });

    return JC.IconLine;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
