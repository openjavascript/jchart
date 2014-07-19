package org.xas.jchart.common.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.ui.icon.*;
	
	public class CurveGramUI extends Sprite
	{
		private var _cmd:Vector.<int>;
		private var _path:Vector.<Number>;
		private var _color:Number;
		private var _point:Vector.<Point>;
		
		public function CurveGramUI( _cmd:Vector.<int>, _path:Vector.<Number>, _color:uint )
		{
			super();
			
			this._cmd = _cmd;
			this._path = _path;
			this._color = _color;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( _evt:Event ):void{
			init();
		}
		
		private function init():void{
			//graphics.clear();
			//graphics.beginFill( 0xffffff, 0 );
			graphics.lineStyle( 2, _color );
			graphics.drawPath( _cmd, _path );
			//graphics.endFill();
			_point = new Vector.<Point>;
			while( _path.length ){
				var _x:Number = _path.shift(), _y:Number = _path.shift()
					, _tmp:Point = new Point( _x, _y );
				_point.push( _tmp );
				addChild( new CircleIcon( _tmp, _color ) );
			}
		}
	}
}