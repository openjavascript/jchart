;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JChart.Legend.html' target='_blank'>API docs</a>
 *  
 * @namespace   JChart
 * @class       Legend
 * @extends     JChart.GraphicBase
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-23
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.Legend 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Legend = Legend;

    function Legend( _stage, _series, _type, _colors  ){

        this._model = new Legend.Model( _stage, _series, _type, _colors );
        this._view = new Legend.View( this._model );

        this._init();

        //JC.log( Legend.Model._instanceName, 'all inited', new Date().getTime() );
    }

    Legend.Model = 
        function( _stage, _data, _type, _colors ){
            this._stage = _stage;
            this._data = _data;
            this._type = _type;
            this._colors = _colors;
        };

    JC.PureMVC.build( Legend, JChart.GraphicBase );

    JC.f.extendObject( Legend.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Legend _beforeInit', new Date().getTime() );
            }
        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                    //_p._view.draw();
                });
            }
        , draw: function(){ this._view.draw(); }
    });

    Legend.Model._instanceName = 'JCLegend';
    JC.f.extendObject( Legend.Model.prototype, {
        init:
            function(){
                //JC.log( 'Legend.Model.init:', new Date().getTime() );
                JChart.GraphicBase.Model.prototype.init.call( this );
            }

        , type:
            function(){
                return this._type || 'rect';
            }

        , data: function(){ return this._data; }

        , offsetX: function(){ return 100; }
        , offsetY: function(){ return 100; }

        , space: function(){ return 2; }
        , itemSpace: function(){ return 8; }
        , itemWidth: function(){ return 20; }
        , itemHeight: function(){ return 20; }
        , colors: function(){ return this._colors; }
    });

    JC.f.extendObject( Legend.View.prototype, {
        init:
            function(){
                //JC.log( 'Legend.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    , _method = 'draw_' + _p._model.type()
                    ;

                if( !( _method in _p ) ) _method = 'draw_rect';
                _p[ _method ]();
            }

        , draw_rect:
            function(){
                var _p = this;

                var _x = _p._model.offsetX();

                $.each( _p._model.data(), function( _k, _item ){
                    if( !_item.name ) return;
                    var _color = _p._model.colors()[ _k % ( _p._model.colors().length - 1 ) ];
                    var _icon = new JChart.IconRect( _p.stage(), _x, _p._model.offsetY(), 18, 10, 1, 4 );
                        _icon.item( 'element' ).attr( { 
                            'fill': _color
                            , 'stroke': _color
                            , x: _x 
                            , 'cursor': 'pointer'
                        } );
                        _x += _icon.item( 'element' ).attr( 'width' ) + _p._model.space();

                    var _text = _p.stage().text( _x, _p._model.offsetY() + 5, _item.name ).attr( { 
                        'text-anchor': 'start' 
                        , 'cursor': 'pointer'
                    } ); 
                    _x = _x + _text.getBBox().width + _p._model.itemSpace();

                    _icon.item( 'element' ).data( 'ix', _k );
                    _text.data( 'ix', _k );

                    _p._model.add( _icon.item( 'element' ), 'icon_' + _k );
                    _p._model.add( _text, 'text_' + _k );
                    _p.trigger( 'render_item', [ _k, _icon.item( 'element' ), _text ] );
                });

                _p._model.set().attr( { 'cursor': 'pointer' } );
            }

        , draw_line:
            function(){
                var _p = this;

                var _x = _p._model.offsetX();

                $.each( _p._model.data(), function( _k, _item ){
                    if( !_item.name ) return;
                    var _color = _p._model.colors()[ _k % ( _p._model.colors().length - 1 ) ];
                    var _icon = new JChart.IconRect( _p.stage(), _x, _p._model.offsetY(), 18, 10, 1, 4 );
                        _icon.item( 'element' ).attr( { 
                            'fill': _color
                            , 'stroke': _color
                            , x: _x 
                            , 'cursor': 'pointer'
                        } );
                        _x += _icon.item( 'element' ).attr( 'width' ) + _p._model.space();

                    var _text = _p.stage().text( _x, _p._model.offsetY() + 5, _item.name ).attr( { 
                        'text-anchor': 'start' 
                        , 'cursor': 'pointer'
                    } ); 
                    _x = _x + _text.getBBox().width + _p._model.itemSpace();

                    _icon.item( 'element' ).data( 'ix', _k );
                    _text.data( 'ix', _k );

                    _p._model.add( _icon.item( 'element' ), 'icon_' + _k );
                    _p._model.add( _text, 'text_' + _k );
                    _p.trigger( 'render_item', [ _k, _icon.item( 'element' ), _text ] );
                });

                _p._model.set().attr( { 'cursor': 'pointer' } );
            }

    });

    return JC.Legend;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
