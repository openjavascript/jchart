package org.xas.core.utils
{
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;

	public class FreeMemory
	{
		private static var _instance:FreeMemory = new FreeMemory();
		private var _intervalMs:int;
		private var _timer:Timer;
		
		public function FreeMemory()
		{
			if( _instance )
			{
				throw new Error( 'FreeMemory implement with singleton pattern!');
			}
		}
		
		public static function getInstance():FreeMemory
		{
			return _instance;
		}
		
		public function execute( $intervalMs:int = 120000 ):void
		{
			_intervalMs = $intervalMs;
			if( _timer ) return;
			init();
		}
		
		private function init():void
		{
			releaseMemory();
		}
		/**
		 * 按间隔触发内存回收
		 * @param 	$intervalMs		每间隔多少毫秒进行一次内存回收
		 */
		private function releaseMemory():void
		{
			var timer:Timer = new Timer( _intervalMs, 1 );
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onReleaseMemory);
			timer.start();
		}
		
		private function onReleaseMemory( $event:TimerEvent ):void
		{
			var timer:Timer = Timer( $event.target );
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onReleaseMemory);
			timer = null;
			
			flash.system.System.gc();			
			
			releaseMemory();
		}
	}
}