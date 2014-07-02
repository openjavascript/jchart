package org.xas.core.net.loadqueue
{
	import org.xas.core.model.ProgressData;

	public interface ILoadQueueView
	{
		function get visible():Boolean;
		function set visible($val:Boolean):void;
		
		function setProgress( $data:ProgressData ):void;
		function setLoaded($data:Object):void;
		
		function setLoadDetail($text:String):void;
		function loadComplete():void;
		function dispose():void;
	}
}