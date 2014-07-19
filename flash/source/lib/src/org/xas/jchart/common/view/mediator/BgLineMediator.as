package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseFacade;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.BgLineView.*;
	
	public class BgLineMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PBgLineMediator';
		private var _view:BaseBgLineView;
		public function get view():BaseBgLineView{ return _view; }
		
		public function BgLineMediator()
		{
			super( name );
		}
		
		override public function onRegister():void{
			
			switch( (facade as BaseFacade).name ){
				case 'CurveGramFacade':{
					mainMediator.view.index5.addChild( _view = new CurveGramBgLineView() );
					break;
				}
				case 'HistogramFacade':{
					mainMediator.view.index5.addChild( _view = new HistogramBgLineView() );
					break;
				}
				default:{
					mainMediator.view.index5.addChild( _view = new BaseBgLineView() );
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