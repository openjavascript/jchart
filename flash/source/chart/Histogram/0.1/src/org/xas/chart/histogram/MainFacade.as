package org.xas.chart.histogram
{
	import flash.net.registerClassAlias;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.facade.*;
	import org.xas.chart.histogram.controller.CalcCoordinateCmd;
	import org.xas.chart.histogram.controller.ClearCmd;
	import org.xas.chart.histogram.controller.DrawCmd;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class MainFacade extends Facade implements ICommand
	{
		public static const name:String = 'HistogramFacade';
		
		public function MainFacade( _name:String )
		{
			super( _name );
		}
		
		public function execute( notification:INotification ):void{
		}
		
		public static function getInstance():Facade {
			if ( instanceMap[ name ] == null ) instanceMap[ name ]  = new MainFacade( name );
			return instanceMap[ name ] as MainFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
						
			registerCommand( JChartEvent.CALC_COORDINATE, CalcCoordinateCmd );
			
			registerCommand( JChartEvent.CLEAR, ClearCmd );
			registerCommand( JChartEvent.DRAW, DrawCmd );
		}			
	}
}