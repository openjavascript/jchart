package org.xas.jchart.histogram.controller
{
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Config;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.histogram.view.mediator.*;
	
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
			
			//Log.log( Config.rate.length );
			//Log.log( Config.maxNum, Config.finalMaxNum, Config.chartMaxNum, 11111 );
			
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
				
				if( Config.legendEnabled ){
					facade.registerMediator( new LegendMediator() );
					Config.c.maxY -= pLegendMediator.view.height;
					Config.c.legend = { 
						x: Config.width / 2 - pLegendMediator.view.width / 2
						, y: Config.c.maxY
					};
					Config.c.maxY -= 2;
				}
				
				Config.c.maxX -= 5;
				
				facade.registerMediator( new VLabelMediator() );
				Config.c.minX += pVLabelMediator.maxWidth;
				
				facade.registerMediator( new HLabelMediator() );
				Config.c.maxY -= pHLabelMediator.maxHeight;
				
				Config.c.arrowLength = 8;
				Config.c.chartWidth = Config.c.maxX - Config.c.minX - 5;
				Config.c.chartHeight = Config.c.maxY - Config.c.minY;	
				
				Config.c.chartX = Config.c.minX + Config.c.arrowLength - 2;
				Config.c.chartY = Config.c.minY;
				
				facade.registerMediator( new GraphicBgMediator() );	
				facade.registerMediator( new TipsMediator() );
				
				calcChartPoint();
				
				calcGraphic();	
				
				//Log.log( Config.c.chartWidth, Config.c.chartHeight );
			}
									
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{			
			facade.registerMediator( new GraphicMediator() );
			
			Config.c.rects = [];
			if( !( Config.cd.series && Config.cd.series.length ) ) return;
			
			Config.c.partWidth = Config.c.itemWidth / Config.cd.series.length;
			
			Config.each( Config.cd.xAxis.categories, function( _k:int, _item:Object ):void{
				
				var _items:Array = []
					, _pointItem:Object = Config.c.hlinePoint[ _k ]
					, _sp:Point = _pointItem.start as Point
					, _ep:Point = _pointItem.end as Point
					, _x:Number = _sp.x + ( Config.c.itemWidth - Config.c.itemWidth / 2 )
					;
				
				Config.each( Config.cd.series, function( _sk:int, _sitem:Object ):void{
					var _rectItem:Object = {}
						, _num:Number = _sitem.data[ _k ]
						, _itemNum:Number
						, _h:Number, _y:Number
						;
					
					if( Config.isNegative( _num ) ){
						_itemNum = Math.abs( _num );	
						_h = Config.c.vpart * Math.abs( Config.rate.length - Config.rateZeroIndex -1 );
						_y = _sp.y + Config.c.vpart * Config.rateZeroIndex;
						_h = Math.abs( _num / Config.finalMaxNum ) * _h;
					}else{
						_h = Config.c.vpart * Config.rateZeroIndex;
						_h = ( _num / Config.chartMaxNum || 1 ) * _h;
						_y = _sp.y + Config.c.vpart * Config.rateZeroIndex - _h;
					}
					
					//Log.log( _h, _y );
										
					_rectItem.x = _x + _sk * Config.c.partWidth;
					_rectItem.y = _y;
					_rectItem.width = Config.c.partWidth;
					_rectItem.height = _h;
					
					_items.push( _rectItem );
				});
				
				Config.c.rects.push( _items );
			});
		}
		
		private function calcChartPoint():void{
			facade.registerMediator( new BgLineMediator() );
			
			calcChartVPoint();
			calcChartHPoint();
		}
		
		private function calcChartVPoint():void{
			var _partN:Number = Config.c.chartHeight / ( Config.rate.length -1 )
				, _sideLen:Number = Config.c.arrowLength
				;
			Config.c.vpart = _partN;
			Config.c.itemHeight = _partN / 2;
			Config.c.vpoint = [];
			Config.c.vpointReal = [];
			
			Config.each( Config.rate, function( _k:int, _item:* ):void{
				var _n:Number = Config.c.minY + _partN * _k, _sideLen:int = Config.c.arrowLength;
				Config.c.vpoint.push( {
					start: new Point( Config.c.minX, _n )
					, end: new Point( Config.c.maxX, _n )
				});
				
				Config.c.vpointReal.push( {
					start: new Point( Config.c.minX + _sideLen, _n )
					, end: new Point( Config.c.maxX + _sideLen, _n )
				});
			});
		}
		
		private function calcChartHPoint():void{
			var _partN:Number = Config.c.chartWidth / ( Config.categories.length )
				, _sideLen:Number = Config.c.arrowLength
				;
			Config.c.hpart = _partN;
			Config.c.hpoint = [];
			Config.c.hlinePoint = [];
			Config.c.hpointReal = [];
			Config.c.itemWidth = _partN / 2;
						
			Config.each( Config.categories, function( _k:int, _item:* ):void{
				var _n:Number = Config.c.minX + _partN * _k + 5, _sideLen:int = Config.c.arrowLength;
				
				if( _k === 0 ){					
					Config.c.hlinePoint.push( {
						start: new Point( _n, Config.c.minY )
						, end: new Point( _n, Config.c.maxY + 1 )
					});					
				}
								
				Config.c.hlinePoint.push( {
					start: new Point( _n + _partN, Config.c.minY )
					, end: new Point( _n + _partN, Config.c.maxY + 1 )
				});
				
				Config.c.hpoint.push( {
					start: new Point( _n + _partN / 2, Config.c.maxY )
					, end: new Point( _n + _partN / 2, Config.c.maxY + _sideLen )
				});
				
				Config.c.hpointReal.push( {
					start: new Point( _n, Config.c.minY )
					, end: new Point( _n, Config.c.maxY )
				});
			});
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