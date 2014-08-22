package org.xas.jchart.common.view.components.SerialLabel
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
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseSerialLabelView extends Sprite
	{	
		public function BaseSerialLabelView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		protected function addToStage( _evt:Event ):void{
		}
		
		protected function showChart( _evt: JChartEvent ):void{
		}
		
		protected function showTips( _evt: JChartEvent ):void{
		}
		
		protected function hideTips( _evt: JChartEvent ):void{		
		}		
		
		protected function updateTips( _evt: JChartEvent ):void{
		}

	}
}