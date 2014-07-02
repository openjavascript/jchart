package org.xas.jchart.main
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	/**
	 * ...
	 * @author suches@btbtd.org
	 */
	public class MainFacade extends Facade implements ICommand
	{
		public static const NAME:String = 'MainFacade';
		
		public function MainFacade( _key:String ) {
			super( _key );
		}
		
		public function execute( notification:INotification ):void {
			
		}
		
		override protected function initializeController():void {
			super.initializeController();
		}
		
		public function update( _data:Object ):void {
			
		}
		
		public static function getInstance():MainFacade {
			if ( instanceMap[ NAME ] == null ) instanceMap[ NAME ]  = new MainFacade( NAME );
			return instanceMap[ NAME ] as MainFacade;
		}
		
	}
	
}