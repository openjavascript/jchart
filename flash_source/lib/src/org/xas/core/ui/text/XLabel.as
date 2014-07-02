package org.xas.core.ui.text
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class XLabel extends Sprite
	{
		private var _text:String;
		private var _tf:TextField;
		private var _tFormat:TextFormat;
		
		public function XLabel( $text:String )
		{
			_text  = $text;
			
			init();
		}
		
		private function init():void
		{			
			_tFormat = new TextFormat();
			_tFormat.color = 0x000000;
			_tFormat.size = 12;
			
			_tf = new TextField();
			_tf.text = _text;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.defaultTextFormat = _tFormat;
			_tf.setTextFormat( _tFormat );
			addChild( _tf );
		}
		
		public function set text($v:String):void{ _tf.text = $v; }
		public function get text():String{ return _tf.text; }
		public function get textFiled():TextField{return _tf;}	
		public function get textFormat():TextFormat{return _tFormat;}
		
		public function setTextStyle( $params:Object ):void
		{
			for( var k:String in $params)
			{
				_tFormat[k] = $params[k];
			}
			_tf.defaultTextFormat = _tFormat;
			_tf.setTextFormat( _tFormat );
		}
	}
}