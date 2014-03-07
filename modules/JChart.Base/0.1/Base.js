;(function(define, _win) { 'use strict'; define( [ 'JChart.Stage' ], function(){
/**
 * 组件用途简述
 *
 *<p><b>require</b>:
 *   <a href='JChart.Stage.html'>JChart.Stage</a>
 *</p>
 *
 *<p><a href='https://github.com/openjavascript/jchart' target='_blank'>JChart Project Site</a>
 *   | <a href='http://jchart.openjavascript.org/docs_api/classes/JChart.Base.html' target='_blank'>API docs</a>
 *   | <a href='../../modules/JChart.Base/0.1/_demo' target='_blank'>demo link</a></p>
 *  
 *<h2>页面只要引用本脚本, 默认会处理 div class="js_compBase"</h2>
 *
 *<h2>可用的 HTML attribute</h2>
 *
 *<dl>
 *    <dt></dt>
 *    <dd><dd>
 *</dl> 
 *
 * @namespace   JChart
 * @class       Base
 * @extends     JC.BaseMVC
 * @constructor
 * @param   {selector|string}   _selector   
 * @version dev 0.1 2014-02-13
 * @author  qiushaowei <suches@btbtd.org> | 75 Team
 * @example
        <h2>JC.Base 示例</h2>
 */
    var _jdoc = $( document ), _jwin = $( window );

    JChart.Base = Base;

    function Base( _selector ){
        _selector && ( _selector = $( _selector ) );

        if( JC.BaseMVC.getInstance( _selector, Base ) ) 
            return JC.BaseMVC.getInstance( _selector, Base );

        JC.BaseMVC.getInstance( _selector, Base, this );

        this._model = new Base.Model( _selector );
        this._view = new Base.View( this._model );

        this._init();

        //JC.log( Base.Model._instanceName, 'all inited', new Date().getTime() );
    }
    JC.BaseMVC.build( Base );

    var _oldInit = Base.prototype._init;

    JC.f.extendObject( Base.prototype, {
        _init:
            function(){
                _oldInit.call( this );

                this.on( 'update', function( _evt, _data ){
                    this._view.update( _data );
                });

                this._initData();
            }

        , _beforeInit:
            function(){
            }

        , _initHanlderEvent:
            function(){
            }

        , _inited:
            function(){
                _p._initData();
            }

        , _initData:
            function(){

                var _data;

                if( this.selector().attr( 'chartScriptData' ) ){
                    _data = JC.f.scriptContent( this._model.selectorProp( 'chartScriptData' ) );
                    _data = eval( '(' + _data + ')' );
                    this.trigger( 'update', [ _data ] );
                }

                return this;
            }
    });

    Base.Model._instanceName = 'JChartBase';
    JC.f.extendObject( Base.Model.prototype, {
        init:
            function(){
                //JC.log( 'Base.Model.init:', new Date().getTime() );
            }

        , width:
            function(){
                var _r = this.selector().prop( 'ffsetWidth' );
                this.is( '[chartWidth]' ) && ( _r = this.intProp( 'chartWidth' ) || _r );
                return _r;
            }

        , height:
            function(){
                var _r = this.selector().prop( 'offsetHeight' );
                this.is( '[chartHeight]' ) && ( _r = this.intProp( 'chartHeight' ) || _r );
                return _r;
            }

        , stage:
            function(){

                if( !this._stage ){
                    this._stage = new JChart.Stage( this.selector()[0], this.width(), this.height() );
                    this._stage.selector();

                    this.background();
                }

                return this._stage;
            }

        , background:
            function(){
                var _corner = 18;
                    
                if( !this._background ){
                    this._background = 
                        this._stage.selector().rect( 0, 0, this.width(), this.height(), _corner );

                    this._background
                        .attr( 'fill-opacity', .35 )
                        .attr( 'fill', '#ccc' )

                        .attr( 'stroke-opacity', .35 )
                        .attr( 'stroke-width', 1 )
                        .attr( 'stroke', '#ccc' )
                        ;
                }

                return this._background;
            }
        
        , data:
            function( _data ){
                typeof _data != 'undefined' && ( this._data = _data );
                return this._data;
            }

        , clear: function(){}

        , legendBox:
            function( _data ){
                if( _data ){
                    var _corner = 5;
                    this._legendBox = this._stage.selector().rect( 0, 0, 300, 28, _corner );

                    this._legendBox
                        .attr( 'stroke-opacity', 1 )
                        .attr( 'stroke-width', 1 )
                        .attr( 'stroke', '#909090' )
                        .translate( .5, .5 )
                        ;

                    this._hasLegendBox = true;
                }

                return this._legendBox;
            }
        , hasLegend: function(){ return this._legendBox; }


        , title:
            function( _title ){
                typeof _title != 'undefined' 
                    && ( this._hasTitle = true )
                    && !this._title 
                    && ( this._title = this.stage().selector().text( 0, 0, _title ) )
                    && ( this._title.node.setAttribute( 'class', 'jcc_title' ) )
                    ;

                return this._title;
            }
        , hasTitle: function(){ return this._hasTitle; }

        , subtitle:
            function( _title ){
                typeof _title != 'undefined' 
                    && ( this._hasSubTitle = true )
                    && !this._subtitle 
                    && ( this._subtitle = this.stage().selector().text( 0, 0, _title ) )
                    && ( this._subtitle.node.setAttribute( 'class', 'jcc_subtitle' ) )
                    ;
                return this._subtitle;
            }
        , hasSubTitle: function(){ return this._hasSubTitle; }

        , vtitle:
            function( _title ){
                typeof _title != 'undefined' 
                    && ( this._hasVTitle= true )
                    && !this._vtitle 
                    && ( this._vtitle = this.stage().selector().text( 0, 0, _title ) )
                    && ( this._vtitle.node.setAttribute( 'class', 'jcc_vtitle' ) )
                    ;
                return this._vtitle;
            }
        , hasVTitle: function(){ return this._hasVTitle; }

        , credit:
            function( _title, _href ){
                typeof _title != 'undefined' 
                    && ( this._hasCredit = true )
                    && !this._credit 
                    && ( this._credit = this.stage().selector().text( 0, 0, _title ) )
                    && ( this._credit.node.setAttribute( 'class', 'jcc_credit' ) )
                    ;

                this._credit && _href 
                    && ( 
                            this._credit.node.setAttribute( 'href', _href ) 
                            , this._credit.node.setAttribute( 'class', 'jcc_credit jcc_pointer jcc_link' ) 
                            , this._credit.node.onclick = function(){ location.href = _href; }
                        );
                return this._credit;
            }
        , hasCredit: function(){ return this._hasCredit; }

    });

    JC.f.extendObject( Base.View.prototype, {
        init:
            function(){
                //JC.log( 'Base.View.init:', new Date().getTime() );
            }

        , width: function(){ return this._model.width(); }
        , height: function(){ return this._model.height(); }

        , selector:
            function(){
                return this._model.selector();
            }

        , clear: 
            function(){
                this.selector().find( 'canvas' ).remove();
            }

        , update: 
            function( _data ){
                this.clear();
                this._model.clear();
                this._model.data( _data );
                this.draw( _data );
            }

        , draw: 
            function( _data ){
                return this;
            }

        , drawLegendBox:
            function( _data ){
                var _rp = this._model.legendBox( _data )
                    , _bbox = _rp.getBBox()
                    , _x = this._model.width() / 2 - 150
                    , _y = this._model.height() - 10 - 28
                    ;
                        ;
                    if( this._model.hasCredit() ){
                        _y -= 10;
                    }

                _rp.attr( 'x', _x ).attr( 'y', _y );

                return this;
            }

        , drawCredit:
            function( _data, _font ){
                if( !( _data && _data.credits && _data.credits.enabled &&
                        ( _data.credits.text || _data.credits.href  )
                    ) ) return this;

                var _text = _data.credits.text || _data.credits.href
                    , _rp = this._model.credit( _text, _data.credits.href )
                    , _bbox = _rp.getBBox()
                    , _x = this._model.width() - _bbox.width
                    , _y = ( this._model.height() ) - 15
                    ;

                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                return this;
            }

        , drawVTitle:
            function( _data, _font ){
                if( !( _data && _data.yAxis && _data.yAxis.title && _data.yAxis.title.text ) ) return this;
                var _rp = this._model.vtitle( _data.yAxis.title.text )
                    , _bbox = _rp.getBBox()
                    , _x = 20
                    , _y = ( this._model.height() ) / 2
                    ;

                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                _rp.rotate( -90 ); 

                return this;
            }

        , drawSubTitle:
            function( _data, _font ){
                if( !( _data && _data.subtitle && _data.subtitle.text ) ) return this;
                var _rp = this._model.subtitle( _data.subtitle.text )
                    , _bbox = _rp.getBBox()
                    , _x = ( this._model.width()  ) / 2
                    , _y = 20
                    ;
                if( this._model.hasTitle() ){
                    var _titleRp = this._model.title().getBBox();
                    _y = _titleRp.y2 + 10;
                }
                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                return this;
              }

        , drawTitle:
            function( _data, _font ){
                if( !( _data && _data.title && _data.title.text) ) return this;
                var _rp = this._model.title( _data.title.text )
                    , _bbox = _rp.getBBox()
                    , _x = ( this._model.width()  ) / 2
                    , _y = 20
                    ;
                _rp.attr( 'x', _x );
                _rp.attr( 'y', _y );

                return this;
              }

        , stage: function(){ return this._model.stage(); }
    });

    return JChart.Base;
});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
