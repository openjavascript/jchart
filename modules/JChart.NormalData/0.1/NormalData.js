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
            /**
             * 纵向坐标的切分粒度
             * @property    yAxis.rate
             * @type        {Array of Number}
             * @default     auto
             * @example 
             *  rate: [ 1, .8, .6, .4, .2, .0 ]
             */
            , rate: null
       }
        /**
         * 展现的数据
         * <br />series 每条数据里的 data 属性, 长度应该与 xAxis.categories 的长度相等
         * <br />显示数值如果为百分比的话, 需要设置 yAxis.maxvalue = 100
         * @property    series
         * @type        {Array of Object}
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
            /**
             * tips 的扩展字段( 在行首显示扩展的字段 )
             * <br />series 每条数据里的 data 属性, 长度应该与 xAxis.categories 的长度相等
             * @property    tooltip.series
             * @type        {Array of Object}
             * @default     null
             * @example
             * 
<pre>"serial": [
    {
        "name": "总体"
        , "data": [ 
            1000, 2000, 3000, 4000, 5000, 6000
            , 1000, 2000, 3000, 4000, 5000, 6000 
            , 1000, 2000, 3000, 4000, 5000, 6000 
            , 7000
        ]
    }
]</pre>     */
            , series: null
            /**
             * tips 的扩展字段( 在行底显示扩展的字段 )
             * <br />series 每条数据里的 data 属性, 长度应该与 xAxis.categories 的长度相等
             * @property    tooltip.afterSeries
             * @type        {Array of Object}
             * @default     null
             * @example
             * 
<pre>"afterSerial": [
    {
        "name": "区分度"
        , "data": [ 
            1.04, 1.05, 1.06, 1.07, 1.08, 1.09
            , 2.01, 2.02, 2.03, 2.04, 2.05, 2.06
            , 3.09, 3.08, 3.07, 3.06, 3.05, 3.04
            , 4.11
        ]
    }
]</pre>
             */
            , afterSeries: null
        }
        /**
         * 是否显示所有横向 label
         * <br />如果非真, 而且长度大于4, 将按横向坐标的长度切分为4个显示坐标
         * @property    displayAllLabel
         * @type        {Boolean}
         * @default     true
         */
        , displayAllLabel: true
        /**
         * 数据点 label 的设置数据
         * @property    dataLabels
         * @type        {object}
         */
        , dataLabels: {
            /**
             * 每个数据点是否显示数值文本
             * @property    dataLabels.enabled
             * @type        {Boolean}
             * @default     false
             * @example 
             *  enabled: false
             */
            enabled: false
            /**
             * 格式化显示数值文本
             * @property    dataLabels.format
             * @type        {String}
             * @default     '{0}'
             * @example 
             *  format: '{0}%'
             */
            , format: '{0}'
        }
        /**
         * 纵向背景线的设置数据
         * @property    vline
         * @type        {object}
         */
        , vline: {
            /**
             * 是否显示纵向背景线
             * @property    vline.enabled
             * @type        {Boolean}
             * @default     true
             * @example 
             *  enabled: true
             */
            enabled: true
        }
        /**
         * 横向背景线的设置数据
         * @property    hline
         * @type        {object}
         */
        , hline: {
            /**
             * 是否显示横向背景线
             * @property    hline.enabled
             * @type        {Boolean}
             * @default     true
             * @example 
             *  enabled: true
             */
            enabled: true
        }
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
             * 图表数据显示块的高度
             * <br />有时需要把多个数据图表显示一样的视觉高度, 但是其他图表的 水平label高度不一样, 就会导致视觉上的不同
             * <br />这个属性就是为了解决这个问题, 把图表数据显示块设置为统一的高度
             * @property    chart.graphicHeight
             * @type        {Number}     
             * @default     0,     0 = auto
             */
            , graphicHeight: 0
        }
        /**
         * 数据项的背景设置
         * <br /> 目前这个属性仅对 柱状图 生效
         * @property    itemBg
         * @type        {object}
         */
        , itemBg: {
            /**
             * 数据项是否显示背景色
             * @property    itemBg.enabled
             * @type        {Boolean}
             * @default     false
             * @example 
             *  enabled: false
             */
            enabled: false
            /**
             * 数据项背景色的样式定义
             * @property    itemBg.style
             * @type        {object}
             * @default     { borderColor: 0xB4B4B4, bgColor: 0xF0F0F0, borderWidth: 0 }
             */
            , style: { borderColor: 0xEDF1F3, bgColor: 0xEDF1F3, borderWidth: 0 }
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
