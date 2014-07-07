package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.common.view.components.HLabelView;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.chart.histogram.view.mediator.MainMediator;
	
	public class HLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PHLabelMediator';
		private var _view:HLabelView;
		public function get view():HLabelView{ return _view; }
		
		public function HLabelMediator(  )
		{
			super( name );
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new HLabelView( ) );
			
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
					
					_view.x = Config.c.title.x;
					_view.y = Config.c.title.y;
					break;
				}
			
			}
		}
		
		public function maxHeight():Number{
			return 0;
		}		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}