;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.IconRect.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.IconRect/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 * @namespace   JChart
 * @class       IconRect
 * @extends     JC.PureMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-24
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.IconRect 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.IconRect = IconRect;

    function IconRect( _paper, _rx, _ry, _rw, _rh, _radius, _style ){

        this._model = new IconRect.Model( _paper, _rx, _ry, _rw, _rh, _radius, _style );
        this._view = new IconRect.View( this._model );

        this._init();

        //JC.log( IconRect.Model._instanceName, 'all inited', new Date().getTime() );
    }

    IconRect.Model = 
        function( _paper, _rx, _ry, _rw, _rh, _rcorner, _radius, _style ){
            this._paper = _paper;
            this._rx = _rx;
            this._ry = _ry;
            this._rw = _rw;
            this._rh = _rh;
            this._rcorner = _rcorner;
            this._radius = _radius;
            this._style = _style;
        };

    JC.PureMVC.build( IconRect );

    JC.f.extendObject( IconRect.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'IconRect _beforeInit', new Date().getTime() );
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
                //JC.log( 'IconRect _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }

        , hover: function(){ this._view.hover(); return this; }
        , unhover: function(){ this._view.unhover(); return this; }

        , update:
            function( _path, _translate ){
                this._view.update( _path, _translate );
                return this;
            }
        , attr:
            function( _k, _v ){
                this._view.attr( _k, _v );
                return this;
            }

        , getBBox:
            function(){
                return this._model.getBBox();
            }

        , setPosition:
            function( _x, _y ){
                this._model._group.setPosition( _x, _y );
            }
    });

    IconRect.Model._instanceName = 'JCIconRect';
    JC.f.extendObject( IconRect.Model.prototype, {
        init:
            function(){
                //JC.log( 'IconRect.Model.init:', new Date().getTime() );
                this._group = new JChart.Group();
            }

        , getBBox: function(){ return this._group.getBBox(); }
    });

    JC.f.extendObject( IconRect.View.prototype, {
        init:
            function(){
                //JC.log( 'IconRect.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _rect = _p._model._paper.rect( 
                        _p._model._rx 
                        , _p._model._ry + _p._model._rh 
                        , _p._model._rw
                        , _p._model._rh
                        )
                this._model._group.addChild( _rect, 'rect' );
                _p.unhover();
            }

        , hover:
            function(){
                var _p = this;
                _p._model._hoverStyle && $.each( _p._model._hoverStyle, function( _k, _item ){
                });
            }

        , unhover:
            function(){
                var _p = this;
                _p._model._style && $.each( _p._model._style, function( _k, _item ){
                });
            }

        , update:
            function( _path, _translate ){
                var _p = this;
                _p.unhover();
            }

        , attr:
            function( _k, _v ){
                this._model._group.attr( _k, _v );
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
