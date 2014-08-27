package org.xas.jchart.common.view.components.ItemBgView
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

	public class HistogramItemBgView extends BaseItemBgView
	{
		private var _config:HistogramConfig;
		
		public function HistogramItemBgView()
		{			
			super();
			
			_config = BaseConfig.ins as HistogramConfig;
		}
		
		override protected function addToStage( _evt:Event ):void{
		}
		
		override protected function update( _evt:JChartEvent ):void{
			graphics.clear();
			
			if( !( _config.c && _config.c.dataRect ) ) return;
			_boxs = new Vector.<Sprite>();
			
			//Log.log( _config.maxValue );
			Common.each( _config.c.rects, function( _k:int, _item:Object ):void{
				
				var _box:Sprite = new Sprite();
				
				Common.each( _item, function( _sk:int, _sitem:Object ):void{
					
					var _spItem:Sprite = new Sprite()
						, _bgColor:uint = 0xEDF1F3
						, _borderColor:uint = 0xEDF1F3
						, _borderWidth:uint = 0
						;
						
					( 'bgColor' in _config.itemBgStyle ) && ( _bgColor = _config.itemBgStyle.bgColor );
					( 'borderColor' in _config.itemBgStyle ) && ( _borderColor = _config.itemBgStyle.borderColor );
					( 'borderWidth' in _config.itemBgStyle ) && ( _borderWidth = _config.itemBgStyle.borderWidth );
					
					_spItem.graphics.beginFill( _bgColor );
					_spItem.graphics.lineStyle( _borderWidth, _borderColor );
					_spItem.graphics.drawRect( _sitem.x, _config.c.chartY, _sitem.width, _config.c.chartHeight );
					//Log.log( _sitem.x, _sitem.width, _config.c.chartY, _config.c.chartHeight  )
					//Log.printJSON( _item );
					//Log.printJSON( _sitem );
					//Log.marker( 'xxxxxxx' );

					_box.addChild( _spItem );
				});
				addChild( _box );
				_boxs.push( _box );
				
			});
		}
		
		override protected function showTips( _evt: JChartEvent ):void{
		}
		
		override protected function hideTips( _evt: JChartEvent ):void{	
			/*
			if( _preIndex >= 0 && _boxs[ _preIndex ] ){
				_boxs[ _preIndex ].visible = false;
			}
			_preIndex = -1;
			*/
		}		
		
		override protected function updateTips( _evt: JChartEvent ):void{
			/*
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
			*/
		}
		
	}
}