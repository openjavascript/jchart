package org.xas.jchart.common.view.components
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
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.TipsUI;
	
	public class TipsView extends Sprite
	{	
		private var _data:Object;
		private var _tips:TipsUI;
		
		public function TipsView()
		{
			super();
			
			addEventListener( JChartEvent.SHOW_TIPS, showTips );
			addEventListener( JChartEvent.UPDATE_TIPS, updateTips );
			addEventListener( JChartEvent.HIDE_TIPS, hideTips );
			
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			
			init();
		}
		
		private function init():void{
			buildData();
			
			addChild( _tips = new TipsUI() );
		}
		
		private function buildData():void{
			
			if( !Config.series.length ){
				return;
			}
			
			_data = { test: 't' };
			
			Config.each( Config.series[0].data, function( _k:int, _item:Number ):void{
				_data[ _k ] = { data: [] };
				
				if( Config.categories.length ){
					_data[ _k ].name = StringUtils.printf( Config.tipTitlePostfix,  Config.categories[ _k ] );
				}else{
					_data[ _k ].name = '';
				}
				
				Config.each( Config.series, function( _sk:int, _sitem:Object ):void{
					//_data[ _k ][ 'name' ] = _sitem.name || '';
					_data[ _k ].data.push( {
						'name': _sitem.name
						, 'value': _sitem.data[ _k ]
					});
				});
			});
			
			//Log.printObject( _data );
		}
		
		private function showTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;			
			//Log.log( 'TipsView showTips' );
			if( !( _data && _data[ 0 ] ) ) return;
			_tips.buildLayout( _data[ 0 ] ).show( new Point( 10000, 0 ) );
		}
		
		private function hideTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;		
			//Log.log( 'TipsView hideTips' );
			_tips.hide();
		}		
		
		private function updateTips( _evt: JChartEvent ):void{
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