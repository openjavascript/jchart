package org.xas.core.ui.xslider.vertical.skin.skin1
{
	import flash.display.Sprite;
	
	public class SliderBg extends Sprite
	{
		private var _bg:Sprite;
		
		private var _w:Number;
		private var _h:Number;
		
		public function SliderBg( $w:Number, $h:Number )
		{
			_w = $w;
			_h = $h;
			
			init();
		}
		
		private function init():void
		{
			_bg = new Sprite();
			_bg.graphics.lineStyle(1, 0);
			_bg.graphics.beginFill(0xffffff, .8);
			_bg.graphics.drawRoundRect( 0, 0, _w, _h, 5, 5 );
			_bg.graphics.endFill();
			
			addChild( _bg );
		}
	}
}