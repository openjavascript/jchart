package org.xas.core.events
{
	public class XSliderEvent extends BaseEvent
	{
		private static const PREFIX:String = 'XSliderEvent_';
		
		public static const UPDATE:String = PREFIX + 'UPDATE';
		
		public function XSliderEvent($type:String, $data:Object=null)
		{
			super($type, $data);
		}
	}
}