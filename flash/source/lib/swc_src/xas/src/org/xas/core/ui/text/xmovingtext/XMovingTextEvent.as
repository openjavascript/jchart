package org.xas.core.ui.text.xmovingtext
{
	import org.xas.core.events.BaseEvent;
	
	public class XMovingTextEvent extends BaseEvent
	{
		private static const PREFIX:String = 'XMovingTextEvent_';
		
		public static const PLAY_DONE:String =  PREFIX + 'PLAY_DONE';
		public static const PLAY:String =  PREFIX + 'PLAY';
		
		public function XMovingTextEvent($type:String, $data:Object=null)
		{
			super($type, $data);
		}
	}
}