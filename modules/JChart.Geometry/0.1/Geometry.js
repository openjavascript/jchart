;(function(define, _win) { 'use strict'; define( [], function(){
    window.JChart = window.JChart || {};

    JChart.Geometry = {
        pointRectangleIntersection:
            function(p, r) {
                return p.x >= r.x && p.x <= r.x2 && p.y >= r.y && p.y <= r.y2;
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
