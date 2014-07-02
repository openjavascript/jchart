package org.xas.core.utils
{
	public class TypeUtils
	{
		public function TypeUtils()
		{
		}
		
		public static function isObject($obj:Object):Boolean
		{
			if(!$obj) return false;
			if( typeof $obj == 'object' && typeof $obj.length == 'number' ) return false;
			if( typeof $obj == 'object' ) return true;
			
			return false;
		}
		
		public static function isArray($obj:Object):Boolean
		{
			if(!$obj) return false;
			if( $obj && typeof $obj == 'object' && typeof $obj.length == 'number' ) return true;			
			return false;
		}
		
		public static function objectLength($obj:Object):int
		{
			var r:int = 0;
			
			if( isArray( $obj ) ) return $obj.length;
			
			for( var k:String in $obj )
			{
				r++;
			}
			
			return r;
		}
	}
}