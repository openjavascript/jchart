package org.xas.jchart.common.view.components
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
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class GraphicBgView extends Sprite
	{	
		public function GraphicBgView()
		{
			super();
		
			addEventListener( JChartEvent.SHOW_CHART, showChart );
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			
			JChartEvent.mouseEnter( this, onMouseEnter );
			JChartEvent.mouseLeave( this, onMouseLeave );
		}
		
		private function showChart( _evt: JChartEvent ):void{
			this.graphics.clear();
			
			this.graphics.beginFill( 0x999999, .3 );
			this.graphics.drawRect(
				0, 0, Config.c.chartWidth, Config.c.chartHeight 
			);
			this.x = Config.c.chartX;
			this.y = Config.c.chartY;
			this.graphics.endFill();
		}
		
		private function onMouseEnter( _evt:MouseEvent ):void{
			//og.log( 'GraphicView mouse onMouseEnter' );
			this.root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			this.root.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, _evt ) );
		}
		
		private function onMouseLeave( _evt:MouseEvent ):void{
			//Log.log( 'GraphicView mouse onMouseLeave' );		
			this.root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt ) );	
		}
		
		private function onMouseMove( _evt:MouseEvent ):void{
			//Log.log( 'GraphicView onMouseMove', new Date().getTime() );
			var _point:Object = { x: _evt.stageX, y: _evt.stageY }
				, _rect:Object = { 
					x: Config.c.chartX
					, y: Config.c.chartY
					, x2: Config.c.chartX + Config.c.chartWidth 
					, y2: Config.c.chartX + Config.c.chartHeight 
				}
				, _ix:int = 0
				;
			if( !Config.pointRectangleIntersection( _point, _rect ) ) return;
			
			_ix = ( _point.x  - _rect.x ) / Config.c.hpart;
		 	_ix < 0 && ( _ix = 0 );
			if( Config.cd && Config.cd.series && Config.cd.series.length && Config.cd.series[0].data ){
				_ix >= Config.cd.series[0].data.length && ( _ix = Config.cd.series[0].data.length - 1 );
			}
					
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _ix } ) );
		}

	}
}