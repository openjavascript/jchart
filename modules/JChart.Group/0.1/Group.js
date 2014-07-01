;(function(define, _win) { 'use strict'; define( [ 'Raphael', 'JChart.Event' ], function(){
window.JChart = window.JChart || {};

    JChart.Group = Group;

    function  Group(){
        this._model = new Model();
        this._view = new View( this._model );
    }

    Group.prototype = {
        addChild:
            function( _item, _name, _offset ){
                this._model.addChild( _item, _name, _offset );
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

        , toFront:
            function(){
                $.each( this._model.children(), function( _ix, _item ){
                    _item.toFront();
                });
                return this;
            }
    };

    function Model(){
        this._children = [];
        this._nameMap = {};
        this._offsetMap = {};
        this._offsetMapList = [];
    }

    Model.prototype = {
        addChild:
            function( _item, _name, _offset ){
                this._children.push( _item );
                this._offsetMapList.push( _offset );
                _name && ( this._nameMap[ _name ] = _item );
                _name && _offset && ( this._offsetMap[ _name ] = _offset );
            }

        , children: function(){ return this._children; }

        , getBBox:
            function(){
                var _r; 
                $.each( this._children, function( _k, _item ){
                    var _bbox = JChart.Base.getBBox( _item );
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
                    var _offset = _p._model._offsetMapList[ _ix ], _rx = _x, _ry = _y;
                    if( _item.setPosition ){
                        if( _offset ){
                            _offset.padX && ( _rx += _offset.padX );
                            _offset.padY && ( _ry += _offset.padY );
                        }
                        _item.setPosition( _rx, _ry, _offset );
                    }else{
                        var _sbbox = JChart.Base.getBBox( _item );
                        if( _item.node.nodeName == 'circle' ){
                            if( typeof _rx != 'undefined' ){
                                _item.attr( 'cx', _rx + ( _item.attr( 'cx' ) - _bbox.x ) );
                            }
                            if( typeof _ry != 'undefined' ){
                                _item.attr( 'cy', _ry + ( _item.attr( 'cy' ) - _bbox.y ) );
                            }
                        }else if( _item.node.nodeName == 'path' ){
                        }else{
                            if( typeof _rx != 'undefined' ){
                                _item.attr( 'x', _rx + ( _item.attr( 'x' ) - _bbox.x ) );
                            }
                            if( typeof _ry != 'undefined' ){
                                _item.attr( 'y', _ry + ( _item.attr( 'y' ) - _bbox.y ) );
                            }
                        }
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
