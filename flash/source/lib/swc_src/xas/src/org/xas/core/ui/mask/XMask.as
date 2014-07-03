package org.xas.core.ui.mask
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class XMask extends Sprite
	{		
		private var _maskBg:Sprite;
		
		private static var _ins:XMask = new XMask();
		public static function getInstance():XMask{ return _ins; }
		
		public function XMask()
		{
			if( _ins )
			{
				throw new Error('XMask is singleton class');
			}
			hide();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
						
			root.stage.addEventListener(Event.RESIZE, onResize);
			
			resetLayout();
		}
		
		private function onResize($evt:Event):void
		{
			if(!root||!this.visible) return; 
			
			resetLayout();
		}
		
		public function resetLayout():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(0, 0);
			this.graphics.beginFill(0x000000, .35);
			this.graphics.drawRect(0, 0, root.stage.stageWidth, root.stage.stageHeight);
			this.graphics.endFill();
		}
		
		public function show():void
		{
			resetLayout();
			this.parent.addChild( this );
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function isVisible():Boolean
		{
			return this.visible;
		}
	}
}