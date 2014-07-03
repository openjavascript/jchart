package org.xas.jchart.common
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author suches@btbtd.org
	 */
	public class Config 
	{
		private static var _debug:Boolean = false;		
		public static function setDebug( _debug:Boolean ):Boolean {
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
		
		private static var _root:DisplayObjectContainer;
		public static function get root():DisplayObjectContainer{
			return _root;
		}
		public static function setRoot( _root:* ):DisplayObjectContainer{
			return Config._root = _root as DisplayObjectContainer;
		}
	}
	
	
	
}