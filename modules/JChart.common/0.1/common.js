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

    !window.JCHART_CANVAS && ( window.JCHART_CANVAS = document.createElement( 'canvas' ) );

    window.Bizs = window.Bizs || {};
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
     * <p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
     * | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.common.html' target='_blank'>API docs</a>
     * | <a href='../../modules/JChart.common/0.1/_demo/' target='_blank'>demo link</a></p>
     * @class common
     * @namespace JChart
     * @static
     * @version dev 0.1 2014-02-11
     * @author  qiushaowei   <suches@btbtd.org> | 360 75 Team
     */
    JChart.f = JChart.common = {
        scriptPath: scriptPath
        , sliceArgs: sliceArgs
        , extendObject: extendObject
        , scriptContent: scriptContent
        , parentSelector: parentSelector
        , getJqParent: getJqParent
        , printf: printf
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
     * 按格式输出字符串
     * @method printf
     * @static
     * @param   {string}    _str
     * @return  string
     * @example
     *      printf( 'asdfasdf{0}sdfasdf{1}', '000', 1111 );
     *      //return asdfasdf000sdfasdf1111
     */
    function printf( _str ){
        for(var i = 1, _len = arguments.length; i < _len; i++){
            _str = _str.replace( new RegExp('\\{'+( i - 1 )+'\\}', 'g'), arguments[i] );
        }
        return _str;
    }
    /**
     * 获取 selector 的指定父级标签
     * @method  getJqParent
     * @param   {selector}  _selector
     * @param   {selector}  _filter
     * @return selector
     * @require jquery
     * @static
     */
    function getJqParent( _selector, _filter ){
        _selector = $(_selector);
        var _r;

        if( _filter ){
            while( (_selector = _selector.parent()).length ){
                if( _selector.is( _filter ) ){
                    _r = _selector;
                    break;
                }
            }
        }else{
            _r = _selector.parent();
        }

        return _r;
    }
    /**
     * 扩展 jquery 选择器
     * <br />扩展起始字符的 '/' 符号为 jquery 父节点选择器
     * <br />扩展起始字符的 '|' 符号为 jquery 子节点选择器
     * <br />扩展起始字符的 '(' 符号为 jquery 父节点查找识别符( getJqParent )
     * @method  parentSelector
     * @param   {selector}  _item
     * @param   {String}    _selector
     * @param   {selector}  _finder
     * @return  selector
     * @require jquery
     * @static
     */
    function parentSelector( _item, _selector, _finder ){
        _item && ( _item = $( _item ) );
        if( /\,/.test( _selector ) ){
            var _multiSelector = [], _tmp;
            _selector = _selector.split(',');
            $.each( _selector, function( _ix, _subSelector ){
                _subSelector = _subSelector.trim();
                _tmp = parentSelector( _item, _subSelector, _finder );
                _tmp && _tmp.length 
                    &&  ( 
                            ( _tmp.each( function(){ _multiSelector.push( $(this) ) } ) )
                        );
            });
            return $( _multiSelector );
        }
        var _pntChildRe = /^([\/]+)/, _childRe = /^([\|]+)/, _pntRe = /^([<\(]+)/;
        if( _pntChildRe.test( _selector ) ){
            _selector = _selector.replace( _pntChildRe, function( $0, $1 ){
                for( var i = 0, j = $1.length; i < j; i++ ){
                    _item = _item.parent();
                }
                _finder = _item;
                return '';
            });
            _selector = _selector.trim();
            return _selector ? _finder.find( _selector ) : _finder;
        }else if( _childRe.test( _selector ) ){
            _selector = _selector.replace( _childRe, function( $0, $1 ){
                for( var i = 1, j = $1.length; i < j; i++ ){
                    _item = _item.parent();
                }
                _finder = _item;
                return '';
            });
            _selector = _selector.trim();
            return _selector ? _finder.find( _selector ) : _finder;
        }else if( _pntRe.test( _selector ) ){
            _selector = _selector.replace( _pntRe, '' ).trim();
            if( _selector ){
                if( /[\s]/.test( _selector ) ){
                    var _r;
                    _selector.replace( /^([^\s]+)([\s\S]+)/, function( $0, $1, $2 ){
                        _r = getJqParent( _item, $1 ).find( $2.trim() );
                    });
                    return _r || _selector;
                }else{
                    return getJqParent( _item, _selector );
                }
            }else{
                return _item.parent();
            }
        }else{
            return _finder ? _finder.find( _selector ) : jQuery( _selector );
        }
    }
    /**
     * 获取脚本模板的内容
     * @method  scriptContent
     * @param   {selector}  _selector
     * @return  string
     * @static
     */
    function scriptContent( _selector ){
        var _r = '';
        _selector 
            && ( _selector = $( _selector ) ).length 
            && ( _r = _selector.html().trim().replace( /[\r\n]/g, '') )
            ;
        return _r;
    }
    /**
     * 扩展对象属性
     * @method  extendObject
     * @param   {object}    _source
     * @param   {object}    _new
     * @param   {bool}      _overwrite      是否覆盖已有属性, default = true  
     * @return  object
     * @static
     */
    function extendObject( _source, _new, _overwrite ){
        typeof _overwrite == 'undefined' && ( _overwrite = true );
        if( _source && _new ){
            for( var k in _new ){
                if( _overwrite ){
                    _source[ k ] = _new[ k ];
                }else if( !( k in _source ) ){
                    _source[ k ] = _new[ k ];
                }
            }
        }
        return _source;
    }
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
