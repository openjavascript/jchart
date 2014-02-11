;(function(define, _win) { 'use strict'; define( [], function(){
    /**
     * 如果 console 不可用, 生成一个模拟的 console 对象
     */
    !window.console && ( window.console = { 
        log: function(){ window.status = sliceArgs( arguments ).join(' '); }
         , dir: function(){} 
    });
    /**
     * 声明主要命名空间, 方便迁移
     */
    window.JChart = window.JChart || {};
    JChart.log = function(){ JChart.debug && console.log( sliceArgs( arguments ).join(' ') ); };
    JChart.dir = function( _obj ){ JChart.debug && console.dir( _obj ); };

    JChart.PATH = JChart.PATH || scriptPath();
   /**
     * JChart.f 是 JChart.common 的别名
     * <br />具体使用请见 <a href='JChart.common.html'>JChart.common</a></p>
     * @class f
     * @namespace JChart
     * @static
     */
    /**
     * JChart 组件通用静态方法和属性( JChart.common, <b>别名: JChart.f</b> )
     * <br />所有 JChart 组件都会依赖这个静态类
     * <p><b>require</b>: <a href='window.jQuery.html'>jQuery</a></p>
     * <p><a href='https://github.com/openjavascript/JChart' target='_blank'>JChart Project Site</a>
     * | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.common.html' target='_blank'>API docs</a>
     * | <a href='../../modules/JChart.common/0.1/_demo/' target='_blank'>demo link</a></p>
     * @class common
     * @namespace JChart
     * @static
     * @version dev 0.1 2014-02-11
     * @author  qiushaowei   <suches@btbtd.org> | 360 75 Team
     */
    JChart.common = {
        , "scriptPath": scriptPath
        , "sliceArgs": sliceArgs
    };
    /**
     * jquery 1.9.1 默认 string 没有 trim 方法, 这里对 string 原型添加一个默认的 trim 方法
     */
    !String.prototype.trim && ( String.prototype.trim = function(){ return $.trim( this ); } );
    /**
     * 全局 css z-index 控制属性
     * <br /> <b>注意</b>: 这个变量是 window.ZINDEX_COUNT
     * @property    ZINDEX_COUNT
     * @type        int
     * @default     50001
     * @static
     */
    window.ZINDEX_COUNT = window.ZINDEX_COUNT || 50001;
    /**
     * 把函数的参数转为数组
     * @method  sliceArgs
     * @param   {arguments}     args
     * @return Array
     * @static
     */
    function sliceArgs( _arg ){
        var _r = [], _i, _len;
        for( _i = 0, _len = _arg.length; _i < _len; _i++){
            _r.push( _arg[_i] );
        }
        return _r;
    }
    /**
     * 取当前脚本标签的 src路径 
     * @method  scriptPath
     * @static
     * @return  {string} 脚本所在目录的完整路径
     */
    function scriptPath(){
        var _sc = document.getElementsByTagName('script'), _sc = _sc[ _sc.length - 1 ], _path = _sc.getAttribute('src');
        if( /\//.test( _path ) ){ _path = _path.split('/'); _path.pop(); _path = _path.join('/') + '/'; }
        else if( /\\/.test( _path ) ){ _path = _path.split('\\'); _path.pop(); _path = _path.join('\\') + '/'; }
        return _path;
    }

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
