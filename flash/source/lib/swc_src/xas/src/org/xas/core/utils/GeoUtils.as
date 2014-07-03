package org.xas.core.utils
{
	import flash.geom.Point;

	public class GeoUtils
	{
		public function GeoUtils()
		{
		}
		
		/**
		 * 求两点之间连线的角度
		 */
		public static function lineAngle(px1:Number, py1:Number, px2:Number, py2:Number):Number 
		{
			//两点的x、y值
			var x:Number = px2-px1;
			var y:Number = py2-py1;
			var h:Number = 0;
			var radian:Number = 0;
			var angle:Number = 0;
			var cos:Number = 0;
			
			h = Math.sqrt(Math.pow(x, 2)+Math.pow(y, 2));
			//斜边长度
			cos = x/h;
			radian = Math.acos(cos);
			//求出弧度
			angle = 180/(Math.PI/radian);
			//用弧度算出角度    
			if (y<0) {
				angle = -angle;
			} else if ((y == 0) && (x<0)) {
				angle = 180;
			}
			
			angle = fixAngle( angle );
			
			return angle;
		}
		
		/**
		 * 求两点之间连线的角度
		 */
		public static function pointAngle($point1:Point, $point2:Point):Number 
		{
			return lineAngle( $point1.x, $point1.y, $point2.x, $point2.y );
		}
		
		public static function moveByAngle( $angle:Number, $centerPoint:Point, $diameter:Number ):Point
		{
			var result:Point = new Point(0, 0);
			var radian:Number;
						
			radian = $angle * Math.PI / 180;					
			result.x = $centerPoint.x + Math.cos( radian  ) * $diameter;
			result.y = $centerPoint.y + Math.sin( radian ) * $diameter;
			
			return result;
		}
		
		public static function pointLength( x1:Number, y1:Number, x2:Number, y2:Number ):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			
			return Math.sqrt( dx * dx + dy * dy );
		}
		
		public static function fixAngle($angle:Number):Number
		{
			if( $angle < 0 ) $angle = 360 + $angle;
			return $angle;
		}
		/**
		 * 画一条穿过某个点的曲线
		 */
		public static function curveToPoint( $begin:Point, $through:Point, $end:Point ):Point
		{
			var r:Point = new Point(0, 0);
			
			r.x = $through.x * 2 - ( $begin.x + $end.x ) / 2;
			r.y = $through.y * 2 - ( $begin.y + $end.y ) / 2;
			
			return r;
		}
	}
}