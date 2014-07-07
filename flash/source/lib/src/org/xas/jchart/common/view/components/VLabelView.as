package org.xas.jchart.common.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mx.controls.Text;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	
	public class VLabelView extends Sprite
	{
		private var _labels:Vector.<TextField>;
		public function get labels():Vector.<TextField>{ return _labels; }
		
		private var _maxWidth:Number = 0;
		public function get maxWidth():Number{ return _maxWidth; }
		
		public function VLabelView(  )
		{
			super();
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			Config.each( Config.rate, function( _k:int, _item:Number ):*{
				_v = Config.finalMaxNum * _item;
				_t = Config.parseFinance( _v ).toString();
				
				_titem = new TextField();
				_titem.autoSize = TextFieldAutoSize.LEFT;
				_titem.text = _t;
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
			});			
			//Log.log( 'maxwidth', _maxWidth );
		}
		
		public function update():void{
			if( !( Config.c && Config.c.vpoint ) ) return;
			
			Config.each( Config.c.vpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				_tf.x = _item.start.x - _tf.width;
				_tf.y = _item.start.y - _tf.height / 2;
			});
		}


	}
}