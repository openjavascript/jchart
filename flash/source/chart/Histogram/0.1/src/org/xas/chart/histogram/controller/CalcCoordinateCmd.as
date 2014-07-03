package org.xas.chart.histogram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		public function CalcCoordinateCmd()
		{
			super();
		}
	}
}