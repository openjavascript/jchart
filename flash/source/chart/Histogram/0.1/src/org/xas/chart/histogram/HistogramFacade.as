package org.xas.chart.histogram
{
	import flash.net.registerClassAlias;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.facade.*;
	
	public class HistogramFacade extends Facade implements ICommand
	{
		public static const name:String = 'HistogramFacade';
		
		public function HistogramFacade( _name:String )
		{
			super( _name );
		}
		
		public function execute( notification:INotification ):void{
			
		}
		
		public static function getInstance():Facade {
			if ( instanceMap[ name ] == null ) instanceMap[ name ]  = new HistogramFacade( name );
			return instanceMap[ name ] as HistogramFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
		}	
		
	}
}