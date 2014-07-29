package org.xas.jchart.common.view.components.TipsView
{
	import flash.events.MouseEvent;
	
	import org.xas.jchart.common.event.JChartEvent;

	public class PieTipsView extends BaseTipsView
	{
		public function PieTipsView()
		{
			super();
		}
		
		
		override protected function buildData():void{
		}
		
		override protected function showTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;			
		}
		
		override protected function hideTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data as MouseEvent;		
		}		
		
		override protected function updateTips( _evt: JChartEvent ):void{
			var _srcEvt:MouseEvent = _evt.data.evt as MouseEvent
				, _ix:int = _evt.data.index as int
				;		
		}
	}
}