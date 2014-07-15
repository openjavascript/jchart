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
	import org.xas.jchart.common.Config;
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
			
			if( !( Config.chartData && Config.chartData.series && Config.chartData.series.length ) ) return;
			var _x:int = 0, _tmp:LegendItemUI;
			
			_items = new Vector.<LegendItemUI>();
			
			Config.each( Config.chartData.series, function( _k:int, _item:Object ):void{
				addChild( _tmp = new LegendItemUI( _item ) );
				_tmp.x = _x;
				_items.push( _tmp );
				
				_x = _x + 2 + _tmp.width;
			});
		}

	}
}