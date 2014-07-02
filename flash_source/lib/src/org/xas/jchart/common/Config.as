package org.xas.jchart.common
{
	
	/**
	 * ...
	 * @author suches@btbtd.org
	 */
	public class Config 
	{
		private static var _params:Object;
		private static var _debug:Boolean = false;
			
		public static function setParams( _params:Object ):Object {
			return Config._params = _params;
		}
		
		public static function get params():Object {
			return Config._params;
		}
			
		public static function setDebug( _debug:Boolean ):Boolean {
			return Config._debug = _debug;
		}
		
		public static function get debug():Object {
			return Config._debug;
		}
	}
	
	
	
}