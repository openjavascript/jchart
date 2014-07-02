package org.xas.core.ui.graphics
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.xas.core.utils.Log;
	
	public class LineGraphicReverse extends Sprite
	{
		private var _w:Number;
		private var _h:Number;
		private var _color:uint;
		private var _lineThickness:Number;
		private var _lineGap:Number;
		private var _lineAngle:Number;
		
		private var _drawBg:Boolean;
		private var _bgColor:uint;
		
		public function LineGraphicReverse( $w:Number, $h:Number, $color:uint = 0x000000
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
			
			var countX:Number = 0;
			var countY:Number = 0;
			
			var nextX:Number;
			var nextY:Number;
			
			var beginPoint:Point;
			var endPoint:Point;
			
			var step:Number = _lineGap + _lineThickness + Math.floor(_lineThickness / 2);
			
			if( _drawBg )
			{
				graphics.lineStyle( 0, 0, 0 );
				graphics.beginFill( _bgColor );
				graphics.drawRect( 0, 0, _w, _h );
				graphics.endFill();
			}
			
			graphics.lineStyle( _lineThickness, _color );
			
			var firstUpperX:Boolean = true;
			var firstUpperY:Boolean = true;
			
			var countY1:Number = 0;
			var countX1:Number = 2;
			
			graphics.moveTo( countX + 2, 0 );
			graphics.lineTo( countX, 2 );
			
			countX = countX + 2;
			countY = 2;
			
			while( countX <= _w || countY <= _h || countY1 <= _h || countX1 <= _w )
			{
				if( countX >= _w && firstUpperX )
				{
					countY1 = countX - _w;
					countX = _w;
					firstUpperX = false;
				}
				
				if( countY >= _h && firstUpperY )
				{
					countX1 = countY - _h;
					countY = _h;
					firstUpperY = false;
				}
				
				if( firstUpperX )
				{
					beginPoint = new Point( countX, 0 );
				}
				else
				{
					beginPoint = new Point( _w, countY1 );
					countY1 += step;
				}
				
				if( firstUpperY )
				{
					endPoint = new Point( 0, countY );	
				}
				else
				{
					endPoint = new Point( countX1, _h  );
					countX1 += step;
				}
				
				graphics.moveTo( beginPoint.x, beginPoint.y );
				graphics.lineTo( endPoint.x, endPoint.y );
				
				countX += step;
				countY += step;
				
				if( countX >= _w && countY >= _h && countY1 >= _h && countX1 >= _w )
				{					
					var outX:Number = countX1 - _w;
					var outY:Number = countY1 - _h ; 
					
					if( outX >= step - 1 && outY >= step - 1 )
					{
						graphics.moveTo( _w - 1, _h );
						graphics.lineTo( _w, _h - 1  );
					}
					break;
				}
			}
			
		}
	}
}