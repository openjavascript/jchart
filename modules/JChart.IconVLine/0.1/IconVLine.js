;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group' ], function(){
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
 * @extends     JC.PureMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.IconVLine 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.IconVLine = IconVLine;

    function IconVLine( _paper, _path, _style, _hoverStyle ){

        this._model = new IconVLine.Model( _paper, _path, _style, _hoverStyle );
        this._view = new IconVLine.View( this._model );

        this._init();

        //JC.log( IconVLine.Model._instanceName, 'all inited', new Date().getTime() );
    }

    IconVLine.Model = 
        function( _paper, _path, _style, _hoverStyle ){
            this._paper = _paper;
            this._path = _path;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
        };

    JC.PureMVC.build( IconVLine );

    JC.f.extendObject( IconVLine.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'IconVLine _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                    _p._view.draw();
                });
            }

        , _inited:
            function(){
                //JC.log( 'IconVLine _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }

        , hover: function(){ this._view.hover(); return this; }
        , unhover: function(){ this._view.unhover(); return this; }

        , attr:
            function( _k, _v ){
                this._view.attr( _k, _v );
                return this;
            }


        , update:
            function( _path, _translate ){
                this._view.update( _path, _translate );
                return this;
            }
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
                    , _element = _p._model._paper.path( _p._model._path )
                    ;
                _p._model._element = _element;
                _p.unhover();
            }

        , hover:
            function(){
                var _p = this;
                _p._model._hoverStyle && $.each( _p._model._hoverStyle, function( _k, _item ){
                    _p._model._element.attr( _k, _item );
                });
            }

        , unhover:
            function(){
                var _p = this;
                _p._model._style && $.each( _p._model._style, function( _k, _item ){
                    _p._model._element.attr( _k, _item );
                });
            }

        , update:
            function( _path, _translate ){
                var _p = this;
                _p._model._element.attr( 'path', _path );
                _p.unhover();

                _translate && _p._model._element.translate( .5, .5 );
            }

        , attr:
            function( _k, _v ){
                this._model._element.attr( _k, _v );
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
