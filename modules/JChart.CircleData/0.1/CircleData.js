;(function(define, _win) { 'use strict'; define( [], function(){
/**
 * JChart 图表数据( 曲线图、柱状图 )
 *
 * <p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.CircleData.html' target='_blank'>API docs</a>
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
 * @class       CircleData
 * @version dev 0.1 2014-08-28
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.HistogramLateral 示例</h2>
 */

    JChart.CircleData = {
        /**
         * 
         */
        xAxis: {
            categories: [ 'cat1', 'cat2', 'cat3' ]
       }
    };

    return CircleData;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
