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
	
	public class BgView extends Sprite
	{	
		public function BgView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
		}
		
		private function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			this.graphics.beginFill( 0x999999, .3 );
			this.graphics.drawRoundRect( Config.c.x, Config.c.y, Config.c.width, Config.c.height, Config.c.corner, Config.c.corner );
			this.graphics.endFill();
		}

	}
}