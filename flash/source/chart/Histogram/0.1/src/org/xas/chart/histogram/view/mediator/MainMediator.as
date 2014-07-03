package org.xas.chart.histogram.view.mediator
{
	import flash.display.Sprite;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.chart.histogram.view.components.MainView;
	
	public class MainMediator extends Mediator implements IMediator
	{
		public static const name:String = 'MainMediator';
		
		private var _view:Sprite;
		
		public function MainMediator()
		{
			super( name  );
		}
		
		override public function onRegister():void{
			_view = new MainView();
		}
		
		override public function listNotificationInterests():Array{
			return [
				
			];
		}
		
		private function init():void{
			
		}
		
		
	}
}