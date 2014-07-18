package org.xas.jchart.histogram.view.components
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
	
	public class GraphicView extends Sprite
	{	
		public function GraphicView()
		{
			super(); 
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
		}

		public function update():void{
			
			graphics.clear();
			
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.rects ) ) return;
			Common.each( BaseConfig.ins.c.rects, function( _k:int, _item:Object ):void{
				
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					var _gitem:Sprite = new Sprite();
						_gitem.graphics.beginFill( BaseConfig.ins.itemColor( _sk ), 1 );
										
					_gitem.graphics.drawRect( _sitem.x, _sitem.y, _sitem.width, _sitem.height );
					//Log.printObject( _gitem );
					
					addChild( _gitem );
				});
			});
		}

	}
}