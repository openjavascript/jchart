package org.xas.jchart.common.ui.widget
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.xas.core.utils.Log;
	
	public class RectBgLine extends Sprite
	{
		protected var _placeholder:Sprite;
		protected var _width:Number;
		protected var _height:Number;
		protected var _thickness:int;
		protected var _color:uint;
		protected var _step:Number;
		
		public function RectBgLine( _width:Number, _height:Number, _thickness:int = 1, _color:uint = 0xE2E2E2 )
		{
			super();
			
			this._width = _width;
			this._height = _height;
			this._thickness = _thickness;
			this._color = _color;
			this._step = _thickness * 3;
			
			addChild( _placeholder = new Sprite() );
			_placeholder.graphics.beginFill( _color, .0 );
			_placeholder.graphics.drawRect( 0, 0, _width, _height );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		protected function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		protected function init():void{
			this.graphics.lineStyle( _thickness, _color );
			
			var _tx:Number = this._width
				, _ty:Number = 0
				
				, _bx:Number = this._width
				, _by:Number = 0
				
				, _tplus:Number = 0
				, _bplus:Number = 0
				
				, _tfirstMin:Boolean = true
				, _bfirstMax:Boolean = true
				;
			
			while( true ){
				
				if( _ty >= _height && _bx <= 0 ){
					break;
				}
				
				if( _tx < 0 ){
					if( _tfirstMin ){
						_tfirstMin = false;
						_ty += Math.abs( _tx );
					}else{
						_ty += _step;
					}
					_tx = 0;
					
				}
											
				if( _ty > _height ){
					_ty = _height;
				}
				
				if( _bx < 0 ){
					_bx = 0;
				}
				
				graphics.moveTo( _tx, _ty );
				graphics.lineTo( _bx, _by );
				
				if( _by >= _height ){
					if( _bfirstMax ){
						_bfirstMax = false;
						_bx -= ( _by - _height );
					}else{
						_bx -= _step;
					}
				}
				
				if( _by >= _height ){
					_by = _height;
				}
				
				//Log.log( _tx, _ty, _bx, _by );
				
				_tx -= _step;
				_by += _step;
				
			}
		}
	}
}