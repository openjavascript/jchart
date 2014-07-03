package org.xas.core.ui.dialog
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.events.BaseEvent;
	import org.xas.core.utils.Log;
	import org.xas.core.ui.mask.XMask;
	
	/**
	 * 会话框类
		<pre>
		XDialog.root = this.root.stage;		
		root.stage.addChild( XMask.getInstance() );
		</pre>
	 */
	public final class XDialog
	{				
		private static var _root:DisplayObjectContainer;
		
		public static function get root():DisplayObjectContainer{return _root;}
		public static function set root($v:DisplayObjectContainer):void
		{
			_root = $v;
			_root.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private static var _mask:XMask;
		private static var _popup:DisplayObject;	
		private static var _popupPosPercent:Point;
		
		public static function alert($s:String, $callback:Function = null):void
		{
			resetMask();
			resetPopup();
			
			var layout:XAlert = new XAlert($s, $callback);
			layout.addEventListener(XDialogEvent.ON_ALERT_CLICK, onAlertClick);
			layout.addEventListener(XDialogEvent.ON_POPUP_POSITION_CHANGE, onPopupPositionChange);
			root.addChild( layout );
			
			_popup = layout;
			centerItem( _popup );
		}
		
		public static function confirm($s:String
									   , $callback:Function = null
									   , $cancelCallback:Function = null):void
		{
			resetMask();
			resetPopup();
			
			var layout:XConfirm = new XConfirm($s, $callback, $cancelCallback);
			layout.addEventListener(XDialogEvent.ON_ALERT_CLICK, onAlertClick);
			layout.addEventListener(XDialogEvent.ON_POPUP_POSITION_CHANGE, onPopupPositionChange);
			root.addChild( layout );
			
			_popup = layout;
			centerItem( _popup );
		}
		private static function onPopupPositionChange($evt:BaseEvent):void
		{
			var popupPoint:Point = Point( $evt.data );
			_popupPosPercent = 
				new Point
				(
					(popupPoint.x) / (root.stage.stageWidth-_popup.width)
					, (popupPoint.y) / (root.stage.stageHeight-_popup.height)
				);			
		}
		private static function onAlertClick($evt:BaseEvent):void
		{
			_mask.hide();
			resetPopup();
			
			//Log.print( 'click event' );
		}
		
		private static function onResize($evt:Event):void
		{
			if(!_mask) return; 
			if(!_mask.isVisible()) return; 
			
			if( _popupPosPercent && _popup )
			{
				_popup.x = _popupPosPercent.x * (root.stage.stageWidth - _popup.width);
				_popup.y = _popupPosPercent.y * (root.stage.stageHeight - _popup.height);
			}
		}
		
		private static function init():void
		{
			if( _mask ) 
			{
				_mask.resetLayout();
				return;	
			} 
			_mask = XMask.getInstance();
		}
		
		private static function resetMask():void
		{
			init();
			_mask.show();
			root.addChild( _mask );
		}
		private static function resetPopup():void
		{
			if( _popup && _popup.root ) 
			{
				_popup.parent.removeChild( _popup );
				_popup = null;
			}
		}
		
		private static function centerItem($item:DisplayObject):void
		{
			if(!$item) return;
			$item.x = (root.stage.stageWidth - $item.width) / 2;
			$item.y = (root.stage.stageHeight - $item.height) / 2;
						
			onPopupPositionChange
			(
				new XDialogEvent
				( 
					XDialogEvent.ON_POPUP_POSITION_CHANGE
					, new Point( $item.x, $item.y ) 
				) 
			);
		}
	}
}
