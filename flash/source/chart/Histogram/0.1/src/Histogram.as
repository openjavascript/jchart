package
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.puremvc.as3.multicore.patterns.facade.*;
	import org.xas.core.events.*;
	import org.xas.core.ui.error.BaseError;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.config.HistogramConfig;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.histogram.MainFacade;
	
	
	[SWF(frameRate="30", width="800", height="400")]
	public class Histogram extends Sprite
	{ 
		private var _inited: Boolean = false;
		private var _timer:Timer;
		private var _data:Object;
		private var _facade:Facade;
		private var _resizeTimer:Timer;
		private var _ins:Histogram;
		private var _loaderInfo:Object;
		
		public function Histogram()
		{			
			flash.system.Security.allowDomain("*");	
			_ins = this; 
			
			this.root.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.root.stage.align = StageAlign.TOP_LEFT;
			
			BaseConfig.setIns( new HistogramConfig() );
			 
			//update( {} );	
			  
			addEventListener( JChartEvent.PROCESS, process );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );	
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
			
			BaseConfig.ins.setDebug( true );
			runData();
			
			if( ExternalInterface.available ){
				ExternalInterface.addCallback( 'update', extenalUpdate );
			}
			//BaseConfig.ins.setChartData( {});
		}
		
		private function extenalUpdate( _data:Object ):void{
			BaseConfig.ins.clearData();
			BaseConfig.ins.updateDisplaySeries( null, _data );
			BaseConfig.ins.setChartData( _data );
			_facade.sendNotification( JChartEvent.DRAW );
		}
		
		public function update( _data:Object, _x:int = 0, _y:int = 0 ):void{			
			if( !_inited ){
				_ins._data = _data;
				_timer = new Timer( 50 );
				_timer.addEventListener( TimerEvent.TIMER, timerHandler );
				_timer.start();
				return;
			}
			_timer && _timer.stop();
			
			BaseConfig.ins.updateDisplaySeries( {}, _data );
			dispatchEvent( new JChartEvent( JChartEvent.PROCESS, _data ) );
		}
		
		private function process( _evt:JChartEvent ):void{
			//Log.printJSON( _evt.data );
			var _data:Object = _evt.data as Object;
			BaseConfig.ins.setRoot( _ins.root );
			if( _data ){
				BaseConfig.ins.setChartData( _data );
			}
			!_facade && ( _facade = MainFacade.getInstance() );			
			_facade.sendNotification( JChartEvent.DRAW );
		}
		
		private function timerHandler( _evt:TimerEvent ):void{
			if( _inited ){
				_timer && _timer.stop();
				update( _ins._data );
			}
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);				
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			this.root.stage.addEventListener( Event.RESIZE, resize );
		}
		
		private function resize( _evt:Event ):void{
			if( !BaseConfig.ins.chartData ) return;
			
			if( _resizeTimer ){
				_resizeTimer.stop();
				_resizeTimer.start();
			}else{
				_resizeTimer = new Timer( 200, 1 );
				_resizeTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onResize );
				_resizeTimer.start();
			}
		}
		
		private function onResize( _evt:TimerEvent ):void{
			
			if( !BaseConfig.ins.chartData ) return;
			dispatchEvent( new JChartEvent( JChartEvent.PROCESS, BaseConfig.ins.chartData ) );
			//_facade.sendNotification( JChartEvent.CLEAR );
		}
		
		private function onRemovedFromStage( _evt:Event ):void{
			removeEventListener( JChartEvent.PROCESS, process );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			_timer &&_timer.stop();
		}		
		
		private function runData():void{
			
			var _data:Object = {};
			
			if( !ExternalInterface.available ){		
				_data = DefaultData.instance.data[2];
			}else{
				_loaderInfo = LoaderInfo(this.root.stage.loaderInfo).parameters||{};	
				
				if( _loaderInfo.chart ){
					_data = JSON.parse( _loaderInfo.chart );
				}				
				_data = _data || {};
			}
			
			update( _data );
		}
		
		public static var author:String = 'suches@btbtd.org';
		public static var version:String = '0.1, 2014-07-30';
	}
}