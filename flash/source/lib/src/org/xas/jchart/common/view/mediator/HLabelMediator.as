package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.HLabelView.BaseHLabelView;
	import org.xas.jchart.common.view.components.HLabelView.CurveGramHLabelView;
	import org.xas.jchart.common.view.components.HLabelView.HistogramHLabelView;
	
	public class HLabelMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PHLabelMediator';
		private var _view:BaseHLabelView;
		public function get view():BaseHLabelView{ return _view; }
		
		public function HLabelMediator(  )
		{
			super( name );
		}
		
		override public function onRegister():void{
			
			switch( (facade as BaseFacade).name ){
				case 'CurveGramFacade':
				{
					mainMediator.view.index5.addChild( _view = new CurveGramHLabelView() );
					break;
				}
				case 'HistogramFacade':
				{
					mainMediator.view.index5.addChild( _view = new HistogramHLabelView() );
					break;
				}
				default:{
					mainMediator.view.index5.addChild( _view = new BaseHLabelView() ); 
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
					_view.dispatchEvent( new JChartEvent( JChartEvent.UPDATE ) );
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