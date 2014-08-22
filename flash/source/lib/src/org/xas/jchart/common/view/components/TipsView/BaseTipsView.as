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
	
	public class BaseTipsView extends Sprite
	{	
		protected var _data:Object;
		protected var _tips:TipsUI;
		
		public function BaseTipsView()
		{
			super();
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		protected function addToStage( _evt:Event ):void{
			
			init();
		}
		
		protected function init():void{
			buildData();
			
			addChild( _tips = new TipsUI() );
		}
		
		protected function buildData():void{
			
			if( !( BaseConfig.ins.displaySeries && BaseConfig.ins.displaySeries.length ) ){
				return;
			}
			
			_data = {};
			
			Common.each( BaseConfig.ins.displaySeries[0].data, function( _k:int, _item:Number ):void{
				_data[ _k ] = { items: [] };
				

				var _format:String = BaseConfig.ins.tooltipHeaderFormat;
				_data[ _k ].name = StringUtils.printf( _format,  BaseConfig.ins.getTipsHeader( _k ) );
				
				Common.each( BaseConfig.ins.displaySeries, function( _sk:int, _sitem:Object ):void{
					//_data[ _k ][ 'name' ] = _sitem.name || '';
					//Log.log( 'xxxxxxx', _sitem.data[_k] );
					
					var _name:String = _sitem.name + ''
						, _value:String = StringUtils.printf( BaseConfig.ins.tooltipPointFormat, 
							Common.moneyFormat( _sitem.data[ _k ], 3, BaseConfig.ins.floatLen )
						)
						
					_data[ _k ].items.push( {
						'name': _name
						, 'value': _value
					});
				});
			});
			
			//Log.printObject( _data );
		}
		
		protected function showTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;			
			//Log.log( 'TipsView showTips' );
			if( !( _data && _data[ 0 ] ) ) return;
			_tips.buildLayout( _data[ 0 ], BaseConfig.ins.tooltipSerial ).show( new Point( 10000, 0 ) );
		}
		
		protected function hideTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;		
			//Log.log( 'TipsView hideTips' );
			_tips.hide();
		}		
		
		protected function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;		
			//Log.log( 'TipsView ix', _ix, _srcEvt.stageX, _srcEvt.stageY );
			if( !( _data && _data[ _ix ] ) ) return;
			//Log.printObject( _data[ _ix ] );
			_tips.update( _data[ _ix ], new Point( _srcEvt.stageX, _srcEvt.stageY ) );
		}

	}
}