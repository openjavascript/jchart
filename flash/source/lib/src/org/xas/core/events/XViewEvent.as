package org.xas.core.events
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class XViewEvent extends BaseEvent
	{
		private static const PREFIX:String = 'XViewEvent_';
		
		public static const ON_VIEW_EVENT:String = PREFIX + 'ON_VIEW_EVENT';	
		
		public function XViewEvent($type:String, $data:Object=null)
		{
			super($type, $data);
		}
		
		public static function initEvent( $dispatcher:IEventDispatcher, $obj:DisplayObject, 
										 $evtName:String, $data:Object = null, $callback:Function = null ):void
		{
			$obj.addEventListener
				(
					MouseEvent.CLICK, 
					function( $evt:MouseEvent ):void
					{
						$dispatcher.dispatchEvent
						( 
							new XViewEvent
							( 
								XViewEvent.ON_VIEW_EVENT, 
								{
									type: $evtName 
									, data: $data 
								} 
							) 
						);
						
						if( $callback != null )
						{
							$callback( $obj );
						}
					}
				);
		}
		
		public static function dispatch($dispatcher:IEventDispatcher, $evtName:String, $data:Object = null):void
		{
			$dispatcher.dispatchEvent
				( 
					new XViewEvent
					( 
						XViewEvent.ON_VIEW_EVENT, 
						{
							type: $evtName 
							, data: $data 
						} 
					) 
				);
		}
	}
}