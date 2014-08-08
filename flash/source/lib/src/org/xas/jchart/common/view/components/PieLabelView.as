package org.xas.jchart.common.view.components
{
	import com.adobe.utils.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
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
		
		public function PieLabelView()
		{
			super();
		
			addEventListener( Event.ADDED_TO_STAGE, addToStage );
		}
		
		private function addToStage( _evt:Event ):void{
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
			
			Common.each( BaseConfig.ins.c.pieLine, function( _k:int, _lineData:Object ):void{
				
				var _data:Object = { index: _k, data: _lineData, line: _line }
					, _line:JSprite = new JSprite( _data )
					, _label:JTextField = new JTextField( _data )
					;
				
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
						_leftTopLabel.push( _label );
						_leftTopLine.push( _line );
						break;
					}
					case 'right':
					{
						//_label.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						_rightBottomLabel.push( _label );
						_rightBottomLine.push( _line );
						break;
					}
					case 'bottom':
					{
						//_label.attr( { x: _item.end.x, y: _item.end.y + 5 } );
						_label.x = _lineData.end.x - _label.width / 2;
						_label.y = _lineData.end.y;
						_leftBottomLabel.push( _label );
						_leftBottomLine.push( _line );
						break;
					}
					case 'left':
					{
						//_label.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
						_leftBottomLabel.push( _label );
						_leftBottomLine.push( _line );
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
			
			_isIntersect = checkIntersect( _labels );
			
			//Log.log( _isIntersect );
			if( _isIntersect ){
				
				_rightTopLabel;
				fixRightTopLabel( _rightTopLabel );
				
				_rightBottomLabel.reverse();
				fixRightBottomLabel( _rightBottomLabel );
				
				_leftTopLabel.reverse();
				fixLeftTopLabel( _leftTopLabel );
				
				_leftBottomLabel.reverse();
				fixLeftBottomLabel( _leftBottomLabel );
			}
		}
		
		private function fixRightTopLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx + _labels[0].width
				, _y:Number = BaseConfig.ins.c.chartY + 5
				;
			
			var _preLabel:JTextField = getLabel( _labels[0].data.index + 1 )
				, _nextLabel:JTextField
				, _xStep:Number = ( BaseConfig.ins.c.chartX 
									+ BaseConfig.ins.c.chartWidth 
									- _x 
									- 5
									) / ( _labels.length - 1 )
				, _yStep:Number = ( BaseConfig.ins.c.cy - _y + _maxHeight ) / ( _labels.length )
				;
			
			Common.each( _labels, function( _k:int, _item:JTextField ):void{
				_preLabel = getLabel( _item.data.index + 1 );
				_nextLabel = getLabel( _item.data.index - 1 );
				var _plus:Number = 0;
				
				_plus = _item.width;
				
				if( _preLabel ){
					_item.x = _x - _plus;
					_item.y = _y;
					_x += _xStep;
					_y += _yStep;
				}
				
				var _line:JSprite = _lines[ _item.data.index ]
				;
				_line.graphics.clear();
			});
		}
		
		private function fixRightBottomLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx + _labels[0].width
				, _y:Number = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight - 5 - _maxHeight
				;
			
			var _preLabel:JTextField = getLabel( _labels[0].data.index + 1 )
				, _nextLabel:JTextField
				, _xStep:Number = ( BaseConfig.ins.c.chartX 
					+ BaseConfig.ins.c.chartWidth 
					- _x 
					- 5
				) / ( _labels.length - 1 )
				, _yStep:Number = ( _y - BaseConfig.ins.c.cy -  _maxHeight / 2  ) / ( _labels.length - 1 )
				;
			
			Common.each( _labels, function( _k:int, _item:JTextField ):void{
				_preLabel = getLabel( _item.data.index + 1 );
				_nextLabel = getLabel( _item.data.index - 1 );
				var _plus:Number = 0;
				
				_plus = _item.width;
				
				if( _preLabel ){
					_item.x = _x - _plus;
					_item.y = _y;
					_x += _xStep;
					_y -= _yStep;
				}
				
				var _line:JSprite = _lines[ _item.data.index ]
				;
				_line.graphics.clear();
			});
		}
		
		private function fixLeftTopLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx - _labels[0].width
				, _y:Number = BaseConfig.ins.c.chartY + 5
				;
			
			var _preLabel:JTextField = getLabel( _labels[0].data.index + 1 )
				, _nextLabel:JTextField
				, _xStep:Number = ( _x - BaseConfig.ins.c.chartX - 10 ) / ( _labels.length - 1 )
				, _yStep:Number = ( BaseConfig.ins.c.cy - _y + _maxHeight ) / ( _labels.length )
				;
			
			Common.each( _labels, function( _k:int, _item:JTextField ):void{
				_preLabel = getLabel( _item.data.index + 1 );
				_nextLabel = getLabel( _item.data.index - 1 );
					
				if( _preLabel ){
					_item.x = _x;
					_item.y = _y;
					_x -= _xStep;
					_y += _yStep;
				}
				
				var _line:JSprite = _lines[ _item.data.index ]
					;
					_line.graphics.clear();
			});
		}		
		
		private function fixLeftBottomLabel( _labels:Vector.<JTextField> ):void{
			if( !_labels.length ) return;
			var _x:Number = BaseConfig.ins.c.cx - _labels[0].width
				, _y:Number = BaseConfig.ins.c.chartY + BaseConfig.ins.c.chartHeight - 5 - _maxHeight
				;
			
			var _preLabel:JTextField = getLabel( _labels[0].data.index + 1 )
				, _nextLabel:JTextField
				, _xStep:Number = ( _x - BaseConfig.ins.c.chartX  - 10) / ( _labels.length - 1 )
				, _yStep:Number = ( _y - BaseConfig.ins.c.cy -  _maxHeight / 2 ) / ( _labels.length - 1 )
				;
			
			Common.each( _labels, function( _k:int, _item:JTextField ):void{
				_preLabel = getLabel( _item.data.index + 1 );
				_nextLabel = getLabel( _item.data.index - 1 );
				
				if( _preLabel ){
					_item.x = _x;
					_item.y = _y;
					_x -= _xStep;
					_y -= _yStep;
				}
				
				var _line:JSprite = _lines[ _item.data.index ]
				;
				_line.graphics.clear();
			});
		}
		
		private function getLabel( _ix:int ):JTextField{
			var _r:JTextField;
			if( _ix >= 0 && _ix <= ( _labels.length - 1 ) ){
			}else{
				_ix = 0;
			}
			
			if( _labels.length ){4
				_r = _labels[ _ix ];
			}
			
			return _r;
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
						_r = true;
						break;
					}
				}
			} 
			
			return _r;
		}

	}
}