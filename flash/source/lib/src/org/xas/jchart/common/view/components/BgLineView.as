package org.xas.jchart.common.view.components
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
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class BgLineView extends Sprite
	{	
		public function BgLineView()
		{
			super(); 
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
		}

		public function update():void{
			
			this.graphics.clear();
			this.graphics.lineStyle( 1, 0x999999 );
			
			this.drawHLine();
			this.drawVLine();
			this.drawLineArrow();			
		}
		
		private function drawHLine():void{
			if( !( Config.c && Config.c.vpoint )  ) return;
			
			Config.each( Config.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point;
					;
				
				//Log.log( _sp.x, _sp.y, _ep.x, _ep.y );
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});
		}
		
		private function drawVLine():void{
			if( !( Config.c && Config.c.hpoint && Config.c.hlinePoint )  ) return;
			
			Config.each( Config.c.hpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				//Log.log( _sp.x, _sp.y, _ep.x, _ep.y );
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});		
			
			Config.each( Config.c.hlinePoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				//Log.log( _sp.x, _sp.y, _ep.x, _ep.y );
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});
		}
		
		private function drawLineArrow():void{
			
		}

	}
}