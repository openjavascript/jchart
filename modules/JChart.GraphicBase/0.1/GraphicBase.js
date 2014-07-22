;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.GraphicBase.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.GraphicBase/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 * @namespace   JChart
 * @class       GraphicBase
 * @extends     JC.PureMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.GraphicBase 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.GraphicBase = GraphicBase;

    function GraphicBase( _stage, _x, _y, _style, _hoverStyle  ){

        this._model = new GraphicBase.Model( _stage, _x, _y, _style, _hoverStyle );
        this._view = new GraphicBase.View( this._model );

        this._init();

        //JC.log( GraphicBase.Model._instanceName, 'all inited', new Date().getTime() );
    }

    GraphicBase.Model = 
        function( _stage, _x, _y, _style, _hoverStyle ){
            this._stage = _stage;
            this._x = _x;
            this._y = _y;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
        };

    JC.PureMVC.build( GraphicBase );

    JC.f.extendObject( GraphicBase.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'GraphicBase _beforeInit', new Date().getTime() );
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
                //JC.log( 'GraphicBase _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }

        , hover: function(){ this._view.hover(); return this; }

        , unhover: function(){ this._view.unhover(); return this; }

        , attr: function( _k, _v ){ this._view.attr( _k, _v ); return this; }

        , setPosition:
            function( _x, _y ){
                this._model.group() && this._model.group().setPosition( _x, _y );
            }

        , getBBox:
            function(){
                return this._model.getBBox();
            }

        , show: function(){ this._view.show(); }
        , hide: function(){ this._view.hide(); }

        , item:
            function( _name ){
                return _name ? this._model._elementMap[ _name ] : this._model._elementMap;
            }
    });

    GraphicBase.Model._instanceName = 'JCGraphicBase';
    JC.f.extendObject( GraphicBase.Model.prototype, {
        init:
            function(){
                //JC.log( 'GraphicBase.Model.init:', new Date().getTime() );
            }

        , stage: function(){ return this._stage; }
        , style: function(){ return this._style; }
        , hoverStyle: function(){ return this._hoverStyle; }

        , elements:
            function(){
                typeof this._elements == 'undefined' && ( this._elements = [] );
                return this._elements;
            }

        , add:
            function( _item, _name ){
                typeof this._elementMap == 'undefined' && ( this._elementMap = {} );
                _name = _name || ( this.elements().length ).toString();
                this._elementMap[ _name ] = _item;
                this.elements().push( _item );
            }
        , item:
            function( _name ){
                return _name ? this._elementMap[ _name ] : this._elementMap;
            }

        , group: 
            function( _setter ){ 
                typeof _setter != 'undefined' && ( this._group = _setter );
                return this._group; 
            }
        , getBBox: function(){ return this._group.getBBox(); }
    });

    JC.f.extendObject( GraphicBase.View.prototype, {
        init:
            function(){
                //JC.log( 'GraphicBase.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                _p.unhover();
            }

        , hover:
            function(){
                var _p = this;
                $.each( _p._model._hoverStyle, function( _k, _item ){
                    $.each( _p._model.elements(), function( _sk, _sitem ){
                        _sitem.attr( _k, _item );
                    });
                });
            }

        , unhover:
            function(){
                var _p = this;
                $.each( _p._model._style, function( _k, _item ){
                    $.each( _p._model.elements(), function( _sk, _sitem ){
                        _sitem.attr( _k, _item );
                    });
                });
            }

        , attr:
            function( _k, _v ){
                var _p = this;
                if( typeof _k == 'object' ){
                    $.each( _k, function( _sk, _sv ){
                        $.each( _p._model.elements(), function( _ssk, _ssitem ){
                            _ssitem.attr( _sk, _sv );
                        });
                    });
                }else{
                    $.each( _p._model.elements(), function( _ssk, _ssitem ){
                        _ssitem.attr( _k, _v );
                    });
                }
            }

        , show:
            function(){
                var _p = this;
                $.each( _p._model.elements(), function( _k, _item ){
                    _item.show();
                });
            }

        , hide:
            function(){
                var _p = this;
                $.each( _p._model.elements(), function( _k, _item ){
                    _item.hide();
                });
            }
    });

    return JC.GraphicBase;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
