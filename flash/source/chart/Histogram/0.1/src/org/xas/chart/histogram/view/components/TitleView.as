package org.xas.chart.histogram.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import org.xas.core.utils.Log;
	
	public class TitleView extends Sprite
	{
		private var _text:String;
		private var _textf:TextField;
		
		public function TitleView( _text:String )
		{
			super();
		
			this._text = _text;
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			_textf = new TextField();
			_textf.text = _text;
			
			addChild( _textf );
		
			_textf.x = 100;
			_textf.y = 100;
		}
	}
}