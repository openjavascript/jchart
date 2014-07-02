package org.xas.core.utils.formatter
{
	public final class Formatter
	{
		public function Formatter()
		{
			
		}
		
		public static function json( $data:Object, $params:Object = null ):String
		{
			var jf:XJSONFormatter = new XJSONFormatter( $params );
			return jf.process( $data );
		}
	}
}