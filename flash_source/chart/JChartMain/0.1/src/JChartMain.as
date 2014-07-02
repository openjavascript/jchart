package 
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import org.xas.core.*;
	import org.xas.core.events.BaseEvent;
	import org.xas.core.utils.Log;
	import org.xas.core.utils.StringUtils;
	import org.xas.jchart.common.*;
	import flash.display.StageScaleMode;
	
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
			
			this.addEventListener( 'init_data', initData );
			this.addEventListener( 'init_handler', initHanlder );
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
	
			dispatchEvent( new BaseEvent( 'init_data' ) );
			dispatchEvent( new BaseEvent( 'init_handler' ) );
		}
		
		private function initData( _evt:Event ):void {
			XAS.test();
			
			Config.setParams( LoaderInfo( this.root.stage.loaderInfo ).parameters );
			
			Config.params 
				&& ( 'debug' in Config.params )
				&& ( Config.setDebug( StringUtils.parseBool( Config.params.debug ) ) );
				
			!ExternalInterface.available && ( Config.setDebug( false ) );
			
			Log.debug = Config.debug;
		}
		
		private function initHanlder( _evt:Event ):void {
		}
		
		
	}
	
}