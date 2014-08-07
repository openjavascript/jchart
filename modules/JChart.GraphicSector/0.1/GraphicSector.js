;(function(define, _win) { 'use strict'; define( [ 'JC.PureMVC', 'Raphael', 'JChart.Group', 'JChart.GraphicBase' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href='JC.PureMVC.html'>JC.PureMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.GraphicSector.html' target='_blank'>API docs</a>
 *  
 * @name    GraphicSector
 * @displayName GraphicSector
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-26
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.GraphicSector 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.GraphicSector = GraphicSector;

    function GraphicSector( _stage, _pieCor, _style, _hoverStyle, _index  ){

        this._model = new GraphicSector.Model( _stage, _pieCor, _style, _hoverStyle, _index );
        this._view = new GraphicSector.View( this._model );

        this._init();

        //JC.log( GraphicSector.Model._instanceName, 'all inited', new Date().getTime() );
    }

    GraphicSector.Model = 
        function( _stage, _pieCor, _style, _hoverStyle, _index ){
            this._stage = _stage;
            this._pieCor = _pieCor;
            this._style = _style;
            this._hoverStyle = _hoverStyle;
            this._index = _index;
        };

    JC.PureMVC.build( GraphicSector, JChart.GraphicBase );

    JC.f.extendObject( GraphicSector.prototype, {

        _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'inited', function(){
                    _p._view.draw();
                });

                _p.on( 'draw_done', function(){
                    _p._model.item( 'element' ).click( function( _evt ){
                        var _isSelected = _p._model.toggleSelected();
                        _p.trigger( 'update_isSelected', _isSelected );
                        _p.trigger( 'selected_changed', [ _isSelected, _p._model.id(), _p._model.index() ] );
                    });

                    _p._model.item( 'element' ).mouseover(
                        function( _evt ){
                            _p.trigger( 'mouseenter', [ _evt, _p._model.id(), _p._model.index() ] );
                        }
                    );

                    _p._model.item( 'element' ).mouseout(
                        function( _evt ){
                            _p.trigger( 'mouseleave', [ _evt, _p._model.id(), _p._model.index() ] );
                        }
                    );

                });

                _p.on( 'update_isSelected', function( _evt, _isSelected ){
                    _p._view.updateSelected( _isSelected );
                });
            }

        , isSelected: function(){ return this._model._isSelected; }
        , id: function(){ return this._model.id(); }
        , selected: 
            function( _setter ){
                typeof _setter != 'undefined' 
                    && this.trigger( 'update_isSelected', [ _setter ] );
                return this;
            }
        , index: function(){ return this._model.index(); }
    });

    GraphicSector.Model._instanceName = 'JCGraphicSector';
    GraphicSector.Model.INS_COUNT = 1;

    var _Model = GraphicSector.Model;
    _Model.PI = 3.14;
    _Model.ANGLE = 360;
    _Model.QUARTER_ANGLE = _Model.ANGLE / 4;
    _Model.ANIMATE_TIME = 500;
    _Model.AD_TIME = 30;

    JC.f.extendObject( GraphicSector.Model.prototype, {
        init:
            function(){
                //JC.log( 'GraphicSector.Model.init:', new Date().getTime() );
                this._insCount = GraphicSector.Model.INS_COUNT++;
            }

        , id: function(){ return this._insCount; }
        , index: function(){ return this._index; }

        , toggleSelected:
            function(){
                return this._isSelected = !this._isSelected;
            }

        , isSelected: 
            function(){ 
                return this._isSelected; 
            }

        , selected: 
            function( _setter ){ 
                typeof _setter != 'undefined' && ( this._isSelected = _setter );
                return this._isSelected; 
            }
        , getRadianPoint:
            function( _totalD, _r, _center ) {
                var _x, _y;
                var _endPoint = {};
                var _dir = this.getDir( _totalD );
                var _rD = 2 * _Model.PI / _Model.ANGLE * 
                	( _totalD - _Model.QUARTER_ANGLE * _dir );
                var _subtense = Math.sin( _rD ) * _r;
                var _limb = Math.cos( _rD ) * _r;
                if( _dir & 1 ) {/* 2，4象限 */
                    _x = _limb;
                    _y = _subtense;
                } else {/* 1，3象限 */
                    _x = _subtense;
                    _y = _limb;
                }
                if( _dir < 2 ) {
                    _endPoint.x = _center.x + _x ;
                    _endPoint.y = ( _dir == 0 ) ? ( _center.y - _y ) : ( _center.y + _y );
                } else {
                    _endPoint.x = _center.x - _x;
                    _endPoint.y = ( _dir == 2 ) ? ( _center.y + _y ) : ( _center.y - _y );
                }
               return _endPoint;
            }
        , getDir :
            function( _angle ) {
                return Math.floor( _angle / 90 );
            }
    });

    JC.f.extendObject( GraphicSector.View.prototype, {
        init:
            function(){
                //JC.log( 'GraphicSector.View.init:', new Date().getTime() );
            }

        , draw:
            function(){
                var _p = this, _item, _path,
                    _pie = _p._model._pieCor,
                    _center = _pie.centerPoint,
                    _radius = _pie.radius,
                    _radius2 = _pie.radius2,
                    _itemD = _pie.itemD,
                    _baseD = _pie.baseD,
                    _startPoint = { x: _center.x, y: _center.y - _radius2 },
                    _endPoint, _innerCPoint1, _innerCPoint2;

                _path = [
                    'M', _startPoint.x, _startPoint.y,
                    'A', _radius, _radius, 0, 0, 1, _startPoint.x, _startPoint.y,
                    'L', _startPoint.x, _startPoint.y,
                    'A', _radius2, _radius2, 0, 0, 0, _startPoint.x, _startPoint.y
                ];
                _item = _p._model.stage().path( _path );
                var _totalTime = _Model.ANIMATE_TIME,
                    _timeStamp = new Date().getTime(),
                    _timeProp, _newTime, _remoteTime, 
                    _remoteRadius, _remoteBaseD, _remoteEndD;
                var _timer = 
                window.setInterval( function(){
                    _newTime = new Date().getTime();
                    _remoteTime = _newTime - _timeStamp;
                    if( _remoteTime >= _totalTime ) {
                        _remoteTime = _totalTime;
                        window.clearInterval( _timer );
                    }
                    _timeProp = _remoteTime / _totalTime;
                    _remoteRadius = _radius2 + ( _radius - _radius2 ) * _timeProp;
                    _remoteBaseD = _baseD * _timeProp;
                    _remoteEndD = _remoteBaseD + _itemD * _timeProp;
                    _startPoint = _p._model.getRadianPoint( _remoteBaseD, _remoteRadius, _center );
                    _endPoint = _p._model.getRadianPoint( _remoteEndD, _remoteRadius, _center );
                    _innerCPoint1 = _p._model.getRadianPoint( _remoteBaseD, _radius2, _center );
                    _innerCPoint2 = _p._model.getRadianPoint( _remoteEndD, _radius2, _center );
                    _path = [
                        'M', _startPoint.x, _startPoint.y,
                        'A', _remoteRadius, _remoteRadius, 0, 0, 1, _endPoint.x, _endPoint.y,
                        'L', _innerCPoint2.x, _innerCPoint2.y,
                        'A', _radius2, _radius2, 0, 0, 0, _innerCPoint1.x, _innerCPoint1.y
                    ];
                    _item.attr( { path: _path } );
                }, _Model.AD_TIME );
                _p._model.add( _item, 'element' );
                _item.attr( { 'cursor': 'pointer' } );
                _p.unhover();
                _p.trigger( 'draw_done' );
            }
        , updateSelected:
            function( _isSelected, _ms, _distance ) {
                var _p = this
                    , _item = _p._model.item( 'element' )
                    , _target
                    , _transform
                    , _pie = _p._model._pieCor
                    ;
                _ms = _ms || 200;
                _distance = _distance || 10;
                _p._model.selected( _isSelected );
                if( _pie._itemD && _pie._itemD >= 360 ) {
                } else {
                    _item.stop();
                    if( _isSelected ) {
                        var _remotePoint = _p._model.getRadianPoint( _pie.midD, 10, { x:0, y:0 } );
                        _transform = JC.f.printf( 't{0} {1}', _remotePoint.x, _remotePoint.y );
                    } else {
                        _transform = JC.f.printf( 't{0} {1}', 0, 0 );
                    }
                     _item.animate( { transform: _transform}, _ms );
                }
            }
    });

    return JC.GraphicSector;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
)
