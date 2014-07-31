package org.xas.jchart.common.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.components.TestView;
	
	public class TestMediator extends Mediator implements IMediator
	{
		public static const name:String = 'PTestMediator';
		private var _view:TestView;
		public function get view():TestView{ return _view; }
		private var _data:Vector.<Object>;
		
		public function TestMediator( _data:Vector.<Object> )
		{		
			super( name );
			this._data = _data;
		}
		
		override public function onRegister():void{
			mainMediator.view.index9.addChild( _view = new TestView( _data ) );
			_view.addEventListener( JChartEvent.UPDATE, onUpdateTestData );
		}
		
		private function onUpdateTestData( _evt:JChartEvent ):void{
			var _index:int = _evt.data.index
				, _data:Object = _evt.data.data
				;
			//Log.log( _index );
			//Log.printJSON( _data );
			BaseConfig.ins.clearData();
			BaseConfig.ins.updateDisplaySeries( null, _data );
			BaseConfig.ins.setChartData( _data );
			sendNotification( JChartEvent.DRAW );
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
					_view.x = 0;
					_view.y = 0;
					break;
				}
					
			}
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
	}
}