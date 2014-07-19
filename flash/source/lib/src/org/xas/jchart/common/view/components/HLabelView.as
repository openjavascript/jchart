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
			
			if( BaseConfig.ins.cd && BaseConfig.ins.cd.xAxis && BaseConfig.ins.cd.xAxis.categories ){
								
				Common.each( BaseConfig.ins.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = _t;
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, BaseConfig.ins.labelsStyle
					] );
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				});			
			}
			//Log.log( '_maxHeight', _maxHeight );
		}
		
		public function update():void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hpoint ) ) return;
			
			Common.each( BaseConfig.ins.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ], _x:Number = _item.end.x - _tf.width / 2;
				
				if( _k === 0 ){
					_x < BaseConfig.ins.c.chartX && ( _x = BaseConfig.ins.c.chartX - 4 );
				}else if( _k === BaseConfig.ins.c.hpoint.length - 1 ){
					
				}
				
				_tf.x = _x;
				_tf.y = _item.end.y;
			});
		}
	}
}