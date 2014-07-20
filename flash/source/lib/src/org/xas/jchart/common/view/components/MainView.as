package org.xas.jchart.common.view.components
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.xas.core.utils.GeoUtils;
	import org.xas.jchart.common.ui.widget.PiePart;
	
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

			/*
			_index9.addChild(
				new PiePart( 
					new Point( 200, 200 )
					, 0, 90
					, 50
				) 
			);
			*/
		}

	}
}