package org.xas.jchart.histogram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.histogram.view.mediator.*;
	
	public class ClearCmd extends SimpleCommand implements ICommand
	{
		public function ClearCmd()
		{
			super();
		}	
		
		override public function execute( notification:INotification ):void{
			
			//Log.log( 'ClearCmd' );
			
			facade.hasMediator( BgMediator.name ) && facade.removeMediator( BgMediator.name );
			facade.hasMediator( TitleMediator.name ) && facade.removeMediator( TitleMediator.name );
			facade.hasMediator( SubtitleMediator.name ) && facade.removeMediator( SubtitleMediator.name );
			facade.hasMediator( VTitleMediator.name ) && facade.removeMediator( VTitleMediator.name );
			facade.hasMediator( CreditMediator.name ) && facade.removeMediator( CreditMediator.name );
			facade.hasMediator( VLabelMediator.name ) && facade.removeMediator( VLabelMediator.name );
			facade.hasMediator( HLabelMediator.name ) && facade.removeMediator( HLabelMediator.name );
			facade.hasMediator( GraphicMediator.name ) && facade.removeMediator( GraphicMediator.name );
			facade.hasMediator( GraphicBgMediator.name ) && facade.removeMediator( GraphicBgMediator.name );
			facade.hasMediator( MainMediator.name ) && facade.removeMediator( MainMediator.name );
			facade.hasMediator( BgLineMediator.name ) && facade.removeMediator( BgLineMediator.name );
			facade.hasMediator( LegendMediator.name ) && facade.removeMediator( LegendMediator.name );
			
		}
	}
}