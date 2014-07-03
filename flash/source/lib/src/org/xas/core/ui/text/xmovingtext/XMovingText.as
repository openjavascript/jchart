package org.xas.core.ui.text.xmovingtext
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.xas.core.utils.Log;
	
	public class XMovingText extends Sprite
	{
		private var _w:Number = 100;
		private var _h:Number = 20;
		
		private var _model:Model;
		private var _view:View;
		
		public function XMovingText( $w:Number, $h:Number )
		{
			_w = $w;
			_h = $h;
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void
		{
			_model = new Model( _w, _h );
			addChild( _view = new View(_model) );
			
			var p:* = this;
			
			_view.addEventListener
				(
					XMovingTextEvent.PLAY_DONE,
					function($evt:Event):void
					{
						p.dispatchEvent
						(
							new Event( XMovingTextEvent.PLAY ) 
						);
					}
				);
			
			_view.addEventListener
				(
					XMovingTextEvent.PLAY_DONE,
					function($evt:Event):void
					{
						p.dispatchEvent
						(
							new Event( XMovingTextEvent.PLAY_DONE ) 
						);
					}
				);
		}
		
		public function add( $text:String ):void
		{
			Log.print( 'XMovingText.add' );
			_model.add($text);
			_view.update();
		}
		
		public function setSize( $w:Number ):void
		{
			_view.setSize($w);
		}
	}
}