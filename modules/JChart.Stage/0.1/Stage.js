 ;(function(define, _win) { 'use strict'; define( [ 'exCanvas', 'JChart.common' ], function(){
     JChart.Stage = Stage;

     function Stage( _width, _height, _isItem ){

        this._model = new Model( _width, _height, _isItem );
        this._view = new View( this._model );
        this._init();
     }

     Stage.prototype = {
         _init:
            function(){
                this._model.init();
                this._view.init();
            }

        , selector: function(){ return this._model.selector(); }
        , width: function(){ return this._model.width(); }
        , height: function(){ return this._model.height(); }
      
     };

     function Model( _width, _height, _isItem ){
         this._width = _width;
         this._height = _height;

         this._isItem = _isItem;
     }

     Model.prototype = {
         init: 
             function(){
                 this.selector();
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

     };

     function View( _model ){
         this._model = _model;
     }

     View.prototype = {
         init:
             function(){
                 //this._model.twod().fillRect( 0, 0, 100, 100 );
             }
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
