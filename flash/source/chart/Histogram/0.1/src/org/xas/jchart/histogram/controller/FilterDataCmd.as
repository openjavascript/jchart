package org.xas.jchart.histogram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.view.mediator.BgLineMediator;
	import org.xas.jchart.common.view.mediator.GraphicBgMediator;
	import org.xas.jchart.common.view.mediator.HLabelMediator;
	import org.xas.jchart.common.view.mediator.TipsMediator;
	import org.xas.jchart.common.view.mediator.VLabelMediator;
	import org.xas.jchart.histogram.view.mediator.GraphicMediator;
	
	public class FilterDataCmd extends SimpleCommand implements ICommand
	{
		public function FilterDataCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void{
			Log.log( 'filter data cmd' );
			BaseConfig.ins.updateDisplaySeries( notification.getBody() );
			//Log.printJSON( BaseConfig.ins.displaySeries );
			
			clear();
			update();
		}
		
		private function clear():void{			
			
			facade.hasMediator( VLabelMediator.name ) && facade.removeMediator( VLabelMediator.name );
			facade.hasMediator( HLabelMediator.name ) && facade.removeMediator( HLabelMediator.name );
			facade.hasMediator( GraphicMediator.name ) && facade.removeMediator( GraphicMediator.name );
			facade.hasMediator( GraphicBgMediator.name ) && facade.removeMediator( GraphicBgMediator.name );
			facade.hasMediator( BgLineMediator.name ) && facade.removeMediator( BgLineMediator.name );
			facade.hasMediator( TipsMediator.name ) && facade.removeMediator( TipsMediator.name );
		}
		
		private function update():void{
			
		}
	}
}