;(function(define, _win) { 'use strict'; define( [ 'JChart.Base', 'JChart.Group', 'JChart.GraphicSector', 'JChart.GraphicRect' ], function(){
/**
 * 组件用途简述
 *
 *  <p><b>require</b>:
 *      <a href="widnow.jQuery.html">jQuery</a>
 *      , <a href='JC.BaseMVC.html'>JC.BaseMVC</a>
 *  </p>
 *
 *  <p><a href='https://github.com/openjavascript/jquerycomps' target='_blank'>JC Project Site</a>
 *      | <a href='http://jc2.openjavascript.org/docs_api/classes/JC.TubularFigure.html' target='_blank'>API docs</a>
 *      | <a href='../../modules/JChart.TubularFigure/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *  <h2>页面只要引用本脚本, 默认会处理 div class="JCharTubularFigure"</h2>
 *
 *  <h2>可用的 HTML attribute</h2>
 *
 *  <dl>
 *      <dt></dt>
 *      <dd><dd>
 *  </dl> 
 *
 * @namespace   JChart
 * @class       TubularFigure
 * @extends     JChart.Base
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2013-12-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.TubularFigure 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.TubularFigure = TubularFigure;

    function TubularFigure( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, TubularFigure ) ) 
            return JC.BaseMVC.getInstance( _selector, TubularFigure );

        JC.BaseMVC.getInstance( _selector, TubularFigure, this );

        this._model = new TubularFigure.Model( _selector );
        this._view = new TubularFigure.View( this._model );
        this._init();

        JC.log( TubularFigure.Model._instanceName, 'all inited', new Date().getTime() );
    }
    /**
     * 初始化可识别的 TubularFigure 实例
     * @method  init
     * @param   {selector}      _selector
     * @static
     * @return  {Array of TubularFigureInstance}
     */
    TubularFigure.init =
        function( _selector ){
            var _r = [];
            _selector = $( _selector || document );

            if( _selector.length ){
                if( _selector.hasClass( 'jcharTubularFigure' )  ){
                    _r.push( new TubularFigure( _selector ) );
                }else{
                    JChart.Base.init( TubularFigure, $( 'div.jcharTubularFigure' ), 0, 1 );
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
    TubularFigure.CURRENT_INS = null;
    /**
     * 响应图表 鼠标移动的默认函数
     * @method  DEFAULT_MOVE
     * @param   {Event} _evt
     * @static
     */
    TubularFigure.DEFAULT_MOVE =
        function( _evt ){
            if( !TubularFigure.CURRENT_INS ){
                _jdoc.off( 'mousemove', TubularFigure.DEFAULT_MOVE );
                return;
            }
            TubularFigure.CURRENT_INS
                .trigger( TubularFigure.Model.MOVING_EVENT, [ _evt ] );
        };

    JC.BaseMVC.build( TubularFigure, JChart.Base);

    JC.f.extendObject( TubularFigure.prototype, {
        _beforeInit:
            function(){
                JC.log( 'TubularFigure _beforeInit', new Date().getTime() );
            }

        , _initHanlderEvent:
            function(){
                var _p = this,
                    _model = TubularFigure.Model;

                _p.on( _model.MOVING_EVENT, function( _evt, _sevt ) {
                    var _offset = _p._model.globalEventToLocalOffset( _sevt )
                        , _index = _p._model.indexAt();
                    _p.trigger( 'clear_status' );
                    if( typeof _index == 'undefined' ) return;
                    _p.trigger( 'update_status', [ _index, _offset  ] );
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

                _p.on( 'update_status', function( _evt, _index, _offset ){
                    if( !_offset ) return;
                    if( typeof _index == 'undefined' ) return;
                    _p._view.updateTips( _index, _offset );
                });

                _p.on( 'unselected_piepart', function( _evt, _isSelected, _id ){
                    _p._model.sectors() && _p._model.sectors().length &&
                        $.each( _p._model.sectors(), function( _k, _item ){
                            if( _item.id() == _id ) return;
                            _item.selected( false );
                        });
                });

                _p.on( 'update_default_selected', function( _evt ){
                    var _ix;
                    _p._model.getDisplaySeries() && _p._model.getDisplaySeries().length
                        && $.each( _p._model.getDisplaySeries()[0].data, function( _k, _item ){
                            _item.selected && ( _ix = _k );
                        });
                    typeof _ix != 'undefined' 
                        && _p._model.sectors() 
                        && _p._model.sectors()[ _ix ]
                        && _p._model.sectors()[ _ix ].selected( true );
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
                JC.log( 'TubularFigure _inited', new Date().getTime() );
                this.trigger( 'inited' );
            }
    });
    
    var _Model = TubularFigure.Model;

    _Model.MOVING_EVENT = 'moving_event';

    _Model.MOVING_START = 'moving_start';

    _Model.MOVING_DONE = 'moving_done';

    _Model.CLEAR_STATUS = 'clear_status';

    _Model.BACKGROUND_SHADOW = 3;

    _Model.PI = 3.14;

    _Model.ANGLE = 360;

    _Model._instanceName = 'JCTubularFigure';

    _Model.STYLE = {
        lineStyle: {
            'stroke': '#999'
            , 'opacity': '.35'
        }
        , style: [
              { 'fill': '#09c100', 'stroke': '#fff'}
            , { 'fill': '#FFBF00', 'stroke': '#fff'}
            , { 'fill': '#0c76c4', 'stroke': '#fff'}
            , { 'fill': '#41e2e6', 'stroke': '#fff'}
            , { 'fill': '#ffb2bc', 'stroke': '#fff'}
            , { 'fill': '#dbb8fd', 'stroke': '#fff'}
            , { 'fill': '#ff06b3', 'stroke': '#fff'}
            , { 'fill': '#ff7100', 'stroke': '#fff'}
            , { 'fill': '#c3e2a4', 'stroke': '#fff'}
            , { 'fill': '#ff0619', 'stroke': '#fff'}

        ]
        , pathStyle: {
            'stroke-width': 2
        }
        , radius: 4
    };

    JC.f.extendObject( TubularFigure.Model.prototype, {
        init:
            function(){
                JC.log( 'TubularFigure.Model.init:', new Date().getTime() );
            }
        /**
         * 图表数据背景
         */
        , dataBackground:
            function( _x, _y, _width, _height ) {
                if( typeof this._dataBackground == 'undefined' ) {
                    var _strWidth = 1, _strOpacity = .15, _md = 2,
                        _shadowWidth = _md * _Model.BACKGROUND_SHADOW,
                    _w = _width - _shadowWidth,
                    _h = _height - _shadowWidth;
                    for( var i = 0; i < _Model.BACKGROUND_SHADOW; i++ ) {
                        this.stage().rect( _x, _y, _w, _h )
                            .attr( { 'stroke-opacity': _strOpacity, 'stroke-width': _strWidth } );
                        _strWidth += _md;
                        _strOpacity = _strOpacity * 2 / 3;
                    }
                    this._dataBackground = this.stage().rect( _x - 1, _y - 1, _w, _h )
                            .attr( { 'fill': '#fff', 'stroke-opacity': .15, 'fill-opacity': 0.9, 'stroke-width': 1 } );
                }
                return this._dataBackground;
            }
        , sectors:
            function( _data ) {
                var _p = this, _tmp, _style;
                if( typeof _p.sector == 'undefined' ){
                    _p.sector = [];
                    $.each( _data, function( _i, _item ) {
                        _style = _Model.STYLE.style[ _i % _Model.STYLE.style.length ];
                        _style['stroke-width'] = 2;
                        _tmp = new JChart.GraphicSector( _p.stage(), _item, _style, 
                                _p.itemHoverStyle( _p.displayLegendMap[ _i ] ), _i);
                        _tmp.on( 'selected_changed', function( _evt, _isSelected, _id ){
                            _p.trigger( 'unselected_piepart', [ _isSelected, _id ] );
                        });
                       _tmp.on( 'mouseenter', function( _evt, _srcEvt, _id, _index ){
                            _jdoc.off( 'mousemove', TubularFigure.DEFAULT_MOVE );
                            _jdoc.on( 'mousemove', TubularFigure.DEFAULT_MOVE );
                            TubularFigure.CURRENT_INS = _p;
                            _p.indexAt( _index );
                            _p.trigger( 'moving_start' );
                       });
                       _tmp.on( 'mouseleave', function( _evt, _srcEvt, _id, _index ){
                            _jdoc.off( 'mousemove', TubularFigure.DEFAULT_MOVE );
                            _p.trigger( 'moving_done' );
                            TubularFigure.CURRENT_INS = null;
                       });
                        _p.sector.push( _tmp );
                    } );
                }
                return _p.sector;
            }
        , itemStyle:
            function( _ix ) {
                var _r = {}, _p = this
                _r.stroke = _p.itemColor( _ix );
                _r.fill = _p.itemColor( _ix );
                _r[ 'fill-opacity' ] = 1;

                return _r;
            }
        , itemHoverStyle :
            function( _ix ) {
                var _r = {}, _p = this
                _r.stroke = _p.itemColor( _ix );
                _r.fill = _p.itemColor( _ix );
                _r[ 'fill-opacity' ] = .65;
                return _r;
            }
        , lineStyle :
            function( _ix ) {
                var _r = { stroke: '#999', opacity: .35 };
                return _r;
            }
        ,indexAt :
        function( _setter ){
                typeof _setter != 'undefined' && ( this._index = _setter );
                return this._index;
            }
        /**
         * 保存图表数据
         */
        , data :
            function( _data ){
                var _p = this;
                if( typeof _data != 'undefined' ){
                    _p._data = _data;
                    _p._data.series && _p._data.series.length && 
                        $.each( _p._data.series[0].data, function( _k, _item ){
                            if( JChart.f.isArray( _item ) ){
                                _p._data.series[0].data[ _k ] = { 'name': _item[0], 'y': _item[1] };
                                _p.getDisplaySeries()[ _k ] = { 'name': _item[0], 'y': _item[1] };
                            }
                        });
                }
                return _p._data;
            }
        , series:
            function(){
                var _p = this;

                typeof _p._series == 'undefined' && _p.data() && _p.data().series 
                    && _p.data().series.length 
                    && _p.data().series[0].data
                    && _p.data().series[0].data.length
                    && ( _p._series = _p.data().series[0].data )
                return _p._series;
            }
        , coordinate :
            function( _data ) {
                if( typeof this._coordinate != 'undefined' || !_data ){
                    return this._coordinate;
                }
                var _c = {};
                this._coordinate = _c;
                var _tableMargin = 5;
                var _p = this, _bbox, 
                    _offsetY = _p.height(),
                    _offsetX = _p.width(),
                    _y = 5, _x = 5,
                    _chartMargin = 5,
                    _maxX = _offsetX, _maxY = _offsetY;
                
                _p.stage();

                _c.stage = { x: 0, y: 0, width: _p.width(), height: _p.height(), corner: _p.stageCorner()  };
                _p.background( _c );

                /* title */
                var _title = _p.title( _data );
                if( _title ) {
                    _bbox = JChart.f.getBBox( _title );
                    _c.title = {
                        x : _maxX / 2,
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
                        x: _maxX - _bbox.width / 2,
                        y: _maxY - _bbox.height / 2,
                        ele: _credits
                    }
                    _maxY = _c.credits.y;
                }
                
                /* 管状图显示区域背景 */
                _c.x = _x += _chartMargin;
                _c.y = _y += _chartMargin;
                _c.maxX = _maxX -= _chartMargin;
                _c.maxY = _maxY -= _chartMargin;
                var _chartWidth = _maxX - _x,
                    _chartHeight = _maxY - _y,
                    _dataBackground = _p.dataBackground( _x, _y, _chartWidth, _chartHeight );
                if( _dataBackground ){
                    _c.dataBackground = {
                        x: _x, y: _y, width: _chartWidth, height: _chartHeight, item: _dataBackground
                    };
                }

                /* 图例图标的显示坐标 */
                if( _p.legendEnable() ) {
                    var _legend = _p.legend( _data, 'rect', function( _ix, _legend, _text, _data ){
                        var _color = _data.stroke 
                                        || Histogram.Model.STYLE.data[ _ix % Histogram.Model.STYLE.data.length ].stroke 
                                        || '#fff';
                        _legend.attr( 'fill', _color ).attr( 'stroke', _color );
                    } );
                    if( _legend ) {
                        _bbox = JChart.f.getBBox( _legend );
                        _maxY = _maxY - _bbox.height - 5;
                        _c.legend = {
                            x: _offsetX / 2 - _bbox.width / 2,
                            y: _maxY,
                            ele: _legend
                        }
                    }
                }

                /* 扇形区域 */
                var _radius = Math.floor( ( _chartWidth < _chartHeight ? _chartWidth : _chartHeight ) * .4 ), 
                    _radius2 = _radius * 3 / 7;
                var _total = 0, _baseD = 0, _partD, _itemD, _endD, _s, _midD,
                    _center = { x: _x + _chartWidth / 2, y: _y + _chartHeight / 2 };
                _c.sector = [], _c.sLine = [];
                for( var i = 0; i < _p.displaySeries[0].data.length; i++ ){
                    _total += _p.displaySeries[0].data[i].y; 
                }
                _partD = _Model.ANGLE / _total;
                $.each( _p.displaySeries[0].data, function( _i, _item ) {
                    _itemD = _partD * _item.y;
                    _endD = _baseD + _itemD;
                    _midD = _baseD + _itemD / 2;
                    _c.sector.push( {
                    	'radius': _radius,
                    	'radius2': _radius2,
                    	'itemD': _itemD,
                    	'midD': _midD,
                    	'baseD': _baseD,
                    	'centerPoint': _center
                    } );
                    _c.sLine.push( {
                        'startPoint': _p.getRadianPoint( _midD, _radius, _center ),
                        'endPoint': _p.getRadianPoint( _midD, _radius + 25, _center ),
                        'dir': _p.getDir( _midD ),
                        'data': _item
                    } );
                    _baseD = _endD;
                } );
                return this._coordinate;
            }
        /* 根据角度算坐标 */
        , getRadianPoint:
            function( _totalD, _r, _center ) {
                var _x, _y;
                var _endPoint = {};
                var _dir = this.getDir( _totalD );
                var _rD = 2 * _Model.PI / _Model.ANGLE * ( _totalD - 90 * _dir );
                var _subtense = Math.sin( _rD ) * _r;
                var _limb = Math.cos( _rD ) * _r;
                if( _dir & 1 ) {/* 2，4象限 */
                    _x = _limb;
                    _y = _subtense;
                } else {/* 1，3象限 */
                    _x = _subtense;
                    _y = _limb;
                }
                if( _dir < 2 ) {
                    _endPoint.x = _center.x + _x ;
                    _endPoint.y = ( _dir == 0 ) ? ( _center.y - _y ) : ( _center.y + _y );
                } else {
                    _endPoint.x = _center.x - _x;
                    _endPoint.y = ( _dir == 2 ) ? ( _center.y + _y ) : ( _center.y - _y );
                }
               return _endPoint;
            }
        , getDir :
            function( _angle ) {
                return Math.floor( _angle / 90 );
            }
        , isCover : 
            function( _obj1, _obj2, _margin ) {
                var _b1, _b2;
                if( !_obj1 || !_obj2 ) {
                    return false;
                }
                _b1 = JChart.f.getBBox( _obj1 );
                _b2 = JChart.f.getBBox( _obj2 );
                _margin = _margin ? _margin : 5;
                return !(
                    _b2.x > ( _b1.x + _b1.width + _margin ) || 
                    ( _b2.x + _b2.width + _margin ) < _b1.x || 
                    _b2.y > ( _b1.y + _b1.height + _margin ) ||
                    ( _b2.y + _b2.height + _margin ) < _b1.y
                );
            }
        , sLabel :
            function( _data ) {
                var _p = this, _c = _p.coordinate(), _position, _text, _label, _cover,
                    _labels = [], _tmp1 = [], _tmp2 = [], _bbox, _tbbox, _next, _dir;
                if( _data && typeof _p.sLabels == 'undefined' ) {
                    _p.sLabels = [];
                    $.each( _data, function( _ix, _item ) {
                        _position = _item.dir > 1 ? 
                            { x: _item.endPoint.x - 10, y: _item.endPoint.y, 'text-anchor': 'end' } : 
                            { x: _item.endPoint.x + 10, y: _item.endPoint.y, 'text-anchor': 'start' };
                        _position.fill = '#999';
                        _text = _p.stage().text( 0, 0, _item.data.name ).attr( _position );
                        _text.dir = _item.dir; _text.index = _ix;
                        ( _item.dir & 1 ) ? _tmp2.push( _text ) : _tmp1.push( _text );
                    } );
                    $.each( _tmp1, function( _ix, _label ) {
                        _dir = _label.dir;
                        _next = _tmp1[ _ix + ( _dir > 1 ? 1 : -1 ) ];
                        if( _next && _p.isCover( _label, _next ) ) {
                            _bbox = JChart.f.getBBox( _next );
                            _label.attr( {
                                x: _dir > 1 ? (_bbox.x - 5) : (_bbox.x2 + 5),
                                y: (_dir == 0 || _dir == 3) ? (_bbox.y2 + 5) : (_bbox.y - 5)
                            } );
                            _label.change = true;
                        }
                        _labels[ _label.index ] = _label;
                    } );
                    for( var _ix = _tmp2.length - 1; _ix >= 0; _ix-- ) {
                        _cover = false;
                        _label = _tmp2[ _ix ];
                        _dir = _label.dir;
                        _next = _tmp2[ _ix + ( _dir > 1 ? 1 : -1 ) ];
                        if( typeof _next != 'undefined' ) { 
                            for( var _k = _ix; _k < _tmp2.length; _k++ ) {
                                if( _p.isCover( _label, _tmp2[ _k ] ) ) {
                                    _cover = true;
                                    break;
                                }
                            }
                        }
                        if( _cover ) {
                            _bbox = JChart.f.getBBox( _next );
                            var _x = _dir > 1 ? ( _bbox.x - 5 ) : ( _bbox.x2 + 5 ); 
                            var _y = ( _dir == 0 || _dir == 3 ) ? ( _bbox.y2 + 5 ) : ( _bbox.y - 5 );
                            _tbbox = JChart.f.getBBox( _label );
                            ( _x < _c.x || _c.maxX < _x ) && ( _x = ( _dir > 1 ) ? 
                                    ( _c.x + _tbbox.width ) : ( _c.maxX - _tbbox.width ) );
                            _label.attr( { x: _x, y: _y } );
                            _label.change = true;
                        }
                        _labels[ _label.index ] = _label;
                    }
                    _p.sLabels = _labels;
                }
                return _p.sLabels;
            }
        , sLines :
            function( _sLine ) {
                var _p = this, _c = _p.coordinate();
                if( _sLine && typeof _p.sLine == 'undefined' ) {
                    var _tmp, _path, _style, _text, _path, _tpNum = -1, _bbox,
                        _textMargin = 5, _next, _sLabel, _bbox,
                        _position, _item, _dir, _tpArray = [];
                    _p._sLine = []; 
                    _sLabel = _p.sLabel( _sLine );
                    $.each( _sLabel, function( _i, _label ) {
                        _item = _sLine[ _i ];
                        _bbox = JChart.f.getBBox( _label );
                        _dir = _item.dir;
                        _style = _Model.STYLE.style[ _i % _Model.STYLE.style.length ];
                        _path = ' M' + _item.startPoint.x + ' ' + _item.startPoint.y + 
                                ' S' + _item.endPoint.x + ' ' + 
                                ( function() {
                                    var _basey = _item.endPoint.y;
                                    if( typeof _label.change != 'undefined' && _label.change ) {
                                        _basey += ( _label.dir == 0 || _label.dir == 3 ) ? 10 : -10; 
                                    }
                                    return _basey;
                                })() + 
                                ' ' + ( _item.dir > 1 ? _bbox.x2 + 5 : _bbox.x - 5 ) +
                                ' ' + (_bbox.y + _bbox.height / 2);
                        _tmp = _p.stage().path( _path ).attr( { 'stroke': _style.fill } )
                            .translate( .5, .5 );
                        _p._sLine.push( _tmp );
                    } );
                }
                return _p._sLine;
            }
        , tips :
            function( _ix ){
                var _p = this, _c = _p.coordinate(), _items, _text, _val
                    , _len = _c.hlen, _count = 0
                    , _offsetY = 34
                    , _offsetX = 20
                    , _padWidth = 14
                    , _padHeight = 8
                    , _strokeColor = '#000'
                    , _tmp, _tmpBox, _tmpItem, _maxWidth = 0
                    ;

                if( !_p._tips ) {
                    var _initOffset = { x: 10000, y: 0 };
                    //_initOffset.x = 0;
                    _p._tips = new JChart.Group();

                    _p._tips.addChild( 
                        _p.stage().rect( 0 + _initOffset.x, 0 + _initOffset.y, 50, 30, 5 ).attr( { 
                            'stroke': '#999'
                            , 'fill': '#fff' 
                            , 'fill-opacity': .98
                        } )
                    , 'rect' );

                    _p._tips.addChild( _p.stage().text( 10 + _initOffset.x, 14 + _initOffset.y, 'tips' )
                            .attr( { 'font-weight': 'bold', 'fill': '#999', 'text-anchor': 'start' } )
                    , 'title' );

                    _tmp = _p.stage().text( _offsetX + _initOffset.x, _offsetY + _initOffset.y, _p.data().series[0].name || 'empty' )
                            .attr( { 'text-anchor': 'start' } );
                    _tmpBox = JChart.f.getBBox( _tmp );
                    _offsetY += _tmpBox.height + 5;
                    _tmpBox.width > _maxWidth && ( _maxWidth = _tmpBox.width );
                    _p._tips.addChild( _tmp, 'label_0' );

                    _tmpItem = _p._tips.getChildByName( 'label_0' );
                    _tmpBox = JChart.f.getBBox( _tmpItem );
                    _tmp = _p.stage().text( _maxWidth + _offsetX + 10 + _initOffset.x, _tmpItem.attr( 'y' ) + _initOffset.y, '012345678901.00' )
                            .attr( { 'text-anchor': 'start' } );
                    _p._tips.addChild( _tmp, 'val_0' );

                    _tmpItem = _p._tips.getChildByName( 'val_0' );
                    _tmpItem.attr( 'text', '0.00' );

                    _p._tipLabelMaxWidth = _maxWidth;
                }
                if( typeof _ix != 'undefined' ){
                    _p._tips.getChildByName( 'title' ).attr( 'text', _p.tipsTitle( _ix ) );
                    var _maxTextWidth = 0, _tmpLabel;
                    var _fillColor = _Model.STYLE.style[ _ix % _Model.STYLE.style.length ].fill; 
                    _maxTextWidth = JChart.f.getBBox( _p._tips.getChildByName( 'val_' + 0 )
                                    .attr( 'text', JC.f.moneyFormat( _p.series()[ _ix ].y , 3, _p.floatLen() ) )).width;
                    _p._tips.getChildByName( 'rect' ).attr( 'stroke', _fillColor );
                    _p._tips.getChildByName( 'title' ).attr( 'fill', _fillColor );
                    $.each( _p.data().series, function( _k, _item ){
                        _tmp = _p._tips.getChildByName( 'val_' + _k );
                        _tmpLabel = _p._tips.getChildByName( 'label_' + _k );
                        _tmpBox = JChart.f.getBBox( _tmpLabel );
                        _tmp.attr( 'x', _tmpBox.x + _p._tipLabelMaxWidth + 10 + _maxTextWidth - JChart.f.getBBox( _tmp ).width );
                    });
                }
                _p._tips.getChildByName( 'rect' ).attr( { width: 80, height: 50 } );
                _tmpBox = JChart.f.getBBox( _p._tips );
                _p._tips.getChildByName( 'rect' ).attr( { 'width': _tmpBox.width + _padWidth, 'height': _tmpBox.height + _padHeight } );

                return _p._tips;
            }
        /**
         * 获取 tips 标题文本
         */
        , tipsTitle:
            function( _ix ){
                var _p = this, _r = '';
                _p.series() && _p.series().length && _p.series()[ _ix ] &&
                    ( _r = _p.series()[ _ix ].name );
                return _r;
            }

        , tipsLabel:
            function(){
                var _p = this, _r = '';
                _p.data() && _p.data().series && _p.data().series.length &&
                    ( _r = _p.data().series[ 0 ].name );
                return _r;
            }

    });

    JC.f.extendObject( TubularFigure.View.prototype, {
        init :
            function() {

                JC.log( 'TubularFigure.View.init:', new Date().getTime() );
    
                var _p = this;
            }
        , draw :
            function( _data ) {
                var _p = this,
                    _c = _p._model.coordinate( _data ),
                    _d = _p._model.dataBackground();
                _p.setStaticPosition( _c );
                _d.mouseenter( function( _evt ) {
                    TubularFigure.CURRENT_INS = _p;
                    _jdoc.off( 'mousemove', TubularFigure.DEFAULT_MOVE );
                    _jdoc.on( 'mousemove', TubularFigure.DEFAULT_MOVE );
                    _p.trigger( TubularFigure.Model.MOVING_START );
                } );

                _d.mouseleave( function( _evt ) {
                    _p.trigger( TubularFigure.Model.MOVING_DONE );
                    _jdoc.off( 'mousemove', TubularFigure.DEFAULT_MOVE );
                    TubularFigure.CURRENT_INS = null;
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
                if( _c.legend ){
                    _p._model.legend().setPosition( _c.legend.x, _c.legend.y );
                }
                if( _c.sector ) {
                    _p._model.sectors( _c.sector );
                    _p.trigger( 'update_default_selected' );
                }
                if( _c.sLine ) {
                    _p._model.sLines( _c.sLine );
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
            function( _ix, _offset ){
                var _p = this
                    , _tips = _p._model.tips( _ix )
                    , _bbox = JChart.f.getBBox( _tips )
                    , _c = _p._model.coordinate()
                    , _x = _offset.x + 15, _y = _offset.y + 18
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
        });

    _jdoc.ready( function(){
        TubularFigure.autoInit && TubularFigure.init();
    });

    return JC.TubularFigure;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);

