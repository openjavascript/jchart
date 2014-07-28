package org.xas.jchart.common.config
{
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	
	public class PieGraphConfig extends BaseConfig
	{
		public function PieGraphConfig()
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
			
			Log.printJSON( _displaySeries );
			
			
			return this;
		}
	}
}