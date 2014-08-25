package org.xas.jchart.common
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.DefaultOptions;

	public class BaseConfig
	{
		protected static var _ins:BaseConfig;
		public static function setIns( _ins:BaseConfig ):BaseConfig{
			return BaseConfig._ins = _ins;
		}
		
		public static function get ins():BaseConfig{
			return BaseConfig._ins;	
		}
		
		protected var _debug:Boolean = false;		
		public function setDebug( _d:Boolean ):Boolean {
			Log.debug = _d;
			return _debug = _d;
		}		
		public function get debug():Object {
			return _debug;
		}
		
		protected var _params:Object;
		public function setParams( _d:Object ):Object {	return _params = _d; }		
		public function get params():Object { return _params;	}		
		public function get p():Object { return _params;	}
	
		protected var _displaySeries:Array;
		public function get displaySeries():Array{
			return _displaySeries;	
		}
		public function updateDisplaySeries( _filter:Object = null, _data:Object = null ):BaseConfig{
			_data = _data || chartData;
			if( !( _data && _data.series && _data.series.length ) ) return this;
			_displaySeries = JSON.parse( JSON.stringify( _data.series ) ) as Array;
			_displaySeriesIndexMap = null;
			if( _filter ){
				var _tmp:Array = [], _count:int = 0;
				_displaySeriesIndexMap = {};
				Common.each( _displaySeries, function( _k:int, _item:Object ):void{
					if( !(_k in _filter) ){
						_tmp.push( _item );	
						_displaySeriesIndexMap[ _count++ ] = _k;
					}
				});
				_displaySeries = _tmp;
			}
			_filterData = _filter || {};
			
			return this;
		}
		protected var _displaySeriesIndexMap:Object;
		public function get displaySeriesIndexMap():Object{ return _displaySeriesIndexMap; }
		
		public function get tooltipSerial():Array{
			var _r:Array = [];
			
			//Log.log( 'tooltipSerial xxx ' );
			
			this.cd
				&& this.cd.tooltip
				&& this.cd.tooltip.serial
				&& this.cd.tooltip.serial.length
				&& ( _r = this.cd.tooltip.serial )
				;
			
			return _r;
		}
		
		protected var _filterData:Object;
		public function get filterData():Object{
			return _filterData;	
		}	
		
		protected var _chartData:Object;
		public function setChartData( _d:Object ):Object { 
			reset();
			_chartData = _d;
			calcRate();		
			calcLabelDisplayIndex();
			return _d;
		}		
		public function get chartData():Object { return _chartData; }	
		public function get cd():Object {	return _chartData; }
		public function get rateZeroIndex():int{ return _rateZeroIndex; }
		protected var _rateZeroIndex:int = 0; 
		
		protected var _absNum:Number;
		protected var _finalMaxNum:Number;
		public function get finalMaxNum():Number{ return _finalMaxNum; }
		
		protected var _rate:Array;
		public function get rate():Array{ return _rate; }
		
		protected var _maxNum:Number = 0;
		public function get maxNum():Number{ return _maxNum; }
		
		
		public function get chartMaxNum():Number{
			return finalMaxNum * rate[0];
		}
		
		protected var _minNum:Number = 0;
		public function get minNum():Number{ return _minNum; }
		protected function calcminNum():Number{
			var _r:Number = 0, _tmp:Array;
			if( this.isPercent ) return 0;
			if( cd && cd.series ){
				_tmp = [];
				Common.each( displaySeries, function( _k:int, _item:Number ):*{
					_tmp = _tmp.concat( displaySeries[ _k ].data );
				});
				_tmp.length && ( _r = Math.min.apply( null, _tmp ) );
				
				_r > 0 && ( _r = 0 );
				_r < 0 && ( _r = -Common.numberUp( Math.abs( _r ) ) );
			}
			return _r;
		}

		
		protected var _floatLen:int = 0;
		protected var _isFloatLenReady:Boolean = false;
		public function get floatLen():int{
			
			if( _isFloatLenReady ){
				return _floatLen;
			}
			_isFloatLenReady = true;
			
			if( cd && ( 'floatLen' in cd ) ){
				_floatLen = cd.floatLen;
			}else{
				_floatLen = 0;
				var _tmpLen:int = 0;
				Common.each( series, function( _k:int, _item:Object ):void{
					Common.each( _item.data, function( _sk:int, _sitem:Number ):void{
						_tmpLen = Common.floatLen( _sitem );
						_tmpLen > _floatLen && ( _floatLen = _tmpLen );
						//Log.log( _tmpLen, _floatLen );
					});
				});
			}
			_floatLen == 1 && ( _floatLen = 2 );
			
			return _floatLen;
		}

					
		protected var _root:DisplayObject;
		public function get root():DisplayObject{ return _root; }
		public function setRoot( _d:* ):DisplayObject{
			_root = _d as DisplayObject;
			_width = _root.stage.stageWidth;
			_height = _root.stage.stageHeight;
			return _root;
		}
		
		protected var _width:uint;
		public function get width():uint{ return _width; }
		
		protected var _height:uint;
		public function get height():uint{ return _height; }
		
		protected var _coordinate:Coordinate
		public function get c():Coordinate{ return _coordinate; }
		public function get coordinate():Coordinate{	return _coordinate;	}
		public function setCoordinate( _d:Coordinate ):Coordinate{
			_coordinate = _d;
			c.width = width;
			c.height = height;
			c.x = 0;
			c.y = 0;
			return _coordinate;
		}
		
		public function get categories():Array{
			var _r:Array = [];
			if( cd && cd.xAxis && cd.xAxis.categories ){
				_r = cd.xAxis.categories;
			}
			return _r;
		}
		
		public function get tipsHeader():Array{
			var _r:Array = [];
			if( cd && cd.xAxis && cd.xAxis.tipsHeader ){
				_r = cd.xAxis.tipsHeader;
			}
			return _r;
		}
		
		
		public function getTipsHeader( _ix:int ):String{
			var _r:String = this.tipsHeader[ _ix ] || this.categories[ _ix ] || '';
			return _r;
		}
		
		public function get tipTitlePostfix():String{
			var _r:String = '{0}';
			if( cd && cd.xAxis && ( 'tipTitlePostfix' in  cd.xAxis ) ){
				_r = cd.xAxis.tipTitlePostfix;
			}
			return _r;
		}
		
		public function get series():Array{
			var _r:Array = [];
			if( cd && cd.series && cd.series.length ){
				_r = cd.series;
			}
			return _r;
		}
		
		public function get legendEnabled():Boolean{
			var _r:Boolean = true;
			
			if( cd && cd.legend && ( 'enabled' in cd.legend ) ){
				_r = StringUtils.parseBool( cd.legend.enabled );
			}
			
			return _r;
		}
		
		public function get rateLabelEnabled():Boolean{
			var _r:Boolean = true;
			
			if( cd && cd.rateLabel && ( 'enabled' in cd.rateLabel ) ){
				_r = StringUtils.parseBool( cd.rateLabel.enabled );
			}
			
			return _r;
		}
		
		public function get dataLabelEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.pie
				&& cd.plotOptions.pie.dataLabels
				&& ( 'enabled' in cd.plotOptions.pie.dataLabels )
				&& ( _r = cd.plotOptions.pie.dataLabels.enabled );
			
			return _r;
		}
		
		public function get dataLabelFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.dataLabels
				&& ( 'format' in cd.dataLabels )
				&& ( _r = cd.dataLabels.format );
			
			return _r;
		}
		
		public function get yAxisFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.yAxis
				&& ( 'format' in cd.yAxis )
				&& ( _r = cd.yAxis.format );
			
			return _r;
		}
		
		public function get tooltipPointFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.tooltip
				&& ( 'pointFormat' in cd.tooltip )
				&& ( _r = cd.tooltip.pointFormat );
			
			return _r;
		}
		
		public function get tooltipHeaderFormat():String{
			var _r:String = "{0}";
			cd 
			&& cd.tooltip
				&& ( 'headerFormat' in cd.tooltip )
				&& ( _r = cd.tooltip.headerFormat );
			
			return _r;
		}
		
		public function get xAxisWordwrap():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
			&& cd.xAxis
				&& ( 'wordwrap' in cd.xAxis )
				&& ( _r = StringUtils.parseBool( cd.xAxis.wordwrap ) );
			
			return _r;
		}
		
		public function get serialLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.dataLabels
				&& ( 'enabled' in cd.dataLabels )
				&& ( _r = StringUtils.parseBool( cd.dataLabels.enabled ) );
			
			return _r;
		}
		
		public function get vlineEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
			&& cd.vline
				&& ( 'enabled' in cd.vline )
				&& ( _r = StringUtils.parseBool( cd.vline.enabled ) );
			
			return _r;
		}
		
		public function get hlineEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			cd 
			&& cd.hline
				&& ( 'enabled' in cd.hline )
				&& ( _r = StringUtils.parseBool( cd.hline.enabled ) );
			
			return _r;
		}
		
		public function get tooltipEnabled():Boolean{
			var _r:Boolean = true;
			//return false;
			//Log.printJSON( cd.tooltip );
			cd 
			&& cd.tooltip
				&& ( 'enabled' in cd.tooltip )
				&& ( _r = StringUtils.parseBool( cd.tooltip.enabled ) );
			
			return _r;
		}
		
		public function get cdataLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.dount
				&& cd.plotOptions.dount.cdataLabels
				&& ( 'enabled' in cd.plotOptions.dount.cdataLabels )
				&& ( _r = cd.plotOptions.dount.cdataLabels.enabled );
			
			return _r;
		}
		
		protected function calcMaxNum():Number{
			var _r:Number = 0, _tmp:Array;
			
			if( this.isPercent ){
				if( cd && cd.series ){
					_tmp = [];
					Common.each( displaySeries, function( _k:int, _item:Object ):*{
						if( _item.data ){
							Common.each( _item.data, function( _sk:int, _item:Number ):void{
								_r += _item;	
							});
						}
					});
				}
			}else{
				if( cd && cd.series ){
					_tmp = [];
					Common.each( displaySeries, function( _k:int, _item:Number ):*{
						_tmp = _tmp.concat( displaySeries[ _k ].data );
					});
					_tmp.length && ( _r = Math.max.apply( null, _tmp ) );
				}
				
				_r < 0 && ( _r = 0 );
				
				_r > 0 && _r && ( _r = Common.numberUp( _r ) );
			}
			
			this.rateMaxValue && ( _r = this.rateMaxValue );
				
			_r === 0 && ( _r = 10 );
			return _r;
		}
		
		
		public function calcRate():void{
			var _data:Object = _chartData;
			_rate = [];
			if( !_data ) return;
			
			_maxNum = calcMaxNum();
			_minNum = calcminNum();
			_absNum = Math.abs( _minNum );
			_finalMaxNum = Math.max( _maxNum, _absNum );
			
			if( _data && Common.hasNegative( displaySeries ) ){				
				if( _maxNum > _absNum ){
					if( Math.abs( _finalMaxNum * 0.333333333333333 ) > _absNum ){
						_rate = [ 1, 0.666666666666666, 0.333333333333333, 0, -0.333333333333333];
						_rateZeroIndex = 3;
					}
				}else{
					if( _maxNum == 0 ){
						_rate = [ 0, -0.25, -0.5, -0.75, -1 ];
						_rateZeroIndex = 0;
					}else if( Math.abs( _finalMaxNum * 0.333333333333333 ) > _maxNum ){
						_rate = [ 0.333333333333333, 0, -0.333333333333333, -0.666666666666666, -1 ];
						_rateZeroIndex = 1;
					}
				}
				if( !_rate.length ){
					_rate = [ 1, .5, 0, -.5, -1 ];
					_rateZeroIndex = 2;
				} 
				
			}else{
				_rate = [1, .75, .5, .25, 0 ];
				_rateZeroIndex = 4;
			}
			
			_realRate = [];
			_realRateFloatLen = 0;
			var _tmpLen:int = 0, _rateValue:Number = _finalMaxNum;
			if( this.isPercent ){
				_rateValue = 100;
			}
			this.rateMaxValue && ( _rateValue = this.rateMaxValue );
			
			Common.each( _rate, function( _k:int, _item:Number ):void{
				var _realItem:Number = _rateValue * _item;
					_realItem = Common.parseFinance( _realItem, 10 );
					
					if( Common.isFloat( _realItem ) ){
						_tmpLen = _realItem.toString().split( '.' )[1].length;
						_tmpLen > _realRateFloatLen && ( _realRateFloatLen = _tmpLen );
					}
				_realRate.push( _realItem );
				//Log.log( _realItem );
			});
		}
		
		public function get rateMaxValue():Number{
			var _r:Number = 0;
			this.cd && this.cd.rateLabel && ( 'maxvalue' in this.cd.rateLabel )
				&& ( _r = this.cd.rateLabel.maxvalue );
			return _r;
		}
		
		private var _realRate:Array;
		public function get realRate():Array{ return _realRate; }
		
		private var _realRateFloatLen:int;
		public function get realRateFloatLen():int{ return _realRateFloatLen; }
		
		public function get titleStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.xAxis
				&& chartData.xAxis.title
				&& chartData.xAxis.title.style
				&& ( _r = chartData.xAxis.title.style )
				;
			return _r;
		}
		public function get labelsStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.xAxis
				&& chartData.xAxis.labels
				&& chartData.xAxis.labels.style
				&& ( _r = chartData.xAxis.labels.style )
				;
			return _r;
		}
		
		public function get vtitleStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.yAxis
				&& chartData.yAxis.title
				&& chartData.yAxis.title.style
				&& ( _r = chartData.yAxis.title.style )
				;
			return _r;
		}
		
		public function get vlabelsStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.yAxis
				&& chartData.yAxis.labels
				&& chartData.yAxis.labels.style
				&& ( _r = chartData.yAxis.labels.style )
				;
			return _r;
		}
		
		public function get subtitleStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.subtitle
				&& chartData.subtitle.style
				&& ( _r = chartData.subtitle.style )
				;
			return _r;
		}
		
		public function get creditsStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.credits
				&& chartData.credits.style
				&& ( _r = chartData.credits.style )
				;
			return _r;
		}
		
		public function get legendItemStyle():Object{
			var _r:Object = {};
			chartData 
			&& chartData.legend
				&& chartData.legend.itemStyle
				&& ( _r = chartData.legend.itemStyle )
				;
			return _r;
		}
		
		public function itemColor( _ix:uint, _fixColorIndex:Boolean = true ):uint{
			var _r:uint = 0, _colors:Array = colors;
			
			if( _fixColorIndex && displaySeriesIndexMap && ( _ix in displaySeriesIndexMap ) ){
				//Log.log( 'find', _ix, filterData[ _ix ] );
				//_ix = _filterData[ _ix ];
				_ix = displaySeriesIndexMap[ _ix ];
			}
				
			_r = _colors[ _ix % ( _colors.length ) ];			
			return _r;
		}
		
		public function get colors():Array{
			var _r:Array = DefaultOptions.colors;
			
			chartData 
			&& chartData.colors
				&& chartData.colors.length
				&& ( _r = chartData.colors );
			
			return _r;
		}
		
		public function get displayAllLabel():Boolean{
			var _r:Boolean = true;
			chartData 
				&& ( 'displayAllLabel' in chartData )
				&& ( _r = chartData[ 'displayAllLabel' ] );
			return _r;
		}
		
		/**
		 * 获取要显示的水平标签索引位置
		 * 如果返回 undefined, 将显示全部
		 */
		protected function calcLabelDisplayIndex():void{
			var _tmp:Number, _len:int = categories.length;
			_labelDisplayIndex = {};
			if( !displayAllLabel ){
				_labelDisplayIndex[ 0 ] = true;
				_labelDisplayIndex[ _len - 1 ] = true;
				
				_tmp = Math.ceil( _len / 3 );
				
				_labelDisplayIndex[ Math.floor( _tmp * 1 ) - 1 ] = true;
				_labelDisplayIndex[ Math.floor( _tmp * 2 ) - 1 ] = true;
			}
		}
		protected var _labelDisplayIndex:Object = {};
		public function get labelDisplayIndex():Object{ return _labelDisplayIndex; }
		
		public function get offsetAngle():Number{
			var _r:Number = 270;
			
			cd 
				&& ( 'offsetAngle' in cd )
				&& ( _r = cd.offsetAngle );
			
			return _r;
		}
		public function get totalNum():Number{
			return 0;
		}
		
		protected var _selected:int = -1;
		public function get selected():int{ return _selected; }
		public function set selected( _setter:int ):void{ _selected = _setter; }
		public function get itemName():String{ return ''; }
		
		public function clearData():BaseConfig{
			_displaySeries = [];
			_displaySeriesIndexMap = {};
			_filterData = {};
			_chartData = {};
			
			return this;
		}
		
		public function get isPercent():Boolean{
			return StringUtils.parseBool( this.cd.isPercent );
		}
		
		private var _maxValue:Number = 0;
		private var _isMaxValueReady:Boolean;
		
		public function get maxValue():Number{
			if( !_isMaxValueReady && this.series && this.series.length ){
				_isMaxValueReady = true;
				
				Common.each( this.displaySeries, function( _k:int, _item:Object ):void{
					Common.each( _item.data, function( _sk:int, _sitem:Number ):void{
						_sitem > _maxValue && ( _maxValue = _sitem );
					});
				});
			}
			
			return _maxValue;
		}		
		
		public function get maxItemParams():Object{
			var _r:Object = {};
			
			this.cd 
				&& this.cd.maxItem
				&& ( _r = this.cd.maxItem );
			
			return _r;
		}
		
		public function get chartParams():Object{
			var _r:Object = {};
			
			this.cd 
				&& this.cd.chart
				&& ( _r = this.cd.chart );
			
			return _r;
		}
		
		public function get hoverBgParams():Object{
			var _r:Object = {};
			
			this.cd 
				&& this.cd.hoverBg
				&& ( _r = this.cd.hoverBg );
			
			return _r;
		}
		
		public function get hoverBgStyle():Object{
			var _r:Object = {};
			
			if( 'style' in this.hoverBgParams  ){
				_r = StringUtils.parseBool( this.hoverBgParams.style );
			}
			
			return _r;
		}
		
		public function get hoverBgEnabled():Boolean{
			var _r:Boolean = false;
			
			if( 'enabled' in this.hoverBgParams  ){
				_r = StringUtils.parseBool( this.hoverBgParams.enabled );
			}
			
			return _r;
		}
		
		public function get vlabelSpace():Number{
			var _r:Number = this.c.vlabelSpace || 4;
			return _r;
		}
		
		public function reset():void{
			_isFloatLenReady = false;
			_isMaxValueReady = false;
			_maxValue = 0;
		}
				
		public function BaseConfig()
		{
		}
	}
}