;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.IconVLine.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.IconVLine/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 * @namespace   JChart
 * @class       IconVLine
 * @extends     JChart.GraphicBase
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.IconVLine 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.IconVLine = IconVLine;

    function IconVLine( _stage, _path, _style, _hoverStyle ){

        this._model = new IconVLine.Model( _stage, _path, _style, _hoverStyle );
        this._view = new IconVLine.View( this._model );

        this._init();

        //JC.log( IconVLine.Model._instanceName, 'all inited', new Date().getTime() );
    }

    IconVLine.Model = 
        function( _stage, _path, _style, _hoverStyle ){
            this._stage = _stage;
            this._path = _path;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
        };

    JC.PureMVC.build( IconVLine, JChart.GraphicBase );

    JC.f.extendObject( IconVLine.prototype, {
    });

    IconVLine.Model._instanceName = 'JCIconVLine';
    JC.f.extendObject( IconVLine.Model.prototype, {
        init:
            function(){
                //JC.log( 'IconVLine.Model.init:', new Date().getTime() );
            }
    });

    JC.f.extendObject( IconVLine.View.prototype, {
        init:
            function(){
                //JC.log( 'IconVLine.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _element = _p._model.stage().path( _p._model._path )
                    ;
                _p._model.add( _element, 'element' );
                _p.unhover();
            }
    });

    return JC.IconVLine;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
