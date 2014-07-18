package org.xas.jchart.common.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.LegendItemUI;
	
	public class LegendView extends Sprite
	{	
		private var _items:Vector.<LegendItemUI>;
		
		public function LegendView()
		{
			super();
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			showChart();
		}
		
		private function showChart( ):void{
			this.graphics.clear();
			
			if( !( BaseConfig.ins.chartData && BaseConfig.ins.chartData.series && BaseConfig.ins.chartData.series.length ) ) return;
			var _x:int = 0, _tmp:LegendItemUI;
			
			_items = new Vector.<LegendItemUI>();
			
			Common.each( BaseConfig.ins.chartData.series, function( _k:int, _item:Object ):void{
				addChild( _tmp = new LegendItemUI( _item ) );
				_tmp.addEventListener( JChartEvent.UPDATE_STATUS, onUpdateStatus );
				_tmp.x = _x;
				_items.push( _tmp );
				
				if( _k in BaseConfig.ins.filterData ){
					_tmp.toggle();
				} 
				
				_x = _x + 2 + _tmp.width;
			});
		}
		
		private function onUpdateStatus( _evt:JChartEvent ):void{
			var _selected:Boolean = _evt.data as Boolean
				, _filterObject:Object = {}
				;
			//Log.log( 'onUpdateStatus', _selected );
			Common.each( _items, function( _k:int, _item:LegendItemUI ):void{
				//Log.log( 'selected', _item.selected );
				_item.selected && ( _filterObject[ _k ] = 1 );
			});
			
			dispatchEvent( new JChartEvent( JChartEvent.FILTER_DATA, _filterObject ) );
		}

	}
}