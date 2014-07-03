package org.xas.core.net
{
	import org.xas.core.model.HttpResultData;
	import org.xas.core.model.ProgressData;
	import org.xas.core.utils.Log;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	
	public class BaseLoad extends EventDispatcher
	{
		private var url:String;
		private var callback:Function;
		private var progressCallback:Function;
		
		public function BaseLoad( $url:String, $callback:Function, 
									$progressCallback:Function = null )
		{						
			url 				= $url;
			callback		 	= $callback;
			progressCallback 	= $progressCallback;
		}	
		
		public function load( $returnLoader:Boolean = false, $url:String = null, 
							  $callback:Function = null, 
							  $progressCallback:Function = null ):void
		{
			Log.print( 'BaseLoading load', 80 );
			
			url				 	= $url || url;
			callback 			= $callback || callback;
			progressCallback 	= $progressCallback ||progressCallback;
			
			var lContext:LoaderContext = new LoaderContext(true);
			lContext.applicationDomain = ApplicationDomain.currentDomain;
			//lContext.securityDomain = SecurityDomain.currentDomain;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onError);
			loader.load( new URLRequest( url ), lContext );
			
			Log.print( url );
			
			var resultData:HttpResultData = new HttpResultData(200, url);
			
			function onProgress( $evt:ProgressEvent ):void
			{
				if( progressCallback != null )
				{
					progressCallback
					(
						new ProgressData( $evt.bytesLoaded, $evt.bytesTotal )
					);
				}
			}	
			
			function onComplete( $evt:Event ):void
			{
				if( callback != null )
				{		
					if( $returnLoader ){ resultData.DATA = loader; }
					else{ resultData.DATA = loader.content; }
					
					callback( resultData );
				}
				
				destoryLoader();
			}	
			
			function onError( $evt:IOErrorEvent ):void
			{
				if( callback != null )
				{			
					resultData.CODE = 400;
					callback( resultData );
				}
				destoryLoader();
			}
			
			function destoryLoader():void
			{
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR , onError);
				if(!$returnLoader){ loader.unload(); }
				loader = null;
			}
		}	
	}
}