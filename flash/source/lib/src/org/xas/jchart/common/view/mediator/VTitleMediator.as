package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.TitleView;
	import org.xas.jchart.common.view.components.VTitleView;
	
	public class VTitleMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PVTitleMediator';
		private var _text:String;
		private var _view:VTitleView;
		public function get view():VTitleView{ return _view; }
		
		public function VTitleMediator( _text:String )
		{
			super( name );
			
			this._text = _text; 
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new VTitleView( _text ) );			
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
						_view.x = BaseConfig.ins.c.vtitle.x;
						_view.y = BaseConfig.ins.c.vtitle.y;
						break;
					}			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}