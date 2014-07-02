package org.xas.core.ui.xslider
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.xas.core.events.XSliderEvent;
	
	public class XSlider extends Sprite
	{
		protected var _box:Sprite;
		
		protected var _bg:DisplayObjectContainer;
		protected var _dragArea:DisplayObjectContainer;
		protected var _dragBtn:DisplayObjectContainer;
		protected var _forwardBtn:DisplayObjectContainer;
		protected var _backwardBtn:DisplayObjectContainer;		
		
		protected var _lower:Number = .1;
		public function get lower():Number{ return _lower; }
		
		protected var _upper:Number = 2;
		public function get upper():Number{ return _upper; }
		
		protected var _step:Number = .1;
		public function get step():Number{ return _step; }
		
		protected var _defaultValue:Number = .5;
		public function get defaultValue():Number{ return _defaultValue; }
		
		protected var _value:Number = _defaultValue;
		public function get value():Number{ return calcDragValue(); }
		public function set value( $v:Number ):void{}
		
		protected var _dragLower:Number = 0;
		protected var _dragUpper:Number = 1;
		protected var _dragSpan:Number = Math.abs( _dragUpper - _dragLower );
		
		protected var _mouseDownFix:Number = 0;
		
		public function XSlider()
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);		
			init();
		}
		
		protected function init():void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		protected function onMouseDown($evt:MouseEvent):void
		{
			$evt.stopPropagation();
		}
		
		protected function calcDragButtonPosition( $val:Number ):Number
		{
			var r:Number = 0;
			return r;
		}
		
		protected function calcDragValue():Number
		{
			var r:Number = 0;
			return r;
		}
		
		protected function dragDown($evt:MouseEvent):void
		{
			root.stage.addEventListener(MouseEvent.MOUSE_UP, dragUp);
			root.stage.addEventListener(MouseEvent.MOUSE_MOVE, dragMove);
		}
		
		protected function dragMove($evt:MouseEvent):void
		{			
		}
		
		protected function dragUp($evt:MouseEvent):void
		{
			root.stage.removeEventListener(MouseEvent.MOUSE_UP, dragUp);
			root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragMove);
		}
		
		protected function notifyEvent():void
		{
			this.dispatchEvent
				(
					new XSliderEvent
					(
						XSliderEvent.UPDATE, this.value
					)
				);
		}
	}
}