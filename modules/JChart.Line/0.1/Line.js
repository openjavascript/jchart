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
            function( _data ){
                if( _data ){
                    var _p = this
                        , _maxNum = _p.maxNum( _data )
                        , _rate = _p.labelRate( _data )
                        , _eles = []
                        ;

                    $.each( _rate, function( _ix, _item ){
                        _eles.push( {
                            type: 'text'
                            , text: ( _maxNum * _item ).toString()
                        });
                    });

                    _p._vlabels = _p.root().add( _eles );

                    _p._hasVLabels = true;
                }
                return this._vlabels;
            }

        , workspaceOffset:
            function( _data ){
                _oldWorkspaceOffset.call( this, _data );

                if( _data ){
                    this._workspaceOffset.height -= 30;
                }

                return this._workspaceOffset;
            }

        , chartWorkspaceOffset:
            function( _data ){

                if( _data ){
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
            function( _data ){
                if( _data ){
                    var _p = this
                        , _eles = []
                        ;

                    $.each( _p.vlables(), function( _x, _item ){
                        _eles.push( {
                            'type': 'path'
                            , 'path': 'M0,0'
                        });
                    });

                    _p._hlines = _p.root().add( _eles );

                }
                return this._hlines;
            }

        , vlines:
            function( _data ){
                var _p = this, _eles;
                if( _data && _data.xAxis && _data.xAxis.categories ){
                    _eles = [];

                    $.each( _data.xAxis.categories, function( _x, _item ){
                        _eles.push( {
                            'type': 'path'
                            , 'path': 'M0,0'
                        });
                    });

                    _p._vlines = _p.root().add( _eles );

                }
                return this._vlines;
            }

        , dataLine:
            function( _data ){
                var _p = this, _eles;
                if( _data && _data.series ){
                    _eles = [];

                    $.each( _data.series, function( _x, _item ){
                        _eles.push( {
                            'type': 'path'
                            , 'path': 'M0,0'
                        });
                    });

                    _p._dataLine = _p.root().add( _eles );

                }

                return this._dataLine;
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

                this._model.maxNum( _data );

                this.drawVLabels( _data );

                this.drawChartWorkspace( _data );

                this.drawChartHLines( _data );
                this.drawChartVLines( _data );

                this.drawDataLine( _data );
            }

        , drawDataLine:
            function( _data ){
                if( !( _data && _data.series ) ) return;
                var _p = this
                    , _dataLine = _p._model.dataLine( _data )
                    , _labelRate = _p._model.labelRate()
                    , _rateInfo = _p._model.rateInfo( _data, _labelRate )
                    , _chartOffset = _p._model.chartWorkspaceOffset()
                    , _partWidth = _chartOffset.width / ( _p._model.vlines().length - 1 )
                    , _partHeight = _chartOffset.height / ( _labelRate.length - 1 )
                    ;

                JC.log( JC.f.printf( '_partWidth: {0}, _partHeight: {1}', _partWidth, _partHeight ) );

                $.each( _data.series, function( _ix, _items ){
                    var _pathPoints = [], _x, _y, _dataHeight, _dataY, _maxNum;
                    $.each( _items.data, function( _six, _num ){
                        if( _num < 0 ) return;

                        _pathPoints.push( _six === 0 ? 'M' : 'L' );
                        _x = _chartOffset.x + _partWidth * _six;
                        _y = 0;

                        if( JChart.Base.isNegative( _num ) ){
                        }else{
                            _dataY = _chartOffset.y;
                            _dataHeight = _partHeight * _rateInfo.zeroIndex;
                            _maxNum = _rateInfo.maxNum;

                            _y = _chartOffset.y + _dataHeight - _num / _maxNum * _dataHeight;

                            //JC.log( [ _dataY, _dataHeight ] );
                        }

                        _pathPoints.push( [ _x, _y ] );
                    });
                    JC.log( _pathPoints.join('') );
                    _dataLine[ _ix ].attr( 'path', _pathPoints.join('') );
                });
            }

        , drawDataLineNegative:
            function( _data ){
            }

        , drawDataLineNormal:
            function( _data ){
            }

        , drawChartVLines:
            function( _data ){
                var _p = this
                    , _vlines = _p._model.vlines( _data )
                    , _wkOffset = _p._model.chartWorkspaceOffset()
                    , _len, _partWidth, _x, _y, _h
                    ;

                if( _vlines && _vlines.length ){
                    _len = _vlines.length - 1;
                    _partWidth = _wkOffset.width / _len;

                    $.each( _vlines, function( _ix, _item ){
                        _x = Math.floor( _wkOffset.x + _partWidth * _ix );
                        _y = Math.floor( _wkOffset.y );
                        _h = _wkOffset.height;

                        _item.attr( 'path', JC.f.printf( 
                            'M{0},{1}L{2},{3}'
                            , _x, _y
                            , _x, _y + _h
                        )).data( 'x', _x ).data( 'y', _y )
                        ;

                        !JChart.Base.isFloat( _x ) && _item.translate( .5, .5 );
                    });
                }
            }

        , drawChartHLines:
            function( _data ){
                var _p = this
                    , _hlines = _p._model.hlines( _data )

                    , _vlabels = _p._model.vlables()
                    , _wkOffset = _p._model.chartWorkspaceOffset()
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    var _bbox = _item.getBBox()
                        , _y = _bbox.y + _bbox.height / 2
                        , _path = JC.f.printf( 'M{0},{1}L{2},{3}'
                            , _wkOffset.x, _y
                            , _wkOffset.x + _wkOffset.width, _y
                        )
                    _hlines[ _ix ].attr( 'stroke', '#9c9c9c' )
                        .attr( 'path', _path )
                        .data( 'x', _wkOffset.x )
                        .data( 'y', _y )
                        ;

                    !JChart.Base.isFloat( _y ) && _hlines[ _ix ].translate( .5, .5 );
                });
            }

        , drawVLabels:
            function( _data ){
                var _p = this
                    , _vlabels = _p._model.vlables( _data )

                    , _maxNum = _p._model.maxNum( _data )
                    , _rate = JChart.Base.Model.LABEL_RATE
                    , _len = _rate.length
                    , _workspaceOffset = _p._model.workspaceOffset()
                    , _partHeight = _workspaceOffset.height / ( _len - 1 )
                    , _maxItemWidth = 0
                    , _bbox 
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    _bbox = _item.getBBox();
                    _bbox.width > _maxItemWidth && ( _maxItemWidth = _bbox.width )
                    _item.attr( 'y', _workspaceOffset.y + _partHeight * _ix );
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
