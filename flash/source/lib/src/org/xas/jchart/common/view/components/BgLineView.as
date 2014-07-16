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
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
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
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.vpoint )  ) return;
			
			Common.each( BaseConfig.ins.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
					, _ep:Point = _item.end as Point;
					;
				
				//Log.log( _sp.x, _sp.y, _ep.x, _ep.y );
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});
		}
		
		private function drawVLine():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hpoint && BaseConfig.ins.c.hlinePoint )  ) return;
			
			Common.each( BaseConfig.ins.c.hpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				//Log.log( _sp.x, _sp.y, _ep.x, _ep.y );
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});		
			
			Common.each( BaseConfig.ins.c.hlinePoint, function( _k:int, _item:Object ):void{
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