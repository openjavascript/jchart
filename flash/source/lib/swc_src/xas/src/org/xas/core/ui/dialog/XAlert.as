package org.xas.core.ui.dialog
{
	import fl.controls.Button;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import org.xas.core.ui.button.XButton;
	import org.xas.core.ui.layout.BaseBg;
	import org.xas.core.ui.text.XLabel;
	import org.xas.core.utils.Log;
	
	internal class XAlert extends Sprite
	{
		private var _msg:String;
		private var _callback:Function;
		
		private var _label:XLabel;
		private var _btn:XButton;
		
		private var _bg:BaseBg;
		
		private var _preX:Number = 0;
		private var _preY:Number = 0;
		
		public function XAlert($s:String, $callback:Function = null)
		{
			_msg = $s;	
			_callback = $callback;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
						
			super();
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			init();
		}
		private function onRemovedFromStage($evt:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);	
			root.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown($evt:KeyboardEvent):void
		{
			if( $evt.keyCode )
			{
				onBtnClick(null);
			}
		}
		
		private function init():void
		{			
			_bg = new BaseBg();
			addChild( _bg );
			
			_label = new XLabel(_msg);
			addChild( _label );
			
			_btn = new XButton('确定');
			addChild(_btn);
						
			
			var padX:Number = 40;
			var padY:Number = 10;
			
			var itemSpaceY:Number = 10;
			
			_label.x = padX;
			_label.y = padY;
			
			_btn.x = (padX * 2 + _label.width - _btn.width) / 2;
			_btn.y = _label.y + _label.height + itemSpaceY;
			
			
			_label.setTextStyle( {color:0xffffff} );
			_bg.resize( padX * 2 + _label.width, padY + _btn.y + _btn.height, 0, 0, 10 );
			
			
			_btn.addEventListener(MouseEvent.CLICK, onBtnClick);			
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, onBgDown);
			
		}
		
		private function onBgDown($evt:MouseEvent):void
		{
			_preX = root.stage.mouseX - this.x;
			_preY = root.stage.mouseY - this.y;
			
			root.stage.addEventListener(MouseEvent.MOUSE_UP, onBgUp);			
			root.stage.addEventListener(MouseEvent.MOUSE_MOVE, onBgMove);
		}
		
		private function onBgUp($evt:MouseEvent):void
		{
			root.stage.removeEventListener(MouseEvent.MOUSE_UP, onBgUp);			
			root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onBgMove);
			
			var pos:Point = new Point( this.x, this.y );
			this.dispatchEvent( new XDialogEvent( XDialogEvent.ON_POPUP_POSITION_CHANGE, pos) );
		}
		
		private function onBgMove($evt:MouseEvent):void
		{			
			var newX:Number = root.stage.mouseX - _preX;
			var newY:Number = root.stage.mouseY - _preY;
			
			var maxX:Number = root.stage.stageWidth - this.width;			
			var maxY:Number = root.stage.stageHeight - this.height;
			
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
			
			this.x = newX;
			this.y = newY;
		}
		
		private function onBtnClick($evt:MouseEvent):void
		{
			if( this.parent) this.parent.removeChild( this );
			
			dispatchEvent( new XDialogEvent( XDialogEvent.ON_ALERT_CLICK ) );
			
			if( _callback != null )
			{
				_callback();
			}
		}
	}
}
