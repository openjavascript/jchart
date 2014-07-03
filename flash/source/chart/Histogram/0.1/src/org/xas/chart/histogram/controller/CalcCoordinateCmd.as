package org.xas.chart.histogram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.chart.histogram.view.mediator.MainMediator;
	import org.xas.chart.histogram.view.mediator.PTitleMediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		
		public function CalcCoordinateCmd()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			
			_c = Config.setCoordinate( new Coordinate() );
			
			_c.corner = stageCorner();
			
			_c.minX = _c.x + 5;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _c.width - 10;
			_c.maxY = _c.y + _c.height - 10;
			
			if( Config.cd && Config.cd.title && Config.cd.title.text ){
				facade.registerMediator( new PTitleMediator( Config.cd.title.text ) )

				Config.c.title = { x: _c.width / 2, y: _c.y, item: pTitleMediator };
				Config.c.y += pTitleMediator.view.height + 5;			
			}
			sendNotification( JChartEvent.SHOW_CHART );
			
		}
		
		private function get pTitleMediator():PTitleMediator{
			return facade.retrieveMediator( PTitleMediator.name ) as PTitleMediator;
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		private function stageCorner():uint{
			return 5;
		}
	}
}