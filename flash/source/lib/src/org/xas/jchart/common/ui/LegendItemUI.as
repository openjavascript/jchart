package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class LegendItemUI extends Sprite
	{
		private var _data:Object;
		private var _styles:Object;
		
		private var _rect:Sprite;
		private var _txf:TextField;
		private var _selected:Boolean = false;
		public function get selected():Boolean{ return _selected; }
		public function set selected( _setter:Boolean ):void{ 
			_selected = _setter;			
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_STATUS, _selected ) );
		}
		public function toggle():LegendItemUI{
			_selected = !_selected;
			dispatchEvent( new JChartEvent( JChartEvent.UPDATE_STATUS, _selected ) );
			return this;
		}
		
		public function LegendItemUI( _data:Object, _styles:Object = null )
		{
			super();
			
			this._data = _data;
			this._styles = _styles;
			
			init();
		}
		
		private function init():void{
			draw();	
			
			addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
			addEventListener( MouseEvent.CLICK, onMouseClick );
			addEventListener( JChartEvent.UPDATE_STATUS, onUpdateStatus );
		}
		
		private function onUpdateStatus( _evt:Event ):void{
			//Log.log( '_selected', _selected );	
			
			if( _selected ){
				this.alpha = .3;
			}else{
				this.alpha = 1;
			}
		}
		
		private function onMouseClick( _evt:MouseEvent ):void{			
			toggle();
		}
		
		private function onMouseOver( _evt:MouseEvent ):void{
			Mouse.cursor = MouseCursor.BUTTON;			
		}
		
		private function onMouseOut( _evt:MouseEvent ):void{
			Mouse.cursor = MouseCursor.AUTO;			
		}
		
		private function draw():void{
			addChild( _rect = new Sprite() );
			addChild( _txf = new TextField() );
			
			
			Common.implementStyle( _txf, [ _styles ] );
			
			_rect.graphics.beginFill( _styles.color || 0x000000 );
			_rect.graphics.drawRect( 0, 0, 18, 10 );
			_rect.y = 5;
			
			_txf.text = _data.name || '';
			_txf.x = _rect.width + 1;
			_txf.mouseEnabled = false;
		}
		
	
	}
}