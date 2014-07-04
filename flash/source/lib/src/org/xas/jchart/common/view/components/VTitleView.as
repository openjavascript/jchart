package org.xas.jchart.common.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.ui.text.RotationText;
	import org.xas.core.utils.Log;
	
	public class VTitleView extends Sprite 
	{
		private var _text:String;
		private var _textf:RotationText;
		
		public function VTitleView( _text:String )
		{
			super();
		
			this._text = _text;
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			_textf = new RotationText( _text, -90, function( _stf:TextField ):void{
				
			});
			addChild( _textf );
		}

	}
}