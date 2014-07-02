package org.xas.core.net
{
	import org.xas.core.model.HttpResultData;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * Http 通信类
	 */
	public class Http
	{

		public function Http()
		{
		}
		
		public static function get( $url:String, $callback:Function ):void
		{
			var resultData:HttpResultData = new HttpResultData(200, $url);
				
			var request:URLRequest = new URLRequest( $url );
			
			var variables:URLVariables = new URLVariables(  );
			request.method = URLRequestMethod.GET;
			
			var loader:URLLoader = new URLLoader(  );			
			loader.addEventListener( Event.COMPLETE, onComplete );	
			loader.addEventListener( IOErrorEvent.NETWORK_ERROR, onError );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onError );		
			loader.load( request );
			
			function onComplete( event:Event ):void
			{
				resultData.DATA = URLLoader(event.target).data;	
				$callback( resultData );
				dispose();
			}
			
			function onError(event:Event):void
			{
				resultData.CODE = 400;	
				resultData.DATA = URLLoader(event.target).data;	
				$callback( resultData );
				dispose();
			}
			
			function dispose():void
			{
				loader.removeEventListener( Event.COMPLETE, onComplete );
				loader.removeEventListener( Event.COMPLETE, onError );
				loader = null;
				resultData = null;
			}
		}//public static function get( $url:String, $callback ):void
		
		public static function post( $url:String, $data:Object, $callback:Function ):void
		{
			var resultData:HttpResultData = new HttpResultData(200, $url);
			
			var request:URLRequest = new URLRequest( $url );
			request.method = URLRequestMethod.POST;
			
			var variable:URLVariables = new URLVariables();
			for( var k:String in $data )
			{
				variable[k] = $data[k];
			}
			
			
			request.data = variable;
			
			var loader:URLLoader = new URLLoader(  );			
			loader.addEventListener( Event.COMPLETE, onComplete );	
			loader.addEventListener( IOErrorEvent.NETWORK_ERROR, onError );
			loader.addEventListener( IOErrorEvent.IO_ERROR, onError );		
			loader.load( request );
			
			function onComplete( event:Event ):void
			{
				resultData.DATA = URLLoader(event.target).data;	
				$callback( resultData );
				dispose();
			}
			
			function onError(event:Event):void
			{
				resultData.CODE = 400;	
				resultData.DATA = URLLoader(event.target).data;	
				$callback( resultData );
				dispose();
			}
			
			function dispose():void
			{
				loader.removeEventListener( Event.COMPLETE, onComplete );
				loader.removeEventListener( Event.COMPLETE, onError );
				loader = null;
				resultData = null;
			}
		}//public static function get( $url:String, $callback ):void
	}
}