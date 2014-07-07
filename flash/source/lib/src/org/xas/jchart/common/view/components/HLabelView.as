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
	import org.xas.jchart.common.Config;
	
	public class HLabelView extends Sprite
	{
		private var _labels:Vector.<TextField>;
		public function get labels():Vector.<TextField>{ return _labels; }
		
		private var _maxHeight:Number = 0;
		public function get maxHeight():Number{ return _maxHeight; }
		
		public function HLabelView()
		{
			super();
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			if( Config.cd && Config.cd.xAxis && Config.cd.xAxis.categories ){
								
				Config.each( Config.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.autoSize = TextFieldAutoSize.LEFT;
					_titem.text = _t;
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				});			
			}
			//Log.log( '_maxHeight', _maxHeight );
		}
		
		public function update():void{
			if( !( Config.c && Config.c.hpoint ) ) return;
			
			Config.each( Config.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				_tf.x = _item.end.x - _tf.width / 2;
				_tf.y = _item.end.y;
			});
		}
	}
}