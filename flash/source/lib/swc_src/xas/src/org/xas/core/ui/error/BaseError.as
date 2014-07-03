package org.xas.core.ui.error
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.EffectUtility;
	
	public class BaseError extends Sprite
	{
		protected var _width:uint;
		protected var _height:uint;
		
		protected var _msg:String;
		protected var _bgSp:Sprite;
		
		protected var _textLabel:TextField;
		
		public function BaseError( $msg:String, $width:uint = 500, $height:uint = 400 )
		{
			_msg = $msg;
			_width = $width;
			_height = $height;
			
			init();
		}
		
		protected function init():void
		{
			_bgSp = new Sprite();
			addChild( _bgSp );
			
			_textLabel = new TextField();
			_textLabel.autoSize = TextFieldAutoSize.CENTER;
			_textLabel.wordWrap = true;
			_textLabel.text = _msg;
			_textLabel.selectable = false;
			_textLabel.mouseEnabled = false;
			addChild( _textLabel );
			
			resize(_width, _height);
			
			EffectUtility.textShadow( _textLabel, { color: 0xffffff, size: 14, align:'center' }, 0x000000 );
		}
		
		public function resize($w:Number, $h:Number):void
		{
			_bgSp.graphics.lineStyle(0, 0x000000, 0);
			_bgSp.graphics.beginFill(0x000000);
			_bgSp.graphics.drawRect( 0, 0, $w, $h );
			_bgSp.graphics.endFill(); 	
			
			_textLabel.width = $w - 20;
			
			_textLabel.x = ( $w - _textLabel.width ) / 2;
			_textLabel.y = ( $h - _textLabel.height ) / 2;
		}
	}
}