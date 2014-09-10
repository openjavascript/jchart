package org.xas.jchart.common.view.components.ToggleBgView
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
	import org.xas.jchart.common.ui.widget.RectBgLine;
	
	public class CurveGramToggleBgView extends BaseToggleBgView
	{	
		private var _config:Config;
		
		public function CurveGramToggleBgView()
		{
			super(); 
			_config = BaseConfig.ins as Config;
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			addEventListener( JChartEvent.UPDATE, update );
		}
		
		override protected function addToStage( _evt:Event ):void{
		}

		override protected function update( _evt:JChartEvent ):void{
			if( !( _config.c && _config.c.hpointReal )  ) return;
			var _p:CurveGramToggleBgView = this;
			
			Common.each( _config.c.hpointReal, function( _k:int, _item:Object ):void{
				var _tmp:Object
				, _hpItem:Object = _item
				, _sp:Point =_item.start as Point
				, _ep:Point = _hpItem.end as Point
				;
				if( !(_k % 2)  ) return;
				if( _k === _config.c.hpointReal.length - 1 ) return;

				//_p.graphics.beginFill( 0xcccccc );
				//_p.graphics.drawRect( _sp.x, _sp.y, _config.c.itemWidth * 2, _config.c.chartHeight );
				
				var _rb:RectBgLine = new RectBgLine( _config.c.itemWidth * 2, _config.c.chartHeight );
					_rb.x = _sp.x;
					_rb.y = _sp.y;
					addChild( _rb );
			});	
		}

	}
}