;(function(define, _win) { 'use strict'; define( [ 'JC.common' ], function(){
    /**
     * 声明主要命名空间, 方便迁移
     */
    window.JChart = window.JChart || {};
    JChart.PATH = JChart.PATH || JC.PATH;
    /**
     * JChart.f 是 JChart.common 的别名
     * <br />具体使用请见 <a href='JChart.common.html'>JChart.common</a></p>
     * @class JChart.f
     * @static
     */
    /**
     * JChart 组件通用静态方法和属性 ( JChart.common, <b>别名: JChart.f</b> )
     * <br />所有 JC 组件都会依赖这个静态类
     * <p><b>require</b>: <a href='window.jQuery.html'>jQuery</a></p>
     * <p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
     * | <a href='http://JChart.openjavascript.org/docs_api/classes/JChart.common.html' target='_blank'>API docs</a>
     * | <a href='../../modules/JChart.common/0.1/_demo/' target='_blank'>demo link</a></p>
     * @class JChart.common
     * @static
     * @version 2014-07-02
     * @author  qiushaowei   <suches@btbtd.org> | 360 75 Team
     */
    JChart.common = JChart.f = {
        "isArray": isArray
        , 'getBBox': getBBox
    };
    /**
     * 判断参数是否为数组
     * @method  isArray
     * @param   {Object}    obj
     * @return  {bool}
     * @static
     */
    function isArray(obj){  
        return Object.prototype.toString.call(obj) === '[object Array]' ;  
    }  

    function getBBox( _item ){
        var _r;
        if( _item.node && _item.node.getBBox ){
            _r = _item.node.getBBox();
            _r.x2 = _r.x + _r.width;
            _r.y2 = _r.y + _r.height;
        }else if( _item.getBBox ){
            _r = _item.getBBox();
        }
        return _r;
    };

    return JChart.common;

});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
