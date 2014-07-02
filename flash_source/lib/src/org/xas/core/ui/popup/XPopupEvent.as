package org.xas.core.ui.popup
{
	import org.xas.core.events.BaseEvent;
	
	public class XPopupEvent extends BaseEvent
	{
		public static const ON_CLOSE:String = 'ON_CLOSE';
		
		public function XPopupEvent($type:String, $data:Object = null)
		{
			super($type, $data);
		}
	}
}