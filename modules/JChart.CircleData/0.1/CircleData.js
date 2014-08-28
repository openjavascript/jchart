;(function(define, _win) { 'use strict'; define( [], function(){
/**
 * JChart 图表数据( 曲线图、环状图、管状图 )
 *
 * <p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.CircleData.html' target='_blank'>API docs</a>
 *  </p>
 * <h2></h2>
 * <dl>
 *    <dt></dt>
 *    <dd><dd>
 * </dl> 
 *
 * @namespace   JChart
 * @class       CircleData
 * @constructor
 * @static
 * @version dev 0.1 2014-08-28
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
<h2>显示 两块数据[ 曲线图、环状图、管状图 ]的图表数据</h2>
<pre>{
    series:[{
        data: [
            ['全体覆盖率',   60],
            ['样本覆盖率',   20]
        ]
    }]
    , isPercent: true
    
    , colors: [ 
        0x00ABEF
        , 0xFF6297
        
        , 0x09c100
        , 0x0c76c4 				
        , 0xff0619
        
        , 0xFFBF00			
        , 0xff7100	
        , 0xff06b3
        
        , 0x41e2e6			
        , 0xc3e2a4	
        , 0xffb2bc
        
        , 0xdbb8fd
    ]
}</pre>
 */

    JChart.CircleData = {
        /**
         * 展现的数据
         * <br />series 数组只有索引0数据
         * <br />series 索引0 里的 data 应该是个两维数组, 或者 数组里的数据为 object: { name: String, y: Number }
         * @property    series
         * @type        {Array of Object}
         * @default     null
         * @example
         * 
<pre>series:[{
    data: [
        ['全体覆盖率',   60],
        ['样本覆盖率',   20]
    ]
}]</pre>
<pre>series:[{
    data: [
        { name:'全体覆盖率',   y:60],
        [ name:'样本覆盖率',   y:20]
    ]
}]</pre>

         */
        series: null
        /**
         * 图表数值是否按总数值=100划分百分比
         * @property    isPercent
         * @type        {Boolean}
         * @default     false
         * @example 
         *  isPercent: false
         */
        , isPercent: false
        /**
         * 数据项的显示颜色
         * @property    colors
         * @type        {Array of hex colors}
         * @default:    [0x03ACEF, 0x5DC979, 0x09c100, 0x0c76c4 , 0xff0619, 0xFFBF00, 0xff7100, 0xff06b3, 0x41e2e6, 0xc3e2a4, 0xffb2bc, 0xdbb8fd]    
         */
        , colors: [
            0x09c100, 
            0x0c76c4, 				
            0xff0619,
            
            0xFFBF00, 			
            0xff7100,	
            0xff06b3, 
            
            0x41e2e6,			
            0xc3e2a4,	
            0xffb2bc,
            
            0xdbb8fd
        ]
        /**
         * 设置圆环的环宽
         * <br /> 仅对 NDount 生效
         * @property radiusStep
         * @default 10
         * @type int
         */
        , radiusStep: 10
        /**
         * 不同 圆环图的设置数据
         * @property plotOptions
         * @type {Object}
         */
        , plotOptions: {
            /**
             * NDount 的设置数据
             * @property plotOptions.ndount
             * @type {Object}
             */
            ndount: {
                /**
                 * NDount的圆环中的文本显示设置
                 * @property plotOptions.ndount.cdataLabels
                 * @type {Object}
                 */
                cdataLabels: {
                    /**
                     * 是否显示 NDount的圆环中的文本
                     * @property plotOptions.ndount.cdataLabels.enabled
                     * @type Boolean
                     * @default false
                     */
                    enabled: false
                }
            }
        }
        /**
         * 图表背景的设置数据
         * @property    chart
         * @type        {object}
         */
        , chart: {
            /**
             * 图表的背景颜色
             * @property    chart.bgColor
             * @type        {hex color}
             * @default     0xcccccc
             */
            bgColor: 0xcccccc
            /**
             * 图表的背景色透明度
             * @property    chart.bgAlpha
             * @type        {Number}     0.01 ~ 1
             * @default     0.13
             */
            , bgAlpha: .13
            /**
             * 图表数据显示块的高度 ( pending )
             * <br />有时需要把多个数据图表显示一样的视觉高度, 但是其他图表的 水平label高度不一样, 就会导致视觉上的不同
             * <br />这个属性就是为了解决这个问题, 把图表数据显示块设置为统一的高度
             * @property    chart.graphicHeight
             * @type        {Number}     
             * @default     0,     0 = auto
             */
            , graphicHeight: 0
        }
        /**
         * tips 设置数据 
         * @property    tooltip
         * @type        {object}
         */
        , tooltip: {
            /**
             * 是否显示 tips ( pending )
             * @property    tooltip.enabled
             * @type        {Boolean}
             * @default     true
             * @example 
             *  enabled: true
             */
            enabled: true
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
