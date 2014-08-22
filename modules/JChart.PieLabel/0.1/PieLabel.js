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

        , leftTopLabel: 
            function(){ 
                typeof this._leftTopLabel == 'undefined' && ( this._leftTopLabel = [] );
                return this._leftTopLabel;
            }

        , leftBottomLabel: 
            function(){ 
                typeof this._leftBottomLabel == 'undefined' && ( this._leftBottomLabel = [] );
                return this._leftBottomLabel;
            }

        , rightTopLabel: 
            function(){ 
                typeof this._rightTopLabel == 'undefined' && ( this._rightTopLabel = [] );
                return this._rightTopLabel;
            }

        , rightBottomLabel: 
            function(){ 
                typeof this._rightBottomLabel == 'undefined' && ( this._rightBottomLabel = [] );
                return this._rightBottomLabel;
            }

        , maxWidth:
            function( _setter ){
                typeof _setter != 'undefined' && ( this._maxWidth = _setter );
                return this._maxWidth || 0;
            }

        , maxHeight:
            function( _setter ){
                typeof _setter != 'undefined' && ( this._maxHeight = _setter );
                return this._maxHeight || 0;
            }

    });

    JC.f.extendObject( PieLabel.View.prototype, {
        init:
            function(){
                //JC.log( 'PieLabel.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this;
                _p.normalDraw();
                _p.isCollision() && _p.collideDraw();
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
                    , _maxWidth = 0, _maxHeight = 15
                    ;

                var _topLabel
                    , _rightLabel
                    , _bottomLabel
                    , _leftLabel
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
                                _topLabel = _text;
                                break;
                            }
                        case 'right':
                            {
                                _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                _rightLabel = _text;
                                break;
                            }
                        case 'bottom':
                            {
                                _text.attr( { x: _item.end.x, y: _item.end.y + 5 } );
                                _bottomLabel = _text;
                                break;
                            }
                        case 'left':
                            {
                                _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                _leftLabel = _text;
                                break;
                            }

                        case 'left_top':
                            {
                                _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                _m.leftTopLabel().push( _text );
                                break;
                            }
                        case 'right_top':
                            {
                                _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                _m.rightTopLabel().push( _text );
                                break;
                            }
                        case 'left_bottom':
                            {
                                _text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
                                _m.leftBottomLabel().push( _text );
                                break;
                            }
                        case 'right_bottom':
                            {
                                _text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
                                _m.rightBottomLabel().push( _text );
                                break;
                            }
                    }

                    var _bbox = _text.getBBox();
                        _bbox.width > _maxWidth && ( _maxWidth = _bbox.width );
                        _bbox.height > _maxHeight && ( _maxHeight = _bbox.height );

                    _m.pathList().push( _path );
                    _m.textList().push( _text );
                });

                _m.maxWidth( _maxWidth );
                _m.maxHeight( _maxHeight );

                if( _topLabel ){
                    _m.leftTopLabel().push( _topLabel );
                }
                
                if( _rightLabel ){
                    _m.rightTopLabel().push( _rightLabel );
                }
                
                if( _bottomLabel ){
                    _m.rightBottomLabel().push( _bottomLabel );
                }
                
                if( _leftLabel ){
                    _m.leftBottomLabel().push( _leftLabel );
                }

                //JC.log( _m.maxWidth(), _m.maxHeight() );
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

                _p.fixRightTopLabel( _m.rightTopLabel() );

                 _m.rightBottomLabel().reverse() 
                _p.fixRightBottomLabel( _m.rightBottomLabel() );

                 _m.leftTopLabel().reverse();
                 _p.fixLeftTopLabel( _m.leftTopLabel() );

                 _p.fixLeftBottomLabel( _m.leftBottomLabel() );
            }

        , fixRightTopLabel:
            function( _labels ){
                if( !_labels.length ) return;
                var _p = this, _pm = _p._model.pieModel(), _m = _p._model;
                var _c = _pm.coordinate()
                    , _x = _c.cx + 5
                    , _y = _c.chartY + 5
                    , _maxWidth = _m.maxWidth(), _maxHeight = _m.maxHeight()
                    , _endX = _c.chartX + _c.chartWidth - 5 - _maxWidth
                    , _endY = _c.cy - _maxHeight - 5
                    ;	


                if( _labels.length < 5 ){
                    _x = _c.chartX + _c.chartWidth - ( _c.cx - _c.chartX ) / 5;
                }

                _p.positionItems( _labels, _x, _y, _endX, _endY, function( _item ){				
                    /*
                    var _line = _item.data.line as JSprite
                    , _controlX = -8
                    , _controlY = -8
                    , _anchorX = _item.x - 2
                    , _anchorY = _item.y + _item.height / 2
                    ;			

                    if( _item.data.data.start.x > _anchorX && _item.data.data.start.y > _anchorY ){
                        _controlX = 8;
                        _controlY = 0;
                        _anchorX = _item.x + _item.width / 2;
                        _anchorY = _item.y + _item.height + 2;
                    }

                    if( _line ){

                        _line.graphics.clear();
                        _line.graphics.lineStyle( 1, _item.data.color );
                        _line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
                        _line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );

                        _line.graphics.curveTo( 
                                _anchorX + _controlX, _anchorY + _controlY
                                , _anchorX, _anchorY
                                );
                    }
                    */
                });

            }

        , fixRightBottomLabel:
            function( _labels ){
            }

        , fixLeftTopLabel:
            function( _labels ){
            }

        , fixLeftBottomLabel:
            function( _labels ){
            }

		, positionItems:
            function( _labels, _x, _y, _endX, _endY, _cb )
            {
                JC.log( 'positionItems', _x, _endX );
                var _xWidth = Math.abs( _x - _endX )
                    , _xIsMax = _x > _endX
                    
                    ,  _yHeight = Math.abs( _y - _endY )
                    , _yIsMax = _y > _endY
                    
                    , _maxLen = _labels.length - 1
                    , _yStep = Math.abs( _y - _endY ) / _maxLen
                    ;
                if( _labels.length ){
                    var _tmpX, _tmpY = _y, _tmpWidth = _xWidth;
                    $.each( _labels, function( _k, _item ){
                        var _percent = .65
                        , _maxX = Math.max( _x, _endX )
                        , _minX = Math.min( _x, _endX )
                        ;
                        if( _xIsMax ){
                            if( _k == 0 ){
                                _percent = .99;
                            }else if( _k == _maxLen ){
                            }else{				
                            }
                        }else{
                            if( _k == 0 ){
                                _percent = .99;
                            }else if( _k == _maxLen ){
                            }else{				
                            }
                        }
                        _tmpWidth *= _percent;
                        if( _xIsMax ){
                            _tmpX = _maxX - ( _xWidth - _tmpWidth );
                        }else{						
                            _tmpX = _minX + ( _xWidth - _tmpWidth );
                        }
                        _item.attr( { 'x': _tmpX, 'y': _tmpY } );
                        
                        if( _yIsMax ){
                            _tmpY -= _yStep;
                        }else{
                            _tmpY += _yStep;
                        }
                        
                        _cb && _cb( _item );				
                    });
                }else{
                    
                }
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
