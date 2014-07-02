package org.xas.core.ui.textbox
{
	import fl.controls.UIScrollBar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class TextBox extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		
		private var _isInput:Boolean;
		
		private var _tbx:TextField;
		private var _scr:UIScrollBar;
		public function get uiscrollbar():UIScrollBar{ return _scr; }
		
		private var _tFormat:TextFormat;
				
		public function TextBox($width:Number = 400, $height:Number = 200, $isInput:Boolean = true)
		{
			_width = $width;
			_height = $height;
			_isInput = $isInput;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		public function get textFiled():TextField{return _tbx;}		
		public function get scroller():UIScrollBar{return _scr;}
		
		public function set text($v:String):void
		{ 
			_tbx.text = $v;
			_scr.update();
			_scr.scrollPosition = _scr.maxScrollPosition;
		}
		public function get text():String{ return _tbx.text; }
		
		private function init():void
		{					
			_scr = new UIScrollBar();
			addChild( _scr );
			
			_tbx = new TextField();
			addChild( _tbx );
			
			_tFormat = new TextFormat();
			
			initAction();
			initSize();
		}
		
		private function initAction():void
		{
			_tFormat.font = '宋体';
			
			_tbx.border = true;	
			_tbx.wordWrap = true;
			_tbx.multiline = true;
			_tbx.defaultTextFormat = _tFormat;
			_tbx.setTextFormat( _tFormat );
			
			_tbx.type = _isInput?TextFieldType.INPUT:TextFieldType.DYNAMIC;	
		}
		
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
		
		private function initSize():void
		{			
			var newWidth:Number = _width - _scr.width;
			
			_tbx.width = newWidth;			
			_tbx.height = _height - 1;
							
			_scr.scrollTarget = _tbx;
			_scr.setScrollProperties( _height, 0, _height );
			_scr.move( newWidth, _tbx.y );
			_scr.height = _height;
			_scr.update();
		}
		
		public function resize($w:Number, $h:Number):void
		{
			_width = $w;
			_height = $h;
			
			initSize();
		}
	}
}
