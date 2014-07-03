package org.xas.core.ui.geo
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class BaseTriangle extends Sprite
	{
		protected var _diameter:Number;
		public function get diameter():Number{ return _diameter; }
		
		protected var _angle:Number;		
		public function get angle():Number{ return _angle; }
		
		protected var _sp:Sprite;
		public function get sp():Sprite{ return _sp; }
		
		protected var _p1:Point;
		protected var _p2:Point;
		protected var _p3:Point;
		protected var _p4:Point;
		
		public function BaseTriangle()
		{
			init();
		}
		
		protected function init():void
		{
			addChild( _sp = new Sprite() );	
			initGraphics();	
			initPoint();
			draw();
		}
		
		protected function initPoint():void
		{
			
		}
		
		protected function initGraphics():void
		{	
			_sp.graphics.clear();
			_sp.graphics.lineStyle(1, 0);
			_sp.graphics.beginFill(0xffffff);	
		}
		
		public function draw():void
		{
			this.graphics.clear();
		}
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
	}
}