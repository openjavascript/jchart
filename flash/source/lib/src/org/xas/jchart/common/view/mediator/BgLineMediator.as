package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.histogram.view.mediator.MainMediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.BgLineView;
	
	public class BgLineMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PBgLineMediator';
		private var _view:BgLineView;
		public function get view():BgLineView{ return _view; }
		
		public function BgLineMediator()
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new BgLineView() );			
		}
		
		override public function listNotificationInterests():Array{
			return [
				JChartEvent.SHOW_CHART
			];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch( notification.getName() ){
				case JChartEvent.SHOW_CHART:
					{								
						_view.update();
						break;
					}			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}