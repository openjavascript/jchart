;(function(define, _win) { 'use strict'; define( [], function(){
    window.JChart = window.JChart || {};
    /**
     * JChart.Geometry 提供一些实用的几何算法
     * <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
     * | <a href='http://raphaeljs.com/reference.html' target='_blank'>API docs</a>
     * @namespace   JChart
     * @name Geometry
     * @version dev 0.1 2014-07-21
     * @author  qiushaowei   <suches@btbtd.org> | 75 Team
     */
    JChart.Geometry = {
        /**
         * 判断一个点是否在矩形里面
         * @method  pointRectangleIntersection
         * @param   {point} _p
         * @param   {rect}  _r
         * @return  Boolean
         * @static
         */
        pointRectangleIntersection:
            function(p, r) {
                return p.x >= r.x && p.x <= r.x2 && p.y >= r.y && p.y <= r.y2;
            }
        /**
         * 计算两个坐标点之间的距离
         * @method pointDistance
         * @param   {point} _p1
         * @param   {point} _p2
         * @return  Boolean
         * @static
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
         * @method  distanceAngleToPoint
         * @param  {Number} _distance
         * @param  {Number} _angle
         * @return Point
         * @static
         */
        , distanceAngleToPoint: function( _distance, _angle){
            var _radian = _angle * Math.PI / 180;					
            return {
                x: ( Math.cos( _radian  ) * _distance )
                , y: ( Math.sin( _radian ) * _distance )
            }
        }
        /**
         * 从角度获取弧度
         * @method  radians
         * @param   {Number} _angle
         * @return  {Number}
         * @static
         */
        , radians: function( _angle ){ return _angle * Math.PI / 180; }
        /**
         * 从弧度获取角度
         * @method  degree
         * @param   {Number} _radians
         * @return  {Number}
         * @static
         */
        , degree: function( _radians ){ return _radians / Math.PI * 180; }
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
