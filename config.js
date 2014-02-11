;(function(){
window.JChart = window.JChart || {log:function(){}};
JChart.PATH = JChart.PATH || scriptPath();
/**
 * requirejs config.js for JC Chart Project
 */
window.requirejs && 
requirejs.config( {
    baseUrl: JChart.PATH
    , urlArgs: 'v=20140212'
    , paths: {
        'JChart.common': 'modules/JChart.common/0.1/common'
        , 'JChart.BaseMVC': 'modules/JChart.BaseMVC/0.1/BaseMVC'

        , 'JChart.Line': 'modules/JChart.Line/0.1/Line'

        , 'exCanvas': 'modules/exCanvas/0.3.0/excanvas'
    }
});
/**
 * 取当前脚本标签的 src路径 
 * @static
 * @return  {string} 脚本所在目录的完整路径
 */
function scriptPath(){
    var _sc = document.getElementsByTagName('script'), _sc = _sc[ _sc.length - 1 ], _path = _sc.getAttribute('src');
    if( /\//.test( _path ) ){ _path = _path.split('/'); _path.pop(); _path = _path.join('/') + '/'; }
    else if( /\\/.test( _path ) ){ _path = _path.split('\\'); _path.pop(); _path = _path.join('\\') + '/'; }
    return _path;
}
}());
