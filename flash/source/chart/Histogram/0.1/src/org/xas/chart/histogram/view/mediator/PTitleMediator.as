package org.xas.chart.histogram.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.chart.histogram.view.components.PTitleView;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class PTitleMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PTitleMediator';
		private var _text:String;
		private var _view:PTitleView;
		public function get view():PTitleView{ return _view; }
		
		public function PTitleMediator( _text:String )
		{
			super( name );
			
			this._text = _text;
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new PTitleView( _text ) );
			
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
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}