package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.CreditView;
	
	public class CreditMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PCreditMediator';
		private var _text:String, _href:String;
		private var _view:CreditView;
		public function get view():CreditView{ return _view; }
		
		public function CreditMediator( _text:String, _href:String )
		{
			super( name );
			
			this._text = _text;
			this._href = _href;
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new CreditView( _text, _href ) );
			
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
					
					_view.x = BaseConfig.ins.c.credits.x;
					_view.y = BaseConfig.ins.c.credits.y;
					break;
				}
			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}