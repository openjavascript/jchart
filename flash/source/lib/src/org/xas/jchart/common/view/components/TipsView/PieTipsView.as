package org.xas.jchart.common.view.components.TipsView
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;

	public class PieTipsView extends BaseTipsView
	{
		public function PieTipsView()
		{
			super();
		}
		
		
		override protected function buildData():void{
			
			if( !( BaseConfig.ins.displaySeries && BaseConfig.ins.displaySeries.length ) ){
				return;
			}
			
			_data = {};
			
			Common.each( BaseConfig.ins.displaySeries, function( _k:int, _item:Object ):void{
				_data[ _k ] = { 
					'name': _item.name || ''
					, 'items': [ 
						{ 
							'name': BaseConfig.ins.itemName
							, 'value': Common.moneyFormat( _item.y || 0, 3, BaseConfig.ins.floatLen ) 
						}  
					] 
				};
				
				/*
				if( BaseConfig.ins.categories.length ){
					_data[ _k ].name = StringUtils.printf( BaseConfig.ins.tipTitlePostfix,  BaseConfig.ins.categories[ _k ] );
				}else{
					_data[ _k ].name = '';
				}
				*/
				
				/*
				Common.each( BaseConfig.ins.displaySeries, function( _sk:int, _sitem:Object ):void{
					//_data[ _k ][ 'name' ] = _sitem.name || '';
					_data[ _k ].items.push( {
						'name': _sitem.name
						, 'value': Common.moneyFormat( _sitem.data[ _k ], 3, BaseConfig.ins.floatLen )
					});
				});
				*/
			});
		}
		
		override protected function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;		
			//Log.log( 'TipsView ix', _ix, _srcEvt.stageX, _srcEvt.stageY );
			if( !( _data && _data[ _ix ] ) ) return;
			//Log.printObject( _data[ _ix ] );
			_tips.update( _data[ _ix ], new Point( _srcEvt.stageX, _srcEvt.stageY ), [ BaseConfig.ins.itemColor( _ix ) ] );
		}

	}
}