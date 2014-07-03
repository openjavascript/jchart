package org.xas.core.utils
{
	public class ObjectUtils
	{
		public static function clone( $o:Object ):Object
		{
			var r:Object;
			
			if( $o )
			{
				r = {};
				
				for( var k:String in $o )
				{
					if( typeof $o[k] === 'object' )
					{
						if( $o[k] !== $o )
						{
							r[k] = clone( $o[k] );
						}
						else
						{
							r[k] = $o[k];
						}
					}
					else if( typeof $o[k] === 'array' )
					{
						r[k] = cloneArray( $o[k] );
					}
					else
					{
						r[k] = $o[k];
					}
				}
			}
			
			return r;
		}
		
		public static function cloneArray( $a:Array ):Array
		{
			var r:Array = [];
			
			for( var i:int = 0; i < $a.length; i++ )
			{
				if( typeof $a[i] === 'object' )
				{
					r[i] = clone( $a[i] );
				}
				else if( typeof $a[i] === 'array' )
				{
					r[i] = cloneArray( $a[i] );
				}
				else
				{
					r[i] = $a[i];
				}
			}
			
			return r;
		}
	}
}