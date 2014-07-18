package org.xas.jchart.curvegram.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.MainMediator;
	import org.xas.jchart.curvegram.view.components.GraphicView;
	
	public class GraphicMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PChartMediator';
		private var _view:GraphicView;
		public function get view():GraphicView{ return _view; }
		
		public function GraphicMediator()
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			mainMediator.view.index6.addChild( _view = new GraphicView() );			
		}
		
		override public function onRemove():void{
			_view.parent.removeChild( _view );
		}
		
		override public function listNotificationInterests():Array{
			return [
				JChartEvent.SHOW_CHART
				, JChartEvent.UPDATE_TIPS
				, JChartEvent.SHOW_TIPS
				, JChartEvent.HIDE_TIPS
			];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch( notification.getName() ){
				case JChartEvent.SHOW_CHART:
					{								
						_view.update();
						break;
					}	
				case JChartEvent.UPDATE_TIPS:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.UPDATE_TIPS, notification.getBody() ) );
					break;
				}	
				case JChartEvent.SHOW_TIPS:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_TIPS, notification.getBody() ) );
					break;
				}	
				case JChartEvent.HIDE_TIPS:
				{
					_view.dispatchEvent( new JChartEvent( JChartEvent.HIDE_TIPS, notification.getBody() ) );
					break;
				}
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}