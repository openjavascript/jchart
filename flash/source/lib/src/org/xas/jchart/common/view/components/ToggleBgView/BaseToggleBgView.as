package org.xas.jchart.common.view.components.ToggleBgView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BaseToggleBgView extends Sprite
	{	
		public function BaseToggleBgView()
		{
			super(); 
			
			this.mouseEnabled = false;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );
		}
		
		protected function addToStage( _evt:Event ):void{
		}

		protected function update( _evt:JChartEvent ):void{
		
		}

	}
}