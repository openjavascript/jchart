package org.xas.core.model.cmdqueue
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class CmdQueue extends EventDispatcher
	{
		private var _max:int;
		
		private var _data:Vector.<Object> = new Vector.<Object>();
		
		public function CmdQueue($maxItems:int = 50)
		{
			_max = $maxItems;
		}
		
		public function add( $data:Object ):void
		{
			_data.push( $data );
			if( _data.length > _max )
			{
				while( _data.length > _max )
				{
					_data.shift();
				}
			}
		}
		
		public function get items():Vector.<Object>{ return _data; }
		public function get length():int{ return _data.length; }
		public function get max():int{ return _max; }
		
		public function getItemAt($ix:int):Object{ return _data[$ix]; }
	}
}