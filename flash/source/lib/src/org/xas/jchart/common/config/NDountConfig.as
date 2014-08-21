package org.xas.jchart.common.config
{
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	
	public class NDountConfig extends BaseConfig
	{
		public function NDountConfig()
		{
			super();
		}
		
		private var _pseries:Array = [];
		
		override public function setChartData(_d:Object):Object{
			super.setChartData( _d );
			
			_pseries = [];
			
			if( this.cd.series && this.cd.series.length ){
				Common.each( this.cd.series[0].data, function( _k:int, _item: * ):void{
					var _o:Object, _a:Array = _item as Array;
					if( !_a ){
						_o = _item as Object;
					}else{
						_o = { 'name': _a[0], 'y': _a[1] };
					}
					_pseries.push( _o );
				});
				//Log.printJSON( _pseries );
			}
			
			return this.chartData;
		}
		
		override public function get series():Array{
			
			return _pseries;
		}
		
		override public function updateDisplaySeries( _filter:Object = null, _data:Object = null ):BaseConfig{
			_data = _data || chartData;
			if( !( _data && _data.series && _data.series.length ) ) return this;
			var _tmpSeries:Array = JSON.parse( JSON.stringify( _data.series ) ) as Array
				;
			
			_displaySeries = []
			//Log.printJSON( _tmpSeries[0].data );
			
			Common.each( _tmpSeries[0].data, function( _k:int, _item: * ):void{
				var _o:Object, _a:Array = _item as Array;
				if( !_a ){
					_o = _item as Object;
				}else{
					_o = { 'name': _a[0], 'y': _a[1] };
				}
				_displaySeries.push( _o );
			});			
			
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
			
			//Log.printJSON( _displaySeries );			
			
			return this;
		}
		
		override public function get totalNum():Number{
			var _r:Number = 0;
			
			if( this.isPercent ){
				_r = 100;
			}else{
				Common.each( _displaySeries, function( _k:int, _item:Object ):void{
					_r += _item.y;
				});
			}
			
			return _r;
		}
		
		override public function get itemName():String{
			var _r:String = '';
			cd && cd.series && cd.series.length && ( _r = cd.series[0].name || '' );
			return _r;
		}
		
		override public function get floatLen():int{
			
			if( _isFloatLenReady ){
				return _floatLen;
			}
			_isFloatLenReady = true;
			
			if( cd && ( 'floatLen' in cd ) ){
				_floatLen = cd.floatLen;
				Log.log( 1 );
			}else{
				_floatLen = 0;
				var _tmpLen:int = 0;
				Common.each( series, function( _k:int, _item:Object ):void{
					_tmpLen = Common.floatLen( _item.y );
					_tmpLen > _floatLen && ( _floatLen = _tmpLen );
				});
			}
			_floatLen == 1 && ( _floatLen = 2 );
			
			return _floatLen;
		}
		
		override public function get legendEnabled():Boolean{
			var _r:Boolean = false;
			
			if( cd && cd.legend && ( 'enabled' in cd.legend ) ){
				_r = StringUtils.parseBool( cd.legend.enabled );
			}
			
			return _r;
		}
		
		override public function get dataLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.ndount
				&& cd.plotOptions.ndount.dataLabels
				&& ( 'enabled' in cd.plotOptions.ndount.dataLabels )
				&& ( _r = cd.plotOptions.ndount.dataLabels.enabled );
			
			return _r;
		}
		
		override public function get cdataLabelEnabled():Boolean{
			var _r:Boolean = false;
			//return false;
			cd 
			&& cd.plotOptions
				&& cd.plotOptions.ndount
				&& cd.plotOptions.ndount.cdataLabels
				&& ( 'enabled' in cd.plotOptions.ndount.cdataLabels )
				&& ( _r = cd.plotOptions.ndount.cdataLabels.enabled );
			
			return _r;
		}
		
		public function get radiusStep():Number{
			var _r:Number = 8;
			cd 
			&& cd.radiusStep
				&& ( _r = cd.radiusStep);
			return _r;
		}
	}
}