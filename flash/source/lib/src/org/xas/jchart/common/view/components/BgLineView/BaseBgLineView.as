package org.xas.jchart.common.view.components.BgLineView
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
	
	public class BaseBgLineView extends Sprite
	{	
		public function BaseBgLineView()
		{
			super(); 
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		protected function addToStage( _evt:Event ):void{
		}

		public function update():void{
			
			this.graphics.clear();
			this.graphics.lineStyle( 1, 0x999999 );
			
			this.drawHLine();
			this.drawVLine();
			this.drawLineArrow();			
		}
		
		protected function drawHLine():void{

		}
		
		protected function drawVLine():void{

		}
		
		protected function drawLineArrow():void{

		}

	}
}