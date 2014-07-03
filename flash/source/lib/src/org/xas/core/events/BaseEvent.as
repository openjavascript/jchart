package org.xas.core.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class BaseEvent extends Event
	{
		private var _data:Object = null;
		
		public function BaseEvent( $type:String, $data:Object = null )
		{
			super($type);
			_data = $data;
		}
		
		public function get data():*
		{
			return _data;
		}
	}
}