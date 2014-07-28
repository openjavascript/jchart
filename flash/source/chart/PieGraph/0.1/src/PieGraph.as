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
	import org.xas.jchart.common.config.PieGraphConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.piegraph.MainFacade;
	
	
	[SWF(frameRate="30", width="800", height="400")]
	public class PieGraph extends Sprite
	{ 
		private var _inited: Boolean = false;
		private var _timer:Timer;
		private var _data:Object;
		private var _facade:Facade;
		private var _resizeTimer:Timer;
		private var _ins:PieGraph;
		private var _loaderInfo:Object;
		
		public function PieGraph()
		{			
			flash.system.Security.allowDomain("*");	
			_ins = this; 
			
			this.root.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.root.stage.align = StageAlign.TOP_LEFT;
			
			BaseConfig.setIns( new PieGraphConfig() );
			
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
			//BaseConfig.ins.setChartData( {});
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
				_data = {
					title: { text: 'test title 中文' }
					, subtitle: { text: 'test subtitle 中文' }
					, yAxis: { title: { text: 'vtitle 中文' } }
					, credits: {
						enabled: true
						, text: 'jchart.openjavascript.org'
						, href: 'http://jchart.openjavascript.org/'
					},
					xAxis: {
						categories: [2111111111111, 2, 3, 4, 5, 6, 7, 8, 999999999999]
						, tipTitlePostfix: '{0}月'
					}, 
					series:[{
						name: 'Temperature',
						data: [-50, -1, -3, 10.01, -20, -27, -28, -32, -30]
						}, {
							name: 'Rainfall1',
							data: [-20.10, -21, 50, 100, -10, -210, -220, -100, -20]
						}, {
							name: 'Rainfall2',
							data: [-30, -21, -20, -100, -10, -210, -20, -100, -20]
						}, {
							name: 'Rainfall3',
							data: [-40, -21, -20, -100, -10, -210, -120, -100, -20]
						}
						
					],
					legend: {
						enabled: true
					}
					, displayAllLabel: false
				};
				//_data = {};
			}else{
				_loaderInfo = LoaderInfo(this.root.stage.loaderInfo).parameters||{};				
				_data = _loaderInfo.chart || _data;
			}
			
			update( _data );
		}
	}
}