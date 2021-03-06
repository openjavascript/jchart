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
		protected var _config:BaseConfig;
		
		public function BaseTipsView()
		{
			super();
			
			_config = BaseConfig.ins;
			
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
			
			if( !( _config.displaySeries && _config.displaySeries.length ) ){
				return;
			}			
			_data = {};
		}
		
		protected function showTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;			
			//Log.log( 'TipsView showTips' );
			if( !( _data && _data[ 0 ] ) ) return;
			_tips.buildLayout( _data[ 0 ] ).show( new Point( 10000, 0 ) );
		}
		
		protected function hideTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;		
			//Log.log( 'TipsView hideTips' );
			_tips.hide();
		}		
		
		protected function updateTips( _evt: JChartEvent ):void{
			
		}

	}
}