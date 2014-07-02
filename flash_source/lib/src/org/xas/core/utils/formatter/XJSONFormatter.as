package org.xas.core.utils.formatter
{
	import com.adobe.serialization.json.JSON;
	
	import org.xas.core.utils.Log;
	import org.xas.core.utils.TypeUtils;
	import org.xas.core.utils.formatter.i.IFormatter;
	
	public class XJSONFormatter implements IFormatter
	{
		private var _tabLen:int = 4;
		
		public function XJSONFormatter( $params:Object = null )
		{
		}
		
		public function process($data:Object):String
		{
			var result:Array = [];
			
			analysisData( $data, result, 0 );
			
			return result.join('\n');
		}
		
		private function analysisData($data:*, result:Array, deep:int):void
		{			
			var pad:String = new Array( deep * 4 +(deep>0?1:0)).join(' ');
			var itemPad:String = new Array( (deep+1) * 4 + 1 ).join(' ');
			
			var openSymbol:String, closeSymbol:String;
			var pushSymbol:Boolean = false;
			
			var i:int, j:int, k:String;
			var objLen:int = 0, count:int = 0;
			var itemSeparate:String = '';
			
			var item:*, lastItem:*;
			
			if( TypeUtils.isArray( $data ) )
			{
				openSymbol = '[';
				closeSymbol = ']';
				
				pushSymbol = true;
			}
			else if( TypeUtils.isObject( $data ) )
			{
				openSymbol = '{';
				closeSymbol = '}';
				
				pushSymbol = true;
			}
			
			if( pushSymbol ) result.push( pad+openSymbol );
			
			if( TypeUtils.isArray( $data ) )
			{
				objLen = TypeUtils.objectLength( $data );
				count = 0;
				for( i = 0, j = objLen; i < j; i++ )
				{
					count++;
					
					item = $data[i];			
					
					if( TypeUtils.isArray( item ) || TypeUtils.isObject( item ) )
					{								
						//result.push( itemPad + k + ':' );
						analysisData( item, result , deep + 1);
						if( count < objLen ) 
						{
							lastItem = result[result.length-1];
							result[result.length-1] = lastItem + ', ';
						}
					}
					else
					{	
						if( typeof item == 'string' )
						{
							item = JSON.encode(item);
						}
						
						if( count < objLen ) itemSeparate = ', ';
						else itemSeparate = '';
						
						result.push( itemPad + item + itemSeparate );
					}
				}
			}
			else if( TypeUtils.isObject( $data ) )
			{
				objLen = TypeUtils.objectLength( $data );
				count = 0;
				for( k in $data )
				{
					count++;
					
					item = $data[k];			
					
					if( TypeUtils.isArray( item ) || TypeUtils.isObject( item ) )
					{								
						result.push( itemPad + JSON.encode(k) + ':' );
						analysisData( item, result , deep + 1);
						if( count < objLen ) 
						{
							lastItem = result[result.length-1];
							result[result.length-1] = lastItem + ', ';
						}
					}
					else
					{	
						if( typeof item == 'string' )
						{
							item = JSON.encode(item);
						}
						
						if( count < objLen ) itemSeparate = ', ';
						else itemSeparate = '';
						
						result.push( itemPad + JSON.encode(k) + ': ' + item + itemSeparate );
					}
				}
			}
			
			if( pushSymbol ) result.push( pad+closeSymbol );
		}
		
	}
}