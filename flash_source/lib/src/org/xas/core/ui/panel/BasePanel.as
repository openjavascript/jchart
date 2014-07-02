package org.xas.core.ui.panel
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.xas.core.model.BaseSize;
	import org.xas.core.ui.layout.BaseBg;
	import org.xas.core.ui.text.XLabel;
	import org.xas.core.ui.textbox.TextBox;
	import org.xas.core.utils.DragUtils;
	import org.xas.core.utils.Log;
	
	public class BasePanel extends Sprite
	{
		protected var _type:String = 'NULL';
		public function get type():String{ return _type; }
		
		protected var _bg:BaseBg;
		protected var _size:BaseSize;
		
		protected var _name:XLabel;
		
		protected var _width:Number = 400;
		protected var _height:Number = 200;
		
		protected var _bgParams:Object;
		
		protected var _nameColor:int = 0xffffff;
		
		public function BasePanel()
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);		
			init();
		}
		
		protected function init():void
		{
			//Log.print( 'BasePanel.init: ' );
			_size = new BaseSize( this.width, this.height );
			
			if( _size.width < _width ) _size.width = _width;
			if( _size.height < _height ) _size.height = _height;
			
			//Log.print( '_size.width: ' + _size.width + ', _size.height: ' + _size.height );
			
			addChild( _bg = new BaseBg( _bgParams ) );
			
			addChild( _name = new XLabel( this.type ) );
			_name.x = 6;
			_name.y = 4;
			_name.textFiled.selectable = false;
			_name.textFiled.textColor = _nameColor;
			
			
			_bg.resize( _size.width, _size.height, 0, 0 );
			
			DragUtils.init( this );
			
			this.x = 5;
			this.y = 60;
		}
		
		public function toggle():Boolean
		{
			Log.print( 'BasePanel.toggle: ' );
			
			var r:Boolean;
			
			this.visible = !this.visible;
			
			return r;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function isVisible():Boolean
		{
			return this.visible
		}
	}
}