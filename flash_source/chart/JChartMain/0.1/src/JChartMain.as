package 
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	
	import org.xas.core.*;
	import org.xas.core.events.BaseEvent;
	import org.xas.core.utils.FreeMemory;
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.*;
	import org.xas.jchart.main.MainFacade;
	
	/**
	 * ...
	 * @author suches@btbtd.org
	 */
	[SWF(frameRate="30", width="600", height="400")]
	public class JChartMain extends Sprite 
	{		
		public function JChartMain():void 
		{
			Security.allowDomain( '*' );
			this.root.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.root.stage.align = StageAlign.LEFT;
			
			this.addEventListener( 'init_handler', initHanlder );
			this.addEventListener( 'init_data', initData );
			this.addEventListener( 'initDraw', initDraw );
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
	
			dispatchEvent( new BaseEvent( 'init_data' ) );
			dispatchEvent( new BaseEvent( 'init_handler' ) );
			
			dispatchEvent( new BaseEvent( 'initDraw' ) );
		}
		
		private function initHanlder( _evt:BaseEvent ):void {
			Log.print( 'main initHandler' );	
			
			if( ExternalInterface.available ){
				ExternalInterface.addCallback(  'update', update );
			}
		}
		
		private function initData( _evt:BaseEvent ):void {
			
			Config.setParams( LoaderInfo( this.root.stage.loaderInfo ).parameters || {} );
			
			Config.params 
				&& ( 'debug' in Config.params )
				&& ( Config.setDebug( StringUtils.parseBool( Config.params.debug ) ) );
				
			!ExternalInterface.available && ( Config.setDebug( true ) );
			
			Log.debug = Config.debug;
			
			Log.print( 'main initData' );
		}
				
		private function update( _data:Object ):void{
			//MainFacade.getInstance().update( _data );
			Log.print( 'test' );
		}
		
		private function initDraw( _evt:BaseEvent ):void {
			FreeMemory.getInstance().execute();
			MainFacade.getInstance().update( Config.params.data );
		}
		
	}
	
}