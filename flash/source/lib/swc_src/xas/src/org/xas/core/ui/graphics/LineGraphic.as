package org.xas.core.ui.graphics
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class LineGraphic extends Sprite
	{
		private var _w:Number;
		private var _h:Number;
		private var _color:uint;
		private var _lineThickness:Number;
		private var _lineGap:Number;
		
		private var _drawBg:Boolean;
		private var _bgColor:uint;
		
		public function LineGraphic( $w:Number, $h:Number, $color:uint = 0x000000
									 	, $lineThickness:Number = 1, $lineGap:Number = 3
										, $drawBg:Boolean = false
										, $bgColor:uint = 0xDEEBDA
		)
		{
			_w = $w;
			_h = $h;
			_color = $color;
			_lineThickness = $lineThickness;
			_lineGap = $lineGap;
			
			_drawBg = $drawBg;
			_bgColor = $bgColor;
			
			init();
		}
		
		private function init():void
		{
			this.scrollRect = new Rectangle( 0, 0, _w, _h );
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			var countX:Number = _w;
			var countY:Number = 0;
			
			var nextX:Number;
			var nextY:Number;
			
			var beginPoint:Point;
			var endPoint:Point;
			
			//var step:Number = _lineGap+_lineThickness;
			
			var step:Number = _lineGap + _lineThickness + Math.floor(_lineThickness / 2);
			
			if( _bgColor )
			{
				graphics.lineStyle( 0, 0, 0 );
				graphics.beginFill( _bgColor );
				graphics.drawRect( 0, 0, _w, _h );
				graphics.endFill();
			}
			
			graphics.lineStyle( _lineThickness, _color );
			
			var firstUpperX:Boolean = true;
			var firstUpperY:Boolean = true;
			
			var countY1:Number;
			var countX1:Number;
			
			graphics.moveTo( countX - 2, 0 );
			graphics.lineTo( countX, 2 );
			
			countX = countX - 2;
			countY = 2;
			
			while( countX >= 0 || countY <= _h || countY1 >= _h || countX1 >= 0 )
			{
				
				if( countX <= 0 && countY >= _h && countY1 >= _h && countX1 <= 0 )
				{
					var outX:Number = countX - countX1;
					var outY:Number = countY1 - countY; 
					
					if( outX >= step - 1 && outY >= step - 1 )
					{
						graphics.moveTo( 0, _h - 1 );
						graphics.lineTo( 1, _h  );
					}
					break;
				}
				
				if( firstUpperX )
				{
					beginPoint = new Point( countX, 0 );
				}
				else
				{
					beginPoint = new Point( 0, countY1  );
					
					countY1 += step;
				}
				
				if( firstUpperY )
				{
					endPoint = new Point( _w, countY );	
				}
				else
				{
					endPoint = new Point( countX1, _h  );
					countX1 -= step;
				}
				
				graphics.moveTo( beginPoint.x, beginPoint.y );
				graphics.lineTo( endPoint.x, endPoint.y );
				
				countX -= step;
				countY += step;
				
				if( countX <= 0 && firstUpperX )
				{
					firstUpperX = false;
					countY1 = 0 - countX;
					countX = 0;
				}
				
				if( countY >= _h && firstUpperY )
				{
					firstUpperY = false;
					countX1 = _w - (countY - _h);
					countY = _h;
				}
			}
		}
	}
}