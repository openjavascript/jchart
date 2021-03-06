;(function(){
window.JC = window.JC|| {log:function(){}};
JC.PATH = JC.PATH || scriptPath();
/**
 * requirejs config.js for JC Chart Project
 */
window.requirejs && 
requirejs.config( {
    baseUrl: JC.PATH
    , urlArgs: 'v=20141017'
    , paths: {
        'JC.common': 'modules/JC.common/0.2/common'
        , 'JC.BaseMVC': 'modules/JC.BaseMVC/0.1/BaseMVC'
        , 'JC.PureMVC': 'modules/JC.PureMVC/0.1/PureMVC'

        , 'JChart.common': 'modules/JChart.common/0.1/common'
        , 'JChart.Base': 'modules/JChart.Base/0.1/Base'

        , 'JChart.CurveGram': 'modules/JChart.CurveGram/0.1/CurveGram'
        , 'JChart.Histogram': 'modules/JChart.Histogram/0.1/Histogram'
        , 'JChart.HistogramLateral': 'modules/JChart.HistogramLateral/0.1/HistogramLateral'
        , 'JChart.PieGraph': 'modules/JChart.PieGraph/0.1/PieGraph'
        , 'JChart.TubularFigure': 'modules/JChart.TubularFigure/0.1/TubularFigure'

        , 'JChart.DefaultOptions': 'modules/JChart.DefaultOptions/0.1/DefaultOptions'
        , 'JChart.Extend': 'modules/JChart.Extend/0.1/Extend'
        , 'JChart.Geometry': 'modules/JChart.Geometry/0.1/Geometry'
        , 'JChart.Group': 'modules/JChart.Group/0.1/Group'

        , 'JChart.GraphicBase': 'modules/JChart.GraphicBase//0.1/GraphicBase'
        , 'JChart.GraphicPoint': 'modules/JChart.GraphicPoint/0.1/GraphicPoint'
        , 'JChart.GraphicRect': 'modules/JChart.GraphicRect/0.1/GraphicRect'
        , 'JChart.GraphicPiePart': 'modules/JChart.GraphicPiePart/0.1/GraphicPiePart'
        , 'JChart.GraphicSector': 'modules/JChart.GraphicSector/0.1/GraphicSector'

        , 'JChart.IconVLine': 'modules/JChart.IconVLine/0.1/IconVLine'
        , 'JChart.IconLine': 'modules/JChart.IconLine/0.1/IconLine'
        , 'JChart.IconRect': 'modules/JChart.IconRect/0.1/IconRect'
        , 'JChart.IconCircle': 'modules/JChart.IconCircle/0.1/IconCircle'

        , 'JChart.Legend': 'modules/JChart.Legend/0.1/Legend'
        , 'JChart.PieLabel': 'modules/JChart.PieLabel/0.1/PieLabel'
        , 'JChart.Test': 'modules/JChart.Test/0.1/Test'
        , 'JChart.Tips': 'modules/JChart.Tips/0.1/Tips'

        , 'Raphael': 'modules/Raphael/latest/raphael'
        , 'json2': 'modules/JSON/2/JSON'
        , 'swfobject': 'modules/swfobject/2.3/swfobject'
        , 'SWFObject': 'modules/swfobject/2.3/swfobject'
        , 'browser': 'modules/browser/0.7.1/bowser'
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
