package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.SerialLabel.BaseSerialLabelView;
	import org.xas.jchart.common.view.components.SerialLabel.HistogramSerialLabelView;
	import org.xas.jchart.common.view.components.TitleView;
	
	public class SerialLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PDataLabelMediator';
		private var _view:BaseSerialLabelView;
		public function get view():BaseSerialLabelView{ return _view; }
		
		public function SerialLabelMediator( )
		{
			super( name );
			
		}
		
		override public function onRegister():void{
			//Log.log( 'DataLabelMediator register' );				
			switch( (facade as BaseFacade).name ){
				case 'HistogramFacade':
				{
					mainMediator.view.index7.addChild( _view = new HistogramSerialLabelView() );
					break;
				}
				default:{
					mainMediator.view.index7.addChild( _view = new BaseSerialLabelView() );
					break;
				}
			}	
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
		
		public function get maxHeight():Number{
			var _r:Number = 0;
			_view && ( _r = _view.maxHeight );
			return _r;
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}