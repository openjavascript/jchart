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
	import org.xas.core.events.*;
	import org.xas.core.ui.error.BaseError;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
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
		
		public function Histogram()
		{			
			flash.system.Security.allowDomain("*");	
			_ins = this; 
			
			this.root.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.root.stage.align = StageAlign.TOP_LEFT;
			
			
			//update( {} );			
			update( {
				title: { text: 'test title 中文' }
				, subtitle: { text: 'test subtitle 中文' }
				, subtitle: { text: 'test subtitle 中文' }
				, yAxis: { title: { text: 'vtitle 中文' } }
				, credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://jchart.openjavascript.org/'
				},
				xAxis: {
					categories: [1, 2, 3, 4, 5, 6, 7, 8, 9]
					, tipTitlePostfix: '{0}月'
				}, 
				series:[{
					name: 'Temperature',
					data: [-50, -1, -3, 10, -20, -27, -28, -32, -30]
				}, {
					name: 'Rainfall1',
					data: [-20, -21, 50, 100, -10, -210, -220, -100, -20]
				}, {
					name: 'Rainfall2',
					data: [-20, -21, -20, -100, -10, -210, -20, -100, -20]
				}, {
					name: 'Rainfall3',
					data: [-20, -21, -20, -100, -10, -210, -120, -100, -20]
				}
				],
				legend: {
					enabled: true
				}
			});
			
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
			
			Config.setDebug( true );
			//Config.setChartData( {});
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
			
			dispatchEvent( new JChartEvent( JChartEvent.PROCESS, _data ) );
		}
		
		private function process( _evt:JChartEvent ):void{
			//Log.printJSON( _evt.data );
			Config.setRoot( _ins.root );
			if( _evt.data as Object ){
				Config.setChartData( _evt.data as Object );
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
			if( !Config.chartData ) return;
			
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
			
			if( !Config.chartData ) return;
			dispatchEvent( new JChartEvent( JChartEvent.PROCESS, Config.chartData ) );
			//_facade.sendNotification( JChartEvent.CLEAR );
		}
		
		private function onRemovedFromStage( _evt:Event ):void{
			removeEventListener( JChartEvent.PROCESS, process );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			_timer &&_timer.stop();
		}
	}
}