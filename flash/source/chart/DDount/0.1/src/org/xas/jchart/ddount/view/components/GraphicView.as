package org.xas.jchart.ddount.view.components
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
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.DDountUI;
	import org.xas.jchart.common.ui.widget.DDountPart;
	import org.xas.jchart.common.ui.widget.PiePart;
	
	public class GraphicView extends Sprite
	{	
		private var _boxs:Vector.<DDountUI>;
		
		private var _preIndex:int = -1;
		private var _piePart:Vector.<DDountPart>;
		
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
			_piePart = new Vector.<DDountPart>();
			
			Common.each( BaseConfig.ins.c.piePart, function( _k:int, _item:Object ):void{
				/*
				var _pp:PiePart = new PiePart( 
										new Point( _item.cx, _item.cy )
										, _item.startAngle, _item.endAngle
										, _item.radius
										, _k
										, { 'color': BaseConfig.ins.itemColor( _k ) }
									);
				*/
				var _pp:DDountPart = new DDountPart(
					new Point( _item.cx, _item.cy )
					, _item.startAngle, _item.endAngle
					, _item.radius, _item.radius - 19, _item.radius - 26, _item.radius - 26 - 1
					, _k
					, { 'color': BaseConfig.ins.itemColor( _k ) }
					, {}
				);
				_pp.addEventListener( JChartEvent.UPDATE_STATUS, onPiePartUpdateStatus );
				_pp.addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
				_pp.addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
				_pp.addEventListener( MouseEvent.CLICK, onMouseClick );
				addChild( _pp );
				//_pp.x = 10000;
				_piePart.push( _pp );
				
				//Log.log( _item.cx, _item.cy, _item.startAngle, _item.endAngle, _item.radius );
			});
			
			if( BaseConfig.ins.c.piePart.length > 1 ){
				Common.each( BaseConfig.ins.c.piePart, function( _k:int, _item:Object ):void{
					var _spaceLine:Sprite = new Sprite()
						, _ePoint:Point
						;
					_ePoint = GeoUtils.moveByAngle( _item.endAngle, new Point( _item.cx, _item.cy ), _item.radius );
						
					_spaceLine.graphics.lineStyle( 4, 0xffffff );
					_spaceLine.graphics.moveTo( _item.cx, _item.cy );
					_spaceLine.graphics.lineTo( _ePoint.x, _ePoint.y );					
					addChild( _spaceLine );
				});	
			}
						
			var _selectedIndex:int = -1;
			Common.each( BaseConfig.ins.displaySeries, function( _k:int, _item:Object ):void{
				if( _item.selected ){
					_selectedIndex = _k;
				}
			});
			
			//Log.log( _selectedIndex );
			if( BaseConfig.ins.selected >= 0 ){
				_selectedIndex = BaseConfig.ins.selected;
			}
			
			if( _selectedIndex >= 0 && _selectedIndex <= (_piePart.length - 1 ) && _piePart.length > 1 ){
				//_piePart[ _selectedIndex ].selected( true );
			}
			/*
			var _part:DDountPart = new DDountPart(
					new Point( BaseConfig.ins.c.cx, BaseConfig.ins.c.cy )
					, 0, 90
					, 200, 200 - 20, 200 - 28, 200 - 28 - 2
					, 0
					, { 'color': BaseConfig.ins.itemColor( 0 ) }
					, {}
					, 270
				);
			addChild( _part );
			*/
		}
				
		protected function onMouseOver( _evt:MouseEvent ):void{
			
			root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, _evt ) );
			//Log.log( 'show tips' );
			
		}
		
		protected function onMouseOut( _evt:MouseEvent ):void{
			try{
				root.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, _evt ) );
			}catch( ex:Error ){}
			//Log.log( 'hide tips' );
			
		}
		
		protected function onMouseClick( _evt:MouseEvent ):void{
			var _pp:PiePart = _evt.target as PiePart;
			if( !(　_pp && BaseConfig.ins.displaySeries.length >= 2 ) )  return;
			_pp.toggle();
		}
		
		protected function onMouseMove( _evt:MouseEvent ):void{
			//Log.log( 'GraphicView onMouseMove', new Date().getTime() );
			var _pp:PiePart = _evt.target as PiePart;
			if( !_pp ) return;
			//Log.log( _pp.dataIndex );
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, { evt: _evt, index: _pp.dataIndex } ) );
		}	
				
		private function onPiePartUpdateStatus( _evt:JChartEvent ):void{
			var _data:Object = _evt.data as Object;
			
			
			if( _piePart.length === 1 ) {
				return;
			}
			
			if( BaseConfig.ins.selected >= 0 
				&& BaseConfig.ins.selected <= ( _piePart.length - 1 ) 
				&& BaseConfig.ins.selected != _data.dataIndex 
			){
				//_piePart[ BaseConfig.ins.selected ].unselected();
			}
			
			if( _data.selected ){
				BaseConfig.ins.selected = _data.dataIndex;
			}else{
				BaseConfig.ins.selected = -1;
			}					
			//Log.log( BaseConfig.ins.selected );			
		}
		
		private function showTips( _evt: JChartEvent ):void{
		}
		
		private function hideTips( _evt: JChartEvent ):void{	
			
			if( _preIndex >= 0 ){
				Common.each( _boxs, function( _k:int, _item:DDountUI ):void{
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
				Common.each( _boxs, function( _k:int, _item:DDountUI ):void{
					_preIndex >= 0 && _boxs[ _k ].items[ _preIndex ].unhover();
				});
			}
			Common.each( _boxs, function( _k:int, _item:DDountUI ):void{
				_ix >= 0 && _boxs[ _k ].items[ _ix ].hover();
			});
			
			_preIndex = _ix;
		}
		
	}
}