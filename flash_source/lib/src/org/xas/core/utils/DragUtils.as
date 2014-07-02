package org.xas.core.utils
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class DragUtils extends EventDispatcher
	{
		private var _display:DisplayObject;
		private var _inViewport:Boolean;
		private var _params:Object;
		
		private var _preX:Number = 0;
		private var _preY:Number = 0;
		
		private var root:DisplayObject;
		
		public function DragUtils( $display:DisplayObject, $inViewport:Boolean = true, $params:Object = null )
		{
			_display = $display;
			_inViewport = $inViewport;
			_params = $params;
			
			init();
		}
		
		private function init():void
		{
			if( !_display.root ) 
			{
				Log.error( 'DragUtils.init: _display.root is null! ' + _display );
				return;
			}
			
			root = _display.root;
			
			_display.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownX);
		}
		
		private function onMouseDownX($evt:MouseEvent):void
		{
			_preX = root.stage.mouseX - _display.x;
			_preY = root.stage.mouseY - _display.y;
			
			root.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpX);			
			root.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveX);
		}
		
		private function onMouseUpX($evt:MouseEvent):void
		{
			root.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpX);			
			root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveX);
			
		}
		
		private function onMouseMoveX($evt:MouseEvent):void
		{			
			var newX:Number = root.stage.mouseX - _preX;
			var newY:Number = root.stage.mouseY - _preY;
			
			var maxX:Number = root.stage.stageWidth - _display.width;			
			var maxY:Number = root.stage.stageHeight - _display.height;
			
			if( newX <= 0)
			{
				newX = 0;
			}
			if( newY <= 0)
			{
				newY = 0;
			}
			
			if( newX >= maxX )
			{
				newX = maxX;
			}
			
			if( newY >= maxY )
			{
				newY = maxY;
			}
			
			_display.x = newX;
			_display.y = newY;
		}
		
		public static function init( $display:DisplayObject, $inViewport:Boolean = true, $params:Object = null ):void
		{
			var du:DragUtils = new DragUtils( $display, $inViewport, $params );
		}
	}
}