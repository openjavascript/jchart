package org.xas.jchart.common.view.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	
	public class TestView extends Sprite
	{
		private var _data:Vector.<Object>;
		
		public function TestView( _data:Vector.<Object> )
		{
			super();
			this._data = _data;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			Common.each( _data, function( _k:int, _item:Object ):void{
				Log.log( _k );
			});
		}
		
	}
}