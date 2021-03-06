package org.xas.jchart.common.view.components.TipsView
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.TipsUI;
	
	public class NormalTipsView extends BaseTipsView
	{	
		public function NormalTipsView()
		{
			super();
		}

		
		override protected function buildData():void{
			
			if( !( _config.displaySeries && _config.displaySeries.length ) ){
				return;
			}
			
			_data = {};
			
			Common.each( _config.displaySeries[0].data, function( _k:int, _item:Number ):void{
				_data[ _k ] = { items: [], beforeItems: [], afterItems: [] };
				

				var _format:String = _config.tooltipHeaderFormat;
				_data[ _k ].name = StringUtils.printf( _format,  _config.getTipsHeader( _k ) ).replace( /[\r\n]+/g, '' );
							
				Common.each( _config.tooltipSerial, function( _sk:int, _sitem:Object ):void{
					//_data[ _k ][ 'name' ] = _sitem.name || '';
					//Log.log( 'xxxxxxx', _sitem.data[_k] );
					
					var _name:String = _sitem.name + ''
					, _value:String = StringUtils.printf( _config.tooltipSerialFormat, 
						Common.moneyFormat( _sitem.data[ _k ], 3, Common.floatLen( _sitem.data[ _k ] ) )
					)
					
					_data[ _k ].beforeItems.push( {
						'name': _name.replace( /[\r\n]+/g, '' )
						, 'value': _value
					});
				});
				
				Common.each( _config.displaySeries, function( _sk:int, _sitem:Object ):void{
					//_data[ _k ][ 'name' ] = _sitem.name || '';
					//Log.log( 'xxxxxxx', _sitem.data[_k] );
					
					var _name:String = _sitem.name + ''
					, _value:String = StringUtils.printf( _config.tooltipPointFormat, 
						Common.moneyFormat( _sitem.data[ _k ], 3, _config.floatLen  )
					)
					
					_data[ _k ].items.push( {
						'name': _name.replace( /[\r\n]+/g, '' )
						, 'value': _value
					}); 
				});
				
				Common.each( _config.tooltipAfterSerial, function( _sk:int, _sitem:Object ):void{
					//_data[ _k ][ 'name' ] = _sitem.name || '';
					//Log.log( 'xxxxxxx', _sitem.data[_k] );
					
					var _name:String = _sitem.name + ''
					, _value:String = StringUtils.printf( _config.tooltipAfterSerialFormat, 
						Common.moneyFormat( _sitem.data[ _k ], 3, Common.floatLen( _sitem.data[ _k ] ) )
					)
					
					_data[ _k ].afterItems.push( {
						'name': _name.replace( /[\r\n]+/g, '' )
						, 'value': _value
					});
				});
			});
			
			//Log.printObject( _data );
		}

		
		override protected function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				, _x:Number, _y:Number
				, _pos:Object
				;		
			//Log.log( 'TipsView ix', _ix, _srcEvt.stageX, _srcEvt.stageY );
			if( !( _data && _data[ _ix ] ) ) return;
			//Log.printObject( _data[ _ix ] );
			_x = _srcEvt.stageX;
			_y = _srcEvt.stageY;
			_pos = { x: _x, y: _y };
			
			if( _config.hoverBgEnabled && _config.c.dataRect && _config.c.dataRect[ _ix ]){
				_tips.update( _data[ _ix ], _pos, null, _config.c.dataRect[ _ix ] );
			}else{
				_tips.update( _data[ _ix ], _pos );
			}
			
		}

	}
}