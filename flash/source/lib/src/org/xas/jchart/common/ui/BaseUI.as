package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.ui.icon.*;
	
	public class BaseUI extends Sprite
	{
		public function get items():Vector.<CircleIcon>{ return _items; }
		
		public function BaseUI( )
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		protected function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		protected function init():void{

		}
	}
}

