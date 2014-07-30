;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.IconVLine', 'JChart.GraphicRect' ], function(){
/**
 * 柱状图
 *
 *<p><b>require</b>:
 *   <a href='JChart.Base.html'>JChart.Base</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Histogram.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.Histogram/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 span class="jchartHistogram"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt>chartScriptData = script selector</dt>
 *    <dd>保存图表数据的脚本标签</dd>
 *
 *    <dt>chartWidth = int, default = auto</dt>
 *    <dd>显式设置图表的宽度, 如果为空则为自适应宽度</dd>
 *
 *    <dt>chartWidth = int, default = 400</dt>
 *    <dd>设置图表的宽度</dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       Histogram
 * @extends     JChart.Base
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-06-20
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Histogram = Histogram;

    function Histogram( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, Histogram ) ) 
            return JC.BaseMVC.getInstance( _selector, Histogram );

        JC.BaseMVC.getInstance( _selector, Histogram, this );

        this._model = new Histogram.Model( _selector );
        this._view = new Histogram.View( this._model );

        this._init();

        //JC.log( Histogram.Model._instanceName, 'all inited', new Date().getTime() );
    }
    Histogram.FLASH_PATH = "{0}/flash/pub/charts/Histogram.swf";
    /**
     * 初始化可识别的 Histogram 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of HistogramInstance}
     */
    Histogram.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jchartHistogram' )  ){
                    _r.push( new Histogram( _selector ) );
                }else{
                    JChart.Base.init( Histogram, $( 'div.jchartHistogram' ), 0, 1 );
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
    Histogram.CURRENT_INS = null;
    /**
     * 响应图表 鼠标移动的默认函数
     * @method  DEFAULT_MOVE
     * @param   {Event} _evt
     * @static
     */
    Histogram.DEFAULT_MOVE =
        function( _evt ){
            if( !Histogram.CURRENT_INS ){
                _jdoc.off( 'mousemove', Histogram.DEFAULT_MOVE );
                return;
            }
            var _p = Histogram.CURRENT_INS;
            //JC.log( 'Histogram.DEFAULT_MOVE', _evt.pageX, _evt.pageY, JC.f.ts(), _selector.length, _src.nodeName );
            _p.trigger( Histogram.Model.UPDATE_MOVING_STATUS, [ _evt ] );
        };

    JC.BaseMVC.build( Histogram, JChart.Base );

    JC.f.extendObject( Histogram.prototype, {
        _beforeInit:
            function(){
                //JC.log( 'Histogram _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this;

                _p.on( Histogram.Model.UPDATE_MOVING_STATUS, function( _evt, _srcEvt, _srcEle ){
                    var _offset = _p._model.globalEventToLocalOffset( _srcEvt )
                        , _index = _p._model.indexAt( _offset );

                    _p.trigger( Histogram.Model.CLEAR_STATUS );
                    if( typeof _index == 'undefined' ) return;

                    _p.trigger( Histogram.Model.UPDATE_STATUS, [ _index, _offset  ] );
                });

                _p.on( Histogram.Model.MOVING_START, function( _evt ){
                    _p.trigger( Histogram.Model.CLEAR_STATUS );
                    if( !( _p._model.displaySeries && _p._model.displaySeries.length ) ) return;
                    _p._model.tips() && _p._model.tips().show();
                });

                _p.on( Histogram.Model.MOVING_DONE, function( _evt ){
                    _p.trigger( Histogram.Model.CLEAR_STATUS );
                    _p._model.tips() && _p._model.tips().hide();
                });

                _p.on( Histogram.Model.CLEAR_STATUS, function(){
                    _p._view.clearStatus();
                });

                _p.on( Histogram.Model.UPDATE_STATUS, function( _evt, _index, _offset ){
                    if( !_offset ) return;
                    if( typeof _index == 'undefined' ) return;
                    //JC.log( _index, _offset.x, _offset.y, JC.f.ts() );
                    _p._view.updateTips( _index, _offset );
                    _p._view.updateRect( _index );
                    _p._view.updateVLine( _index );
                });

                _p.on( JChart.Base.Model.RESET_DISPLAY_SERIES, function( _evt, _data ){
                    _p._model.resetDisplaySeries( _data );
                });

                _p.on( JChart.Base.Model.LEGEND_UPDATE, function( _evt, _ix ){
                    _p._model.updateLegend( _ix );
                });
            }

        , _inited:
            function(){
                //JC.log( 'Histogram _inited', new Date().getTime() );
            }
    });

    Histogram.Model._instanceName = 'JChartHistogram';
    /**
     * 鼠标移动式触发的事件
     * @event update_moving_status
     */
    Histogram.Model.UPDATE_MOVING_STATUS = 'update_moving_status';
    /**
     * 更新 图表 和 Tips 的显示状态
     * @event update_status
     */
    Histogram.Model.UPDATE_STATUS = 'update_status';
    /**
     * 鼠标进入图表主区域时, 触发的事件
     * @event   moving_start
     */
    Histogram.Model.MOVING_START = 'moving_start';
    /**
     * 鼠标离开图表主区域时, 触发的事件
     * @event   moving_done
     */
    Histogram.Model.MOVING_DONE = 'moving_done';
    /**
     * 清除图表的显示状态
     * @event   clear_status
     */
    Histogram.Model.CLEAR_STATUS = 'clear_status';

    var _oldWorkspaceOffset = Histogram.Model.prototype.workspaceOffset;

    JC.f.extendObject( Histogram.Model.prototype, {
        init:
            function(){
                //JC.log( 'Histogram.Model.init:', new Date().getTime() );
                JChart.Base.Model.prototype.init.call( this );
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
         * 从不同的索引获取对应的样式
         * @param   {int}   _ix
         */
        , itemStyle:
            function( _ix ){
                var _r = {}, _p = this
                _r.stroke = _p.itemColor( _ix );
                _r.fill = _p.itemColor( _ix );
                _r[ 'fill-opacity' ] = 1;

                return _r;
            }
        /**
         * 从不同的索引获取不同 hover 样式
         * @param   {int}   _ix
         */
        , itemHoverStyle:
            function( _ix ){
                var _r = {}, _p = this

                _r.stroke = _p.itemColor( _ix );
                _r.fill = _p.itemColor( _ix );
                _r[ 'fill-opacity' ] = .65;

                return _r;
            }
        /**
         * 从不同的索引获取 背景线条的样式
         * @param   {int}   _ix
         */
        , lineStyle:
            function( _ix ){
                var _r = { stroke: '#999', opacity: .35 };
                return _r;
            }
        /**
         * 从坐标点计算位于哪个数据项
         * @param   {Point} _point
         */
        , indexAt:
            function( _point ){
                var _p = this
                    , _c = _p.coordinate()
                    , _realX = _point.x - _c.chartX
                    , _realY = _point.y - _c.chartY
                    , _maxX = _c.chartWidth
                    , _maxY = _c.chartHeight
                    , _itemLen, _partWidth
                    , _partWhat = 0;
                    ;

                if( _realX <= 0 || _realY <= 0 || _realX >= _maxX || _realY >= _maxY ){
                    return undefined;
                }

                _itemLen = ( _c.hlen );
                _partWidth = _c.chartWidth / _itemLen;
                _partWhat = Math.floor( _realX / _partWidth  );

                return _partWhat;
            }
        /**
         * 计算图表所有显示内容的坐标
         * @param   {object} _data
         * @return object
         */
        , coordinate:
            function( _data ){
                if( typeof this._coordinate != 'undefined' || !_data ){
                    return this._coordinate;
                }
                var _p = this
                    , _c = {}
                    , _bbox
                    , _x = 0, _maxX = _p.width() - 10
                    , _y = 0, _maxY = _p.height()
                    , _tmp, _tmpX, _tmpY, _padX, _tmpA, _tmpA1
                    ;
                this._coordinate = _c;

                _p.stage();

                _c.stage = { x: 0, y: 0, width: _p.width(), height: _p.height(), corner: _p.stageCorner()  };
                _p.background( _c );
                _x = 2, _y = 2;

                /**
                 * 标题文字的显示坐标
                 */
                var _title = _p.title( _data );
                if( _title ){
                    _bbox = JChart.f.getBBox( _title );
                    _c.title = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                        , ele: _title
                    }
                    _y = _c.title.y + _bbox.height / 2;
                }
                /**
                 * 子标题文字的显示坐标
                 */
                var _subtitle = _p.subtitle( _data );
                if( _subtitle ){
                    _bbox = JChart.f.getBBox( _subtitle );
                    _c.subtitle = {
                        x: _p.width() / 2
                        , y: _y + _bbox.height / 2 + 5
                        , ele: _subtitle
                    }
                    _y = _c.subtitle.y + _bbox.height / 2 + 5;
                }

                !( _title && _subtitle ) && ( _y += 10 );
                /**
                 * 垂直标题文字的显示坐标
                 */
                var _vtitle = _p.vtitle( _data );
                if( _vtitle ){
                    _bbox = JChart.f.getBBox( _vtitle );
                    _c.vtitle = {
                        x: _x + _bbox.height / 2 + 5
                        , y: _p.height() / 2
                        , rotate: -90
                        , ele: _vtitle
                    }
                    _x = _c.vtitle.x + 5 + 10;
                }
                /**
                 * 版权信息的显示坐标
                 */
                var _credits = _p.credits( _data );
                if( _credits ){
                    _bbox = JChart.f.getBBox( _credits );
                    _c.credits = {
                        x: _maxX - _bbox.width / 2
                        , y: _maxY - _bbox.height / 2
                        , ele: _credits
                    }
                    _maxY = _c.credits.y - 5;
                }
                /**
                 * 图例图标的显示坐标
                 */
                if( _p.legendEnable() ){
                    var _legend = _p.legend( _data, 'rect', function( _ix, _legend, _text, _data ){
                        var _color = _data.stroke 
                                        || Histogram.Model.STYLE.data[ _ix % Histogram.Model.STYLE.data.length ].stroke 
                                        || '#fff';
                        _legend.attr( 'fill', _color ).attr( 'stroke', _color );;
                    } );
                    if( _legend ){
                        _bbox = JChart.f.getBBox( _legend );
                        _c.legend = {
                            x: ( _maxX - _bbox.width ) / 2
                            , y: _maxY - _bbox.height + 5
                            , ele: _legend
                        }
                        _maxY = _c.legend.y;
                    }
                }

                _maxY -= _p.varrowSize();
                _x += _p.harrowSize();

                    //水平 label 的最大高度
                var _hlabelMaxHeight = _p.hlabelMaxHeight( _data )
                    //垂直 label 的最大宽度
                    , _vlabelMaxWidth = _p.vlabelMaxWidth( _data )
                    , _vx = _x, _hy = _y
                    ;

                if( _vlabelMaxWidth ){
                    _x += _vlabelMaxWidth;
                    _vx = _x - _p.harrowSize();
                    _x += 5;
                }

                if( _hlabelMaxHeight ){
                    _maxY -= 2;
                    _maxY -= _hlabelMaxHeight;
                    _hy = _maxY + _p.varrowSize() + 4;
                    _maxY -= 5;
                }

                _c.vlen = _p.vlen(); //图表数据粒度的长度
                _c.hlen = _p.hlen(); //图表数据的长度
                /**
                 * 垂直内容的高度
                 */
                _c.vpart = ( _maxY - _y ) / ( _c.vlen - 1 ); 
                /**
                 * 水平内容的宽度
                 */
                _c.hpart = ( _maxX - _x ) / ( _c.hlen );
                /**
                 * 水平内容的一半宽度
                 */
                _c.halfHPart = _c.hpart / 2;
                /**
                 * 图表有多少条数据
                 */
                _c.seriesLength = _p.seriesLength();
                /**
                 * 计算总共有多少条数据
                 */
                _c.seriesPart = Math.floor( _c.hpart / ( _c.seriesLength * 1.5 ) );
                /**
                 * 柱状图的高度
                 */
                _c.chartHeight = _maxY - _y;
                /**
                 * 柱状图的 y 坐标
                 */
                _c.chartY = _y;
                /**
                 * 柱状图的最大 y 坐标
                 */
                _c.chartMaxY = _maxY;
                /**
                 * 柱状图的宽度
                 */
                _c.chartWidth = _maxX - _x;
                /**
                 * 柱状图的 x 坐标
                 */
                _c.chartX = _x;
                /**
                 * 柱状图的最大 x 坐标
                 */
                _c.chartMaxX = _maxX;
                /**
                 * 柱状图的背景
                 */
                var _dataBackground = _p.dataBackground( _c.chartX, _c.chartY, _c.chartWidth, _c.chartHeight );
                if( _dataBackground ){
                    _c.dataBackground = {
                        x: _c.chartX, y: _c.chartY, width: _c.chartWidth, height: _c.chartHeight, item: _dataBackground
                    };
                }

                var _vlines = _p.vlines( _data );
                if( _vlines && _vlines.length ){
                    _tmpA = [];
                    _tmpA1 = [];
                    _tmp = _p.labelDisplayIndex( _data );
                    $.each( _vlines, function( _ix, _item ){
                        _tmpX = _x + _c.hpart * _ix + _c.halfHPart;
                        _padX = _p.varrowSize();
                        if( _tmp && _tmp.length ){
                            !_tmp[ _ix ] && ( _padX = 0 );
                        }
                        _tmpA.push( {  start: { 'x': _tmpX, 'y': _y + _c.chartHeight }
                            , end: { 'x': _tmpX, 'y': _maxY + _padX }
                            , 'item': _item  } );
                        _tmpA1.push( {  start: { 'x': _tmpX, 'y': _y }
                            , end: { 'x': _tmpX, 'y': _maxY }
                            , 'item': _item  } );
                    });
                    _tmpA.length && ( 
                        _c.vlines = _tmpA  //垂直线条带箭头的坐标
                    );
                    _tmpA1.length && ( 
                        _c.vlinePoint = _tmpA1 //垂直线条的坐标
                    );
                }

                var _hlines = _p.hlines( _data );
                if( _hlines && _hlines.length ){
                    _tmpA = [];
                    _tmpA1 = [];
                    $.each( _hlines, function( _ix, _item ){
                        _tmpY = _y + _c.vpart * _ix;
                        _tmpA.push( {  start: { 'x': _x - _p.harrowSize(), 'y': _tmpY }
                            , end: { 'x': _maxX , 'y': _tmpY }
                            , 'item': _item  } );
                        _tmpA1.push( {  start: { 'x': _x, 'y': _tmpY }
                            , end: { 'x': _maxX , 'y': _tmpY }
                            , 'item': _item  } );
                    });
                    _tmpA.length && ( 
                        _c.hlines = _tmpA //水平线条带箭头的坐标
                    );
                    _tmpA1.length && ( 
                        _c.hlinePoint = _tmpA1 //水平线条的坐标
                    );
                }

                if( _vlabelMaxWidth ){
                    /**
                     * 垂直 label
                     */
                    var _vlabels = _p.vlables( _data );
                    _tmp = 0;
                    _tmpA = [];
                    $.each( _vlabels, function( _ix, _item ){
                        _bbox = JChart.f.getBBox( _item );
                        _tmpX = _vx - _bbox.width / 2;
                        _tmpY = parseInt( _y + ( _maxY - _y ) * _tmp );
                        _tmp += .25;
                        _tmpA.push( { 'x': _tmpX, 'y': _tmpY, 'item': _item  } );
                    });
                    _tmpA.length && ( _c.vlables = _tmpA );
                }

                if( _hlabelMaxHeight ){
                    /**
                     * 水平 label
                     */
                    var _hlabels = _p.hlables( _data );
                    _tmp = 0;
                    _tmpA = [];
                    $.each( _c.vlinePoint, function( _ix, _lineItem ){
                        var _item = _hlabels[_ix ], _bbox;
                        if( !_item ) return;
                        _tmpX = _lineItem.end.x;
                        _bbox = JChart.f.getBBox( _item );
                        if( _ix === ( _c.vlinePoint.length - 1 ) ){
                            _tmpX = _lineItem.end.x + 2;
                            if(  ( _tmpX + _bbox.width / 2 ) > _c.chartMaxX ){
                                _tmpX = _c.chartMaxX - _bbox.width / 2;
                            }
                        }else if( _ix === 0 ){
                            _tmpX = _lineItem.end.x - 2;
                            if(  ( _tmpX - _bbox.width / 2 ) < _c.chartX ){
                                _tmpX = _c.chartX + _bbox.width / 2;
                            }
                        }
                        _tmpY = _hy;
                        _tmpA.push( { 'x': _tmpX, 'y': _tmpY, 'item': _item  } );
                    });
                    _tmpA.length && ( _c.hlables = _tmpA );
                }

                //get data point
                /**
                 * 所有矩形的坐标
                 */
                _c.rects = [];
                /**
                 * 所有矩形的线条坐标
                 */
                _c.rectLine = [];

                var _rateInfo = _p.rateInfo( _data, _p.rate( _data ) )
                    , _lineStartY = _c.vlinePoint[0].start.y
                    , _lineEndY = _c.vlinePoint[0].end.y
                    ;
                $.each( _data.xAxis.categories, function( _ix, _items ){
                    var _rectItems = []
                        , _lineItem = _c.vlinePoint[ _ix ]
                        , _sstart = _lineItem.end.x - _c.seriesPart * _p.displaySeries.length / 2
                        , _chartX = _lineItem.end.x - _c.hpart / 2 
                        , _maxNum
                        ;
                    _c.rectLine.push( {
                        start: { x: _chartX, y: _lineStartY }
                        , end: { x: _chartX, y: _lineEndY }
                        , item: _p.stage().path('M0 0').attr( _p.lineStyle( _ix ) )
                    } );

                    if( _ix === _data.xAxis.categories.length - 1 ){
                        _chartX = _lineItem.end.x + _c.hpart / 2;
                        _c.rectLine.push( {
                            start: { x: _chartX, y: _lineStartY }
                            , end: { x: _chartX, y: _lineEndY }
                            , item: _p.stage().path('M0 0').attr( _p.lineStyle( _ix ) )
                        } );
                    }

                    //JC.dir( _p.displaySeries );

                    $.each( _p.displaySeries, function( _six, _sd ){
                        var _d = { 'y': _lineItem.start.y, 'x': _sstart + _six * _c.seriesPart  }
                            , _item, _dataHeight, _dataY, _height
                            , _num = _sd.data[ _ix ]
                            ;

                        if( JChart.Base.isNegative( _num ) ){
                            _num = Math.abs( _num );
                            _dataHeight = _c.vpart * Math.abs( _rateInfo.length - _rateInfo.zeroIndex - 1 );
                            _dataY = _c.chartY + _c.vpart * _rateInfo.zeroIndex;
                            _maxNum = Math.abs( _rateInfo.finalMaxNum * _p.rate()[ _p.rate().length - 1 ] );
                            _height = ( _num / _maxNum ) * _dataHeight;
                            _d.y = _d.y + _c.chartHeight - _dataHeight;
                            //JC.log( _rateInfo.length, _rateInfo.zeroIndex, _c.vpart, _dataHeight, JC.f.ts() );
                        }else{
                            _dataHeight = _c.vpart * _rateInfo.zeroIndex;
                            _dataY = _c.chartY;
                            _maxNum = _rateInfo.finalMaxNum;
                            _height = ( _num / _maxNum ) * _dataHeight;
                            _d.y = _d.y + _dataHeight - _height;
                        }
                        //_p.stage().rect( _d.x, _d.y, _c.seriesPart, _height );
                        _d.width = _c.seriesPart;
                        _d.height = _height;

                        _rectItems.push( _d );
                    });
                    _c.rects.push( _rectItems );
                });

                var _tips = _p.tips();

                //JC.dir( this._coordinate );

                return this._coordinate;
            }
    });

    JC.f.extendObject( Histogram.View.prototype, {
        _inited:
            function(){
            }
        /**
         * 显示所有图表内容
         * @param   {Object}    _coordinate
         */
        , setStaticPosition:
            function( _coordinate ){
                var _p = this, _c = _coordinate, _tmp;
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
                if( _c.legend ){
                    _p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                }
                if( _c.vlables ){
                    $.each( _c.vlables, function( _k, _item ){
                        _item.item.attr( { 'x': _item.x, 'y': _item.y } );
                    });
                }
                if( _c.hlables ){
                    $.each( _c.hlables, function( _k, _item ){
                        _item.item.attr( { 'x': _item.x, 'y': _item.y } );
                    });
                }

                if( _c.vlines ){
                    $.each( _c.vlines, function( _k, _item ){
                        _item.item.attr( 'path', JC.f.printf('M{0} {1}L{2} {3}', _item.start.x, _item.start.y, _item.end.x, _item.end.y ) );
                    });
                }
                if( _c.hlines ){
                    $.each( _c.hlines, function( _k, _item ){
                        _item.item && _item.item.attr( 'path', JC.f.printf('M{0} {1}L{2} {3}', _item.start.x, _item.start.y, _item.end.x, _item.end.y ) );
                    });
                }
                if( _c.rectLine ){
                    $.each( _c.rectLine, function( _k, _item ){
                        _item.item && _item.item.attr( 'path', JC.f.printf('M{0} {1}L{2} {3}', _item.start.x, _item.start.y, _item.end.x, _item.end.y ) );
                    });
                }
                if( _c.rects ){
                    var _rects = _p._model.rects();
                    $.each( _c.rects, function( _k, _item ){
                        $.each( _item, function( _sk, _sitem ){
                            _tmp = _rects[ _k ][ _sk ];
                            _tmp.attr( { x: _sitem.x, y: _sitem.y, width: _sitem.width, height: _sitem.height } );
                        });
                    });
                }

                _p._model.tips().toFront();

                /*
                var _text = _p.stage().text( 100, 100, 'test 1' ).attr( { 'text-anchor': 'start' } )
                    , _text2 = _p.stage().text( 80, 120, 'test 2' ).attr( { 'text-anchor': 'start' } )
                    , _set = _p.stage().set()
                    ;
                _set.push( _text );
                _set.push( _text2 );

                JChart.moveSet( _set, 0, 0);
                */

            }
        /**
         * 从给出的数据显示图表
         * @param   {object}  _data
         */
        , draw: 
            function( _data ){
                var _p = this, _coordinate;

                var _detect = _p._model.displayDetect();
                //JC.log( 'draw displayDetect', _detect, JC.f.ts() );
                //_detect = 1;

                if( _detect === 1 && Histogram.FLASH_PATH ){
                    _p.drawFlash( _data );
                }else{
                    _p.drawSVG( _data );
                }
             }
        , drawSVG:
            function( _data ){
                var _p = this, _coordinate;
                _p.setStaticPosition( _p._model.coordinate( _data ) );

                _p._model.dataBackground().mouseenter( function( _evt ){
                    Histogram.CURRENT_INS = _p;
                    //JC.log( 'mouseenter', JC.f.ts() );
                    _jdoc.off( 'mousemove', Histogram.DEFAULT_MOVE );
                    _jdoc.on( 'mousemove', Histogram.DEFAULT_MOVE );
                    _p.trigger( Histogram.Model.MOVING_START );
                });

                _p._model.dataBackground().mouseleave( function( _evt ){
                    //JC.log( 'mouseleave', JC.f.ts() );
                    _p.trigger( Histogram.Model.MOVING_DONE );
                    _jdoc.off( 'mousemove', Histogram.DEFAULT_MOVE );
                    Histogram.CURRENT_INS = null;
                });
            }
        , drawFlash:
            function( _data ){
                //JC.dir( _data );
                var _p = this
                    , _fpath =  JC.f.printf( Histogram.FLASH_PATH, JChart.PATH ).replace( /[\/]+/g, '/' )
                    , _element
                    , _dataStr = JSON.stringify( _data ) 
                    ; 
                _element = $( JC.f.printf( '<span id="{0}"></span>', _p._model.gid() ) );
                _element.appendTo( _p.selector() );
                //JC.log( 'drawFlash', _fpath, _p._model.gid(), _p._model.width(), _p._model.height(), _element[0] );
                JC.log( _dataStr );
                swfobject.embedSWF( 
                    _fpath
                    , _p._model.gid()
                    , _p._model.width()
                    , _p._model.height()
                    , '10' 
                    , ''
                    , { 'testparams': 2, 'chart': _dataStr }
                    , { 'wmode': 'transparent' }
                );
            }
        /**
         * 显示 Tips
         * @param   {int}   _ix     数据索引
         * @param   {point} _offset 当前鼠标位置
         */
        , updateTips:
            function( _ix, _offset ){
                var _p = this;
                if( !( _p._model.displaySeries && _p._model.displaySeries.length ) ) return;
                var _tips = _p._model.tips( _ix )
                    , _bbox = JChart.f.getBBox( _tips )
                    , _c = _p._model.coordinate()
                    , _x = _offset.x + 15, _y = _offset.y + 18
                    , _point = _c.vlinePoint[ _ix ]
                    ;

                if( ( _y + _bbox.height ) > _c.stage.height ){
                    _y = _offset.y - _bbox.height + 8;
                }
                _y < 0 && ( _y = 0 );

                if( ( _x + _bbox.width ) > _c.stage.width ){
                    _x = _offset.x - _bbox.width;
                }
                _x < 0 && ( _x = 0 );

                _tips.setPosition( _x, _y );
            }
        /**
         * 更新当前距行的显示状态
         * @param   {int}   _ix     
         */
        , updateRect:
            function( _ix ){
                var _p = this, _r = [], _preItems = _p._model.preItems() || {};
                //JC.dir( _p._model.rects()[ _ix ] );
                $.each( _p._model.rects()[ _ix ], function( _k, _item ){
                    _r.push( _item.hover() );
                });
                _preItems.point = _r;
                _p._model.preItems( _preItems );
            }
        /**
         * 更新当前背景线的显示状态
         * @param   {int}   _ix     
         */
        , updateVLine:
            function( _ix ){
                var _p = this, _r = [], _preItems = _p._model.preItems() || {};

                _p._model.vlines() 
                    && ( _preItems.vlines = _p._model.vlines()[ _ix ].hover() )
                    && _p._model.preItems( _preItems );
            }
        /**
         * 清除所有显示状态
         * @param   {int}   _ix     
         */
        , clearStatus:
            function(){
                var _p = this, _preItems = _p._model.preItems();

                if( _preItems ){
                    _preItems.point && $.each( _preItems.point, function( _k, _item ){
                        _item.unhover();
                    });
                    _preItems.vlines && _preItems.vlines.unhover();
                }

                _p._model.preItems( null );
            }
    });

    _jdoc.ready( function(){
        Histogram.autoInit && Histogram.init();
    });

    _jwin.on( JChart.Base.RESIZE_UPDATE, function( _evt ){
        JChart.Base.reset( 'div.jchartHistogram', JChart.Histogram );
    });

    return Histogram;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
