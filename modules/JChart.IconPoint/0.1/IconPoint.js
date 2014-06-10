;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.IconPoint.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.IconPoint/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 * @namespace   JChart
 * @class       IconPoint
 * @extends     JC.PureMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.IconPoint 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.IconPoint = IconPoint;

    function IconPoint( _paper, _x, _y, _radius, _style, _hoverStyle  ){

        this._model = new IconPoint.Model( _paper, _x, _y, _radius, _style, _hoverStyle );
        this._view = new IconPoint.View( this._model );

        this._init();

        //JC.log( IconPoint.Model._instanceName, 'all inited', new Date().getTime() );
    }

    IconPoint.Model = 
        function( _paper, _x, _y, _radius, _style, _hoverStyle ){
            this._paper = _paper;
            this._x = _x;
            this._y = _y;
            this._radius = _radius;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
        };

    JC.PureMVC.build( IconPoint );

    JC.f.extendObject( IconPoint.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'IconPoint _beforeInit', new Date().getTime() );
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
                //JC.log( 'IconPoint _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }

        , hover: function(){ this._view.hover(); return this; }

        , unhover: function(){ this._view.unhover(); return this; }

        , attr: function( _k, _v ){ this._view.attr( _k, _v ); return this; }
    });

    IconPoint.Model._instanceName = 'JCIconPoint';
    JC.f.extendObject( IconPoint.Model.prototype, {
        init:
            function(){
                //JC.log( 'IconPoint.Model.init:', new Date().getTime() );
            }
    });

    JC.f.extendObject( IconPoint.View.prototype, {
        init:
            function(){
                //JC.log( 'IconPoint.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _element = _p._model._paper.circle( _p._model._x, _p._model._y, _p._model._radius )
                    ;
                _p._model._element = _element;
                _p.unhover();
            }

        , hover:
            function(){
                var _p = this;
                $.each( _p._model._hoverStyle, function( _k, _item ){
                    _p._model._element.attr( _k, _item );
                });
            }

        , unhover:
            function(){
                var _p = this;
                $.each( _p._model._style, function( _k, _item ){
                    _p._model._element.attr( _k, _item );
                });
            }

        , attr:
            function( _k, _v ){
                var _p = this;
                if( typeof _k == 'object' ){
                    $.each( _k, function( _ssk, _ssv ){
                        _p._model._element.attr( _ssk, _ssv );
                    });
                }else{
                    _p._model._element.attr( _k, _v );
                }
            }
    });

    return JC.IconPoint;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
