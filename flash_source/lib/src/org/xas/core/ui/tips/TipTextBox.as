package org.xas.core.ui.tips
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.StringUtils;
	
	public class TipTextBox extends Sprite
	{
		private var _tip:String = '请输入内容';
		public function get tip():String{ return _tip; }
		
		private var _width:Number;
		private var _height:Number;
		private var _bg:Shape;
		
		private var _textField:TextField;
		
		private var _textTf:TextFormat;
		private var _tipTf:TextFormat;
		
		private var _noEffect:Boolean = false;
		public function get noEffect():Boolean{ return _noEffect; }
		public function set noEffect($v:Boolean):void
		{ 
			_noEffect = $v;	
			_textField.defaultTextFormat = _textTf;
			_textField.setTextFormat( _textTf );
			
			if( isEmpty() )
			{
				_textField.text = '';
			}
		}
		
		public function get text():String{ return _textField.text; }
		public function set text($v:String):void
		{ 
			_textField.text = $v;
			if( StringUtils.trim( $v ) )
			{
				onMouseOver( null );
			}
		}
		
		public function get textField():TextField{ return _textField; }
		
		public function TipTextBox( $tip:String = '', $width:Number = 198, $height:Number = 30
									, $textTf:TextFormat = null, $tipTf:TextFormat = null )
		{			
			_tip = $tip || _tip;			
			_width = $width;
			_height = $height;
			_textTf = $textTf;
			_tipTf = $tipTf;
			
			init();
		}
		
		private function init():void
		{		
			if( !_textTf )
			{
				_textTf = new TextFormat();
				_textTf.size = 12;
				_textTf.color = 0x000000;
			}	
			
			if( !_tipTf )
			{
				_tipTf = new TextFormat();
				_tipTf.size = 12;
				_tipTf.color = 0xcccccc;
			}		
			
			_bg = new Shape();
			_bg.graphics.lineStyle(1, 0);
			_bg.graphics.moveTo( 0, 0 );
			_bg.graphics.lineTo( _width, 0 );
			_bg.graphics.lineTo( _width, _height );
			_bg.graphics.lineTo( 0, _height );
			_bg.graphics.lineTo( 0, 0 );
			addChildAt( _bg, 0 );
			
			_textField = new TextField();
			_textField.multiline = false;
			_textField.wordWrap = false;
			_textField.type = TextFieldType.INPUT;
			
			_textField.defaultTextFormat = _tipTf;
			_textField.setTextFormat( _tipTf );
			
			_textField.width = _width - 4;
			_textField.height = _textField.textHeight + 6;
			_textField.text = _tip;
			
			_textField.x = 4;
			_textField.y = (_height - _textField.height) / 2;
			
			addChild( _textField );
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_textField.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown($evt:KeyboardEvent):void
		{
			onMouseOver( null );
		}
		
		private function onMouseOver( $evt:MouseEvent ):void
		{
			if( _noEffect ) return;
			
			if( _textField.text === _tip )
			{
				_textField.text = '';
			}
			
			if( this.root )
			{
				this.root.stage.focus = _textField;
			}
			
			_textField.defaultTextFormat = _textTf;
			_textField.setTextFormat( _textTf );
		}
		
		private function onMouseOut( $evt:MouseEvent ):void
		{
			if( _noEffect ) return;
			
			if( StringUtils.trim( _textField.text ) === '' )
			{
				_textField.defaultTextFormat = _tipTf;
				_textField.setTextFormat( _tipTf );
				
				_textField.text = _tip;
			}
		}
		
		public function isEmpty():Boolean
		{
			var r:Boolean = true;
			
			if( StringUtils.trim(_textField.text) && StringUtils.trim( _textField.text ) != _tip )
			{
				r = false;
			}
			
			return r;
		}
	}
}