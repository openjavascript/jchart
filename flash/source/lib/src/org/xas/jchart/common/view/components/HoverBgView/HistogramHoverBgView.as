package org.xas.jchart.common.view.components.HoverBgView
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.HistogramUI;

	public class HistogramHoverBgView extends BaseHoverBgView
	{
		private var _config:Config;
		
		public function HistogramHoverBgView()
		{			
			super();
			
			_config = BaseConfig.ins as Config;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function update( _evt:JChartEvent ):void{
			
			graphics.clear();
			
			if( !( _config.c && _config.c.dataRect ) ) return;
			_boxs = new Vector.<Sprite>();
			
			//Log.log( _config.maxValue );
			Common.each( _config.c.dataRect, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite()
					, _bgColor:uint = 0xF0F0F0
					, _borderColor:uint = 0xB4B4B4
					, _borderWidth:uint = 2
					;
				
				( 'bgColor' in _config.hoverBgStyle ) && ( _bgColor = _config.hoverBgStyle.bgColor );
				( 'borderColor' in _config.hoverBgStyle ) && ( _borderColor = _config.hoverBgStyle.borderColor );
				( 'borderWidth' in _config.hoverBgStyle ) && ( _borderWidth = _config.hoverBgStyle.borderWidth );
				
				_box.graphics.beginFill( _bgColor );
				_box.graphics.lineStyle( _borderWidth, _borderColor );
				
				//Log.printJSON( _item );
				
				_box.graphics.drawRect( _item.x, _item.y, _item.width, _item.height );
				_box.visible = false;

				_boxs.push( _box );
				addChild( _box );
			});
		}
		
		override protected function showTips( _evt: JChartEvent ):void{
		}
		
		override protected function hideTips( _evt: JChartEvent ):void{	
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].visible = false;
			}
			_preIndex = -1;
		}		
		
		override protected function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			if( !_boxs[ _ix ] ) return;
			
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].visible = false;
			}
			
			_boxs[ _ix ].visible = true;
			_preIndex = _ix;
		}
		
	}
}