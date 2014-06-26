;(function(define, _win) { 'use strict'; define( [], function(){
    window.JChart = window.JChart || {};

    JChart.Geometry = {
        pointRectangleIntersection:
            function(p, r) {
                return p.x >= r.x && p.x <= r.x2 && p.y >= r.y && p.y <= r.y2;
            }
        /**
         * 计算两个坐标点之间的距离
         */
        , pointDistance: function( _p1, _p2 ){
            var _dx = _p2.x - _p1.x
                , _dy = _p2.y - _p1.y
                , _dist = Math.sqrt( _dx * _dx + _dy * _dy );
                ;
            return _dist;
        }
        /**
         * 从长度和角度求坐标点
         */
        , distanceAngleToPoint: function( _distance, _angle){
            var _radian = _angle * Math.PI / 180;					
            return {
                x: ( Math.cos( _radian  ) * _distance )
                , y: ( Math.sin( _radian ) * _distance )
            }
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
