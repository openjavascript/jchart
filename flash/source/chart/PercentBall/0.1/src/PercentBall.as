package
{
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.system.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.*;
	
	import org.xas.core.utils.EffectUtility;
	import org.xas.core.utils.ElementUtility;
	import org.xas.core.utils.Log;
	import org.xas.jchart.common.Common;
	import org.xas.jchart.common.data.test.*;
	import org.xas.jchart.common.event.JChartEvent;
	import org.xas.jchart.common.ui.widget.CyclicPart;
	import org.xas.jchart.common.ui.widget.JTextField;
	
	
	[SWF(frameRate="30", width="150", height="150")]
	public class PercentBall extends Sprite
	{
		private var _ins:PercentBall;
		private var _inited: Boolean = false;
		private var _timer:Timer;
		private var _data:Object;
		private var _resizeTimer:Timer;
		private var _loaderInfo:Object;
		
		public function PercentBall()
		{			
			
			flash.system.Security.allowDomain("*");	
			_ins = this; 
			
			Log.debug = true;
			
			this.root.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.root.stage.align = StageAlign.TOP_LEFT;
			
			//update( {} );	
			
			addEventListener( JChartEvent.PROCESS, process );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );	
		}
		
		private function onEnterFrame( $evt:Event ):void
		{
			if( root.stage.stageWidth > 0 && root.stage.stageHeight > 0 )
			{
				removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				init();
			}
		}
		private function init():void
		{			
			_inited = true;
			
			runData();
			
			if( ExternalInterface.available ){
				//ExternalInterface.call( 'alert(1)' );
				//ExternalInterface.addCallback( 'update', extenalUpdate );
			}
			//BaseConfig.ins.setChartData( {});
		}
		
		private function extenalUpdate( _data:Object ):void{
			update( _data );
		}
		
		public function update( _data:Object, _x:int = 0, _y:int = 0 ):void{		
			ElementUtility.removeAllChild( this );
			if( !_inited ){
				_ins._data = _data;
				_timer = new Timer( 50 );
				_timer.addEventListener( TimerEvent.TIMER, timerHandler );
				_timer.start();
				return;
			}
			_timer && _timer.stop();
			
			dispatchEvent( new JChartEvent( JChartEvent.PROCESS, _data ) );
		}
		
		private function process( _evt:JChartEvent ):void{
			//Log.printJSON( _evt.data );
			var _data:Object = _evt.data as Object;
			if( !_data ) return;
			
			var _margin:Number = 10
				, _diameter:Number = Math.min( this.root.stage.stageWidth, this.root.stage.stageHeight )
				, _radius:Number = ( _diameter - _margin * 2 ) / 2
				, _sradius:Number = _radius - 6
				, _cx:Number = this.root.stage.stageWidth / 2
				, _cy:Number = this.root.stage.stageHeight / 2
				
				, _bgcylic:CyclicPart
				, _cyclic:CyclicPart
				;

			
			var _offsetAngle:Number = 90
				, _eangle:Number
				, _sangle:Number
				, _score:Number = _data.score || 0
				, _text:String
				;
			if( _score < 0 ) _score = 0;
			if( _score > 100 ) _score = 100;
			_text = Common.moneyFormat( _score );
			_score /= 100;
			
			//Log.log( _percent, _text );
			//_percent = .80;
						
			_bgcylic = new CyclicPart( new Point( _cx, _cy ), 1, _radius, _sradius );
			addChild( _bgcylic );
			
			if( _score ){
				
				_eangle = 180 * _score;
				_sangle = 360 - _eangle;
				
				_eangle += _offsetAngle;
				_sangle += _offsetAngle;
				
				_cyclic = new CyclicPart( new Point( _cx, _cy ), _score, _radius, _sradius,
					{ 
						color: 0xfeb556
						, bgFill: 0xffffff
						//, coverFill: 0x000001
					}, true
				);					
				addChild( _cyclic );
			}
			
			var _tfx:TextField = new TextField(  );
				_tfx.text = _text;
				_tfx.autoSize = TextFieldAutoSize.LEFT;
				EffectUtility.textFormat( _tfx, { 'bold': false, 'size': 28 } );
				_tfx.x = this.root.stage.stageWidth / 2 - _tfx.width / 2;
				_tfx.y = this.root.stage.stageHeight / 2 - _tfx.height / 2;
				_tfx.mouseEnabled = false;
				
				addChild( _tfx );
			
		}
		
		private function timerHandler( _evt:TimerEvent ):void{
			if( _inited ){
				_timer && _timer.stop();
				update( _ins._data );
			}
		}
		
		private function onAddedToStage($evt:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);				
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			this.root.stage.addEventListener( Event.RESIZE, resize );
		}
		
		private function resize( _evt:Event ):void{
			
			if( _resizeTimer ){
				_resizeTimer.stop();
				_resizeTimer.start();
			}else{
				_resizeTimer = new Timer( 200, 1 );
				_resizeTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onResize );
				_resizeTimer.start();
			}
		}
		
		private function onResize( _evt:TimerEvent ):void{
			if( !_data ) return;
			//dispatchEvent( new JChartEvent( JChartEvent.PROCESS, _data ) );
			//_facade.sendNotification( JChartEvent.CLEAR );
		}
		
		private function onRemovedFromStage( _evt:Event ):void{
			removeEventListener( JChartEvent.PROCESS, process );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			_timer &&_timer.stop();
		}		
		
		private function runData():void{
			
			var _data:Object = {};
			
			if( !ExternalInterface.available ){		
				_data = DefaultPercentBallData.instance.data[ 8 ];
			}else{
				//ExternalInterface.call( 'alert', '2322' );
				_loaderInfo = LoaderInfo(this.root.stage.loaderInfo).parameters||{};
				
				//ExternalInterface.call( 'alert', _loaderInfo.chart );
				
				if( _loaderInfo.chart ){
					_data = JSON.parse( _loaderInfo.chart );
				}				
				//ExternalInterface.call( 'alert', _data.score );
				_data = _data || {};
			}
			
			update( _data );
		}
		
		public static var author:String = 'suches@btbtd.org';
		public static var version:String = '0.1, 2014-07-30';
	}
}