package org.xas.jchart.common.event
{
	import org.xas.core.events.BaseEvent;
	
	public class JChartEvent extends BaseEvent
	{
		public static const PROCESS:String = 'process';
		public static const CALC_COORDINATE:String = 'calc_coordinate';
		
		public static const DRAW:String = 'draw';
		public static const CLEAR:String = 'clear';
		
		public function JChartEvent($type:String, $data:Object=null)
		{
			super($type, $data);
		}
	}
}