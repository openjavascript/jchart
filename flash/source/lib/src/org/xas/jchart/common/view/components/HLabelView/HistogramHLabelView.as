package org.xas.jchart.common.view.components.HLabelView
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;

	public class HistogramHLabelView extends BaseHLabelView
	{
		public function HistogramHLabelView()
		{
			super();
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			if( BaseConfig.ins.cd && BaseConfig.ins.cd.xAxis && BaseConfig.ins.cd.xAxis.categories ){
				
				//Log.log( 'ssssssssss', BaseConfig.ins.c.labelWidth );
				Common.each( BaseConfig.ins.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = _t;
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': 'center' }
						, BaseConfig.ins.labelsStyle
					] );
					//Log.log( 'w:', BaseConfig.ins.c.labelWidth, 'wrap:', BaseConfig.ins.xAxisWordwrap );
					
					if( BaseConfig.ins.c.labelWidth && BaseConfig.ins.xAxisWordwrap ){
						var _twidth:Number = BaseConfig.ins.c.labelWidth;
						if( _twidth < 14 ) _twidth = 14;
						_titem.width = _twidth * 1.8;
						_titem.wordWrap = true;
					}
					
					if( !BaseConfig.ins.displayAllLabel ){
						if( !( _k in BaseConfig.ins.labelDisplayIndex ) ){
							_titem.visible = false;
						}
					}
					
					addChild( _titem );
					
					_labels.push( _titem );
					
					_titem.height > _maxHeight && ( _maxHeight = _titem.height );
				});			
			}
			//Log.log( '_maxHeight', _maxHeight );
		}
		
		override protected function update( _evt:JChartEvent ):void{
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.hpoint ) ) return;
			
			Common.each( BaseConfig.ins.c.hpoint, function( _k:int, _item:Object ):void{
				var _tf:TextField = _labels[ _k ];
				
				var _x:Number = _item.end.x - _tf.width / 2;
				
				if( _k === 0 ){
					//Log.log( BaseConfig.ins.c.linePadding, 0, _tf.width );
					_x < BaseConfig.ins.c.chartX && ( _x = BaseConfig.ins.c.chartX - 3 );
				}else if( _k === BaseConfig.ins.c.hpointReal.length - 1 ){
					if( _x + _tf.width > BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth ){
						_x = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth - _tf.width + 3;
						//Log.log( BaseConfig.ins.c.linePadding, 'last', _tf.width );
					}
				}
				
				_tf.x = _x;
				_tf.y = _item.end.y - 2;
			});
		}
	}
}