package org.xas.core.ui.text
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class RotationText extends Sprite
	{
		private var _text:String;
		private var _angle:Number;
		private var _initTextCallback:Function;
		
		private var _tf:TextField;
		
		private var _bitmapData:BitmapData;
		private var _bitmap:Bitmap;
		
		public function RotationText( $text:String, $angle:Number = 0, $initTextCallback:Function = null )
		{
			_text = $text;
			_angle = $angle;
			_initTextCallback = $initTextCallback;
			
			init();
		}
		
		private function init():void
		{
			_tf = new TextField();
			_tf.text = _text;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.mouseEnabled = false;
			_tf.selectable = false;
			
			if( _initTextCallback != null )
			{
				_initTextCallback( _tf );
			}
			
			_bitmapData = new BitmapData( _tf.width + 10, _tf.height + 4, true, 0xffffffff );
			var mtx:Matrix = new Matrix();
			_bitmapData.draw( _tf, mtx, null, null, null, true );
			
			_bitmap = new Bitmap( _bitmapData, "auto", true );
			
			
			if( _angle !== 0 )
			{
				this.rotation = _angle;
			}
			addChild( _bitmap );
		}
	}
}