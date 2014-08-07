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
		
		private var _leftButtonLabel:Vector.<JTextField>;
		private var _leftButtonLine:Vector.<JSprite>;
		
		private var _rightButtonLabel:Vector.<JTextField>;
		private var _rightButtonLine:Vector.<JSprite>;
		
		private var _isIntersect:Boolean = false;
		
		private var _maxWidth:Number;
		
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
			
			_leftButtonLabel = new Vector.<JTextField>();
			_leftButtonLine = new Vector.<JSprite>();
			
			_rightButtonLabel = new Vector.<JTextField>();
			_rightButtonLine = new Vector.<JSprite>();
			
			_isIntersect = false;
			_maxWidth = 0;
			
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
						break;
					}
					case 'right':
					{
						//_label.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						break;
					}
					case 'bottom':
					{
						//_label.attr( { x: _item.end.x, y: _item.end.y + 5 } );
						_label.x = _lineData.end.x - _label.width / 2;
						_label.y = _lineData.end.y;
						break;
					}
					case 'left':
					{
						//_label.attr( { x: _item.end.x - 5, y: _item.end.y, 'text-anchor': 'end' } );
						_label.x = _lineData.end.x - 5 - _label.width;
						_label.y = _lineData.end.y - _label.height / 2;
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
						_leftButtonLabel.push( _label );
						_leftButtonLine.push( _line );
						break;
					}
					case 'right_bottom':
					{
						//_label.attr( { x: _item.end.x + 5, y: _item.end.y, 'text-anchor': 'start' } );
						_label.x = _lineData.end.x + 5;
						_label.y = _lineData.end.y - _label.height / 2;
						_rightButtonLabel.push( _label );
						_rightButtonLine.push( _line );
						break;
					}
				}			
				_label.textColor = BaseConfig.ins.itemColor( _k );
				addChild( _label );
				
				_label.width > _maxWidth && ( _maxWidth = _label.width );
				
				_labels.push( _label );
				_lines.push( _line );
			});
			
			_isIntersect = checkIntersect( _labels );
			
			//Log.log( _isIntersect );
			if( _isIntersect ){
				_leftTopLabel.reverse();
				
				if( checkIntersect( _leftTopLabel ) ){
					fixLeftTop();
				}
			}
		}
		
		private function fixLeftTop():void{
			if( !_leftTopLabel.length ) return;
			var _x:Number = BaseConfig.ins.c.chartX + ( BaseConfig.ins.c.chartWidth - BaseConfig.ins.c.radius * 2 ) / 2 - 0 - _maxWidth
				, _y:Number = BaseConfig.ins.c.chartY + 5
				;
			
			Common.each( _leftTopLabel, function( _k:int, _item:JTextField ):void{
				var _preLabel:JTextField = getLabel( _item.data.index + 1 )
					, _nextLabel:JTextField = getLabel( _item.data.index - 1 )
					;
				if( _preLabel ){
					_item.x = _x + ( _maxWidth - _item.width ) - _k * 10;
					if( _k === 0 ){
						_item.y = _y;
					}else{
						_item.y = _preLabel.y + _preLabel.height - 5;
					}
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