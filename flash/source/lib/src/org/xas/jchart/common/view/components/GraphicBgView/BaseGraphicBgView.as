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
	
	public class BaseGraphicBgView extends Sprite
	{	
		public function BaseGraphicBgView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		protected function addToStage( _evt:Event ):void{
			
			JChartEvent.mouseEnter( this, onMouseEnter );
			JChartEvent.mouseLeave( this, onMouseLeave );
		}
		
		protected function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			this.graphics.beginFill( 0xffffff, .01 );
			this.graphics.drawRect(
				0, 0, BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight 
			);
			this.x = BaseConfig.ins.c.chartX;
			this.y = BaseConfig.ins.c.chartY;
			this.graphics.endFill();
		}
		
		protected function onMouseEnter( _evt:MouseEvent ):void{
			Log.log( 'GraphicView mouse onMouseEnter' );
			this.root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			this.root.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, _evt ) );
		}
		
		protected function onMouseLeave( _evt:MouseEvent ):void{
			Log.log( 'GraphicView mouse onMouseLeave' );		
			this.root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt ) );	
		}
		
		protected function onMouseMove( _evt:MouseEvent ):void{
		}

	}
}