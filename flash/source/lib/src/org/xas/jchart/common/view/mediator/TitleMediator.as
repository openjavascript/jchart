package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.common.view.components.TitleView;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class TitleMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PTitleMediator';
		private var _text:String;
		private var _view:TitleView;
		public function get view():TitleView{ return _view; }
		
		public function TitleMediator( _text:String )
		{
			super( name );
			
			this._text = _text;
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new TitleView( _text ) );
			
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
					
					_view.x = BaseConfig.ins.c.title.x;
					_view.y = BaseConfig.ins.c.title.y;
					break;
				}
			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}