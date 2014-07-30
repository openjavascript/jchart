package org.xas.jchart.curvegram.controller
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
	import org.xas.jchart.curvegram.view.mediator.*;
	
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
				
				facade.registerMediator( new VLabelMediator() );
				BaseConfig.ins.c.minX += pVLabelMediator.maxWidth;
				
				facade.registerMediator( new HLabelMediator() );
				BaseConfig.ins.c.maxY -= pHLabelMediator.maxHeight;
				
				BaseConfig.ins.c.arrowLength = 8;
				BaseConfig.ins.c.chartWidth = BaseConfig.ins.c.maxX - BaseConfig.ins.c.minX - 5;
				BaseConfig.ins.c.chartHeight = BaseConfig.ins.c.maxY - BaseConfig.ins.c.minY;	
				
				BaseConfig.ins.c.chartX = BaseConfig.ins.c.minX + BaseConfig.ins.c.arrowLength - 2;
				BaseConfig.ins.c.chartY = BaseConfig.ins.c.minY;
				
				facade.registerMediator( new GraphicBgMediator() );	
				facade.registerMediator( new TipsMediator() );
				
				calcChartPoint();
				
				calcGraphic();	
				
				//Log.log( BaseConfig.ins.c.chartWidth, BaseConfig.ins.c.chartHeight );
			}
									
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{			
			facade.registerMediator( new GraphicMediator() );
			
			BaseConfig.ins.c.paths = [];
			if( !( BaseConfig.ins.series && BaseConfig.ins.series.length ) ) return;
			BaseConfig.ins.c.partWidth = BaseConfig.ins.c.itemWidth / BaseConfig.ins.displaySeries.length;

			
			Common.each( BaseConfig.ins.displaySeries, function( _k:int, _item:Object ):void{
				
				var _cmd:Vector.<int> = new Vector.<int>
				, _path:Vector.<Number> = new Vector.<Number>
				;				
				
				Common.each( _item.data, function( _sk:int, _num:Number ):void{
					var _rectItem:Object = {}
						, _pointItem:Object = BaseConfig.ins.c.hlinePoint[ _sk ]
						, _sp:Point = _pointItem.start as Point
						, _ep:Point = _pointItem.end as Point
						, _h:Number, _x:Number, _y:Number
						, _itemNum:Number
						, _dataHeight:Number
						, _dataY:Number
						;
						//Log.log( _sk, _sp.x, _sp.y );
						
						if( Common.isNegative( _num ) || _num == 0 ){
							_num = Math.abs( _num );
							_h = BaseConfig.ins.c.vpart * BaseConfig.ins.rateZeroIndex;
							_dataHeight = BaseConfig.ins.c.chartHeight - _h;
							_dataHeight = 
								( _num / 
									Math.abs( BaseConfig.ins.chartMaxNum * BaseConfig.ins.rate[ BaseConfig.ins.rate.length - 1 ] ) ) 
								* _dataHeight;
							Log.log( _num, BaseConfig.ins.chartMaxNum, _dataHeight, BaseConfig.ins.rate[ BaseConfig.ins.rate.length - 1 ] );
							_y = _sp.y + _h + _dataHeight;
						}else{							
							_h = BaseConfig.ins.c.vpart * BaseConfig.ins.rateZeroIndex;
							_h = ( _num / BaseConfig.ins.chartMaxNum || 1 ) * _h;
							_y = _sp.y 
								+ BaseConfig.ins.c.vpart * BaseConfig.ins.rateZeroIndex - _h
								;
						}
						_x = _sp.x;
						
						_cmd.push( _sk === 0 ? 1 : 2 );
						_path.push( _x, _y );
					//Log.log( _y, _sp.y, BaseConfig.ins.c.vpart, BaseConfig.ins.rateZeroIndex, _h, BaseConfig.ins.finalMaxNum );
						
				});
				
				BaseConfig.ins.c.paths.push( { cmd: _cmd, path: _path } );
			});

		}
		
		private function calcChartPoint():void{
			facade.registerMediator( new BgLineMediator() );
			
			calcChartVPoint();
			calcChartHPoint();
		}
		
		private function calcChartVPoint():void{
			var _partN:Number = BaseConfig.ins.c.chartHeight / ( BaseConfig.ins.rate.length -1 )
				, _sideLen:Number = BaseConfig.ins.c.arrowLength
				;
			BaseConfig.ins.c.vpart = _partN;
			BaseConfig.ins.c.itemHeight = _partN / 2;
			BaseConfig.ins.c.vpoint = [];
			BaseConfig.ins.c.vpointReal = [];
			
			Common.each( BaseConfig.ins.rate, function( _k:int, _item:* ):void{
				var _n:Number = BaseConfig.ins.c.minY + _partN * _k, _sideLen:int = BaseConfig.ins.c.arrowLength;
				BaseConfig.ins.c.vpoint.push( {
					start: new Point( BaseConfig.ins.c.minX, _n )
					, end: new Point( BaseConfig.ins.c.maxX, _n )
				});
				
				BaseConfig.ins.c.vpointReal.push( {
					start: new Point( BaseConfig.ins.c.minX + _sideLen, _n )
					, end: new Point( BaseConfig.ins.c.maxX + _sideLen, _n )
				});
			});
		}
		
		private function calcChartHPoint():void{
			var _partN:Number = BaseConfig.ins.c.chartWidth / ( BaseConfig.ins.categories.length - 1 )
				, _sideLen:Number = BaseConfig.ins.c.arrowLength
				;
			BaseConfig.ins.c.hpart = _partN;
			BaseConfig.ins.c.hpoint = [];
			BaseConfig.ins.c.hlinePoint = [];
			BaseConfig.ins.c.hpointReal = [];
			BaseConfig.ins.c.itemWidth = _partN / 2;
						
			Common.each( BaseConfig.ins.categories, function( _k:int, _item:* ):void{
				var _n:Number = BaseConfig.ins.c.minX + _partN * _k + 5
					, _sideLen:int = BaseConfig.ins.c.arrowLength;
								
				BaseConfig.ins.c.hlinePoint.push( {
					start: new Point( _n, BaseConfig.ins.c.minY )
					, end: new Point( _n, BaseConfig.ins.c.maxY + 1 )
				});
				
				if( !BaseConfig.ins.displayAllLabel ){
					if( !( _k in BaseConfig.ins.labelDisplayIndex ) ){
						_sideLen = 0;
					}
				}
				
				BaseConfig.ins.c.hpoint.push( {
					start: new Point( _n, BaseConfig.ins.c.maxY )
					, end: new Point( _n, BaseConfig.ins.c.maxY + _sideLen )
				});
				
				BaseConfig.ins.c.hpointReal.push( {
					start: new Point( _n, BaseConfig.ins.c.minY )
					, end: new Point( _n, BaseConfig.ins.c.maxY )
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