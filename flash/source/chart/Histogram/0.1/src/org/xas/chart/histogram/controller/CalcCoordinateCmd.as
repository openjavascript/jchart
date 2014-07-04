package org.xas.chart.histogram.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.chart.histogram.view.mediator.MainMediator;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.BgMediator;
	import org.xas.jchart.common.view.mediator.SubtitleMediator;
	import org.xas.jchart.common.view.mediator.TitleMediator;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		
		public function CalcCoordinateCmd()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			
			_c = Config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x + 5;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _c.width - 10;
			_c.maxY = _c.y + _c.height - 10;
						
			facade.registerMediator( new BgMediator( ) )	
			
			if( Config.cd ){					
				if( Config.cd.title && Config.cd.title.text ){
					facade.registerMediator( new TitleMediator( Config.cd.title.text ) )	
					Config.c.title = { x: _c.width / 2, y: _c.minY, item: pTitleMediator };
					Config.c.minY += pTitleMediator.view.height;			
				}
				
				if( Config.cd.subtitle && Config.cd.subtitle.text ){
					facade.registerMediator( new SubtitleMediator( Config.cd.subtitle.text ) )
						
					Config.c.subtitle = { x: _c.width / 2, y: _c.minY, item: pSubtitleMediator };
					Config.c.minY += pSubtitleMediator.view.height + 5;
				}
			}
			
			
			
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function get pSubtitleMediator():SubtitleMediator{
			return facade.retrieveMediator( SubtitleMediator.name ) as SubtitleMediator;
		}
		
		private function get pTitleMediator():TitleMediator{
			return facade.retrieveMediator( TitleMediator.name ) as TitleMediator;
		}
		
		
		private function get mainMediator():MainMediator{
			return facade.retrieveMediator( MainMediator.name ) as MainMediator;
		}
		
		private function corner():uint{
			return 20;
		}
	}
}