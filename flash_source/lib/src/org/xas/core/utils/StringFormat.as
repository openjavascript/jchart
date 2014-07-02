package org.xas.core.utils
{
	public class StringFormat
	{
		public function StringFormat()
		{
		}
		
		public static function minuteSecond($time:Number):String
		{
			var result:Array = [];				
			if( $time > 0 )
			{	
				var time:int = Math.ceil( $time );	
				
				var m:String = parseInt(time / 60+'')+'';				
				if( m.length < 2 )
				{
					m = '00' + m;
					result.push( m.slice( m.length - 2 ) );
				}
				else
				{
					result.push( m );
				}	
				
				var s:String = '00'+(time % 60);
				result.push( s.slice( s.length - 2 ) );				
			}
			else
			{
				result = ['00', '00'];
			}
			
			return result.join(':');
		}
	}
}