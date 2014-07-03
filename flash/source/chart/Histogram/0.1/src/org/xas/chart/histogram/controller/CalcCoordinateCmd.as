package org.xas.chart.histogram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.chart.histogram.view.mediator.MainMediator;
	import org.xas.chart.histogram.view.mediator.TitleMediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.data.Coordinate;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		
		public function CalcCoordinateCmd()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			Log.print( 'CalcCoordinateCmd' );
			
			_c = Config.setCoordinate( new Coordinate() );
			
			_c.corner = stageCorner();
			
			_c.minX = _c.x + 5;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _c.width - 10;
			_c.maxY = _c.y + _c.height - 10;
			
			
			Config.cd 
				&& Config.cd.title
				&& Config.cd.title.text
				&& facade.registerMediator( new TitleMediator( Config.cd.title.text ) )
				;
			//Log.printObject( _c );
		}
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		private function stageCorner():uint{
			return 5;
		}
	}
}