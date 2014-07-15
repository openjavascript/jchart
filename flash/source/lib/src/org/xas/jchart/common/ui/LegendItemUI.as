package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class LegendItemUI extends Sprite
	{
		private var _data:Object;
		private var _rect:Sprite;
		private var _txf:TextField;
		
		public function LegendItemUI( _data:Object )
		{
			super();
			
			this._data = _data;
			
			draw();
		}
		
		private function draw():void{
			addChild( _rect = new Sprite() );
			addChild( _txf = new TextField() );
			
			_rect.graphics.beginFill( 0x000000 );
			_rect.graphics.drawRect( 0, 0, 18, 10 );
			_rect.y = 5;
			
			_txf.autoSize = TextFieldAutoSize.LEFT;
			_txf.text = _data.name || '';
			_txf.x = _rect.width + 1;
		}
	}
}