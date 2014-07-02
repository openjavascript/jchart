package org.xas.core.ui.xslider.vertical.skin.skin2
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class SliderBackwardButton extends Sprite
	{
		private var _bg:Shape;
		private var _color:uint;
		
		public function SliderBackwardButton( $color:uint )
		{
			_color = $color;
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
			
			graphics.lineStyle(2, _color);
			graphics.moveTo(0,5);
			graphics.curveTo(10, 5, 10, 5);
			graphics.endFill();
		}
	}
}