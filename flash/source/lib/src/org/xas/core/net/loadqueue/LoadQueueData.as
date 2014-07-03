package org.xas.core.net.loadqueue
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class LoadQueueData extends EventDispatcher
	{
		private var _queue:Vector.<String> = new Vector.<String>;
		public function get queue():Vector.<String>{ return _queue; };
		
		public function get length():int{ return _queue.length; }
		
		private var _index:uint = 0;
		public function get index():int{ return _index; }
		
		public var error:uint = 0;
		public var success:uint = 0;
		
		public function LoadQueueData()
		{
		}
		
		public function addItem( $url:String ):void
		{
			_queue.push( $url );
		}
		
		public function reset():void
		{
			_index = 0;
		}
		
		public function get currentItem():String
		{
			var result:String = ''
				
			if( _index < length )
			{
				result = _queue[_index];
				_index++;
			}
			return result;
		}
	}
}