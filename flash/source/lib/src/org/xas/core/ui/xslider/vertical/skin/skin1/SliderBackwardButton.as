package org.xas.core.ui.xslider.vertical.skin.skin1
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class SliderBackwardButton extends Sprite
	{
		private var _bg:Shape;
		
		public function SliderBackwardButton()
		{
			init();
		}
		
		private function init():void
		{
			addChild( _bg = new Shape() );
			_bg.graphics.lineStyle(0, 0, 0);
			_bg.graphics.beginFill(0x000000, 0 );
			_bg.graphics.drawRect(0, 0, 10, 10);
			_bg.graphics.endFill();
			
			this.buttonMode = true;
			
			graphics.lineStyle(1, 0);
			graphics.moveTo(0,5);
			graphics.curveTo(10, 5, 10, 5);
			graphics.endFill();
		}
	}
}