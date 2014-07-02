package org.xas.core.ui.xslider.vertical.skin.skin2
{
	import flash.display.Sprite;
	
	public class SliderDragButton extends Sprite
	{		
		private var _color:uint;
		
		public function SliderDragButton( $color:uint )
		{
			_color = $color;
			init();
		}
		
		private function init():void
		{			
			this.buttonMode = true;
			
			graphics.lineStyle(0, 0, 0);
			graphics.beginFill( _color );
			graphics.drawRect(0, -5.5, 20, 10);
			graphics.endFill();
		}
	}
}