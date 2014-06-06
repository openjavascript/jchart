;(function(define, _win) { 'use strict'; define( [ 'Raphael', 'JChart.Event', 'JChart.Graphics' ], function(){
window.JChart = window.JChart || {};

    JChart.Group = Group;

    function  Group(){
        this._model = new Model();
        this._view = new View( this._model );
    }

    Group.prototype = {
        addChild:
            function( _item, _name ){
                this._model.addChild( _item, _name );
                return this;
            }

        , getBBox: function(){ return this._model.getBBox(); }

        , attr: function(){ this._view.attr.apply( this._view, JC.f.sliceArgs( arguments ) ); return this; }

        , children: function(){ return this._model._children; }
        , getChildByName: function( _name ){ return this._model._nameMap[ _name ]; }

        , setX:
            function( _x ){
                return this;
            }

        , setY: 
            function( _y ){
                return this;
            }

        , setPosition:
            function( _x, _y ){
                this._view.setPosition( _x, _y );
                return this;
            }

        , show:
            function(){
                this._view.show();
                return this;
            }

        , hide:
            function(){
                this._view.hide();
                return this;
            }
    };

    function Model(){
        this._children = [];
        this._nameMap = {};
    }

    Model.prototype = {
        addChild:
            function( _item, _name ){
                this._children.push( _item );
                _name && ( this._nameMap[ _name ] = _item );
            }

        , children: function(){ return this._children; }

        , getBBox:
            function(){
                var _r; 
                $.each( this._children, function( _k, _item ){
                    var _bbox = _item.getBBox();
                    if( !_r ){
                        _r = {};
                        _r.x = _bbox.x;
                        _r.x2 = _bbox.x2;
                        _r.y = _bbox.y;
                        _r.y2 = _bbox.y2;
                    }else{
                        _r.x > _bbox.x && ( _r.x = _bbox.x );
                        _r.x2 < _bbox.x2 && ( _r.x2 = _bbox.x2 );

                        _r.y > _bbox.y && ( _r.y = _bbox.y );
                        _r.y2 < _bbox.y2 && ( _r.y2 = _bbox.y2 );
                    }
                });

                _r && (
                    _r.width = _r.x2 - _r.x
                    , _r.height = _r.y2 - _r.y
                );

                !_r && ( _r = {
                    x: 0, y: 0, x1: 0, x2: 0, width: 0, height: 0
                });;

                return _r;
            }
    };

    function View( _model ){
        this._model = _model;
    }
    View.prototype = {
        attr:
            function( _k, _v ){
                $.each( this._model._children, function( _sk, _item ){
                    if( typeof _k == 'object' ){
                        $.each( _k, function( _ssk, _ssv ){
                            _item.attr( _ssk, _ssv );
                        });
                    }else{
                        _item.attr( _k, _v );
                    }
                });
            }

        , setPosition:
            function( _x, _y ){
                var _p = this, _bbox = _p._model.getBBox();
                $.each( _p._model.children(), function( _ix, _item ){
                    var _sbbox = _item.getBBox();
                    if( typeof _x != 'undefined' ){
                        _item.attr( 'x', _x + ( _item.attr( 'x' ) - _bbox.x ) );
                    }
                    if( typeof _y != 'undefined' ){
                        _item.attr( 'y', _y + ( _item.attr( 'y' ) - _bbox.y ) );
                    }
                });
            }

        , show:
            function(){
                $.each( this._model.children(), function( _k, _item ){
                    _item.show();
                });
            }

        , hide:
            function(){
                $.each( this._model.children(), function( _k, _item ){
                    _item.hide();
                });
            }
    };

    return Group;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
