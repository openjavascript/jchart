package org.xas.jchart.piegraph.controller
{
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.piegraph.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		
		public function CalcCoordinateCmd()
		{
			super();
		}
		
		override public function execute(notification:INotification):void{
			
			_c = BaseConfig.ins.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _c.width - 5;
			_c.maxY = _c.y + _c.height - 5;
						
			facade.registerMediator( new BgMediator( ) )		
			
			//Log.log( BaseConfig.ins.rate.length );
			//Log.log( BaseConfig.ins.maxNum, BaseConfig.ins.finalMaxNum, BaseConfig.ins.chartMaxNum, 11111 );
			
			if( BaseConfig.ins.cd ){			
				
				if( BaseConfig.ins.cd.title && BaseConfig.ins.cd.title.text ){
					facade.registerMediator( new TitleMediator( BaseConfig.ins.cd.title.text ) )	
					BaseConfig.ins.c.title = { x: _c.width / 2, y: _c.minY, item: pTitleMediator };
					BaseConfig.ins.c.minY += pTitleMediator.view.height;			
				}
				
				if( BaseConfig.ins.cd.subtitle && BaseConfig.ins.cd.subtitle.text ){
					facade.registerMediator( new SubtitleMediator( BaseConfig.ins.cd.subtitle.text ) )
					
					BaseConfig.ins.c.subtitle = { x: _c.width / 2, y: _c.minY, item: pSubtitleMediator };
					BaseConfig.ins.c.minY += pSubtitleMediator.view.height + 5;
				}				
				
				if( BaseConfig.ins.cd.yAxis && BaseConfig.ins.cd.yAxis.title && BaseConfig.ins.cd.yAxis.title.text ){
					facade.registerMediator( new VTitleMediator( BaseConfig.ins.cd.yAxis.title.text ) )
					
					BaseConfig.ins.c.vtitle = { x: BaseConfig.ins.c.minX, y: BaseConfig.ins.c.x + BaseConfig.ins.c.height / 2, item: pVTitleMediator };
					BaseConfig.ins.c.minX += pVTitleMediator.view.width - 5;
				}
				
				if( BaseConfig.ins.cd.credits && BaseConfig.ins.cd.credits.enabled && ( BaseConfig.ins.cd.credits.text || BaseConfig.ins.cd.credits.href ) ){
					facade.registerMediator( new CreditMediator( BaseConfig.ins.cd.credits.text, BaseConfig.ins.cd.credits.href ) )
					
					BaseConfig.ins.c.credits = { x: BaseConfig.ins.c.maxX, y: BaseConfig.ins.c.maxY, item: pCreditMediator };
					BaseConfig.ins.c.maxY -= pCreditMediator.view.height;
				}	
				
				if( BaseConfig.ins.legendEnabled ){
					facade.registerMediator( new LegendMediator() );
					BaseConfig.ins.c.maxY -= pLegendMediator.view.height;
					BaseConfig.ins.c.legend = { 
						x: BaseConfig.ins.width / 2 - pLegendMediator.view.width / 2
						, y: BaseConfig.ins.c.maxY
					};
					BaseConfig.ins.c.maxY -= 2;
				}
				
				BaseConfig.ins.c.maxX -= 5;
				
				/*
				facade.registerMediator( new VLabelMediator() );
				BaseConfig.ins.c.minX += pVLabelMediator.maxWidth;
				
				facade.registerMediator( new HLabelMediator() );
				BaseConfig.ins.c.maxY -= pHLabelMediator.maxHeight;
				*/
				
				BaseConfig.ins.c.arrowLength = 0;
				BaseConfig.ins.c.chartWidth = BaseConfig.ins.c.maxX - BaseConfig.ins.c.minX - 5;
				BaseConfig.ins.c.chartHeight = BaseConfig.ins.c.maxY - BaseConfig.ins.c.minY;	
				
				BaseConfig.ins.c.chartX = BaseConfig.ins.c.minX + BaseConfig.ins.c.arrowLength - 2;
				BaseConfig.ins.c.chartY = BaseConfig.ins.c.minY;
				
				facade.registerMediator( new GraphicBgMediator() );	
				//facade.registerMediator( new TipsMediator() );
								
				calcGraphic();	
				
				//Log.log( BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight );
			}
									
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{			
			facade.registerMediator( new GraphicMediator() );
			
			BaseConfig.ins.c.cx = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth / 2;
			BaseConfig.ins.c.cy = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight / 2;
			BaseConfig.ins.c.lineLength = 40;
			BaseConfig.ins.c.lineStart = 10;
			BaseConfig.ins.c.radius = calcRadius( BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight );
			
			BaseConfig.ins.c.piePart = [];
			BaseConfig.ins.c.pieLine = [];
			
			if( !( BaseConfig.ins.series && BaseConfig.ins.series.length ) ) return;
			
			var _angle:Number = 360
				, _angleCount:Number = 0
				, _offsetAngle:Number = BaseConfig.ins.offsetAngle
				, _totalNum:Number = BaseConfig.ins.totalNum
				, _tmpPoint:Point
				;

			Common.each( BaseConfig.ins.displaySeries, function( _k:int, _item:Object ):void {
				var _pieP:Object = { 
						cx: BaseConfig.ins.c.cx
						, cy: BaseConfig.ins.c.cy
						, radius: BaseConfig.ins.c.radius 
						, offsetAngle: _offsetAngle
					}
					, _pieL:Object  = {}
					;
			});
		}
		
		private function calcRadius( _w:Number, _h:Number ):Number{
			var _radius:Number = Math.min( _w, _h );
			
			if( BaseConfig.ins.legendEnabled ){
				_radius -= 30;
			}
			
			if( BaseConfig.ins.dataLabelEnabled ){
				_radius -= ( BaseConfig.ins.c.lineLength - BaseConfig.ins.c.lineStart + 40 ) * 2;
			}else{
				_radius -= 40;
			}
			
			_radius /= 2;
			
			return _radius;
		}
		
		private function get pLegendMediator():LegendMediator{
			return facade.retrieveMediator( LegendMediator.name ) as LegendMediator;
		}
		
		private function get pHLabelMediator():HLabelMediator{
			return facade.retrieveMediator( HLabelMediator.name ) as HLabelMediator;
		}
		
		private function get pVLabelMediator():VLabelMediator{
			return facade.retrieveMediator( VLabelMediator.name ) as VLabelMediator;
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