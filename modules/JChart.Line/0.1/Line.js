;(function(define, _win) { 'use strict'; define( [ 'JChart.Base' ], function(){
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

    JC.BaseMVC.build( Line, JChart.Base );

    JC.f.extendObject( Line.prototype, {
        _beforeInit:
            function(){
                JC.log( 'Line _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
            }

        , _inited:
            function(){
                JC.log( 'Line _inited', new Date().getTime() );
            }
    });

    Line.Model._instanceName = 'JChartLine';
    var _oldWorkspaceOffset = Line.Model.prototype.workspaceOffset;

    JC.f.extendObject( Line.Model.prototype, {
        init:
            function(){
                JC.log( 'Line.Model.init:', new Date().getTime() );
            }

        , vlables:
            function( _new ){
                if( _new ){
                    var _p = this
                        , _maxNum = _p.maxNum( true )
                        , _rate = JChart.Base.Model.LABEL_RATE
                        , _data = []
                        ;
                    $.each( _rate, function( _ix, _item ){
                        _data.push( {
                            type: 'text'
                            , text: ( _maxNum * _item ).toString()
                        });
                    });

                    _p._vlabels = _p.root().add( _data );

                    _p._hasVLabels = true;
                }
                return this._vlabels;
            }

        , workspaceOffset:
            function( _new ){
                _oldWorkspaceOffset.call( this, _new );

                if( _new ){
                    this._workspaceOffset.height -= 30;
                }

                return this._workspaceOffset;
            }

        , chartWorkspaceOffset:
            function( _new ){

                if( _new ){
                    this._chartWorkspaceOffset = JC.f.cloneObject( this.workspaceOffset() );

                    if( this.vlables() && this.vlables().length ){
                        var _maxWidth = 0;
                        $.each( this.vlables(), function( _ix, _item ){
                            _item.getBBox().width > _maxWidth 
                                && ( _maxWidth = _item.getBBox().width );
                        });
                        _maxWidth > 0 && ( _maxWidth += 15 );
                        this._chartWorkspaceOffset.x += _maxWidth;
                        this._chartWorkspaceOffset.width -= _maxWidth;
                    }
                }

                return this._chartWorkspaceOffset;
            }

        , hlines:
            function( _new ){
                if( _new ){
                    var _p = this
                        , _data = []
                        ;

                    $.each( _p.vlables(), function( _x, _item ){
                        _data.push( {
                            'type': 'path'
                            , 'path': 'M0,0'
                        });
                    });

                    _p._hlines = _p.root().add( _data );

                }
                return this._hlines;
            }

        , vlines:
            function( _new ){
                if( _new && _p.data() && _p.data().xAxis ){
                    var _p = this
                        , _data = []
                        ;

                    $.each( _p.data.(), function( _x, _item ){
                        _data.push( {
                            'type': 'path'
                            , 'path': 'M0,0'
                        });
                    });

                    _p._hlines = _p.root().add( _data );

                }
                return this._hlines;
            }

    });

    JC.f.extendObject( Line.View.prototype, {
        _inited:
            function(){
            }

        , draw: 
            function( _data ){
                this.root();

                this.drawTitle( _data );
                this.drawSubTitle( _data );
                this.drawVTitle( _data );

                this.drawCredit( _data );
                this.drawLegendBox( _data );

                this.drawWorkspace( _data );

                this._model.maxNum( true );

                this.drawVLabels();

                this.drawChartWorkspace();

                this.drawChartHLines();
                this.drawChartVLines();
            }

        , drawChartVLines:
            function(){
                var _p = this
                    , _vlines = _p._model.vlines( true )
                    ;
            }

        , drawChartHLines:
            function(){
                var _p = this
                    , _hlines = _p._model.hlines( true )

                    , _vlabels = _p._model.vlables()
                    , _wkOffset = _p._model.chartWorkspaceOffset()
                    , _data = []
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    var _bbox = _item.getBBox()
                        , _y = _bbox.y + _bbox.height / 2
                        , _path = JC.f.printf( 'M{0},{1}L{2},{3}'
                            , _wkOffset.x, _y
                            , _wkOffset.x + _wkOffset.width, _y
                        )
                    _hlines[ _ix ].attr( 'stroke', '#9c9c9c' ).attr( 'path', _path );
                    if( ( _y - parseInt( _y ) ) === 0 ){
                        _hlines[ _ix ].translate( .5, .5 );
                    }
                });
            }

        , drawVLabels:
            function(){
                var _p = this
                    , _vlabels = _p._model.vlables( true )

                    , _maxNum = _p._model.maxNum( true )
                    , _rate = JChart.Base.Model.LABEL_RATE
                    , _len = _rate.length
                    , _data = []
                    , _workspaceOffset = _p._model.workspaceOffset()
                    , _partHeight = _workspaceOffset.height / ( _len - 1 )
                    , _maxItemWidth = 0
                    , _bbox 
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    _bbox = _item.getBBox();
                    _bbox.width > _maxItemWidth && ( _maxItemWidth = _bbox.width )
                    _item.attr( 'y', _workspaceOffset.y + _partHeight * _ix )
                });

                $.each( _vlabels, function( _ix, _item ){
                    _item.attr( 'x', _workspaceOffset.x - _item.getBBox().width / 2 + _maxItemWidth );
                });
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
