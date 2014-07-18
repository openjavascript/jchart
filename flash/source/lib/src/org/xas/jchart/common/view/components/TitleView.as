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
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	
	public class TitleView extends Sprite
	{
		private var _text:String;
		private var _textf:TextField;
		private var _tf:TextFormat;
		
		public function TitleView( _text:String )
		{
			super();
		
			this._text = _text;
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			_textf = new TextField();
			_textf.text = _text;
			
			Common.implementStyle( _textf, [
				DefaultOptions.title.style
				, DefaultOptions.xAxis.title.style
				, BaseConfig.ins.titleStyle
			] );
			
			_textf.x = -_textf.width / 2;
			//textf.mouseEnabled
			addChild( _textf );
		}

	}
}