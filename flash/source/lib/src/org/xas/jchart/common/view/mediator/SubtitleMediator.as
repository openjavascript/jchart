package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.histogram.view.mediator.MainMediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.SubtitleView;
	import org.xas.jchart.common.view.components.TitleView;
	
	public class SubtitleMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PSubtitleMediator';
		private var _text:String;
		private var _view:SubtitleView;
		public function get view():SubtitleView{ return _view; }
		
		public function SubtitleMediator( _text:String )
		{
			super( name );
			
			this._text = _text;
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new SubtitleView( _text ) );
			
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
					
					_view.x = Config.c.subtitle.x;
					_view.y = Config.c.subtitle.y;
					break;
				}
			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}
