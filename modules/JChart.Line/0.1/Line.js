;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.IconPoint', 'JChart.IconVLine' ], function(){
/**
 * 组件用途简述
 *
 *<p><b>require</b>:
 *   <a href='JChart.Base.html'>JChart.Base</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Line.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.Line/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 span class="jchartLine"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       Line
 * @extends     JChart.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-02-12
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JChart.Line 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Line = Line;

    function Line( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, Line ) ) 
            return JC.BaseMVC.getInstance( _selector, Line );

        JC.BaseMVC.getInstance( _selector, Line, this );

        this._model = new Line.Model( _selector );
        this._view = new Line.View( this._model );

        this._init();

        JC.log( Line.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 Line 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of LineInstance}
     */
    Line.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jchartLine' )  ){
                    _r.push( new Line( _selector ) );
                }else{
                    _selector.find( 'div.jchartLine' ).each( function(){
                        _r.push( new Line( this ) );
                    });
                }
            }
            return _r;
        };

    Line.CURRENT_INS = null;
    Line.DEFAULT_MOVE =
        function( _evt ){
            if( !Line.CURRENT_INS ){
                _jdoc.off( 'mousemove', Line.DEFAULT_MOVE );
                return;
            }
            var _p = Line.CURRENT_INS;
            //JC.log( 'Line.DEFAULT_MOVE', _evt.pageX, _evt.pageY, JC.f.ts(), _selector.length, _src.nodeName );
            _p.trigger( 'update_moving_status', [ _evt ] );
        };

    JC.BaseMVC.build( Line, JChart.Base );

    JC.f.extendObject( Line.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Line _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( 'update_moving_status', function( _evt, _srcEvt, _srcEle ){
                    //JC.log( 'update_tips', JC.f.ts() );
                    var _index = _p._model.indexAt( _srcEvt );
                    if( typeof _index == 'undefined' ) return;
                    _p._view.updateStatus( _index );
                });

                _p.on( 'moving_start', function( _evt ){
                    //JC.log( 'show', JC.f.ts(), _p._model.tips() );
                    _p._view.clearStatus();
                    _p._model.tips() && _p._model.tips().show();
                });

                _p.on( 'moving_done', function( _evt ){
                    //JC.log( 'hide', JC.f.ts(), _p._model.tips() );
                    _p._view.clearStatus();
                });
            }

        , _inited:
            function(){
                //JC.log( 'Line _inited', new Date().getTime() );
            }
    });

    Line.Model._instanceName = 'JChartLine';

    Line.Model.DATA_LINE_STYLE = {
        common: {
            'stroke-width': 2
        }
        , data: [
            { 'stroke': '#ff0619' }
            , { 'stroke': '#09c100' }
            , { 'stroke': '#ff7100' }

            , { 'stroke': '#FFBF00' }
            , { 'stroke': '#ff06b3' }
            , { 'stroke': '#c3e2a4' }

            , { 'stroke': '#0c76c4' }
            , { 'stroke': '#41e2e6' }
            , { 'stroke': '#ffb2bc' }

            , { 'stroke': '#dbb8fd' }
        ]
        , pointCommon: {
            radius: 4
            , 'iconType': 'circle'
        }
    };

    var _oldWorkspaceOffset = Line.Model.prototype.workspaceOffset;

    JC.f.extendObject( Line.Model.prototype, {
        init:
            function(){
                //JC.log( 'Line.Model.init:', new Date().getTime() );
            }

        , calcCoordinate:
            function( _data ){
                var _p = this
                    , _c = {}
                    , _bbox
                    , _x = 0, _maxX = _p.width() - 5
                    , _y = 0, _maxY = _p.height() - 5
                    ;

                _p.root();

                _c.stage = { x: 0, y: 0, width: _p.width(), height: _p.height(), corner: _p.stageCorner()  };
                _p.background( _c );
                _x = 2, _y = 2;

                var _title = _p.title( _data );
                if( _title ){
                    _bbox = _title.getBBox();
                    _c.title = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                    }
                    _y = _c.title.y + _bbox.height / 2;
                }

                var _subtitle = _p.subtitle( _data );
                if( _subtitle ){
                    _bbox = _subtitle.getBBox();
                    _c.subtitle = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                    }
                    _y = _c.subtitle.y + _bbox.height / 2;
                }

                var _vtitle = _p.vtitle( _data );
                if( _vtitle ){
                    _bbox = _vtitle.getBBox();
                    _c.vtitle = {
                        x: _x + _bbox.height / 2 + 5
                        , y: _p.height() / 2
                        , rotate: -90
                    }
                    _x = _c.vtitle.x;
                }

                var _credits = _p.credits( _data );
                if( _credits ){
                    _bbox = _credits.getBBox();
                    _c.credits = {
                        x: _maxX - _bbox.width / 2
                        , y: _maxY - _bbox.height / 2
                    }
                    _maxY = _c.credits.y;
                }

                var _legend = _p.legend( _data, 'line', function( _ix, _legend, _text, _data ){
                    var _color = _data.stroke 
                                    || Line.Model.DATA_LINE_STYLE.data[ _ix % Line.Model.DATA_LINE_STYLE.data.length ].stroke 
                                    || '#fff';
                    _legend.attr( 'fill', _color ).attr( 'stroke', _color );;
                } );
                if( _legend ){
                    _bbox = _legend.getBBox();
                    _c.legend = {
                        x: ( _maxX - _bbox.width ) / 2
                        , y: _maxY - _bbox.height - _bbox.height / 2
                    }
                    _maxY = _c.legend.y;
                }

                return this.coordinate( _c );
            }
    });

    JC.f.extendObject( Line.View.prototype, {
        _inited:
            function(){
            }

        , testCoordinate:
            function( _coordinate ){
                var _p = this, _c = _coordinate;
                if( _c.title ){
                    _p._model.title().attr( _c.title );
                }
                if( _c.subtitle ){
                    _p._model.subtitle().attr( _c.subtitle );
                }
                if( _c.vtitle ){
                    _p._model.vtitle().attr( _c.vtitle );
                    _c.vtitle.rotate && _p._model.vtitle().rotate( _c.vtitle.rotate );
                }
                if( _c.credits ){
                    _p._model.credits().attr( _c.credits );
                }
                return;
                if( _c.legend ){
                    _p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                }
            }

        , draw: 
            function( _data ){
                var _p = this, _coordinate;

                _coordinate = _p._model.calcCoordinate( _data );
                _p.testCoordinate( _coordinate );

                JC.dir( _coordinate );

                return;
                _p.drawLegendBox( _data, 'line');

                _p.drawWorkspace( _data );

                _p._model.maxNum( _data );

                _p.drawHLabels( _data );

                _p.drawChartWorkspace( _data );

                _p.drawChartHLines( _data );
                _p.drawChartVLines( _data );

                _p.drawDataLine( _data );
                _p.drawDataPoint( _data, _p._model.dataPoint() );

                _p.drawVLabels( _data, _p._model.vlinePoint() );

                /*
                _p._model.chartWorkspace().mouseover( function( _evt ){
                    JC.log( 'mouseover', new Date().getTime() );
                    JC.dir( _evt );
                });

                _p._model.chartWorkspace().mouseout( function( _evt ){
                    //JC.log( 'mouseout', new Date().getTime() );
                });
                */

                _p._model.chartWorkspace().mouseenter( function( _evt ){
                    Line.CURRENT_INS = _p;
                    _jdoc.on( 'mousemove', Line.DEFAULT_MOVE );
                    _p.trigger( 'moving_start' );
                });

                _p._model.chartWorkspace().mouseleave( function( _evt ){
                    Line.CURRENT_INS = null;
                    _jdoc.off( 'mousemove', Line.DEFAULT_MOVE );
                    _p.trigger( 'moving_done' );
                });

                //JC.log( 'xxxxxxxxxxx', _p._model.chartWorkspace().attr( 'x' ), _p._model.chartWorkspace().attr('width') );

                //this._model.root().legendLine( 100, 200, 18, 1, 9 );
            }
        
    });

    _jdoc.ready( function(){
        Line.autoInit && Line.init();
    });

    return Line;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
