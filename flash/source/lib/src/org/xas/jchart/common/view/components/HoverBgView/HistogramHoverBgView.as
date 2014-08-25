package org.xas.jchart.common.view.components.HoverBgView
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.config.HistogramConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.HistogramUI;

	public class HistogramHoverBgView extends BaseHoverBgView
	{
		private var _config:HistogramConfig;
		
		public function HistogramHoverBgView()
		{			
			super();
			
			_config = BaseConfig.ins as HistogramConfig;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function update( _evt:JChartEvent ):void{
			
			graphics.clear();
			
			if( !( _config.c && _config.c.rects ) ) return;
			_boxs = new Vector.<Sprite>();
			
			//Log.log( _config.maxValue );
			Common.each( _config.c.rects, function( _k:int, _item:Object ):void{
				
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
					
					Log.printJSON( _item );
				
				/*
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					var _color:uint = _config.itemColor( _sk );
					if( _sitem.value == _config.maxValue ){
						//Log.log( _config.maxValue, _sitem.value );
						if( 'style' in _config.maxItemParams && 'color' in _config.maxItemParams.style ){
							_color = _config.maxItemParams.style.color;
						}
					}
					
					var _item:HistogramUI = new HistogramUI(
						_sitem.x, _sitem.y
						, _sitem.width, _sitem.height
						, _color 
					);
					_item.mouseEnabled = false;
					_box.addChild( _item );
				});
				addChild( _box );
				*/
				_boxs.push( _box );
			});
		}
		
		override protected function showTips( _evt: JChartEvent ):void{
		}
		
		override protected function hideTips( _evt: JChartEvent ):void{	
			return;		
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			_preIndex = -1;
		}		
		
		override protected function updateTips( _evt: JChartEvent ):void{
			return;
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			if( !_boxs[ _ix ] ) return;
			
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].alpha = 1;
			}
			
			_boxs[ _ix ].alpha = .65;
			_preIndex = _ix;
		}
		
	}
}