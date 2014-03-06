 ;(function(define, _win) { 'use strict'; define( [ 'JC.common', 'JC.BaseMVC' ], function(){
    window.JChart = window.JChart || {};

     JChart.Stage = Stage;

     function Stage( _width, _height, _isRoot ){
        this._model = new Stage.Model( _width, _height, _isRoot );
        this._view = new Stage.View( this._model );
        this._init();
     }

     Stage.createSVGElement = 
        function( _ns, _elementNS ){
            _ns = _ns || Stage.Model.NS;
            _elementNS = _elementNS || Stage.Model.ELEMENT_NS;
             var _r = document.createElementNS( _ns, 'svg' );
             _r.setAttribute( 'version', '1.1' );
             _r.setAttributeNS( 
                _elementNS
                 , "xmlns"
                 , _ns
             );
             _r.setAttributeNS( 
                _elementNS
                 , "xmlns:xlink"
                 , "http://www.w3.org/1999/xlink"
             );
             return _r;
        };

    Stage.Model =
     function( _width, _height, _isRoot ){
         this._width = _width;
         this._height = _height;

         this._isRoot = _isRoot;
     };

    JC.BaseMVC.build( Stage );

    JC.f.extendObject( Stage.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Base _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
            }

        , _inited:
            function(){
                //JC.log( 'Base _inited', new Date().getTime() );
            }

        , width: function(){ return this._model.width(); }
        , height: function(){ return this._model.height(); }
        , id: function(){ return this._model.id(); }

        , childrens: function(){ return this._model.childrens(); }
        , removeChild: function(){ this._model.removeChild.apply( this._model, JC.f.sliceArgs( arguments ) ); }
        , parent: function(){ return this._model.parent(); }

        , add: 
            function( _stage ){
                this._model.cleanRelationship.apply( this._model, [ _stage, this ] );
                this._model.add.apply( this._model, JC.f.sliceArgs( arguments ) );
                return this;
            }

        , remove:
            function(){
                this._model.cleanRelationship( this );
                this._model.remove.apply( this._model, JC.f.sliceArgs( arguments ) );
                return this;
            }

        , root: function(){ return this._model.root.apply( this._model, JC.f.sliceArgs( arguments ) ); }

        , createTitle: function(){ return this._model.createTitle.apply( this._model, JC.f.sliceArgs( arguments ) ); }

        , setVal: function(){ this._model.setVal.apply( this._model, JC.f.sliceArgs( arguments ) ); return this; }
    });

    Stage.Model.NS = 'http://www.w3.org/2000/svg';
    Stage.Model.ELEMENT_NS = 'http://www.w3.org/2000/xmlns/';

    Stage.Model._instanceName = 'JChartStage';
    Stage.Model._idCount = 1;

    JC.f.extendObject( Stage.Model.prototype, {
         init: 
             function(){
                 this._childrens = [];
                 this._id = Stage.Model._idCount++;
             }

        , id: function(){ return this._id; }

        , isRoot: function(){ return this._isRoot; }

        , childrens: 
            function( _clean ){
                _clean && ( this._childrens = [] );
                return this._childrens;
            }

        , removeChild:
            function( _id ){
                var i, j;
                for( i = this._childrens.length - 1; i >= 0; i-- ){
                    if( this._childrens[ i ].id() === _id ){
                        this._childrens.splice( i );
                    }
                }
            }

        , add: 
            function( _stage ){
                this.childrens().push( _stage );
                _stage.parent( this );
            }

        , remove:
            function(){
                $.each( this.childrens(), function( _ix, _item ){
                    _item.remove();
                });
                this.selector() && this.selector().remove();
                this.childrens( true );
            }

        , cleanRelationship: 
            function( _childStage, _pntStage ){
                _childStage.parent() && _childStage.parent().removeChild( _childStage.id() );
                _pntStage && _pntStage.removeChild( _childStage.id() );
                _childStage.parent( null );
            }
        
        , parent:
            function( _setter ){
                typeof _setter != 'undefined' && ( this._parent = _setter );
                return this._parent;
            }

         , selector: 
             function(){
                 if( !this._selector ){
                    this._selector = $( this.root() );
                    this.isRoot() && this._selector.addClass( 'jchartRoot' );
                    this._isItem && this._selector.addClass( 'jchartItem' );
                 }
                 return this._selector;
             }
         , width: function(){ return this._width; }
         , height: function(){ return this._height; }

         , createRoot: function(){ return Stage.createSVGElement(); }

         //<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="475" height="350">
         , root: 
             function(){
                 if( !this._root ){
                     this._root = this.createRoot();
                     this._root.setAttribute( 'width', this.width() );
                     this._root.setAttribute( 'height', this.height() );
                 }
                 return this._root;
             }

         , createTitle: 
             function(){
                 var _r = document.createElementNS( Stage.Model.NS, 'text' );
                    _r.setAttribute( 'style', 'font-family:Verdana;font-size:24;height:30;y:200;color:red;' );
                    _r.setAttribute( 'y', 200 );
                 return _r;
             }

         , setVal:
             function( _item, _val ){
                 _item.innerHTML = _val;
             }
    });

    JC.f.extendObject( Stage.View.prototype, {
        init:
            function(){
            }
    });

     return Stage;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
