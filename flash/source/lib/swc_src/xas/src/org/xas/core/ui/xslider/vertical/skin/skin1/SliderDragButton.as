package org.xas.core.ui.xslider.vertical.skin.skin1
{
	import flash.display.Sprite;
	
	public class SliderDragButton extends Sprite
	{
		public function SliderDragButton()
		{
			init();
		}
		
		private function init():void
		{			
			this.buttonMode = true;
			
			graphics.lineStyle(1, 0);
			graphics.beginFill( 0xffffff );
			graphics.drawRect(0, -5.5, 20, 10);
			graphics.endFill();
		}
	}
}