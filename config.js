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
        , 'JC.PureMVC': 'modules/JC.PureMVC/0.1/PureMVC'

        , 'JChart.Base': 'modules/JChart.Base/0.1/Base'

        , 'JChart.CurveGram': 'modules/JChart.CurveGram/0.1/CurveGram'
        , 'JChart.Histogram': 'modules/JChart.Histogram/0.1/Histogram'

        , 'JChart.DefaultOptions': 'modules/JChart.DefaultOptions/0.1/DefaultOptions'
        , 'JChart.Event': 'modules/JChart.Event/0.1/Event'
        , 'JChart.Graphics': 'modules/JChart.Graphics/0.1/Graphics'
        , 'JChart.Geometry': 'modules/JChart.Geometry/0.1/Geometry'
        , 'JChart.Group': 'modules/JChart.Group/0.1/Group'

        , 'JChart.IconPoint': 'modules/JChart.IconPoint/0.1/IconPoint'
        , 'JChart.IconVLine': 'modules/JChart.IconVLine/0.1/IconVLine'
        , 'JChart.IconLine': 'modules/JChart.IconLine/0.1/IconLine'

        , 'Raphael': 'modules/Raphael/2.1.2/Raphael'
        , 'json2': 'modules/JSON/2/JSON'
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
