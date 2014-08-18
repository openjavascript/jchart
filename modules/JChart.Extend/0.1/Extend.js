;(function(define, _win) { 'use strict'; define( [ 'Raphael', 'JChart.Geometry', 'JChart.common' ], function(){
    /**
     * 扩展 RaphaelJS 的基础事件
     * <p><b>require</b>: 
     *      <a href='Raphael'>Raphael</a>
     *      , <a href='JChart.Geometry'>JChart.Geometry.html</a>
     *      , <a href='JChart.common'>JChart.common.html</a>
     * </p>
     * <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
     * | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Extend.html' target='_blank'>API docs</a>
     * @version dev 0.1 2014-07-21
     * @author  qiushaowei   <suches@btbtd.org> | 75 Team
     */
    Raphael.el.mouseenter =
        function( _handler ){
            var _p = this, _bbox, _doc = $( document ), _win = $( window ), _rect;
            if( !_p.paper.selector ) return;

            _p.mouseover( function( _evt ){
                if( _p.IS_ENTER ) return;
                var _offset;
                _handler && _handler.call( _p, _evt );
                _bbox = JChart.f.getBBox( _p );
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
                _win.on( 'mousemove', _innerMousemove );
            });

            function _innerMousemove( _evt ){
                if( !_bbox ) return;
                var _offset = { x: Math.floor( _evt.pageX ), y : Math.floor( _evt.pageY ) };
                if( JChart.Geometry.pointRectangleIntersection( _offset, _rect ) ){
                }else{
                    _bbox = null;
                    _p.IS_ENTER = false;
                    _win.off( 'mousemove', _innerMousemove );
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
                _bbox = JChart.f.getBBox( _p );
                _p.IS_ENTER = true;
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

    Raphael.el.hitTestObject =
        function( _el ){
            var _r = false, _p = this, _r1, _r2;
            if( _el ){
                _r1 = _p.getBBox();
                _r2 = _el.getBBox();
                _r = JChart.Geometry.intersectRect( _r1, _r2 );
            }
            return _r;
        }

});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
