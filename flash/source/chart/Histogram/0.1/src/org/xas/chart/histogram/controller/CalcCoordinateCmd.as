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
	import org.xas.jchart.common.view.mediator.*;
	
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
			
			_c.minX = _c.x;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _c.width - 5;
			_c.maxY = _c.y + _c.height - 5;
						
			facade.registerMediator( new BgMediator( ) )	
				
			Config.setChartData( {
				title: { text: 'test title 中文' }
				, subtitle: { text: 'test subtitle 中文' }
				, subtitle: { text: 'test subtitle 中文' }
				, yAxis: { title: { text: 'vtitle 中文' } }
				, credits: {
					enabled: true
					, text: 'jchart.openjavascript.org'
					, href: 'http://jchart.openjavascript.org/'
				},
				xAxis: {
					categories: [1, 2, 3, 4, 5, 6, 7, 8, 9]
					, tipTitlePostfix: '{0}月'
				}, 
				series:[{
					name: 'Temperature',
					data: [-50, -1, -3, -10, -20, -27, -28, -32, -30]
				}, {
					name: 'Rainfall',
					data: [-20, -21, -20, -100, -10, -210, -220, -100, -20]
				}, {
					name: 'Rainfall',
					data: [-20, -21, -20, -100, -10, -210, -220, -100, -20]
				}, {
					name: 'Rainfall',
					data: [-20, -21, -20, -100, -10, -210, -220, -100, -20]
				}
				],
				legend: {
					enabled: false
				}
			});
			
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
				
				if( Config.cd.yAxis && Config.cd.yAxis.title && Config.cd.yAxis.title.text ){
					facade.registerMediator( new VTitleMediator( Config.cd.yAxis.title.text ) )
					
					Config.c.vtitle = { x: Config.c.minX, y: Config.c.x + Config.c.height / 2, item: pVTitleMediator };
					Config.c.minX += pVTitleMediator.view.width;
				}
				
				if( Config.cd.credits && Config.cd.credits.enabled && ( Config.cd.credits.text || Config.cd.credits.href ) ){
					facade.registerMediator( new CreditMediator( Config.cd.credits.text, Config.cd.credits.href ) )
					
					Config.c.credits = { x: Config.c.maxX, y: Config.c.maxY, item: pCreditMediator };
					Config.c.maxY -= pCreditMediator.view.height;
				}	
			}
			
						
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function get pCreditMediator():CreditMediator{
			return facade.retrieveMediator( CreditMediator.name ) as CreditMediator;
		}
		
		private function get pVTitleMediator():VTitleMediator{
			return facade.retrieveMediator( VTitleMediator.name ) as VTitleMediator;
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