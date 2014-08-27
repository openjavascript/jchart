package org.xas.jchart.common.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.BaseConfig;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.DefaultOptions;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.JSprite;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	public class PieLabelView extends Sprite
	{
		private var _labels:Vector.<JTextField>;
		public function get labels():Vector.<JTextField>{ return _labels; }
		
		private var _lines:Vector.<JSprite>;
		public function get lines():Vector.<JSprite>{ return _lines; }
		
		private var _leftTopLabel:Vector.<JTextField>;
		private var _leftTopLine:Vector.<JSprite>;
		
		private var _rightTopLabel:Vector.<JTextField>;
		private var _rightTopLine:Vector.<JSprite>;
		
		private var _leftBottomLabel:Vector.<JTextField>;
		private var _leftBottomLine:Vector.<JSprite>;
		
		private var _rightBottomLabel:Vector.<JTextField>;
		private var _rightBottomLine:Vector.<JSprite>;
		
		private var _isIntersect:Boolean = false;
		
		private var _maxWidth:Number;
		private var _maxHeight:Number;
		
		private var _debugLabel:Boolean = false;
		
		public function PieLabelView()
		{
			super();
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
			_debugLabel = false;
			addEventListener( JChartEvent.SHOW_CHART, onShowChart );
		}
		
		private function onShowChart( _evt:JChartEvent ):void{
			ElementUtility.removeAllChild( this );
			graphics.clear();
			
			_labels = new Vector.<JTextField>();
			_lines = new Vector.<JSprite>();
			
			_leftTopLabel = new Vector.<JTextField>();
			_leftTopLine = new Vector.<JSprite>();
			
			_rightTopLabel = new Vector.<JTextField>();
			_rightTopLine = new Vector.<JSprite>();
			
			_leftBottomLabel = new Vector.<JTextField>();
			_leftBottomLine = new Vector.<JSprite>();
			
			_rightBottomLabel = new Vector.<JTextField>();
			_rightBottomLine = new Vector.<JSprite>();
			
			_isIntersect = false;
			_maxWidth = 0;
			_maxHeight = 15;
			
			
			if( !BaseConfig.ins.dataLabelEnabled ) return;
			
			if( !( BaseConfig.ins.c && BaseConfig.ins.c.piePart && BaseConfig.ins.c.piePart.length ) ) return;
			
			var _topLabel:JTextField, _topLine:JSprite
				, _rightLabel:JTextField, _rightLine:JSprite
				, _bottomLabel:JTextField, _bottomLine:JSprite
				, _leftLabel:JTextField, _leftLine:Sprite
				;
			
			Common.each( BaseConfig.ins.c.pieLine, function( _k:int, _lineData:Object ):void{
				
				var _data:Object = { index: _k, data: _lineData, color: BaseConfig.ins.itemColor( _k ) }
					, _line:JSprite = new JSprite( _data )
					, _label:JTextField = new JTextField( _data )
					;
					_data.line = _line;
				
				_line.graphics.lineStyle( 1, BaseConfig.ins.itemColor( _k ) );
				_line.graphics.moveTo( _lineData.start.x, _lineData.start.y );
				_line.graphics.curveTo( _lineData.control.x, _lineData.control.y, _lineData.end.x, _lineData.end.y );												
				addChild( _line );
				
				_label.text = BaseConfig.ins.displaySeries[ _k ].name;
				_label.mouseEnabled = false;
				_label.autoSize = TextFieldAutoSize.LEFT;
				
				
				switch( _lineData.direction ){
					case 'top':
					{
						_label.x = _lineData.end.x - _label.width / 2;
						_label.y = _lineData.end.y - 5 - _label.height;
						//_leftTopLabel.push( _label );
						//_leftTopLine.push( _line );
						
						_topLabel = _label;
						_topLine = _line;
						break;
					}
					case 'right':
					{
						//_label.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						//_rightBottomLabel.push( _label );
						//_rightBottomLine.push( _line );
						_rightLabel = _label;
						_rightLine = _line;
						break;
					}
					case 'bottom':
					{
						//_label.attr( { x: _item.end.x, y: _item.end.y + 5 } );
						_label.x = _lineData.end.x - _label.width / 2;
						_label.y = _lineData.end.y;
						//_leftBottomLabel.push( _label );
						//_leftBottomLine.push( _line );
						_bottomLabel  = _label;
						_bottomLine  = _line;
						break;
					}
					case 'left':
					{
						//_label.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
						//_leftBottomLabel.push( _label );
						//_leftBottomLine.push( _line );
						_leftLabel  = _label;
						_leftLine  = _line;
						break;
					}
					case 'left_top':
					{
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
						_leftTopLabel.push( _label );
						_leftTopLine.push( _line );
						break;
					}
					case 'right_top':
					{
						//_label.attr( { x: , y: , 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						_rightTopLabel.push( _label );
						_rightTopLine.push( _line );
						break;
					}
					case 'left_bottom':
					{
						//_label.attr( { x: 5, y: , 'text-anchor': 'end' } );
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
						_leftBottomLabel.push( _label );
						_leftBottomLine.push( _line );
						break;
					}
					case 'right_bottom':
					{
						//_label.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						_rightBottomLabel.push( _label );
						_rightBottomLine.push( _line );
						break;
					}
				}			
				_label.textColor = BaseConfig.ins.itemColor( _k );
				addChild( _label );
				
				_label.width > _maxWidth && ( _maxWidth = _label.width );
				_label.height > _maxHeight && ( _maxHeight = _label.height );				
				
				_labels.push( _label );
				_lines.push( _line );
			});
			
			if( _topLabel ){
				_leftTopLabel.push( _topLabel );
				_leftTopLine.push( _topLine );
			}
			
			if( _rightLabel ){
				_rightTopLabel.push( _rightLabel );
				_rightTopLine.push( _rightLine );
			}
			
			if( _bottomLabel ){
				_rightBottomLabel.push( _bottomLabel );
				_rightBottomLine.push( _bottomLine );
			}
			
			if( _leftLabel ){
				_leftBottomLabel.push( _leftLabel );
				_leftBottomLine.push( _leftLine );
			}
			_isIntersect = checkIntersect( _labels );
			
			//Log.log( _isIntersect );
			if( _isIntersect ){
				
				fixRightTopLabel( _rightTopLabel );
				
				_rightBottomLabel.reverse();
				fixRightBottomLabel( _rightBottomLabel );
				
				_leftTopLabel.reverse();
				fixLeftTopLabel( _leftTopLabel );
				
				fixLeftBottomLabel( _leftBottomLabel );
			}
		}
		
		private function fixRightTopLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx + 5
				, _y:Number = BaseConfig.ins.c.chartY + 5
				, _endX:Number = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth - 5 - _maxWidth
				, _endY:Number = BaseConfig.ins.c.cy - _maxHeight - 5
				;	
			
			if( _labels.length < 5 ){
				_x = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth - ( BaseConfig.ins.c.cx - BaseConfig.ins.c.chartX ) / 5;
			}
						
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
				, _controlX:Number = -8
				, _controlY:Number = -8
				, _anchorX:Number = _item.x - 2
				, _anchorY:Number = _item.y + _item.height / 2
				;			
				
				if( _item.data.data.start.x > _anchorX && _item.data.data.start.y > _anchorY ){
					_controlX = 8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2;
					_anchorY = _item.y + _item.height + 2;
				}
				
				if( _line ){
					
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}
		
		private function fixRightBottomLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx + 5
				, _endX:Number = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth - 5 - _maxWidth
				
				, _y:Number = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight - 5 - _maxHeight
				, _endY:Number = BaseConfig.ins.c.cy + _maxHeight - 5
				;	
			
			if( _labels.length < 5 ){
				_x = BaseConfig.ins.c.chartX + BaseConfig.ins.c.chartWidth - ( BaseConfig.ins.c.cx - BaseConfig.ins.c.chartX ) / 5;
			}
			
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
				, _controlX:Number = -8
				, _controlY:Number = 8
				, _anchorX:Number = _item.x - 2
				, _anchorY:Number = _item.y + _item.height / 2
				;			
				
				
				if( _item.data.data.start.x > _anchorX && _item.data.data.start.y < _anchorY ){
					_controlX = -8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2  + 2;
					_anchorY = _item.y ;
				}
				
				
				if( _line ){
					
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}
		
		private function fixLeftTopLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx - _maxWidth - 5
				, _y:Number = BaseConfig.ins.c.chartY + 5
				, _endX:Number = BaseConfig.ins.c.chartX + 10
				, _endY:Number = BaseConfig.ins.c.cy - _maxHeight / 2 - 10
				;
			
			if( _labels.length < 5 ){
				_x = BaseConfig.ins.c.chartX + ( BaseConfig.ins.c.cx - BaseConfig.ins.c.chartX ) / 5;
			}
			
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
					, _controlX:Number = 8
					, _controlY:Number = -8
					, _anchorX:Number = _item.x + _item.width + 2
					, _anchorY:Number = _item.y + _item.height / 2
					;		
					
				
				if( _item.x + _item.width + 25 >= _item.data.data.start.x && _item.data.data.start.y > _anchorY ){
					_controlX = -8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2;
					_anchorY = _item.y + _item.height + 2;
				}
				
				
				if( _line ){
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}		
		
		private function fixLeftBottomLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx - _maxWidth - 5
				, _endX:Number = BaseConfig.ins.c.chartX + 5
				, _y:Number = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight - 5 - _maxHeight
				, _endY:Number = BaseConfig.ins.c.cy + _maxHeight / 2 - 5
				;
			
			if( _labels.length < 5 ){
				_x = BaseConfig.ins.c.chartX + ( BaseConfig.ins.c.cx - BaseConfig.ins.c.chartX ) / 5;
			}
			
			positionItems( _labels, _x, _y, _endX, _endY, function( _item:JTextField ):void{				
				var _line:JSprite = _item.data.line as JSprite
				, _controlX:Number = -8
				, _controlY:Number = 8
				, _anchorX:Number = _item.x + _item.width + 2
				, _anchorY:Number = _item.y + _item.height / 2
				;			
								
				
				if( ( _anchorX + 25 >= _item.data.data.start.x ) && _item.data.data.start.y < _anchorY ){
					_controlX = 8;
					_controlY = 0;
					_anchorX = _item.x + _item.width / 2;
					_anchorY = _item.y - 2;
				}
				
								
				if( _line ){
					
					_line.graphics.clear();
					_line.graphics.lineStyle( 1, _item.data.color );
					_line.graphics.moveTo( _item.data.data.start.x, _item.data.data.start.y );
					_line.graphics.lineTo( _item.data.data.ex.x, _item.data.data.ex.y );
					
					_line.graphics.curveTo( 
						_anchorX + _controlX, _anchorY + _controlY
						, _anchorX, _anchorY
					);
				}
			} );
		}	
		
		private function positionItems( _labels:Vector.<JTextField>
										, _x:Number, _y:Number
										  , _endX:Number, _endY:Number
											, _cb:Function = null
		):void
		{
			var _xWidth:Number = Math.abs( _x - _endX )
				, _xIsMax:Boolean = _x > _endX
				
				,  _yHeight:Number = Math.abs( _y - _endY )
				, _yIsMax:Boolean = _y > _endY
				
				, _maxLen:int = _labels.length - 1
				, _yStep:Number = Math.abs( _y - _endY ) / _maxLen
				;
			if( _labels.length ){
				var _tmpX:Number, _tmpY:Number = _y, _tmpWidth:Number = _xWidth;
				Common.each( _labels, function( _k:int, _item:JTextField ):void{
					var _percent:Number = .65
					, _maxX:Number = Math.max( _x, _endX )
					, _minX:Number = Math.min( _x, _endX )
					;
					if( _xIsMax ){
						if( _k == 0 ){
							_percent = .99;
						}else if( _k == _maxLen ){
						}else{				
						}
					}else{
						if( _k == 0 ){
							_percent = .99;
						}else if( _k == _maxLen ){
						}else{				
						}
					}
					_tmpWidth *= _percent;
					if( _xIsMax ){
						_item.x = _maxX - ( _xWidth - _tmpWidth );
					}else{						
						_item.x = _minX + ( _xWidth - _tmpWidth );
					}
					_item.y = _tmpY;
					
					if( _yIsMax ){
						_tmpY -= _yStep;
					}else{
						_tmpY += _yStep;
					}
					
					//_item.text = _item.text + '_' + _k;
					_cb && _cb( _item );				
				});
			}else{
				
			}
		}
		
		private function checkIntersect( _labes:Vector.<JTextField> ):Boolean{
			var _r:Boolean = false
				, _len:int
				, i:int, j:int
				, _ta:JTextField, _tb:JTextField
				;
			
			_len = _labels.length;
			
			for(  i = 0; i < _len; i++ ){
				_ta = _labels[ i ];
				for( j = i + 1; j < _len; j++ ){
					_tb = _labels[ j ];
					
					if( _ta.hitTestObject( _tb ) ){
                        return true;
					}
				}
			} 
			
			return _r;
		}

	}
}
