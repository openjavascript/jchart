package org.xas.core.net.checknew
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.xas.core.model.HttpResultData;
	import org.xas.core.net.Http;
	import org.xas.core.utils.Log;
	
	public class CheckNew extends EventDispatcher
	{
		private var _checkUrl:String;
		private var _currentVersion:String;
		
		public function CheckNew( $currentVersion:String, $checkUrl:String = '' )
		{
			_checkUrl = $checkUrl;
			_currentVersion = $currentVersion;
		}
		
		public function check($checkUrl:String = ''):void
		{
			_checkUrl = $checkUrl || _checkUrl;
			if( !_checkUrl ) return;
			
			Http.get( _checkUrl, checkNewCallback );
		}
		
		private function checkNewCallback($data:HttpResultData):void
		{
			var data:Object = JSON.decode( $data.DATA );
			
			var re:RegExp = /[^0-9\.]/gi;
			var currentVersion:Number = parseFloat( _currentVersion.replace( re, '' ) );
			var lastVersion:Number = parseFloat( data.version.replace( re, '' ) );
			
			Log.print( 'CheckNew.checkNewCallback: ' );
			Log.print( 'currentVersion: ' + currentVersion + ', lastVersion: ' + lastVersion );
			
			dispatchEvent( new CheckNewEvent( CheckNewEvent.ON_DATA, data ) );
			
			if( currentVersion < lastVersion )
			{
				dispatchEvent( new CheckNewEvent( CheckNewEvent.HAS_NEW_VERSION, data ) );
			}
			
		}
	}
}