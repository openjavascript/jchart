package org.xas.core.ui.nav
{
	import org.xas.core.events.BaseEvent;
	
	public class NavigatorEvent extends BaseEvent
	{
		public static const ON_CLOSE:String = 'ON_CLOSE';
		public static const ON_ITEM_CLICK:String = 'ON_ITEM_CLICK';
		public static const ON_POPUP_POSITION_CHANGE:String = 'ON_POPUP_POSITION_CHANGE';
		
		public function NavigatorEvent($type:String, $data:Object=null)
		{
			super($type, $data);
		}
	}
}