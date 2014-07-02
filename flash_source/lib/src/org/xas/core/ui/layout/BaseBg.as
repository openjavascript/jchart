package org.xas.core.ui.layout
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class BaseBg extends Sprite
	{		
		protected var _bg:Sprite;		
		protected var _params:Object;
		
		public function BaseBg( $params:Object = null )
		{			
			_params = $params ||{};;
			_params.alpha = _params.alpha || .35;
			_params.bgcolor = _params.bgcolor || 0x000000;
			
			_bg = new Sprite();
			addChild( _bg );
		}
		
		public function resize($w:Number, $h:Number, $x:Number = 0, $y:Number = 0, eclipse:Number = 0):void
		{
			_bg.graphics.clear();
			_bg.graphics.lineStyle(1, 0x000000, 1 );
			_bg.graphics.beginFill(_params.bgcolor, _params.alpha );
			if( eclipse > 0 )
			{
				_bg.graphics.drawRoundRect($x, $y, $w - 2, $h, eclipse, eclipse);
			}
			else
			{
				_bg.graphics.drawRect($x, $y, $w - 2, $h);	
			}
			
			_bg.graphics.endFill();
		}
	}
}