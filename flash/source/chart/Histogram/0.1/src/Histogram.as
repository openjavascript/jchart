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
	
	import org.xas.core.events.*;
	import org.xas.core.utils.Log;
	
	[SWF(frameRate="30", width="600", height="400")]
	public class Histogram extends Sprite
	{
		private var _inited: Boolean = false;
		private var _timer:Timer;
		private var _data:Object;
		
		public function Histogram()
		{
			Log.debug = true;
			
			flash.system.Security.allowDomain("*");	
			
			this.root.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.root.stage.align = StageAlign.TOP_LEFT;
			
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
		}
		
		public function update( _data:Object ):void{
			if( !_inited ){
				this._data = _data;
				_timer = new Timer( 50 );
				_timer.addEventListener( 'timer', timerHandler );
				_timer.start();
				return;
			}
			_timer && _timer.stop();
			
			dispatchEvent( new BaseEvent( 'process', _data ) );
		}
		
		private function timerHandler( _evt:TimerEvent ):void{
			if( _inited ){
				_timer && _timer.stop();
				update( this._data );
			}
		}
	}
}