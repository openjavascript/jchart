package org.xas.core.utils
{
	public class DateUtils
	{
		public static function dateSpan( $date1:Date, $date2:Date ):int
		{
			var step:int;
			
			$date1 = new Date( $date1.getFullYear(), $date1.getMonth(), $date1.getDate() );
			$date2 = new Date( $date2.getFullYear(), $date2.getMonth(), $date2.getDate() );
			
			if( $date1.getTime() > $date2.getTime() )
			{
				step = -1;
			}
			else
			{
				step = 1;
			}			
			var r:int = 1;
			
			while( true )
			{				
				if( step > 0 )
				{
					if( $date1.getTime() >= $date2.getTime() )
					{						
						break;
					}
				}
				else
				{
					if( $date1.getTime() <= $date2.getTime() )
					{
						break;	
					}
				}
				
				$date1.setDate( $date1.getDate() + step );
				r++;
			}
			
			return r;
		}
		
		public static function dateString( $date:Date ):String
		{
			return [ StringUtils.pad( $date.getFullYear(), 4 )
				, StringUtils.pad( $date.getMonth() + 1, 2 )
				, StringUtils.pad( $date.getDate(), 2 )
			].join('-');
		}
		
		public static function hourMinuteString( $date:Date ):String
		{
			return [ 
					StringUtils.pad( $date.getHours(), 2 )
					, StringUtils.pad( $date.getMinutes(), 2 )
			].join(':');
		}
		
		public static function dateTimeString( $date:Date ):String
		{
			return [ StringUtils.pad( $date.getFullYear(), 2 )
				, StringUtils.pad( $date.getMonth() + 1, 2 )
				, StringUtils.pad( $date.getDate(), 2 )
			].join('-')
				+ ' ' + [ 
					StringUtils.pad( $date.getHours(), 2 )
					, StringUtils.pad( $date.getMinutes(), 2 )
					, StringUtils.pad( $date.getSeconds(), 2 ) 
				].join(':')
				;
		}
		
		public static function isSameDate( $date1:Date, $date2:Date ):Boolean
		{
			var r:Boolean = false;
			
			if( $date1.getFullYear() === $date2.getFullYear()
				&& $date1.getMonth() === $date2.getMonth() 
				&& $date1.getDate() === $date2.getDate()
			)
			{
				r = true;	
			}
			
			return r;
		}
		
		public static function parse( $dateString:String ):Date
		{
			var d:Date;
			
			if( $dateString )
			{
				var part:Array = $dateString.split(' ');
				var date:Array = ArrayUtils.toInt( part[0].split('-') );
				
				d = new Date( date[0], date[1] - 1, date[2] );
			}
			
			return d;
		}
		
		public static function clone( $date:Date ):Date
		{
			var d:Date = new Date();
			d.setTime( $date.getTime() );			
			return d;
		}
	}
}