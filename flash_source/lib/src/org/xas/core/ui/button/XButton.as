package org.xas.core.ui.button
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public dynamic class XButton extends Sprite
	{
		private var _text:String;
		private var _tbx:TextField;
		private var _bg:Sprite;
		private var _tFormat:TextFormat;
		
		public function XButton( $text:String )
		{
			_text  = $text;
			
			init();
		}
		
		private function init():void
		{			
			this.buttonMode = true;
			
			_tFormat = new TextFormat();
			_tFormat.color = 0xffffff;
			_tFormat.size = 12;
			
			_tbx = new TextField();
			_tbx.text = _text;
			_tbx.autoSize = TextFieldAutoSize.LEFT;
			_tbx.defaultTextFormat = _tFormat;
			_tbx.setTextFormat( _tFormat );
			_tbx.x = 2;
			_tbx.y = 2;
			_tbx.selectable = false;
			_tbx.mouseEnabled = false;
			
			_bg = new Sprite();
			_bg.graphics.lineStyle(1, 0x000000, .8 );
			_bg.graphics.beginFill( 0x000000, .35 );
			_bg.graphics.drawRect(0, 0, _tbx.width + 4, _tbx.height + 4 );
			_bg.graphics.endFill();
			
			addChild( _bg );
			addChild( _tbx );
		}
		
		public function get text():String{ return _tbx.text; }
		public function set text($v:String):void{ _tbx.text = $v; }
		
		public function setTextStyle( $params:Object ):void
		{
			for( var k:String in $params)
			{
				_tFormat[k] = $params[k];
			}
			_tbx.defaultTextFormat = _tFormat;
			_tbx.setTextFormat( _tFormat );
		}
		
		public function setTextBoxStyle( $params:Object ):void
		{
			for( var k:String in $params)
			{
				_tbx[k] = $params[k];
			}
		}
	}
}