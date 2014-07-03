package org.xas.core.ui.dialog
{
	import org.xas.core.events.BaseEvent;
	
	public class XDialogEvent extends BaseEvent
	{
		public static const ON_ALERT_CLICK:String = 'ON_ALERT_CLICK';
		
		public static const ON_POPUP_POSITION_CHANGE:String = 'ON_POPUP_POSITION_CHANGE';
		
		public function XDialogEvent($type:String, $data:Object = null)
		{
			super($type, $data);
		}
	}
}