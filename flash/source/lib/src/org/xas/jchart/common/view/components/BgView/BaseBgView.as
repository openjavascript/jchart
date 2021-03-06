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
	
	public class BaseBgView extends Sprite
	{	
		public function BaseBgView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		protected function addToStage( _evt:Event ):void{
		}
		
		protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			var _bg:uint = 0xcccccc
				, _alpha:Number = .13
				;
			
			if( 'bgColor' in BaseConfig.ins.chartParams ){
				_bg = BaseConfig.ins.chartParams.bgColor;
			}
			if( 'bgAlpha' in BaseConfig.ins.chartParams ){
				_alpha = BaseConfig.ins.chartParams.bgAlpha;
			}
			
			this.graphics.beginFill( _bg, _alpha );
			this.graphics.drawRoundRect( 
				BaseConfig.ins.c.x, BaseConfig.ins.c.y
				, BaseConfig.ins.c.width, BaseConfig.ins.c.height
				, BaseConfig.ins.c.corner, BaseConfig.ins.c.corner 
			);
			this.graphics.endFill();
		}

	}
}