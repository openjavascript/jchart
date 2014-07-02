package org.xas.core.model
{
	/**
	 * HTTP返回结果数据结构
	 * <p>CODE, URL, DATA, MSG</p>
	 * @author	suches@btbtd.org
	 */
	public class HttpResultData extends ResultData
	{
		public var URL	:String;
		
		/**
		 * HTTP返回结果数据结构
		 * @param	$code	错误代码
		 * <p>
		 * 100	继续下一步操作<br/>	
		 * 200	操作成功	<br/>
		 * 300	重定向<br/>	
		 * 400	客户端错误(如无特殊声明,发生错误都是返回400)<br/>	
		 * 500	服务端错误<br/>
		 * </p>
		 * @param	$url	请求的URL
		 * @param	$data	返回数据
		 * @param	$msg	内容提示
		 */
		public function HttpResultData($code:int=200, $url:String='', $data:Object=null, $msg:String='')
		{
			URL		= $url	|| '';
			super($code, $data, $msg);
		}	
		/**
		 * 把类内容输出为Object
		 */
		override public function getData():Object
		{
			var result:Object = super.getData();
				result.URL = URL;
			return result;
		}
	}
}