 ;(function(define, _win) { 'use strict'; define( [ 'JC.BaseMVC', 'Raphael' ], function(){
    window.JChart = window.JChart || {};

     JChart.Stage = Stage;

     function Stage( _container, _width, _height ){
        this._model = new Stage.Model( _container, _width, _height );
        this._view = new Stage.View( this._model );
        this._init();
     }

    Stage.Model =
     function( _container, _width, _height ){
         this._container = _container;
         this._width = _width;
         this._height = _height;
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
                    this._selector = Raphael( this._container, this.width(), this.height() );
                 }
                 return this._selector;
             }
         , width: function(){ return this._width; }
         , height: function(){ return this._height; }

         , createRoot: function(){ return Stage.createSVGElement(); }
    });

    JC.f.extendObject( Stage.View.prototype, {
        init:
            function(){
            }
    });


    Raphael.fn.roundedRectangle = function (x, y, w, h, r1, r2, r3, r4){
      var array = [];
      array = array.concat(["M",x,r1+y, "Q",x,y, x+r1,y]); //A
      array = array.concat(["L",x+w-r2,y, "Q",x+w,y, x+w,y+r2]); //B
      array = array.concat(["L",x+w,y+h-r3, "Q",x+w,y+h, x+w-r3,y+h]); //C
      array = array.concat(["L",x+r4,y+h, "Q",x,y+h, x,y+h-r4, "Z"]); //D

      return this.path(array);
    };

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
