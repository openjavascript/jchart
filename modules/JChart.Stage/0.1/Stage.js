 ;(function(define, _win) { 'use strict'; define( [ 'exCanvas', 'JC.common', 'JC.BaseMVC' ], function(){
    window.JChart = window.JChart || {};

     JChart.Stage = Stage;

     function Stage( _width, _height, _isItem ){
        this._model = new Stage.Model( _width, _height, _isItem );
        this._view = new Stage.View( this._model );
        this._init();
     }

    Stage.Model =
     function( _width, _height, _isItem ){
         this._width = _width;
         this._height = _height;

         this._isItem = _isItem;
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
            function(){
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

    Stage.Model._instanceName = 'JChartStage';
    Stage.Model._idCount = 1;

    JC.f.extendObject( Stage.Model.prototype, {
         init: 
             function(){
                 this._childrens = [];
                 this._id = Stage.Model._idCount++;
             }

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
                _pntStage && _pntStage().removeChild( _childStage.id() );
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
                    this._selector = $( this.domObj() );
                    this._isItem && this._selector.addClass( 'jchartItem' );
                 }
                 return this._selector;
             }
         , width: function(){ return this._width; }
         , height: function(){ return this._height; }

         , domObj: 
             function(){
                 if( !this._domObj ){
                     this._domObj = document.createElement( 'canvas' );

                     this._domObj.setAttribute( 'width', this.width() );
                     this._domObj.style.width = this.width() + 'px';

                     this._domObj.setAttribute( 'height', this.height() );
                     this._domObj.style.height = this.height() + 'px';

                     window.G_vmlCanvasManager && ( this._domObj = G_vmlCanvasManager.initElement(this._domObj) );
                 }
                 return this._domObj;
             }

         , twod: function(){ return this.domObj().getContext( '2d' ); }
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
