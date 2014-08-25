package org.xas.jchart.common.view.components.BgLineView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.config.CurveGramConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.*;
	
	public class CurveGramBgLineView extends BaseBgLineView
	{
		private var _items:Vector.<VLineIcon>;
		public function get items():Vector.<VLineIcon>{ return _items; }
		private var _preIndex:int = -1;
		private var _config:CurveGramConfig;
		
		public function CurveGramBgLineView()
		{
			super();
			
			_config = BaseConfig.ins as CurveGramConfig;
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
		}
		
		override public function update():void{
			super.update();				
		}
		
		override protected function drawHLine():void{
			if( !( _config.c && _config.c.vpoint )  ) return;
			
			Common.each( _config.c.vpoint, function( _k:int, _item:Object ):void{
				var _sp:Point =_item.start as Point
				, _ep:Point = _item.end as Point;
				;
				
				graphics.moveTo( _sp.x, _sp.y );
				graphics.lineTo( _ep.x, _ep.y );
				
			});
		}
		
		override protected function drawVLine():void{
			if( !( _config.c && _config.c.hlinePoint && _config.c.hpoint )  ) return;
			//

			_items = new Vector.<VLineIcon>;
			Common.each( _config.c.hpointReal, function( _k:int, _item:Object ):void{
				var _tmp:VLineIcon
				, _hpItem:Object = _item
				, _sp:Point =_item.start as Point
				, _ep:Point = ( _hpItem.end as Point ).clone();
				;
				_ep.y += 1;
				
				addChild( _tmp = new VLineIcon( _sp, _ep ) );
				!BaseConfig.ins.vlineEnabled && ( _tmp.visible = false );
				_items.push( _tmp );
				//graphics.moveTo( _sp.x, _sp.y );
				//graphics.lineTo( _ep.x, _ep.y );
			});	
		}
		
		override protected function drawLineArrow():void{
		}
		
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{	
			
			if( _preIndex >= 0 ){
				_items[ _preIndex ].unhover();
				!BaseConfig.ins.vlineEnabled && ( _items[ _preIndex ].visible = false );
			}
			_preIndex = -1;
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _items && _items.length ) ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ){
				_items[ _preIndex ].unhover();
				!BaseConfig.ins.vlineEnabled && ( _items[ _preIndex ].visible = false );
			}
			_ix >= 0 && _items[ _ix ].hover();
			!BaseConfig.ins.vlineEnabled && ( _items[ _ix ].visible = true );
			
			_preIndex = _ix;
			
		}
	}
}