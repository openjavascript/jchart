;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.IconVLine', 'JChart.GraphicRect' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href="widnow.jQuery.html">jQuery</a>
 *      , <a href='JC.BaseMVC.html'>JC.BaseMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.HistogramLateral.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChar.HistogramLateral/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *  <h2>页面只要引用本脚本, 默认会处理 div class="JCharHistogramLateral"</h2>
 *
 *  <h2>可用的 HTML attribute</h2>
 *
 *  <dl>
 *      <dt></dt>
 *      <dd><dd>
 *  </dl> 
 *
 * @namespace   JChar
 * @class       HistogramLateral
 * @extends     JChar.Base
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.HistogramLateral 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.HistogramLateral = HistogramLateral;

    function HistogramLateral( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, HistogramLateral ) ) 
            return JC.BaseMVC.getInstance( _selector, HistogramLateral );

        JC.BaseMVC.getInstance( _selector, HistogramLateral, this );

        this._model = new HistogramLateral.Model( _selector );
        this._view = new HistogramLateral.View( this._model );
        this._init();

        JC.log( HistogramLateral.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 HistogramLateral 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of HistogramLateralInstance}
     */
    HistogramLateral.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jcharHistogramLateral' )  ){
                    _r.push( new HistogramLateral( _selector ) );
                }else{
                    JChart.Base.init( HistogramLateral, $( 'div.jcharHistogramLateral' ), 0, 1 );
                }
            }
            return _r;
        };
    /**
     * 当前活动的图表实例
     * @property    CURRENT_INS
     * @type        JChart.Histogram
     * @default     null
     * @static
     */
    HistogramLateral.CURRENT_INS = null;
    /**
     * 响应图表 鼠标移动的默认函数
     * @method  DEFAULT_MOVE
     * @param   {Event} _evt
     * @static
     */
    HistogramLateral.DEFAULT_MOVE =
        function( _evt ){
            if( !HistogramLateral.CURRENT_INS ){
                _jdoc.off( 'mousemove', HistogramLateral.DEFAULT_MOVE );
                return;
            }
            HistogramLateral.CURRENT_INS
                .trigger( HistogramLateral.Model.MOVING_EVENT, [ _evt ] );
        };

    JC.BaseMVC.build( HistogramLateral, JChart.Base);

    JC.f.extendObject( HistogramLateral.prototype, {
        _beforeInit:
            function(){
                JC.log( 'HistogramLateral _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this,
                    _model = HistogramLateral.Model;

                _p.on( 'inited', function(){
                });

                _p.on( _model.MOVING_EVENT, function( _evt, _sevt ) {
                    var _offset = _p._model.globalEventToLocalOffset( _sevt ),
                        _index = _p._model.indexAt( _offset );
                    _p.trigger( _model.CLEAR_STATUS );
                if( typeof _index != 'undefined' ) {
                        _p._view.updateTips( _index, _offset );
                        _p._view.updateRect( _index );
                        _p._view.updateVLine( _index );
                    }
                } );

                _p.on( _model.MOVING_START, function() {
                    _p.trigger( _model.CLEAR_STATUS );
                     if( !( _p._model.displaySeries && _p._model.displaySeries.length ) ) return;
                    _p._model.tips() && _p._model.tips().show();
                } );

                _p.on( _model.MOVING_DONE, function() {
                    _p.trigger( _model.CLEAR_STATUS );
                    _p._model.tips() && _p._model.tips().hide();
                } );

                _p.on( _model.CLEAR_STATUS, function() {
                    _p._view.clearStatus();
                } );

                _p.on( JChart.Base.Model.RESET_DISPLAY_SERIES, function( _evt, _data ){
                    _p._model.resetDisplaySeries( _data );
                });

                _p.on( JChart.Base.Model.LEGEND_UPDATE, function( _evt, _ix ){
                    _p._model.updateLegend( _ix );
                });
            }
        , _inited:
            function(){
                JC.log( 'HistogramLateral _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }
    });
    
    var _Model = HistogramLateral.Model;

    _Model.MOVING_EVENT = 'moving_event';

    _Model.MOVING_START = 'moving_start';

    _Model.MOVING_DONE = 'moving_done';

    _Model.CLEAR_STATUS = 'clear_status';

    _Model.ANIMATE_SPEED = .25;

    HistogramLateral.Model._instanceName = 'JCHistogramLateral';
    JC.f.extendObject( HistogramLateral.Model.prototype, {
        init:
            function(){
                JC.log( 'HistogramLateral.Model.init:', new Date().getTime() );
            }
        /**
         * 创建所有的柱状矩形
         */
        , rects:
            function( ){
                var _p = this, _tmp;

                if( typeof _p._rects == 'undefined' ){
                    _p._rects= [];

                    $.each( _p.data().xAxis.categories, function( _k, _item ){
                        var _items = [];
                        $.each( _p.displaySeries, function( _sk, _sitem ){
                            console.log(_p.itemStyle( _p.displayLegendMap[ _sk ] ));
                            _tmp = new JChart.GraphicRect( 
                                _p.stage()
                                , 10000, 0
                                , 100
                                , 100
                                , _p.itemStyle( _p.displayLegendMap[ _sk ] )
                                , _p.itemHoverStyle( _p.displayLegendMap[ _sk ] )
                            );
                            //JC.log( _sk, _p.displayLegendMap[ _sk ] );
                            _items.push( _tmp );
                        });

                        _p._rects.push( _items );
                    });
                }
                return _p._rects;
            }
        /**
         * 垂直的背景线
         */
        , rectLines:
            function( _data ){
                var _p = this, _items;
                if( !_p._rectLines ){
                    _p._rectLines = [];

                    _data && _data.xAxis && _data.xAxis.categories && ( _items = _data.xAxis.categories );
                    _data 
                        && _p.series()
                        && _p.series().length
                        && _p.series()[0].data
                        && _p.series()[0].data.length
                        && ( _items = _p.series()[0].data );

                    if( _items ) {
                        for(var i = 0; i <= _items.length; i++ ){
                            var _tmp = new JChart.IconVLine( 
                                _p.stage()
                                , ['M0 0'].join(' ')
                               , JC.f.extendObject( _p.lineStyle( i ), { 'stroke': '#999', 'stroke-width': 1 } )
                                , JC.f.extendObject( _p.lineStyle( i ), { 'stroke': '#000', 'stroke-width': 1 } )
                            );
                            _p._rectLines.push( _tmp );
                        }
                    }
                }
                return _p._rectLines;
            }
        , itemStyle:
            function( _ix ){
                var _r = {}, _p = this
                _r.stroke = _p.itemColor( _ix );
                _r.fill = _p.itemColor( _ix );
                _r[ 'fill-opacity' ] = 1;

                return _r;
            }
        , itemHoverStyle:
            function( _ix ){
                var _r = {}, _p = this
                _r.stroke = _p.itemColor( _ix );
                _r.fill = _p.itemColor( _ix );
                _r[ 'fill-opacity' ] = .65;
                return _r;
            }
        , lineStyle :
            function( _ix ){
                var _r = { stroke: '#999', opacity: .35 };
                return _r;
            }
        , indexAt:
            function( _offset ){
                var _p = this,
                    _c = _p.coordinate(),
                    _relatX = _offset.x - _c._baseX,
                    _relatY = _offset.y - _c._baseY;
                if( _relatX <= 0 || _relatY <= 0 || 
                        _relatX >= _c._tableWidth || _relatY >= _c._tableHeight ) {
                    return undefined;
                }
                return Math.floor( _relatY / _c._partY );
            }
        , coordinate :
            function( _data ) {
                if( typeof this._coordinate != 'undefined' || !_data ){
                    return this._coordinate;
                }
                var _c = {};
                this._coordinate = _c;
                var _tableMargin = 5;
                var _p = this,
                    _bbox, 
                    _offsetY = _p.height(),
                    _offsetX = _p.width(),
                    _y = 5, _x = 5;
                var _harrowWidth = _p.harrowSize();
                var _hlabelMaxWidth = this.hlabelMaxWidth( _data );
                var _vLabelsHeight = this.vlabelMaxHeight( _data );
                var _vLabelMaxWidth = _p.vlabelMaxWidth( _data );
                
                _p.stage();

                _c.stage = { x: 0, y: 0, width: _p.width(), height: _p.height(), corner: _p.stageCorner()  };
                _p.background( _c );

                /* title */
                var _title = _p.title( _data );
                if( _title ) {
                    _bbox = JChart.f.getBBox( _title );
                    _c.title = {
                        x : _offsetX / 2,
                        y : _y + _bbox.height / 2,
                        ele : _title
                    }
                    _y = _c.title.y + _bbox.height / 2;
                }

                /* subTitle */
                var _subTitle = _p.subtitle( _data );
                if( _subTitle ) {
                    _bbox = JChart.f.getBBox( _subTitle );
                    _c.subTitle = {
                        x : _offsetX / 2,
                        y : _y + _bbox.height / 2 + 5,
                        ele : _subTitle
                    }
                    _y = _c.subTitle.y + _bbox.height / 2;
                }

                /* 版权文字 */
                var _credits = _p.credits( _data );
                if( _credits ){
                    _bbox = JChart.f.getBBox( _credits );
                    _c.credits = {
                        x: _offsetX - _bbox.width / 2,
                        y: _offsetY - _bbox.height / 2,
                        ele: _credits
                    }
                    _offsetY = _c.credits.y - 5;
                }

                /* 图例图标的显示坐标 */
                if( _p.legendEnable() ){
                    var _legend = _p.legend( _data, 'rect', function( _ix, _legend, _text, _data ){
                        var _color = _data.stroke 
                                        || Histogram.Model.STYLE.data[ _ix % Histogram.Model.STYLE.data.length ].stroke 
                                        || '#fff';
                        _legend.attr( 'fill', _color ).attr( 'stroke', _color );
                    } );
                    if( _legend ){
                        _bbox = JChart.f.getBBox( _legend );
                        _c.legend = {
                            x: _offsetX / 2 - _bbox.width / 2,
                            y: _offsetY - _bbox.height,
                            ele: _legend
                        }
                        _maxY = _c.legend.y;
                        _offsetY -= _bbox.height;
                    }
                }

                /* 底部水平标签 */
                var vLabels = _p.vlables( _data );
                if( vLabels ) {
                    var _len = vLabels.length,
                        _bottomY = _offsetY - _tableMargin,
                        _partX = ( _offsetX - _harrowWidth - _tableMargin
                                - _hlabelMaxWidth - _vLabelMaxWidth / 2 ) / ( _len - 1 ),
                        _baseX = _offsetX - _vLabelMaxWidth / 2, 
                        _tmpA = [];
                    $.each( vLabels, function( _i, _item ) {
                        _bbox = JChart.f.getBBox( _item );
                        _tmpA.push( {
                            x : _baseX - _partX * _i,
                            y : _bottomY - _bbox.height / 2,
                            item : _item
                        } );
                    } );
                    _c.vlables = _tmpA;
                    _offsetY -= _vLabelsHeight;
                }

                /* 左侧垂直标签 */
                
                var hLabels = _p.hlables( _data ),
                    _hlen = hLabels.length,
                    _partY = ( _offsetY  - _harrowWidth - _y - 5 ) / _hlen;
                if( hLabels ) {
                    var _baseY = _y + _partY / 2, 
                        _tmpA = [];
                    $.each( hLabels, function( _i, _item ) {
                        _bbox = JChart.f.getBBox( _item );
                        _tmpA.push( {
                            x : _x + _bbox.width / 2,
                            y : _baseY + _partY * _i + _bbox.height / 4,
                            item : _item
                        } );
                    });
                    _c.hlables = _tmpA;
                    /* 调整基准 */
                    _x += _hlabelMaxWidth;
                }

                /* 带箭头的短水平线 */
                var _vlines = _p.vlines( _data );
                if( _vlines && _vlines.length ) {
                    _y += 5;
                    var _len = _vlines.length,
                        _lineWidth = 1,
                        _baseY = _y + _partY / 2 - _lineWidth / 2,
                        _tmpA = [];
                    $.each( _vlines, function( _i, _item ) {
                        var _tmpY = _baseY + _partY * _i,
                            _baseX = _x + _tableMargin;
                        _tmpA.push( {  
                            start : { x : _baseX, y : _tmpY },
                            end : { x : _baseX + _harrowWidth, y : _tmpY },
                            item : _item  } );
                    } );
                    _tmpA.length && ( _c.vlines = _tmpA );//水平线条带箭头的坐标
                    /* 调整基准 */
                    _x += _harrowWidth + _tableMargin;
                }
                
                /* 水平线条 和 柱状体 */
                _c.rectLine = [];
                _c.rects = [];
                var _baseX = _c._baseX = _x,
                    _baseY = _c._baseY = _y,
                    _maxX = _offsetX - _vLabelMaxWidth / 2,
                    _maxY = _offsetY - _tableMargin,
                    _tableWidth = _c._tableWidth = _maxX - _x,
                    _tableHeight = _c._tableHeight = _maxY - _y - _harrowWidth;
                _partY = _c._partY = _tableHeight / _hlen;
                _partX = _tableWidth / ( vLabels.length - 1 );
                _c.displaySeries = _p.displaySeries.length; /* 图表数据组个数 */
                var _rectItems, _rectMaxNum, _rectMaxWidth, _num, _d;
                var _rateInfo = _p.rateInfo( _data, _p.rate( _data ) );
                
                var _rectY = Math.floor( _partY / ( _c.displaySeries * 1.5 ) ),
                    _rectBaseY, _rectBaseX, _rectX,
                    _rectPadding = ( _partY - _rectY * _c.displaySeries ) / 2,
                    _rectLines = _p.rectLines( _data );
                _rectLines && _rectLines.length &&
                $.each( _rectLines, function( _i, _item ) {
                    /* 水平线条 */
                    _c.rectLine.push( {
                        start: { x: _baseX, y: _baseY }
                        , end: { x: _maxX, y: _baseY }
                        , item: _item
                    } );
                    if( _i === _rectLines.length - 1 ) { return; }
                    
                    /* 柱状体 */
                    _rectItems = [];
                    _rectBaseY = _baseY + _rectPadding;
                    _rectBaseX = _c.rectBaseX = _baseX + _partX * Math.abs( _rateInfo.length - _rateInfo.zeroIndex - 1 );
                    $.each( _p.displaySeries, function( _si, _sitem ){
                        _num = _sitem.data[ _i ];
                        _d = { 'y': _rectBaseY + _si * _rectY, 'x': _rectBaseX };
                        if( JChart.Base.isNegative( _num ) ) {
                            _num = Math.abs( _num );
                            _rectMaxNum = Math.abs( _rateInfo.finalMaxNum * _p.rate()[ _p.rate().length - 1 ] );
                            _rectMaxWidth = _partX * Math.abs( _rateInfo.length - _rateInfo.zeroIndex - 1 );
                            _rectX = _num / _rectMaxNum * _rectMaxWidth;
                            _d.x = _d.x - _rectX;
                        } else {
                            _rectX = _num / _rateInfo.finalMaxNum * _rateInfo.zeroIndex * _partX;
                        }
                        _d.height = _rectY;
                        _d.width = _rectX;
                        _rectItems.push( _d );
                    } );
                    _c.rects.push( _rectItems );

                    _baseY += _partY;
                    
                } );

                /* 垂直线条 */
                var _baseX = _x,
                    _baseY = _y;
                    
                $.each( vLabels, function( _i, _item ) {
                    _c.rectLine.push( {
                        start: { x: _baseX, y: _baseY }
                        , end: { x: _baseX, y: _maxY }
                        , item: _p.stage().path('M0 0').attr( _p.lineStyle( _i ) )
                    } );
                    _baseX += _partX;
                } );

               /* 图表网格的显示部分 */
                var _dataBackground = _p.dataBackground( _x, _y, _tableWidth, _tableHeight );
                if( _dataBackground ){
                    _c.dataBackground = {
                        x: _x, y: _y, width: _tableWidth, height: _tableHeight, item: _dataBackground
                    };
                }
                
                var _tips = _p.tips();

                return this._coordinate;
            }

        /**
         * 获取垂直 label 的最大宽度
         */
        , hlabelMaxWidth:
            function( _data ){
                var _r = 0, _p = this, _tmp;
                _p.hlables( _data ) && $.each( _p.hlables(), function( _k, _item ){
                    _tmp = JChart.f.getBBox( _item );
                     _tmp.width > _r && ( _r = _tmp.width );
                });
                return _r;
            }
        /**
         * 获取水平 label 的最大高度
         */
        , vlabelMaxHeight:
            function( _data ){
                var _r = 0, _p = this, _tmp;
                _p.vlables( _data ) && $.each( _p.vlables( _data ), function( _k, _item ){
                    _tmp = JChart.f.getBBox( _item );
                    _tmp.height > _r && ( _r = _tmp.height );
                });
                return _r;
            }
    });

    JC.f.extendObject( HistogramLateral.View.prototype, {
        init :
            function() {

                JC.log( 'HistogramLateral.View.init:', new Date().getTime() );
    
                var _p = this;
            }
        , draw :
            function( _data ) {
                var _p = this,
                    _c = _p._model.coordinate( _data ),
                    _d = _p._model.dataBackground();
                _p.setStaticPosition( _c );
                _d.mouseenter( function( _evt ) {
                    HistogramLateral.CURRENT_INS = _p;
                    _jdoc.off( 'mousemove', HistogramLateral.DEFAULT_MOVE );
                    _jdoc.on( 'mousemove', HistogramLateral.DEFAULT_MOVE );
                    _p.trigger( HistogramLateral.Model.MOVING_START );
                } );

                _d.mouseleave( function( _evt ) {
                    _p.trigger( HistogramLateral.Model.MOVING_DONE );
                    _jdoc.off( 'mousemove', HistogramLateral.DEFAULT_MOVE );
                    HistogramLateral.CURRENT_INS = null;
                } );
            }
        , setStaticPosition :
            function( _coordinate ) {
                var _p = this,
                    _c = _coordinate, _tmp;
                if( _c.title ) {
                    _p._model.title().attr( _c.title );
                }
                if( _c.subTitle ) {
                    _p._model.subtitle().attr( _c.subTitle );
                }
                if( _c.credits ) {
                    _p._model.credits().attr( _c.credits );
                }
                if( _c.vtitle ) {
                    _p._model.vtitle().attr( _c.vtitle );
                    _c.vtitle.rotate && _p._model.vtitle().rotate( _c.vtitle.rotate );
                }
                if( _c.vlables ) {
                    $.each( _c.vlables, function( _k, _item ){
                        _item.item.attr( { 'x': _item.x, 'y': _item.y } );
                    });
                }
                if( _c.hlables ) {
                    $.each( _c.hlables, function( _k, _item ){
                        _item.item.attr( { 'x': _item.x, 'y': _item.y } );
                    });
                }
                if( _c.legend ){
                    _p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                }
                if( _c.vlines ) {
                    $.each( _c.vlines, function( _k, _item ){
                        _item.item && _item.item.attr( 'path', JC.f.printf('M{0} {1}L{2} {3}',
                                _item.start.x, _item.start.y, _item.end.x, _item.end.y ) );
                    });
                }
                if( _c.rectLine ) {
                    $.each( _c.rectLine, function( _k, _item ) {
                        _item.item && _item.item.attr( 'path', JC.f.printf('M{0} {1}L{2} {3}',
                            _item.start.x, _item.start.y, _item.end.x, _item.end.y ) );
                    });
                }
                if( _c.rects ){
                    var _rects = _p._model.rects(), 
                        _element, _style, speed = .25,
                        _rectBaseX = _c.rectBaseX;
                    $.each( _c.rects, function( _k, _item ){
                        $.each( _item, function( _sk, _sitem ){
                            _tmp = _rects[ _k ][ _sk ],
                            _element = _tmp._model._elements[0];
                            _tmp.attr( { x: _sitem.x, y: _sitem.y, width: 0, height: _sitem.height } );
                            if( _sitem.x == _rectBaseX ) {
                                _style = { width : _sitem.width };
                            } else {
                                _tmp.attr( { x: _rectBaseX } );
                                _style = { width : _sitem.width, x : _sitem.x };
                            }
                            _element.animate( _style, _sitem.width / _Model.ANIMATE_SPEED );
                            //_tmp.attr( { x: _sitem.x, y: _sitem.y, width: _sitem.width, height: _sitem.height } );
                        });
                    });
                }

                _p._model.tips().toFront();
            }
        , clearStatus:
            function() {
                var _p = this,
                    _preItems = _p._model.preItems();
                if( _preItems ){
                    _preItems.point && $.each( _preItems.point, function( _k, _item ){
                        _item.unhover();
                    });
                    _preItems.vlines && _preItems.vlines.unhover();
                    _preItems.rectLines && ( function() {
                        $.each( _preItems.rectLines, function( _i, _item ) {
                            _item.unhover();
                        });
                    } )();
                }
                _p._model.preItems( null );
            }
        , updateTips:
            function( _index, _offset ){
                var _p = this;
                if( !( _p._model.displaySeries && _p._model.displaySeries.length ) ) return;
                var _tips = _p._model.tips( _index ),
                    _bbox = JChart.f.getBBox( _tips ),
                    _c = _p._model.coordinate(),
                    _tipsX = _offset.x + 15,
                    _tipsY = _offset.y + 18;
                if( ( _tipsY + _bbox.height ) > _c.stage.height ){
                    _tipsY = _offset.y - _bbox.height - 3;
                }
                if( ( _tipsX + _bbox.width ) > _c.stage.width ){
                    _tipsX = _offset.x - _bbox.width - 3;
                }
                _tips.setPosition( _tipsX, _tipsY );
            }
        , updateRect:
            function( _ix ) {
                var _p = this, _r = [], _preItems = _p._model.preItems() || {};
                $.each( _p._model.rects()[ _ix ], function( _k, _item ){
                    _r.push( _item.hover() );
                });
                _preItems.point = _r;
                _p._model.preItems( _preItems );
            }
        , updateVLine:
            function( _ix ){
                var _p = this, _model = _p._model,
                    _r = [], _preItems = _model.preItems() || {};
                _model.vlines() 
                    && ( _preItems.vlines = _model.vlines()[ _ix ].hover() )
                    && ( function() {
                        var rlArray = [], _tmp,
                            _rectLines = _model.rectLines();
                        for( var i = 0; i < 2; i++ ) {
                            _tmp = _rectLines[ _ix + i ];
                            _tmp && _tmp.hover() && rlArray.push( _tmp );
                        }
                        _preItems.rectLines = rlArray;
                    } )()
                    && _p._model.preItems( _preItems );
            }
    });

    _jdoc.ready( function(){
        var _insAr = 0;
        HistogramLateral.autoInit
            && ( _insAr = HistogramLateral.init() )
            && $( '<h2>HistogramLateral total ins: ' 
                + _insAr.length + '<br/>' + new Date().getTime() + '</h2>' ).appendTo( document.body )
            ;
    });

    return JC.HistogramLateral;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);

