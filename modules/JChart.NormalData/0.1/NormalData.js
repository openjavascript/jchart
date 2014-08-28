 ;(function(define, _win) { 'use strict'; define( [], function(){
/**
 * JChart 图表数据( 曲线图、柱状图 )
 *
 * <p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.NormalData.html' target='_blank'>API docs</a>
 *  </p>
 * <h2></h2>
 * <dl>
 *    <dt></dt>
 *    <dd><dd>
 * </dl> 
 *
 * @namespace   JChart
 * @class       NormalData
 * @constructor
 * @static
 * @version dev 0.1 2014-08-28
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
<h2>显示 两条[曲线|柱状]的图表数据</h2>
<pre>{
    
    xAxis: {
        categories: [ '02/24', '02/25', '02/26', '02/27', '02/28', '02/29', '03/01' ]
    }
    , yAxis: {
        format: '{0}%'
        , maxvalue: 100
    }
    , series:[{
        name: '目标PV'
        , data: [ 70, 49, 76, 30, 55, 26, 78 ]
    }, {
        name: '目标UV',
        data: [ 48, 62, 50, 50, 30, 40, 35 ]
    }]
    , tooltip: {		
        enabled: true
        , "headerFormat": "{0}"			
        , "pointFormat": "{0} %"
        
    }
    , displayAllLabel: true
    , legend: {
        enabled: false
    }
    , dataLabels: {
        enabled: true
        , format: '{0}%'
    }
    , vline: {
        //enabled: false
    }
    , hline: {
        //enabled: true
    }
    , colors: [
        0x03ACEF
        , 0x5DC979
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
    , chart: {
        bgColor: 0xffffff
        , bgAlpha: 1
        //, graphicHeight: 220
    }
    , hoverBg: {
        enabled: true		
        , style: {
            borderColor: 0xB4B4B4
            , borderWidth: 2
            , bgColor: 0xF0F0F0
        }										
    }
}</pre>
 */

    JChart.NormalData = {
        /**
         * 横向坐标设置数据
         * @property    xAxis
         * @type        {object}
         */
        xAxis: {
            /**
             * 是否显示横向坐标( pending )
             * @property    xAxis.enabled
             * @type        {Boolean}
             * @default     true
             * @example 
             *  enabled: false
             */
            enabled: true
            /**
             * 横向坐标的显示数据
             * <br />这些数据默认也用于显示 tips 的主标题, 如果想重定义 tips 的主标题, 请设置 tooltip.header 属性
             * @property    xAxis.categories
             * @type        {Array of String}
             * @default     null
             * @example 
             *  categories: [ '02/24', '02/25', '02/26', '02/27', '02/28', '02/29', '03/01' ]
             */
            , categories: null
            /**
             * 横向坐标显示数据是否自动换行 
             * @property    xAxis.wordwrap
             * @type        {Boolean}
             * @default     true
             * @example 
             *  wordwrap: true
             */
            , wordwrap: true
            /**
             * 横向坐标显示数据格式化显示
             * @property    xAxis.format
             * @type        {String}
             * @default     '{0}'
             * @example 
             *  format: '{0}%'
             */
            , format: '{0}'
       }
        /**
         * 纵向坐标设置数据
         * @property    yAxis
         * @type        {object}
         */
        , yAxis: {
            /**
             * 是否显示纵向坐标
             * @property    yAxis.enabled
             * @type        {Boolean}
             * @default     true
             * @example 
             *  enabled: true
             */
            enabled: true
            /**
             * 纵向坐标显示数据格式化显示
             * @property    yAxis.format
             * @type        {String}
             * @default     '{0}'
             * @example 
             *  format: '{0}%'
             */
            , format: '{0}'
            /**
             * 自定义纵向坐标的最大值
             * <br /> 0 = auto
             * <br /> 显示百分比的时候, 应该设置为 100
             * @property    yAxis.maxvalue
             * @type        {Number}
             * @default     0
             * @example 
             *  maxvalue: 0
             */
            , maxvalue: 0
       }
        /**
         * 展现的数据
         * <br />series 每条数据里的 data 属性, 长度应该与 xAxis.categories 的长度相等
         * <br />显示数值如果为百分比的话, 需要设置 yAxis.maxvalue = 100
         * @property    series
         * @type        {Array}
         * @default     null
         * @example
         * 
<pre>series:[{
        name: '目标PV'
        , data: [ 70, 49, 76, 30, 55, 26, 78 ]
    }, {
        name: '目标UV',
        data: [ 48, 62, 50, 50, 30, 40, 35 ]
    }]</pre>
         */
        , series: null
        /**
         * tips 设置数据 
         * <br /> tips 的主标题默认为 xAxis.categories 对应索引的数据
         * <br /> 如果想重定义主标题, 请设置 tooltip.header 属性
         * @property    tooltip
         * @type        {object}
         */
        , tooltip: {
            /**
             * 是否显示 tips
             * @property    tooltip.enabled
             * @type        {Boolean}
             * @default     true
             * @example 
             *  enabled: true
             */
            enabled: true
            /**
             * tips 主标题的显示格式
             * @property    tooltip.headerFormat
             * @type        {String}
             * @default     '{0}'
             * @example 
             *  headerFormat: '{0}             right title'
             */
            , headerFormat: '{0}'
            /**
             * tips 坐数值的显示格式
             * @property    tooltip.pointFormat
             * @type        {String}
             * @default     '{0}'
             * @example 
             *  pointFormat: '{0}%'
             */
            , pointFormat: '{0}'
            /**
             * tips 主标题的显示数据
             * <br />如果不显式声明 tooltip.header, 默认数据为 xAxis.categories
             * @property    tooltip.header
             * @type        {Array of String}
             * @default     null
             * @example 
             *  header: [ '2014/02/24', '2014/02/25', '2014/02/26', '2014/02/27', '2014/02/28', '2014/02/29', '2014/03/01' ]
             */
            , header: null

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
