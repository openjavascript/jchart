package org.xas.core.net.checknew
{
	import org.xas.core.events.BaseEvent;
	
	public class CheckNewEvent extends BaseEvent
	{
		public static const HAS_NEW_VERSION:String = 'HAS_NEW_VERSION';
		public static const ON_DATA:String = 'ON_DATA';
		
		public function CheckNewEvent($type:String, $data:Object = null)
		{
			super($type, $data);
		}
	}
}