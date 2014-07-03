package org.xas.jchart.common
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.data.Coordinate;
	
	/**
	 * ...
	 * @author suches@btbtd.org
	 */
	public class Config 
	{
		private static var _debug:Boolean = false;		
		public static function setDebug( _debug:Boolean ):Boolean {
			Log.debug = _debug;
			return Config._debug = _debug;
		}		
		public static function get debug():Object {
			return Config._debug;
		}
		
		private static var _params:Object;
		public static function setParams( _params:Object ):Object {
			return Config._params = _params;
		}		
		public static function get params():Object {
			return Config._params;
		}
		
		private static var _chartData:Object;
		public static function setChartData( _chartData:Object ):Object {
			return Config._chartData = _chartData;
		}		
		public static function get chartData():Object {
			return Config._chartData;
		}
		
		private static var _root:DisplayObject;
		public static function get root():DisplayObject{
			return _root;
		}
		public static function setRoot( _root:* ):DisplayObject{
			Config._root = _root as DisplayObject;
			_width = Config._root.stage.stageWidth;
			_height = Config._root.stage.stageHeight;
			return Config._root;
		}
		
		private static var _width:uint;
		public static function get width():uint{ return _width; }
		
		private static var _height:uint;
		public static function get height():uint{ return _height; }
				
		private static var _coordinate:Coordinate
		public static function get c():Coordinate{
			return _coordinate;
		}
		public static function get coordinate():Coordinate{
			return _coordinate;
		}
		public static function setCoordinate( _coordinate:Coordinate ):Coordinate{
			Config._coordinate = _coordinate;
			Config.c.width = width;
			Config.c.height = height;
			Config.c.x = 0;
			Config.c.y = 0;
			return Config._coordinate;
		}
	}
	
	
	
}