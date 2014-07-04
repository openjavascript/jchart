package org.xas.jchart.common.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	
	public class CreditView extends Sprite
	{
		private var _text:String;
		private var _textf:TextField;
		private var _tf:TextFormat;
		
		public function CreditView( _text:String, _href:String )
		{
			super();
		
			this._text = _text;
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			_textf = new TextField();
			_textf.text = _text;
			_textf.autoSize = TextFieldAutoSize.LEFT;
			_textf.x -= _textf.width;
			_textf.y -= _textf.height;
			addChild( _textf );
		}

	}
}