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

	public class HistogramBgLineView extends BaseBgLineView
	{
		public function HistogramBgLineView()
		{
			super();
		}
		
		override public function update():void{			
			super.update();			
		}
		
		override protected function drawHLine():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.vpoint )  ) return;
			
			Common.each( BaseConfig.ins.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});
		}
		
		override protected function drawVLine():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hlinePoint )  ) return;
			
			Common.each( BaseConfig.ins.c.hlinePoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});	
		}
		
		override protected function drawLineArrow():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hpoint )  ) return;
			
			Common.each( BaseConfig.ins.c.hpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});	
		}
	}
}