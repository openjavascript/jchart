package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.*;
	import org.xas.jchart.histogram.view.mediator.MainMediator;
	
	public class LegendMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PLegendMediator';
		private var _view:LegendView;
		public function get view():LegendView{ return _view; }
		
		public function LegendMediator( )
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			mainMediator.view.index7.addChild( _view = new LegendView() );
			//Log.log( 'LegendMediator register' );	
			_view.addEventListener( JChartEvent.FILTER_DATA, function( _evt:JChartEvent ):void{
				sendNotification( JChartEvent.FILTER_DATA, _evt.data );	
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
					//_view.dispatchEvent( new JChartEvent( JChartEvent.SHOW_CHART ) );
					if( !( BaseConfig.ins.c && BaseConfig.ins.c.legend ) ) return;
					
					_view.x = BaseConfig.ins.c.legend.x;
					_view.y = BaseConfig.ins.c.legend.y;
					break;
				}
			
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}