package org.xas.core.ui.xslider.vertical.skin.skin2
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.xas.core.events.XSliderEvent;
	import org.xas.core.ui.xslider.XSlider;
	import org.xas.core.utils.Log;
	
	public class XVerticalSlider extends XSlider
	{		
		private var _color:uint;
		
		override public function set value($v:Number):void
		{
			_dragBtn.y = calcDragButtonPosition( $v );
		}
		
		public function XVerticalSlider( $lower:Number, $upper:Number,
										 $step:Number, $defaultValue:Number, 
										 $color:uint
		)
		{
			Log.marker( 'XVerticalSlider.XVerticalSlider: ' );
			
			_lower = $lower;
			_upper = $upper;
			_step = $step;
			_defaultValue = $defaultValue;
			_color = $color;
			
			trace( ' _upper: ' + _upper );
			
		}
		
		override protected function init():void
		{
			super.init();
			
			addChild( _box = new Sprite() );
			_box.addChild( _forwardBtn = new SliderForawrdButton( _color ) );
			
			_dragArea = new SliderDragArea( _color );
			_dragArea.y = _forwardBtn.height + 5;
			_box.addChild( _dragArea );
			
			_backwardBtn = new SliderBackwardButton( _color );
			_backwardBtn.y = _dragArea.x + _dragArea.height + 17;
			_box.addChild( _backwardBtn );
			
			_dragBtn = new SliderDragButton( _color );
			
			_dragLower = _dragArea.y + _dragBtn.height / 2;
			_dragUpper = _dragArea.y + _dragArea.height - _dragBtn.height / 2;
			_dragSpan = Math.abs( _dragUpper - _dragLower );
			
			_dragBtn.y = calcDragButtonPosition( _defaultValue );
			_dragBtn.x = -Math.floor((_dragBtn.width - _dragArea.width) / 2);
			
			_box.addChild( _dragBtn );
			
			super.init();			
			
			var w:Number = this.width + 6;
			var h:Number = this.height + 6;
			addChildAt( _bg = new SliderBg( w, h, _color ), 0 );
			_bg.visible = false;
			
			_box.x = _box.width / 2 - 2;
			_box.y = 4;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, 
				function($evt:MouseEvent):void
				{
					_bg.visible = true;
				}
			);
			
			this.addEventListener(MouseEvent.MOUSE_OUT, 
				function($evt:MouseEvent):void
				{
					_bg.visible = false;
				}
			);
			
			_dragBtn.addEventListener( MouseEvent.MOUSE_DOWN, dragDown );
			_forwardBtn.addEventListener( MouseEvent.CLICK, onForward );
			_backwardBtn.addEventListener( MouseEvent.CLICK, onBackward );
		}
		
		private function onForward( $evt:MouseEvent ):void
		{
			var nextValue:Number = this.value + _step;
			var update:Boolean = false;
			
			if( this.value < _upper )
			{
				update = true;
			}
			
			if( nextValue > _upper )
			{
				nextValue = _upper;
			}
			
			_dragBtn.y = calcDragButtonPosition( nextValue );
			
			if( update )
			{
				notifyEvent();
			}
			
		}
		
		private function onBackward( $evt:MouseEvent ):void
		{
			var nextValue:Number = this.value - _step;
			var update:Boolean = false;
			
			if( this.value > _lower )
			{
				update = true;
			}
			
			if( nextValue < _lower )
			{
				nextValue = _lower;
			}
			
			_dragBtn.y = calcDragButtonPosition( nextValue );
			
			if( update )
			{
				notifyEvent();
			}
		}
		
		override protected function calcDragButtonPosition( $val:Number ):Number
		{
			var r:Number = 0;
			
			if( $val > _upper )
			{
				$val = _upper;
			}
			else if( $val < _lower )
			{
				$val = _lower;
			}
			
			var per:Number = ($val-_lower) / (_upper - _lower);
			var pos:Number = _dragSpan * per;
			
			if( _dragLower > _dragUpper )
			{
				r = _dragLower + pos;	
			}
			else
			{
				r = _dragUpper - pos;
			}
			
			return r;
		}
		
		override protected function calcDragValue():Number
		{
			var r:Number = 0;
			var dragValue:Number = _dragSpan - (_dragBtn.y - _dragLower);
			var dragPer:Number = dragValue / _dragSpan;
			
			r = dragPer * (_upper - _lower);
			
			r += _lower;
			
			return r;
		}
		
		override protected function dragDown($evt:MouseEvent):void
		{
			_mouseDownFix = mouseY - _dragBtn.y;
			
			super.dragDown($evt);
		}
		
		override protected function dragMove($evt:MouseEvent):void
		{
			var newPos:Number = mouseY - _mouseDownFix;
			
			if( newPos <= _dragLower )
			{
				newPos = _dragLower;
			}
			
			if( newPos >= _dragUpper )
			{
				newPos = _dragUpper;
			}
			
			_dragBtn.y = newPos;
		}
		
		override protected function dragUp($evt:MouseEvent):void
		{
			super.dragUp($evt);
			notifyEvent();
		}
	}
}