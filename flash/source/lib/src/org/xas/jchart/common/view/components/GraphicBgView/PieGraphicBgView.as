package org.xas.jchart.common.view.components.GraphicBgView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class PieGraphicBgView extends BaseGraphicBgView
	{	
		public function PieGraphicBgView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			this.graphics.beginFill( 0xffffff );
			this.graphics.lineStyle( 1, 0x999999, .35 );
			this.graphics.drawRect(
				0, 0, BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight 
			);
			this.x = BaseConfig.ins.c.chartX;
			this.y = BaseConfig.ins.c.chartY;
			this.graphics.endFill();
		}


	}
}