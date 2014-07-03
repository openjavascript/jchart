package org.xas.core.events
{
	public class XModuleEvent extends BaseEvent
	{
		private static const PREFIX:String = 'XModuleEvent_';
		public static const ON_MODULE_EVENT:String = PREFIX + 'ON_MODULE_EVENT';
		
		public function XModuleEvent($type:String, $data:Object=null)
		{
			super($type, $data);
		}
	}
}