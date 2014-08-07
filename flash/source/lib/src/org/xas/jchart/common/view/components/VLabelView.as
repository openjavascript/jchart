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
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	
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
			
			Common.each( BaseConfig.ins.realRate, function( _k:int, _item:Number ):*{
				
				_t = Common.moneyFormat( _item, 3, BaseConfig.ins.realRateFloatLen || 0 );
				
				_titem = new TextField();
				_titem.text = _t;
				
				Common.implementStyle( _titem, [
					DefaultOptions.title.style
					, DefaultOptions.yAxis.labels.style
					, BaseConfig.ins.vlabelsStyle
				] );
				
				addChild( _titem );
				
				_labels.push( _titem );
				
				_titem.width > _maxWidth && ( _maxWidth = _titem.width );
			});			
			//Log.log( 'maxwidth', _maxWidth );
		}
		
		public function update():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.vpoint ) ) return;
			
			Common.each( BaseConfig.ins.c.vpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				_tf.x = _item.start.x - _tf.width;
				_tf.y = _item.start.y - _tf.height / 2;
			});
		}


	}
}