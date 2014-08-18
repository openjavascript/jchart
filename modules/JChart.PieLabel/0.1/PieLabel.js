;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase', 'JChart.IconRect' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JChart.PieLabel.html' target='_blank'>API docs</a>
 *  
 * @namespace   JChart
 * @name PieLabel
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-23
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.PieLabel 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.PieLabel = PieLabel;

    function PieLabel( _stage, _lines, _pieModel ){

        this._model = new PieLabel.Model( _stage, _lines, _pieModel );
        this._view = new PieLabel.View( this._model );

        this._init();

        //JC.log( PieLabel.Model._instanceName, 'all inited', new Date().getTime() );
    }

    PieLabel.Model = 
        function( _stage, _lines, _pieModel ){
            this._stage = _stage;
            this._lines = _lines;
            this._pieModel = _pieModel;
        };

    JC.PureMVC.build( PieLabel, JChart.GraphicBase );

    JC.f.extendObject( PieLabel.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'PieLabel _beforeInit', new Date().getTime() );
            }
        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                    //_p._view.draw();
                });
            }
        , draw: function(){ this._view.draw(); return this; }
    });

    PieLabel.Model._instanceName = 'JCPieLabel';
    JC.f.extendObject( PieLabel.Model.prototype, {
        init:
            function(){
                //JC.log( 'PieLabel.Model.init:', new Date().getTime() );
                JChart.GraphicBase.Model.prototype.init.call( this );
            }

        , lines: function(){ return this._lines; }
        , pieModel: function(){ return this._pieModel; }

        , textList: 
            function(){ 
                typeof this._textList == 'undefined' && ( this._textList = [] );
                return this._textList;
            }

        , pathList: 
            function(){ 
                typeof this._pathList == 'undefined' && ( this._pathList = [] );
                return this._pathList;
            }
    });

    JC.f.extendObject( PieLabel.View.prototype, {
        init:
            function(){
                //JC.log( 'PieLabel.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this, _isCollision;
                _p.normalDraw();
                _isCollision = _p.isCollision();
                //JC.log( '_isCollision:', _isCollision, JC.f.ts() );
                _isCollision && _p.collideDraw();
            }

        , isCollision:
            function(){
                var _r = false, _p = this, _tl = _p._model.textList(), _len = _tl.length;
                for( var i = 0; i < _len; i++ ){
                    for( var j = i + 1; j < _len; j++ ){
                        if( _tl[ i ].hitTestObject( _tl[ j ] ) ){
                            return true;
                        }
                    }
                }
                return _r;
            }

        , normalDraw:
            function(){
                var _p = this, _pm = _p._model.pieModel(), _m = _p._model
                    , _offsetX = 0, _offsetY = 0
                    , _ix
                    ;
                $.each( _m.lines(), function( _k, _item ){
                    var _path, _style, _text;
                    _ix = _pm.displayLegendMap[ _k ];
                    _style = _pm.itemStyle( _ix );

                    _path = _pm.stage().path( _item.path )
                        .attr( { 'stroke': _style.fill } )
                        .translate( .5, .5 )
                        ;

                    _text = _p.stage().text( _offsetX, _offsetY, _item.data.name )
                        .attr( { 'fill': '#999', 'cursor': 'default' } )
                        ;

                    switch( _item.direction ){
                        case 'top':
                            {
                                _text.attr( { x: _item.end.x, y: _item.end.y - 5 } );
                                break;
                            }
                        case 'left_top':
                            {
                                _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                break;
                            }
                        case 'right_top':
                            {
                                _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                break;
                            }
                        case 'left_bottom':
                            {
                                _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                break;
                            }
                        case 'right_bottom':
                            {
                                _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                break;
                            }
                        case 'right':
                            {
                                _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                break;
                            }
                        case 'bottom':
                            {
                                _text.attr( { x: _item.end.x, y: _item.end.y + 5 } );
                                break;
                            }
                        case 'left':
                            {
                                _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                break;
                            }
                    }

                    _m.pathList().push( _path );
                    _m.textList().push( _text );
                });
            }

        , collideDraw:
            function(){
                //JC.log( 'collideDraw', JC.f.ts() );
                var _p = this, _pm = _p._model.pieModel(), _m = _p._model
                    , _offsetX = 0, _offsetY = 0
                    , _ix
                    , _pl = _m.pathList()
                    , _tl = _m.textList()
                    ;
                $.each( _pl, function( _k, _path ){ _path.remove() });
                _pl = [];
            }
    });

    return JC.PieLabel;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
