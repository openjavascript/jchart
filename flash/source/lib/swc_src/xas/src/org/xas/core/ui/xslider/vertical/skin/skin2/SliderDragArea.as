package org.xas.core.ui.xslider.vertical.skin.skin2
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class SliderDragArea extends Sprite
	{
		private var _bg:Shape;
		
		private var _color:uint;
		
		public function SliderDragArea( $color:uint )
		{
			_color = $color;
			init();
		}
		
		private function init():void
		{
			addChild( _bg = new Shape() );
			_bg.graphics.lineStyle(0, 0, 0);
			_bg.graphics.beginFill(0x000000, 0 );
			_bg.graphics.drawRect(0, 0, 10, 90);
			_bg.graphics.endFill();
			
			this.buttonMode = true;
			
			graphics.lineStyle(1, _color);
			graphics.moveTo(5,0);
			graphics.curveTo(5, 90, 5, 90);
			graphics.endFill();
		}
	}
}