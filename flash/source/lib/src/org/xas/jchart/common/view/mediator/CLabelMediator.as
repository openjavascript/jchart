package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.common.view.components.CLabelView;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class CLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PCLabelMediator';
		private var _view:CLabelView;
		public function get view():CLabelView{ return _view; }
		
		public function CLabelMediator(  )
		{
			super( name );
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new CLabelView( ) );
		}
		
		override public function onRemove():void{
			_view.parent.removeChild( _view );
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
		
		public function get maxHeight():Number{
			return _view.maxHeight;
		}		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}