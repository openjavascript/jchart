package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.chart.histogram.view.mediator.MainMediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.*;
	
	public class VLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PVLabelMediator';
		private var _view:VLabelView;
		public function get view():VLabelView{ return _view; }
		
		public function VLabelMediator( )
		{
			super( name );			
		}
		
		override public function onRegister():void{
			
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
					/*
					_view.x = Config.c.title.x;
					_view.y = Config.c.title.y;
					*/
					break;
				}
			
			}
		}
		
		public function maxWidth():Number{
			return 0;
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}