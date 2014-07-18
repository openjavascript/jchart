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
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	
	public class CreditView extends Sprite
	{
		private var _text:String;
		private var _href:String;
		private var _textf:TextField;
		private var _tf:TextFormat;
		
		public function CreditView( _text:String, _href:String )
		{
			super();
			
			this._text = _text || '';
			this._href = _href || '';
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			_textf = new TextField();
			
			if( _href ){
				!_text && ( _text = _href );
				_textf.htmlText = StringUtils.printf( '<a href="{1}">{0}</a>', _text, _href );
			}else{				
				_textf.text = _text;
			}
			
			Common.implementStyle( _textf, [
				DefaultOptions.title.style
				, DefaultOptions.credits.style
				, BaseConfig.ins.creditsStyle
			] );
			
			_textf.x -= _textf.width;
			_textf.y -= _textf.height;
			addChild( _textf );
		}

	}
}