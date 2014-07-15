package org.xas.jchart.histogram.view.mediator
{
	import flash.display.Sprite;
	import flash.utils.describeType;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.jchart.histogram.view.components.MainView;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class MainMediator extends Mediator implements IMediator
	{
		public static const name:String = 'MainMediator';
		
		private var _view:MainView;
		public function get view():MainView{ return _view; }
		
		public function MainMediator()
		{
			super( name  );
		}
		
		override public function onRegister():void{
			
			Config.root.stage.addChild( _view = new MainView() );
			
			sendNotification( JChartEvent.CALC_COORDINATE );
			//Log.printClass( Config.root );
		}
		
		override public function listNotificationInterests():Array{
			return [
				
			];
		}
		
		private function init():void{
			
		}
		
		
	}
}