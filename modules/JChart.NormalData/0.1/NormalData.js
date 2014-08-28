 ;(function(define, _win) { 'use strict'; define( [], function(){
/**
 * JChart 图表数据( 曲线图、柱状图 )
 *
 * <p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.NormalData.html' target='_blank'>API docs</a>
 *  </p>
 *
 * <h2>特殊字段说明</h2>
 *
 * <dl>
 *    <dt></dt>
 *    <dd><dd>
 * </dl> 
 *
 * @namespace   JChart
 * @class       NormalData
 * @version dev 0.1 2014-08-28
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 */

    JChart.NormalData = {
        /**
         * 横向坐标数据
         * @property    xAxis
         * @type        {object}
         */
        xAxis: {
            /**
             * 横向坐标的显示数据
             * @property    xAxis.categories
             * @type        {Array of String}
             * @default     null
             * @example 
             *  categories: [ 'cat1', 'cat2', 'cat3' ]
             */
            categories: null

            /**
             * 横向坐标显示数据是否自动换行 
             * @property    xAxis.wordwrap
             * @type        {Boolean}
             * @default     true
             * @example 
             *  wordwrap: false
             */
            , wordwrap: true
       }
        /**
         * 纵向坐标数据
         * @property    yAxis
         * @type        {object}
         */
        , yAxis: {
       }

    };

    return NormalData;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
