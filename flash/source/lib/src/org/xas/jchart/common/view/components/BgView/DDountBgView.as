package org.xas.jchart.common.view.components.BgView
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
	
	public class DDountBgView extends BaseBgView
	{	
		public function DDountBgView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		override protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			this.graphics.beginFill( 0xffffff, 1 );
			this.graphics.drawRoundRect( 
				BaseConfig.ins.c.x, BaseConfig.ins.c.y
				, BaseConfig.ins.c.width, BaseConfig.ins.c.height
				, BaseConfig.ins.c.corner, BaseConfig.ins.c.corner 
			);
			this.graphics.endFill();
		}

	}
}