package org.xas.jchart.common.view.components
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class MainView extends Sprite
	{
		private var _index0:Sprite;
		public function get index0():Sprite{ return _index0; }
		
		private var _index1:Sprite;
		public function get index1():Sprite{ return _index1; }
		
		private var _index2:Sprite;
		public function get index2():Sprite{ return _index2; }
		
		private var _index3:Sprite;
		public function get index3():Sprite{ return _index3; }
		
		private var _index4:Sprite;
		public function get index4():Sprite{ return _index4; }
		
		private var _index5:Sprite;
		public function get index5():Sprite{ return _index4; }
		
		private var _index6:Sprite;
		public function get index6():Sprite{ return _index5; }
		
		private var _index7:Sprite;
		public function get index7():Sprite{ return _index6; }
		
		private var _index8:Sprite;
		public function get index8():Sprite{ return _index8; }
		
		private var _index9:Sprite;
		public function get index9():Sprite{ return _index9; }
		
		
		public function MainView()
		{
			super();
			
			addChild( _index0 = new Sprite() );
			addChild( _index1 = new Sprite() );
			addChild( _index2 = new Sprite() );
			addChild( _index3 = new Sprite() );
			addChild( _index4 = new Sprite() );
			addChild( _index5 = new Sprite() );
			addChild( _index6 = new Sprite() );
			addChild( _index7 = new Sprite() );
			addChild( _index8 = new Sprite() );
			addChild( _index9 = new Sprite() );
			
			_index9.graphics.lineStyle( 1, 0x000000 );
			_index9.graphics.beginFill( 0x000000 );
			drawCircleSegment( _index9.graphics, new Point( 200, 200 ), 0 * ( Math.PI / 180 ), 90 * ( Math.PI / 180 ), 100 );
		}
		
		/**
		 * Draw a segment of a circle
		 * @param graphics      the graphics object to draw into
		 * @param center        the center of the circle
		 * @param start         start angle (radians)
		 * @param end           end angle (radians)
		 * @param r             radius of the circle
		 * @param h_ratio       horizontal scaling factor
		 * @param v_ratio       vertical scaling factor
		 * @param new_drawing   if true, uses a moveTo call to start drawing at the start point of the circle; else continues drawing using only lineTo and curveTo
		 * 
		 */
		public static function drawCircleSegment(graphics:Graphics, center:Point, start:Number, end:Number, r:Number, h_ratio:Number=1, v_ratio:Number=1, new_drawing:Boolean=true):void
		{
			var x:Number = center.x;
			var y:Number = center.y;
			// first point of the circle segment
			if(new_drawing)
			{
				graphics.moveTo(x+Math.cos(start)*r*h_ratio, y+Math.sin(start)*r*v_ratio);
			}
			
			// draw the circle in segments
			var segments:uint = 8;
			
			var theta:Number = (end-start)/segments; 
			var angle:Number = start; // start drawing at angle ...
			
			var ctrlRadius:Number = r/Math.cos(theta/2); // this gets the radius of the control point
			for (var i:int = 0; i<segments; i++) {
				// increment the angle
				angle += theta;
				var angleMid:Number = angle-(theta/2);
				// calculate our control point
				var cx:Number = x+Math.cos(angleMid)*(ctrlRadius*h_ratio);
				var cy:Number = y+Math.sin(angleMid)*(ctrlRadius*v_ratio);
				// calculate our end point
				var px:Number = x+Math.cos(angle)*r*h_ratio;
				var py:Number = y+Math.sin(angle)*r*v_ratio;
				// draw the circle segment
				graphics.curveTo(cx, cy, px, py);
			}
			
		}
	}
}