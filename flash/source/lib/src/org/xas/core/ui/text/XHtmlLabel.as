package org.xas.core.ui.text
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class XHtmlLabel extends Sprite
	{
		private var _text:String;
		private var _tf:TextField;
		private var _tFormat:TextFormat;
		
		public function XHtmlLabel( $text:String )
		{
			_text  = $text;
			
			init();
		}
		
		private function init():void
		{			
			_tFormat = new TextFormat();
			_tFormat.font = '宋体';
//			_tFormat.color = 0x000000;
//			_tFormat.size = 12;
			
			_tf = new TextField();
			_tf.htmlText = _text;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.defaultTextFormat = _tFormat;
			_tf.setTextFormat( _tFormat );
			_tf.x = 2;
			_tf.y = 2;
			//_tf.selectable = false;
			//_tf.mouseEnabled = false;
			addChild( _tf );
		}
		
		public function set text($v:String):void{ _tf.htmlText = $v; }
		public function get text():String{ return _tf.htmlText; }
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