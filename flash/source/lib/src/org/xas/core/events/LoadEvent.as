package org.xas.core.events
{
	
	public class LoadEvent extends BaseEvent
	{
		public static const COMPLTE:String = 'COMPLTE';
		public static const ALL_COMPLTE:String = 'ALL_COMPLTE';
		public static const ITEM_COMPLTE:String = 'ITEM_COMPLTE';
		public static const INIT_LOAD_VIEW:String = 'INIT_LOAD_VIEW';
		
		public function LoadEvent($type:String, $data:Object = null)
		{
			super($type, $data);
		}
	}
}