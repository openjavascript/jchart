package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.GraphicBgView;
	import org.xas.jchart.common.view.components.TitleView;
	
	public class GraphicBgMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PChartBgMediator';
		private var _view:GraphicBgView;
		public function get view():GraphicBgView{ return _view; }
		
		public function GraphicBgMediator( )
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( _view = new GraphicBgView() );
			//Log.log( 'ChartBgMediator register' );	
			
			_view.addEventListener( JChartEvent.UPDATE_TIPS, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.UPDATE_TIPS, _evt.data );
			});
			
			_view.addEventListener( JChartEvent.SHOW_TIPS, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.SHOW_TIPS, _evt.data );
			});
			
			_view.addEventListener( JChartEvent.HIDE_TIPS, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.HIDE_TIPS, _evt.data );
			});
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
					_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_CHART ) );
					break;
				}
			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}