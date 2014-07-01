;(function(define, _win) { 'use strict'; define( [ 'Raphael', 'JChart.Geometry', 'JChart.Base' ], function(){
    Raphael.el.mouseenter =
        function( _handler ){
            var _p = this, _bbox, _doc = $( document ), _win = $( window ), _rect;
            if( !_p.paper.selector ) return;

            _p.mouseover( function( _evt ){
                if( _p.IS_ENTER ) return;
                var _offset;
                _handler && _handler.call( _p, _evt );
                _bbox = _p.getBBox();
                _p.IS_ENTER = true;
                _offset = $( _p.paper.selector ).offset();
                _offset.x = _offset.left;
                _offset.y = _offset.top;
                _rect = {
                    x: Math.floor( _offset.x + _bbox.x )
                    , x2: Math.floor( _offset.x + _bbox.x2 )
                    , y: Math.floor( _offset.y + _bbox.y )
                    , y2: Math.floor( _offset.y + _bbox.y2 )
                };
                _win.mousemove( _innerMousemove );
            });

            function _innerMousemove( _evt ){
                if( !_bbox ) return;
                var _offset = { x: Math.floor( _evt.pageX ), y : Math.floor( _evt.pageY ) };
                if( JChart.Geometry.pointRectangleIntersection( _offset, _rect ) ){
                }else{
                    _bbox = null;
                    _p.IS_ENTER = false;
                    _win.mousemove( _innerMousemove );
                }
            }
        };

    Raphael.el.mouseleave =
        function( _handler ){
            var _p = this, _bbox, _doc = $( document ), _win = $( window ), _rect;
            if( !_p.paper.selector ) return;

            _p.mouseover( function( _evt ){
                if( _p.IS_LEAVE ) return;
                var _offset;
                _bbox = _p.getBBox();
                _p.IS_LEAVE = true;
                _offset = $( _p.paper.selector ).offset();
                _offset.x = _offset.left;
                _offset.y = _offset.top;
                _rect = {
                    x: Math.floor( _offset.x + _bbox.x )
                    , x2: Math.floor( _offset.x + _bbox.x2 )
                    , y: Math.floor( _offset.y + _bbox.y )
                    , y2: Math.floor( _offset.y + _bbox.y2 )
                };
                _win.on( 'mouseout', _innerMousemove );
            });

            function _innerMousemove( _evt ){
                if( !_bbox ) return;
                //JC.f.safeTimeout( function(){
                    var _offset = { x: Math.floor( _evt.pageX ), y : Math.floor( _evt.pageY ) };
                    if( JChart.Geometry.pointRectangleIntersection( _offset, _rect ) ){
                    }else{
                        _bbox = null;
                        _p.IS_LEAVE = false;
                        _handler && _handler.call( _p, _evt );
                        _win.off( 'mouseout', _innerMousemove );
                    }
                //}, _p, 'asdfaweasdfawsef_leave', 200 );
            }
        };

});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
