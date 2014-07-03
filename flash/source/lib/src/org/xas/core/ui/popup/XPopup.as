package org.xas.core.ui.popup
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import org.xas.core.ui.button.XButton;
	import org.xas.core.ui.mask.XMask;
	import org.xas.core.ui.textbox.TextBox;
	
	public class XPopup extends Sprite
	{
		private var _mask:XMask = XMask.getInstance();
		
		private var _closeBtn:XButton;
		private var _tbx:TextBox;
		
		private var _popupWidth:Number = 600;
		private var _popupHeight:Number = 300;
		
		public function XPopup()
		{
			this.visible = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			root.stage.addEventListener(Event.RESIZE, onResize);
			init();
		}
		
		private function onResize($evt:Event):void
		{
			if(!root) return; 
			
			if( root.stage.stageWidth <= this.width || root.stage.stageHeight <= this.height )
			{
				return;
			}
			
			this.x = ( root.stage.stageWidth - this.width ) / 2;
			this.y = ( root.stage.stageHeight - this.height ) / 2;
		}
		private function onRemovedFromStage($evt:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage)
		}
		
		private function init():void
		{
			addChild( _closeBtn = new XButton('关闭') );
			addChild( _tbx = new TextBox( _popupWidth, _popupHeight ) );
			
			initPosition();
			initAction();
			initEvent();
		}
		
		private function initPosition():void
		{
			_closeBtn.x = _tbx.width - _closeBtn.width;
			_tbx.y = _closeBtn.y + _closeBtn.height;
			
			this.x = (root.stage.stageWidth - this.width) / 2;
			this.y = (root.stage.stageHeight - this.height) / 2;
		}
		
		private function initAction():void
		{
			_tbx.setTextBoxStyle( {background: 0xffffff} );
			_closeBtn.visible = false;
			_tbx.visible = false;
			
			setTimeout
			(
				function():void
				{
					_closeBtn.visible = true;
					_tbx.visible = true;
					initPosition();
				}
				, 50
			);
		}
		
		private function initEvent():void
		{
			_closeBtn.addEventListener(MouseEvent.CLICK, onClose);
		}
		
		private function onClose($evt:MouseEvent):void
		{
			dispatchEvent( new XPopupEvent( XPopupEvent.ON_CLOSE ) );
		}
		
		public function update($v:String):void
		{
			_tbx.text = $v;
		}
		
		public function show():void
		{
			_mask.show();	
			this.visible = true;	
			root.stage.addChild( this );
		}
		
		public function hide():void
		{
			this.visible = false;
			_mask.hide();
		}
	}
}