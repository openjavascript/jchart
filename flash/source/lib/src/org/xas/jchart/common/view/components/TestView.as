package org.xas.jchart.common.view.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.xas.core.ui.button.XButton;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.event.JChartEvent;
	
	public class TestView extends Sprite
	{
		private var _data:Vector.<Object>;
		private var _isLeave:Boolean;
		
		public function TestView( _data:Vector.<Object> )
		{
			super();
			this._data = _data;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
			_isLeave = true;
			this.root.stage.addEventListener( MouseEvent.MOUSE_OVER, onActive );
			this.root.stage.addEventListener( Event.MOUSE_LEAVE, onLeave );
		}
		
		private function onActive( _evt:Event ):void{
			if( !_isLeave ) return;
			_isLeave = false;
			this.visible = true;
			//Log.log( 'onActive', new Date().getTime() );
		}
		
		private function onLeave( _evt:Event ):void{
			//Log.log( 'onLeave', new Date().getTime() );
			_isLeave = true;
			this.visible = false;			
		}
		
		private function init():void{
			this.visible = false;
			
			var _x:Number = 10
				, _y:Number = 20
				, _yStep:Number = 25
				, _space:Number = 5
				, _maxWidth:Number = root.stage.stageWidth
				;
			if( _maxWidth < 100 ) _maxWidth = 100;
			
			Common.each( _data, function( _k:int, _item:Object ):void{
				var _btn:XButton = new XButton( 'data_' + _k, { index: _k, data: _item } );
				
				if( _k > 0 ) _x += _space;
				
				if( ( _x + _btn.width ) > _maxWidth ){
					_x = 10;
					_y += _yStep;
				}
				
				_btn.x =_x;
				
				_btn.y = _y;
				
				addChild( _btn );
				
				_x += _btn.width;
				
				_btn.addEventListener( MouseEvent.CLICK, onClick );
			});
		}
		
		private function onClick( _evt:MouseEvent ):void{
			var _btn:XButton = _evt.currentTarget as XButton;
			//Log.log( 'xxx' );
			if( !_btn ) return;
			this.dispatchEvent( new JChartEvent( JChartEvent.UPDATE, _btn.data ) );
			
			//Log.printJSON( _btn.data.data );
		}
		
	}
}