package org.xas.chart.histogram.view.mediator
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.xas.chart.histogram.view.components.TitleView;
	
	public class TitleMediator extends Mediator implements IMediator
	{
		private static const name:String = 'TitleMediator';
		private var _text:String;
		private var _view:TitleView;
		
		public function TitleMediator( _text:String )
		{
			super( name );
			
			this._text = _text;
		}
		
		override public function onRegister():void{
			mainMediator.view.index5.addChild( new TitleView( _text ) );
		}
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
	}
}