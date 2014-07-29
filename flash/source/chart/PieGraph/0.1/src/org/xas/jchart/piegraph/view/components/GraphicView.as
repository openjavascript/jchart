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
		private var _piePart:Vector.<PiePart>;
		
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
			//addChild( new PiePart( new Point( 200, 200 ), 0, 360, 100 ) );
		}
		
		public function update():void{
			
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.piePart && BaseConfig.ins.c.piePart.length ) ) return;
			//Log.log( 'GraphicView update', BaseConfig.ins.c.piePart.length );
			
			graphics.clear();
			_piePart = new Vector.<PiePart>();
			
			Common.each( BaseConfig.ins.c.piePart, function( _k:int, _item:Object ):void{
				var _pp:PiePart = new PiePart( 
										new Point( _item.cx, _item.cy )
										, _item.startAngle, _item.endAngle
										, _item.radius
										, BaseConfig.ins.c.pieLine[ _k ]
									);
				
				addChild( _pp );
				_piePart.push( _pp );
				
				if( BaseConfig.ins.dataLabelEnabled ){
					var _tmp:Sprite = new Sprite()
						, _lineData:Object = BaseConfig.ins.c.pieLine[ _k ]
						, _text:TextField = new TextField()
						;
						
						_tmp.graphics.lineStyle( 1, 0x000000 );
						_tmp.graphics.moveTo( _lineData.start.x, _lineData.start.y );
						_tmp.graphics.curveTo( _lineData.control.x, _lineData.control.y, _lineData.end.x, _lineData.end.y );												
						addChild( _tmp );
						
						_text.text = BaseConfig.ins.displaySeries[ _k ].name;
						_text.autoSize = TextFieldAutoSize.LEFT;
						
						switch( _lineData.direction ){
							case 'top':
							{
								_text.x = _lineData.end.x - _text.width / 2;
								_text.y = _lineData.end.y - 5 - _text.height;
								break;
							}
							case 'left_top':
							{
								_text.x = _lineData.end.x - 5 - _text.width;
								_text.y = _lineData.end.y - _text.height / 2;
								break;
							}
							case 'right_top':
							{
								//_text.attr( { x: , y: , 'text-anchor': 'start' } );
								_text.x = _lineData.end.x + 5;
								_text.y = _lineData.end.y - _text.height / 2;
								break;
							}
							case 'left_bottom':
							{
								//_text.attr( { x: 5, y: , 'text-anchor': 'end' } );
								_text.x = _lineData.end.x - 5 - _text.width;
								_text.y = _lineData.end.y - _text.height / 2;
								break;
							}
							case 'right_bottom':
							{
								//_text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
								_text.x = _lineData.end.x + 5;
								_text.y = _lineData.end.y - _text.height / 2;
								break;
							}
							case 'right':
							{
								//_text.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
								_text.x = _lineData.end.x + 5;
								_text.y = _lineData.end.y - _text.height / 2;
								break;
							}
							case 'bottom':
							{
								//_text.attr( { x: _item.end.x, y: _item.end.y + 5 } );
								_text.x = _lineData.end.x - _text.width / 2;
								_text.y = _lineData.end.y;
								break;
							}
							case 'left':
							{
								//_text.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
								_text.x = _lineData.end.x - 5 - _text.width;
								_text.y = _lineData.end.y - _text.height / 2;
								break;
							}
						}

						
						addChild( _text );
						
						//Log.log( _lineData.start.x, _lineData.start.y, _lineData.end.x, _lineData.end.y );
				}
				//Log.log( _item.cx, _item.cy, _item.startAngle, _item.endAngle, _item.radius );
			});
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