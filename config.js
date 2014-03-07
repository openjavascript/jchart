;(function(){
window.JC = window.JC|| {log:function(){}};
JC.PATH = JC.PATH || scriptPath();
/**
 * requirejs config.js for JC Chart Project
 */
window.requirejs && 
requirejs.config( {
    baseUrl: JC.PATH
    , urlArgs: 'v=20140212'
    , paths: {
        'JC.common': 'modules/JC.common/0.2/common'
        , 'JC.BaseMVC': 'modules/JC.BaseMVC/0.1/BaseMVC'

        , 'JChart.common': 'modules/JChart.common/0.1/common'
        , 'JChart.Base': 'modules/JChart.Base/0.1/Base'
        , 'JChart.Stage': 'modules/JChart.Stage/0.1/Stage'

        , 'JChart.Line': 'modules/JChart.Line/0.1/Line'

        , 'Raphael': 'modules/Raphael/2.1.2/Raphael'
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
