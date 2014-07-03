package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.Security;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.puremvc.as3.multicore.patterns.facade.*;
	import org.xas.chart.histogram.MainFacade;
	import org.xas.core.events.*;
	import org.xas.core.ui.error.BaseError;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	
	[SWF(frameRate="30", width="600", height="400")]
	public class Histogram extends Sprite
	{
		private var _inited: Boolean = false;
		private var _timer:Timer;
		private var _data:Object;
		private var _facade:Facade;
		
		public function Histogram()
		{			
			flash.system.Security.allowDomain("*");	
			
			this.root.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.root.stage.align = StageAlign.TOP_LEFT;
			
			addEventListener( JChartEvent.PROCESS, process );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);	
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );			
		}
		
		private function onEnterFrame( $evt:Event ):void
		{
			if( root.stage.stageWidth > 0 && root.stage.stageHeight > 0 )
			{
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				init();
			}
		}
		private function init():void
		{			
			_inited = true;
			
			Config.setDebug( true );
			Config.setRoot( this.root );
			Config.setChartData( {
				title: { text: 'test title 中文' }
				, t: 'test'
			});
			
			update( Config.cd );
		}
		
		public function update( _data:Object ):void{
			if( !_inited ){
				this._data = _data;
				_timer = new Timer( 50 );
				_timer.addEventListener( TimerEvent.TIMER, timerHandler );
				_timer.start();
				return;
			}
			_timer && _timer.stop();
			
			dispatchEvent( new JChartEvent( JChartEvent.PROCESS, _data ) );
		}
		
		private function process( _evt:JChartEvent ):void{
			//Log.printJSON( _evt.data );
			var _data:Object = _evt.data || {};
			!_facade && ( _facade = MainFacade.getInstance() );
			
			_facade.sendNotification( JChartEvent.DRAW, _data );
		}
		
		private function timerHandler( _evt:TimerEvent ):void{
			if( _inited ){
				_timer && _timer.stop();
				update( this._data );
			}
		}
	}
}