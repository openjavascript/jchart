package org.xas.jchart.piegraph.view.components
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
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.PieGraphUI;
	import org.xas.jchart.common.ui.widget.PiePart;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<PieGraphUI>;
		private var _preIndex:int = -1;
		
		public function GraphicView()
		{
			super(); 
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
			/*
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
			*/
		}
		
		private function addToStage( _evt:Event ):void{
			
			//addChild( new PiePart( new Point( 200, 200 ), 0, 100 ) );
		}
		
		public function update():void{
			
			/*
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.paths && BaseConfig.ins.c.paths.length ) ) return;
			
			graphics.clear();
			_boxs = new Vector.<PieGraphUI>;
			Common.each( BaseConfig.ins.c.paths, function( _k:int, _item:Object ):void{
			
				var _cmd:Vector.<int> = _item.cmd as Vector.<int>
					, _path:Vector.<Number> = _item.path as Vector.<Number>
					, _gitem:PieGraphUI
					;
				
				addChild( _gitem = new PieGraphUI( _cmd, _path, BaseConfig.ins.itemColor( _k ) ) );
				_boxs.push( _gitem );
			});
			*/
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{	
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:PieGraphUI ):void{
					_boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			_preIndex = -1;
			
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
			
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;	
			if( !( _boxs && _boxs.length ) ) return;
			if( _preIndex == _ix ) return;
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:PieGraphUI ):void{
					_preIndex >= 0 && _boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			Common.each( _boxs, function( _k:int, _item:PieGraphUI ):void{
				_ix >= 0 && _boxs[ _k ].items[ _ix ].hover();
			});
			
			_preIndex = _ix;
		}
		
	}
}