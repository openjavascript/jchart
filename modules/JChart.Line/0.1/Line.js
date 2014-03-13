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
            size: 4
            , 'iconType': 'circle'
        }
    };

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
                    this._workspaceOffset.height -= 18;
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
                        _maxWidth > 0 && ( _maxWidth += 10 );
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

        , dataPoint:
            function( _setter ){
                _setter && ( this._dataPoint = _setter );
                return this._dataPoint;
            }

        , vlinePoint:
            function( _setter ){
                _setter && ( this._vlinePoint = _setter );
                return this._vlinePoint;
            }

        , hlinePoint:
            function( _setter ){
                _setter && ( this._hlinePoint = _setter );
                return this._hlinePoint;
            }

        , dataLineStyle:
            function( _ix, _data ){
                var _r = { line: {}, point: {} }
                    , _itemStyle = Line.Model.DATA_LINE_STYLE.data[ _ix ]
                    ;

                JC.f.extendObject( _r.line, Line.Model.DATA_LINE_STYLE.common );
                JC.f.extendObject( _r.point, Line.Model.DATA_LINE_STYLE.pointCommon );

                _itemStyle && JC.f.extendObject( _r.line, _itemStyle );
                _itemStyle && (
                    _r.point.stroke = _itemStyle.stroke
                    , _r.point.fill = _itemStyle.stroke
                );

                if( _data && _data.series && _data.series[ _ix] && _data.series[ _ix ].style ){
                    JC.f.extendObject( _r.line, _data.series[ _ix ].style );
                }

                if( _data && _data.series && _data.series[ _ix] && _data.series[ _ix ].pointStyle ){
                    JC.f.extendObject( _r.point, _data.series[ _ix ].pointStyle );
                }

                return _r;
            }

    });

    JC.f.extendObject( Line.View.prototype, {
        _inited:
            function(){
            }

        , draw: 
            function( _data ){
                var _p = this;

                this.root();

                this.drawTitle( _data );
                this.drawSubTitle( _data );
                this.drawVTitle( _data );

                this.drawCredit( _data );
                this.drawLegendBox( _data );

                this.drawWorkspace( _data );

                this._model.maxNum( _data );

                this.drawHLabels( _data );

                this.drawChartWorkspace( _data );

                this.drawChartHLines( _data );
                this.drawChartVLines( _data );

                this.drawDataLine( _data );
                this.drawDataPoint( _data, _p._model.dataPoint() );

                this.drawVLabels( _data, _p._model.vlinePoint() );

                //this._model.root().triangle( 100, 10, 10 );
            }
        
        , drawVLabels:
            function( _data, _hlinePoint ){
                var _p = this, _len = _hlinePoint.length, _isAll = _len < 8, _match = {}, _tmp;
                _data.displayAllLabel && ( _isAll = true );

                if( !_isAll ){
                    _match[ 0 ] = true;
                    _match[ _hlinePoint.length - 1 ] = true;

                    _tmp = Math.ceil( _len / 3 );

                    _match[ Math.floor( _tmp * 1 ) - 1 ] = true;
                    _match[ Math.floor( _tmp * 2 ) - 1 ] = true;
                }

                $.each( _hlinePoint, function( _ix, _item ){
                    if( !_isAll && !( _ix in _match ) ) return;

                    var _point = _hlinePoint[ _ix ] 
                        , _path = JC.f.printf( 'M{0},{1}L{2},{3}', 
                        Math.round( _point.end.x ), Math.floor( _point.end.y  )
                        , Math.round( _point.end.x ), Math.floor( _point.end.y  ) + 6
                    );
                    _p.root().path( _path ).translate( .5, .5 ).attr( 'stroke', '#9c9c9c' );

                    var _x = _point.end.x
                        , _y = _point.end.y + 6 + 8
                        ;

                    var _text = _p.root().text( _x, _y, _data.xAxis.categories[ _ix ] );
                });
            }

        , drawDataPoint:
            function( _data, _dataPoint ){
                var _p = this;
                $.each( _dataPoint, function( _ix, _path ){
                    var _lineStyle = _p._model.dataLineStyle( _ix, _data )
                        ;
                    $.each( _path, function( _six, _point ){
                        var _item;

                        switch( _lineStyle.iconType ){
                            default: 
                                {
                                    _item = _p.root().circle( _point.x, _point.y, _lineStyle.point.size );
                                    _p.implmentStyle( _item, _lineStyle.point );
                                    break;
                                }
                        }
                    });
                });
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

                var _dataPoint = [];
                $.each( _data.series, function( _ix, _items ){
                    var _pathPoints = [], _purePoint = [], _x, _y, _dataHeight, _dataY, _maxNum;
                    $.each( _items.data, function( _six, _num ){
                        //if( _num < 0 ) return;

                        _pathPoints.push( _six === 0 ? 'M' : 'L' );
                        _x = _chartOffset.x + _partWidth * _six;
                        _y = 0;

                        if( JChart.Base.isNegative( _num ) ){
                            _dataHeight = _partHeight * ( _rateInfo.length - _rateInfo.zeroIndex );
                            _dataY = _chartOffset.y + _partHeight * _rateInfo.zeroIndex;
                            _maxNum = Math.abs( _rateInfo.finalMaxNum );

                            _y = _dataY + Math.abs( _num ) / _maxNum * _dataHeight;
                        }else{
                            _dataHeight = _partHeight * _rateInfo.zeroIndex;
                            _dataY = _chartOffset.y;
                            _maxNum = _rateInfo.finalMaxNum;
                            _y = _dataY + _dataHeight - _num / _maxNum * _dataHeight;
                            //JC.log( [ _dataY, _dataHeight ] );
                        }

                        _pathPoints.push( [ _x, _y ] );
                        _purePoint.push( { 'x': _x, 'y': _y } );
                    });
                    _dataPoint.push( _purePoint );
                    _p.setDataLineStyle( _ix, _data );
                    _dataLine[ _ix ] = _dataLine[ _ix ].attr( 'path', _pathPoints.join('') );
                    JC.log( _pathPoints.join('') );
                });
                _p._model.dataPoint( _dataPoint );
            }

        , setDataLineStyle:
            function( _ix, _data ){
                var _p = this
                    , _dataLine = _p._model.dataLine()
                    , _item = _dataLine[ _ix ]
                    , _style = _p._model.dataLineStyle( _ix, _data )
                    ;

                for( var _k in _style.line ){
                    _item.attr( _k, _style.line[ _k ] );
                }
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
                    var _vlinePoint = [];

                    $.each( _vlines, function( _ix, _item ){
                        var _linePoint = {};
                        _linePoint.start = { x: Math.floor( _wkOffset.x + _partWidth * _ix ), y: Math.floor( _wkOffset.y ) };
                        _linePoint.end = { x: Math.floor( _wkOffset.x + _partWidth * _ix )
                            , y: Math.floor( _wkOffset.y )  + _wkOffset.height };

                        _item.attr( 'path', JC.f.printf( 
                            'M{0},{1}L{2},{3}'
                            , _linePoint.start.x, _linePoint.start.y
                            , _linePoint.end.x, _linePoint.end.y
                        )).data( 'x', _linePoint.start.x ).data( 'y', _linePoint.start.y )
                        .attr( 'stroke', '#9c9c9c' )
                        //.attr( 'opacity', .1 )
                        ;

                        !JChart.Base.isFloat( _linePoint.start.x ) && _item.translate( .5, .5 );
                        _vlinePoint.push( _linePoint );
                    });
                    _p._model.vlinePoint( _vlinePoint );
                }
            }

        , drawChartHLines:
            function( _data ){
                var _p = this
                    , _hlines = _p._model.hlines( _data )

                    , _vlabels = _p._model.vlables()
                    , _len = _vlabels.length
                    , _wkOffset = _p._model.chartWorkspaceOffset()
                    , _partHeight = _wkOffset.height / ( _len - 1 )
                    , _hlinePoint = []
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    var _bbox = _item.getBBox(), _path, _linePoint = {};

                    _linePoint.start = { x: _wkOffset.x, y: Math.floor( _wkOffset.y + _partHeight * _ix ) };
                    _linePoint.end = { x: _wkOffset.x + _wkOffset.width,  y: _linePoint.start.y };
                    _path = JC.f.printf( 'M{0},{1}L{2},{3}'
                        , _linePoint.start.x, _linePoint.start.y
                        , _linePoint.end.x, _linePoint.end.y
                    );
                    _hlines[ _ix ].attr( 'stroke', '#9c9c9c' )
                        .attr( 'path', _path )
                        .data( 'x', _linePoint.start.x )
                        .data( 'y', _linePoint.start.y )
                        ;

                    !JChart.Base.isFloat( _linePoint.start.y ) && _hlines[ _ix ].translate( .5, .5 );
                    _hlinePoint.push( _linePoint );
                });

                _p._model.hlinePoint( _hlinePoint );
            }

        , drawHLabels:
            function( _data ){
                var _p = this
                    , _vlabels = _p._model.vlables( _data )

                    , _maxNum = _p._model.maxNum( _data )
                    , _rate = JChart.Base.Model.LABEL_RATE
                    , _len = _rate.length
                    , _workspaceOffset = _p._model.workspaceOffset()
                    , _partHeight = _workspaceOffset.height / ( _len - 1 )
                    , _maxItemWidth = 0
                    , _bbox, _y 
                    , _chartWorkspaceOffset = _p._model.chartWorkspaceOffset( _data )
                    ;

                $.each( _vlabels, function( _ix, _item ){
                    _bbox = _item.getBBox();
                    _bbox.width > _maxItemWidth && ( _maxItemWidth = _bbox.width )
                    _y = _workspaceOffset.y + _partHeight * _ix;

                    var _path = JC.f.printf( 'M{0},{1}L{2},{3}', 
                        Math.round( _chartWorkspaceOffset.x - 6 ), Math.floor( _y )
                        , Math.round( _chartWorkspaceOffset.x ), Math.floor( _y )
                    );
                    _p.root().path( _path ).translate( .5, .5 ).attr( 'stroke', '#9c9c9c' );

                    if( _ix === 0 ){
                        _y += _bbox.height / 2 - 4;
                    }else if( _ix === ( _len - 1 ) ){
                        _y -= _bbox.height / 2 - 4;
                    }

                    _item.attr( 'y', _y );
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
