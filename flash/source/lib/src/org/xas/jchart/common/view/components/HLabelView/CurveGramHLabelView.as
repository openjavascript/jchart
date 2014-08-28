package org.xas.jchart.common.view.components.HLabelView
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.config.CurveGramConfig;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class CurveGramHLabelView extends BaseHLabelView
	{
		private var _config:CurveGramConfig;
		
		public function CurveGramHLabelView()
		{
			super();
			_config = BaseConfig.ins as CurveGramConfig;
		}
		
		override protected function addToStage( _evt:Event ):void{
			_labels = new Vector.<TextField>();
			var _v:Number, _t:String, _titem:TextField;
			
			if( _config.cd && _config.cd.xAxis && _config.cd.xAxis.categories ){
				
				//Log.log( 'ssssssssss', _config.c.labelWidth );
				Common.each( _config.cd.xAxis.categories, function( _k:int, _item:* ):*{
					_t = _item + '';
					
					_titem = new TextField();
					_titem.text = StringUtils.printf( _config.xAxisFormat, _t );
					
					_titem.autoSize = TextFieldAutoSize.LEFT;
					
					var _align:String = 'center';
					
					if( _config.vlineEnabled ){
						if( _config.cd.xAxis.categories === 1 ){
							
						}else if( _k === 0 ){
							_align = 'left';
						}else if( _k === _config.cd.xAxis.categories.length - 1 ){
							_align = 'right';
						}
					}
					
					Common.implementStyle( _titem, [
						DefaultOptions.title.style
						, DefaultOptions.xAxis.labels.style
						, { 'size': 12, color: 0x838383, 'align': _align }
						, _config.labelsStyle
					] );
					//Log.log( 'w:', _config.c.labelWidth, 'wrap:', _config.xAxisWordwrap );
					
					if( _config.c.labelWidth && _config.xAxisWordwrap ){
						var _twidth:Number = _config.c.labelWidth;
						if( _twidth < 14 ) _twidth = 14;
						_titem.width = _twidth * 1.8;
						_titem.wordWrap = true;
					}
					
					if( !_config.displayAllLabel ){
						if( !( _k in _config.labelDisplayIndex ) ){
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
			if( !( _config.c && _config.c.hpoint ) ) return;
			
			Common.each( _config.c.hpointReal, function( _k:int, _item:Object ):void{
				
				var _tf:TextField = _labels[ _k ];	
				
				if( _config.vlineEnabled ){
					normalPosition( _k, _item );
				}else{
					vlineDisabledPosition( _k, _item );
				}
				
				_tf.y = _item.end.y + _config.c.arrowLength;
			});
		}
		
		private function normalPosition( _index:int, _item:Object ):void{
			var _tf:TextField = _labels[ _index ]		
				, _x:Number = _item.end.x - _tf.width / 2
				;
			
			if( _index === 0 ){
				//Log.log( _config.c.linePadding, 0, _tf.width );
				_x < _config.c.chartX && ( _x = _config.c.chartX - 3 );
			}else if( _index === _config.c.hpointReal.length - 1 ){
				if( _x + _tf.width > _config.c.chartX + _config.c.chartWidth ){
					_x = _config.c.chartX + _config.c.chartWidth - _tf.width + 3;
					//Log.log( _config.c.linePadding, 'last', _tf.width );
				}
			}
			
			_tf.x = _x;
		}
		
		private function vlineDisabledPosition( _index:int, _item:Object ):void{

			var _tf:TextField = _labels[ _index ]		
				, _x:Number = _item.end.x - _tf.width / 2
				, _chartX:Number = _config.c.chartX + _config.c.linePadding / 2
				, _chartWidth:Number = _config.c.chartWidth - _config.c.linePadding
				;
			//Log.log( _config.c.chartX, _chartX, _config.c.linePadding );
						
			/*
			if( _index === 0 ){
				_tf.wordWrap = false;
				//Log.log( _config.c.linePadding, 0, _tf.width );
				_x < _chartX && ( _x = _chartX - 3 );
			}else if( _index === _config.c.hpointReal.length - 1 ){
				_tf.wordWrap = false;
				if( _x + _tf.width > _chartX + _chartWidth ){
					_x = _chartX + _chartWidth - _tf.width + 3;
					//Log.log( _config.c.linePadding, 'last', _tf.width );
				}
			}
			*/
			
			_tf.x = _x;
		}
	}
}