;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JChart.Tips.html' target='_blank'>API docs</a>
 *  
 * @namespace   JChart
 * @class       Tips
 * @extends     JChart.GraphicBase
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-23
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.Tips 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Tips = Tips;

    function Tips( _stage, _tipsData, _coordinate, _colors  ){

        this._model = new Tips.Model( _stage, _tipsData, _coordinate, _colors );
        this._view = new Tips.View( this._model );

        this._init();

        //JC.log( Tips.Model._instanceName, 'all inited', new Date().getTime() );
    }

    Tips.Model = 
        function( _stage, _tipsData, _coordinate, _colors ){
            this._stage = _stage;
            this._tipsData = _tipsData;
            this._coordinate = _coordinate;
            this._colors = _colors;
        };

    JC.PureMVC.build( Tips, JChart.GraphicBase );

    JC.f.extendObject( Tips.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Tips _beforeInit', new Date().getTime() );
            }
        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                    //_p._view.draw();
                });
            }
        , draw: function(){ this._view.draw(); }
        , update: function( _indexData ){ this._view.update( _indexData ); return this; }
    });

    Tips.Model._instanceName = 'JCTips';
    JC.f.extendObject( Tips.Model.prototype, {
        init:
            function(){
                //JC.log( 'Tips.Model.init:', new Date().getTime() );
                JChart.GraphicBase.Model.prototype.init.call( this );
            }

        , type:
            function(){
                return this._coordinate || 'rect';
            }

        , tipsData: function(){ return this._tipsData; }

        , offsetX: function(){ return 10000; }
        , offsetY: function(){ return 100; }

        , space: function(){ return 2; }
        , itemSpace: function(){ return 8; }
        , itemWidth: function(){ return 20; }
        , itemHeight: function(){ return 20; }
        , colors: function(){ return this._colors; }
    });

    JC.f.extendObject( Tips.View.prototype, {
        init:
            function(){
                //JC.log( 'Tips.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this
                    ;

                _p._model.add( 
                    _p.stage().rect( 0 + _p._model.offsetX(), 0 + _p._model.offsetY(), 50, 30, 5 ).attr( { 
                        'stroke': '#999'
                        , 'fill': '#fff' 
                        , 'fill-opacity': .95
                    } ) 
                    , 'bg'
                );


                _p._model.add( 
                    _p.stage().text( 10 + _p._model.offsetX(), 14 + _p._model.offsetY(), 'tips' )
                    .attr( { 'font-weight': 'bold', 'fill': '#999', 'text-anchor': 'start' } )
                    , 'title'
                );

                var _countY = 5 + _p._model.item( 'title' ).getBBox().height + 14
                    , _countX = 30
                    , _maxWidth = 0
                    , _tmp
                    , _tmpBox
                    , _tmpItem
                    ;

                $.each( _p._model.tipsData(), function( _k, _item ){
                    _tmp = _p.stage().text( _p._model.offsetX() + _countX, _p._model.offsetY() + _countY,  _item.name || 'empty' )
                            .attr( { 'text-anchor': 'start', 'fill': _p._model.colors()[ _k ] } );
                    _tmpBox = JChart.f.getBBox( _tmp );

                    _p._model.add( _tmp, 'label_' + _k );

                    _tmpBox.width > _maxWidth && ( _maxWidth = _tmpBox.width );
                    _countY += _tmpBox.height +  5;
                });

                _countY = 5 + _p._model.item( 'title' ).getBBox().height + 14;
                _countX += _maxWidth + 10;

                $.each( _p._model.tipsData(), function( _k, _item ){
                    _tmpItem = _p._model.item( 'label_' + _k );
                    _tmpBox = JChart.f.getBBox( _tmpItem );
                    _tmp = _p.stage().text( _p._model.offsetX() + _countX, _p._model.offsetY() + _countY, '012345678901.00' )
                            .attr( { 'text-anchor': 'end', 'fill': _p._model.colors()[ _k ] } );
                    _p._model.add( _tmp, 'val_' + _k );
                    _p._model.add( _tmp, 'lastItem' );
                    _tmp.attr( 'x', _p._model.offsetX() + _countX + _tmp.getBBox().width );
                    _countY += _tmpBox.height +  5;
                });

                if( _p._model.tipsData().length ){
                    var _titleBox = _p._model.item( 'title' ).getBBox()
                        , _lastBox = _p._model.item( 'lastItem' ).getBBox()
                        , _w = _lastBox.x - _p._model.offsetX() + 10 + _lastBox.width
                        , _h = _lastBox.y - _p._model.offsetY() + _lastBox.height + 14
                        ;
                    //JC.log( _x, _y, _w, _h );
                    _p._model.item( 'bg' ).attr( { 'width': _w, 'height': _h } );
                }

            }
        , update:
            function( _indexData ){
                //JC.log( _ix, JC.f.ts() );
                var _p = this;
                if( !_indexData ) return;

                _p._model.item( 'title' ).attr( 'text', _indexData.title || 'empty' );

                if( _indexData.tipsData ){
                    var _labelMaxWidth = 0, _valMaxWidth = 0;
                    $.each( _indexData.tipsData, function( _k, _v ){
                        var _labelItem = _p._model.item( 'label_' + _k )
                            , _valItem = _p._model.item( 'val_' + _k )
                            , _tmpBox
                            ;
                        if( !( _labelItem && _valItem ) ) return;
                        _valItem.attr( 'text', _v );
                        _tmpBox = _valItem.getBBox();
                        _tmpBox.width > _valMaxWidth && ( _valMaxWidth = _tmpBox.width );

                        _tmpBox = _labelItem.getBBox();
                        _tmpBox.width > _labelMaxWidth && ( _labelMaxWidth = _tmpBox.width );

                    });

                    $.each( _indexData.tipsData, function( _k, _v ){
                        var _labelItem = _p._model.item( 'label_' + _k )
                            , _valItem = _p._model.item( 'val_' + _k )
                            , _tmpBox
                        ;

                        if( !( _labelItem && _valItem ) ) return;
                        _tmpBox = _labelItem.getBBox();
                        _valItem.attr( 'x', _p._model.offsetX() + _labelMaxWidth + _valMaxWidth + 44 );


                        if( _indexData.color ){
                            var _style = { 'fill': _indexData.color, 'font-weight': 'bold' };
                            _labelItem.attr( _style );
                            _valItem.attr( _style );
                        }
                    });

                    var _titleBox = _p._model.item( 'title' ).getBBox()
                        , _lastBox = _p._model.item( 'lastItem' ).getBBox()
                        , _w = _labelMaxWidth + _valMaxWidth + 44 + 15
                        ;
                    if( _w < 1 ) return;
                    _p._model.item( 'bg' ).attr( { 'width': _w } );

                }
            }
    });

    return JC.Tips;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
