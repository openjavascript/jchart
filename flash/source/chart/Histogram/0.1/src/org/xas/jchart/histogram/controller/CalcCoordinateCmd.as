package org.xas.jchart.histogram.controller
{
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.config.HistogramConfig;
	import org.xas.jchart.common.data.Coordinate;
	import org.xas.jchart.common.data.test.DefaultData;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.view.mediator.*;
	import org.xas.jchart.histogram.view.mediator.*;
	
	public class CalcCoordinateCmd extends SimpleCommand implements ICommand
	{
		private var _c:Coordinate;
		private var _config:HistogramConfig;
		
		public function CalcCoordinateCmd()
		{
			super();
			
			_config = BaseConfig.ins as HistogramConfig;
		}
		
		override public function execute(notification:INotification):void{
			
			_c = _config.setCoordinate( new Coordinate() );
			
			_c.corner = corner();
			
			_c.minX = _c.x + _config.vlabelSpace + 2;
			_c.minY = _c.y + 5;
			_c.maxX = _c.x + _config.stageWidth - 5;
			_c.maxY = _c.y + _config.stageHeight - 5;
						
			facade.registerMediator( new BgMediator( ) );
			var _yPad:Number = _c.minY;
			
			//Log.log( _config.rate.length );
			//Log.log( _config.maxNum, _config.finalMaxNum, _config.chartMaxNum, 11111 );
			
			if( _config.cd ){			
				
				if( _config.cd.title && _config.cd.title.text ){
					facade.registerMediator( new TitleMediator( _config.cd.title.text ) )	
					_config.c.title = { x: _config.stageWidth / 2, y: _c.minY, item: pTitleMediator };
					_config.c.minY += pTitleMediator.view.height;			
				}
				
				if( _config.cd.subtitle && _config.cd.subtitle.text ){
					facade.registerMediator( new SubtitleMediator( _config.cd.subtitle.text ) )
					
					_config.c.subtitle = { x: _config.stageWidth / 2, y: _c.minY, item: pSubtitleMediator };
					_config.c.minY += pSubtitleMediator.view.height + 5;
				}				
				
				if( _config.cd.yAxis && _config.cd.yAxis.title && _config.cd.yAxis.title.text ){
					facade.registerMediator( new VTitleMediator( _config.cd.yAxis.title.text ) )
					
					_config.c.vtitle = { x: _config.c.minX, y: _config.c.x + _config.c.height / 2, item: pVTitleMediator };
					_config.c.minX += pVTitleMediator.view.width - _config.vlabelSpace;
				}
				
				if( _config.cd.credits && _config.cd.credits.enabled && ( _config.cd.credits.text || _config.cd.credits.href ) ){
					facade.registerMediator( new CreditMediator( _config.cd.credits.text, _config.cd.credits.href ) )
					
					_config.c.credits = { x: _config.c.maxX, y: _config.c.maxY, item: pCreditMediator };
					_config.c.maxY -= pCreditMediator.view.height;
				}	
				
				if( _config.legendEnabled ){
					facade.registerMediator( new LegendMediator() );
					_config.c.maxY -= pLegendMediator.view.height;
					_config.c.legend = { 
						x: _config.width / 2 - pLegendMediator.view.width / 2
						, y: _config.c.maxY
					};
					_config.c.maxY -= 2;
				}
				
				_config.c.maxX -= 5;
				
				if( _config.rateLabelEnabled ){
					facade.registerMediator( new VLabelMediator() );
					_config.c.minX += pVLabelMediator.maxWidth;
				}

				_config.c.hoverPadY = 10;
				if( _config.hoverBgEnabled ){
					facade.registerMediator( new HoverBgMediator() );
					_config.c.minY += _config.c.hoverPadY;
					_yPad += _config.c.hoverPadY;
				}
				
				_config.c.serialLabelPadY = 15;
				if( _config.serialLabelEnabled ){
					facade.registerMediator( new SerialLabelMediator() );
					_config.c.minY += _config.c.serialLabelPadY;
					_yPad += _config.c.serialLabelPadY;
				}
				
				_config.c.arrowLength = 8;
				
				if( _config.rateLabelEnabled ){
					_config.c.chartWidth = _config.c.maxX - _config.c.minX - 5;
				}else{
					//_config.c.chartWidth = _config.c.maxX - 5;
					_config.c.chartWidth = _config.c.maxX - _config.c.minX;
				}
				
				if( _config.categories && _config.categories.length ){
					_config.c.labelWidth = _config.c.chartWidth / ( _config.categories.length ) / 2
				}
				facade.registerMediator( new HLabelMediator() );
				_config.c.maxY -= pHLabelMediator.maxHeight;
			
				if( _config.graphicHeight ){
					var _hpad:Number = _config.c.maxY - _config.graphicHeight;
					_config.c.chartHeight = _config.graphicHeight - _yPad;		
					_config.c.maxY -= _hpad;
					
					if( _config.c.legend ){
						_config.c.legend.y -= _hpad;
					}
					
					if( _config.c.credits ){
						_config.c.credits.y -= _hpad;
					}
				}else{	
					_config.c.chartHeight = _config.c.maxY - _config.c.minY;
				}
							
				
				_config.c.chartX = _config.c.minX + _config.c.arrowLength - 2;
				_config.c.chartY = _config.c.minY;
				
				facade.registerMediator( new GraphicBgMediator() );	
				_config.tooltipEnabled && facade.registerMediator( new TipsMediator() );
				//Log.log( _config.tooltipEnabled );
				
				
				calcChartPoint();
				
				calcGraphic();	
				
				if( !ExternalInterface.available ){
					facade.registerMediator( new TestMediator( DefaultData.instance.data ) );	
				}
				
				//Log.log( _config.c.chartWidth, _config.c.chartHeight );
			}
									
			sendNotification( JChartEvent.SHOW_CHART );			
		}
		
		private function calcGraphic():void{			
			facade.registerMediator( new GraphicMediator() );
			
			_config.c.rects = [];
			_config.c.dataRect = [];
			
			if( !( _config.series && _config.series.length ) ) return;
			
			_config.c.partSpace = 0; 
			_config.c.partWidth = 
				_config.c.itemWidth / _config.displaySeries.length
				;
			
			if( _config.displaySeries.length > 1 ){				
				_config.c.partSpace = 4; 
				_config.c.partWidth = 
					(
						_config.c.itemWidth - (_config.displaySeries.length - 1) * _config.c.partSpace
					) / _config.displaySeries.length
					;
			}
			
			//_config.c.partWidth > 50 && ( _config.c.partWidth = 50 );
			var _partWidth:Number = _config.c.partWidth
				;
			//_partWidth > 50 && ( _partWidth = 50 );
			if( _partWidth > 50 ){
				_partWidth = 50;
			}
			
			
			Common.each( _config.cd.xAxis.categories, function( _k:int, _item:Object ):void{
				
				var _items:Array = []
					, _pointItem:Object = _config.c.hlinePoint[ _k ]
					, _sp:Point = _pointItem.start as Point
					, _ep:Point = _pointItem.end as Point
					//, _x:Number = _sp.x + ( _config.c.itemWidth - _config.c.itemWidth / 2 )
					, _x:Number = _sp.x 
						+ ( _config.c.itemWidth 
							- _partWidth * _config.displaySeries.length / 2
							- _config.c.partSpace * ( ( _config.displaySeries.length || 1 ) - 1 ) / 2 
						)
					, _tmp:Number = 0
					, _tmpDataRect:Object = {
						x: _sp.x, y: _sp.y
						, width: _config.c.itemWidth * 2
						, height: _ep.y - _sp.y 
					}
					, _tmpYAr:Array = []
					, _tmpHAr:Array = []
					;
				
				Common.each( _config.displaySeries, function( _sk:int, _sitem:Object ):void{
					var _rectItem:Object = {}
						, _num:Number = _sitem.data[ _k ]
						, _itemNum:Number
						, _h:Number, _y:Number
						, _dataHeight:Number
						;
						
						if( _config.isItemPercent && _config.displaySeries.length > 1 ){
							_h = _config.c.vpart * _config.rateZeroIndex;
							_h = ( _num / _config.itemMax( _k ) || 0 ) * _h;
							_y = _sp.y 
							+ _config.c.vpart * _config.rateZeroIndex - _h
							;
							if( _k === 0 ){
								//Log.log( _num / _config.itemMax( _k ) * 100, _num, _config.itemMax( _k ) );
							}
						}else{
							if( Common.isNegative( _num ) || _num == 0 ){
								_num = Math.abs( _num );
								_dataHeight = _config.c.vpart * _config.rateZeroIndex;
								
								_h = _config.c.chartHeight - _dataHeight;
								_y = _sp.y + _dataHeight ;
								_h = 
								( _num / 
									Math.abs( _config.finalMaxNum * _config.rate[ _config.rate.length - 1 ] ) ) 
								* _h;
								//Log.log( _h, _config.finalMaxNum );
							}else{
								_h = _config.c.vpart * _config.rateZeroIndex;
								_h = ( _num / _config.chartMaxNum || 1 ) * _h;
								_y = _sp.y 
								+ _config.c.vpart * _config.rateZeroIndex - _h
								;
							}
						}						
						//Log.log( _h, _y );
						
						_rectItem.x = _x + _sk * _partWidth + _config.c.partSpace * _sk;
						
						_rectItem.y = _y;
						_rectItem.width = _partWidth;
						_rectItem.height = _h;
						_rectItem.value = _sitem.data[ _k ];
						
						_tmpYAr.push( _y );
						_tmpHAr.push( _h );
						
						_items.push( _rectItem );
				});
				
				_tmpDataRect.y = Math.min.apply( null, _tmpYAr );
				_tmpDataRect.height = Math.max.apply( null, _tmpHAr );
				
				if( _config.hoverBgEnabled ){
					_tmpDataRect.y -= _config.c.hoverPadY;
					_tmpDataRect.height += _config.c.hoverPadY
				}
				
				if( _config.serialLabelEnabled ){
					_tmpDataRect.y -= _config.c.serialLabelPadY;
					_tmpDataRect.height += _config.c.serialLabelPadY
				}
				
				_config.c.rects.push( _items );
				_config.c.dataRect.push( _tmpDataRect );
			});
		}
		
		private function calcChartPoint():void{
			facade.registerMediator( new BgLineMediator() );
			
			calcChartVPoint();
			calcChartHPoint();
		}
		
		private function calcChartVPoint():void{
			var _partN:Number = _config.c.chartHeight / ( _config.rate.length -1 )
				, _sideLen:Number = _config.c.arrowLength
				;
			_config.c.vpart = _partN;
			_config.c.itemHeight = _partN / 2;
			_config.c.vpoint = [];
			_config.c.vpointReal = [];
			
			
			var _padX:Number = 0;
			if( !_config.rateLabelEnabled ){
			}
			
			Common.each( _config.rate, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.minY + _partN * _k, _sideLen:int = _config.c.arrowLength;
				_config.c.vpoint.push( {
					start: new Point( _config.c.minX + _padX, _n )
					, end: new Point( _config.c.maxX + _padX, _n )
				});
				
				_config.c.vpointReal.push( {
					start: new Point( _config.c.minX + _sideLen, _n )
					, end: new Point( _config.c.maxX + _sideLen, _n )
				});
			});
		}
		
		private function calcChartHPoint():void{
			if( !_config.rateLabelEnabled ){
				_config.c.chartWidth -= ( _config.vlabelSpace + 2 );
			}
			var _partN:Number = _config.c.chartWidth / ( _config.categories.length )
				, _sideLen:Number = _config.c.arrowLength
				;
			
			_config.c.hpart = _partN;
			_config.c.hpoint = [];
			_config.c.hlinePoint = [];
			_config.c.hpointReal = [];
			_config.c.itemWidthRate = 2;
			_config.c.itemWidth = _partN / _config.c.itemWidthRate;
						
			Common.each( _config.categories, function( _k:int, _item:* ):void{
				var _n:Number = _config.c.minX + _partN * _k + 5, _sideLen:int = _config.c.arrowLength;
				
				if( _k === 0 ){					
					_config.c.hlinePoint.push( {
						start: new Point( _n, _config.c.minY )
						, end: new Point( _n, _config.c.maxY + 1 )
					});					
				}
								
				_config.c.hlinePoint.push( {
					start: new Point( _n + _partN, _config.c.minY )
					, end: new Point( _n + _partN, _config.c.maxY + 1 )
				});
				
				_config.c.hpoint.push( {
					start: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.maxY )
					, end: new Point( _n + _partN / _config.c.itemWidthRate, _config.c.maxY + _sideLen )
				});
				
				_config.c.hpointReal.push( {
					start: new Point( _n, _config.c.minY )
					, end: new Point( _n, _config.c.maxY )
				});
			});
		}
		
		private function get pLegendMediator():LegendMediator{
			return facade.retrieveMediator( LegendMediator.name ) as LegendMediator;
		}
		
		private function get pSerialLabelMediator():SerialLabelMediator{
			return facade.retrieveMediator( SerialLabelMediator.name ) as SerialLabelMediator;
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
