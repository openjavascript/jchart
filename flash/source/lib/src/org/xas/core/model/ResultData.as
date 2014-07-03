package org.xas.core.model
{
	/**
	 * 全局统一返回结果数据结构
	 * <p>CODE, DATA, MSG</p>
	 * @author	suches@btbtd.org
	 */
	public class ResultData
	{
		public var CODE	:int;
		public var DATA	:*;
		public var MSG	:String;
		
		/**
		 * 全局统一返回结果数据结构
		 * @param	$code	错误代码
		 * <p>
		 * 100	继续下一步操作<br/>	
		 * 200	操作成功	<br/>
		 * 300	重定向<br/>	
		 * 400	客户端错误(如无特殊声明,发生错误都是返回400)<br/>	
		 * 500	服务端错误<br/>
		 * </p>
		 * @param	$data	返回数据
		 * @param	$msg	内容提示
		 */
		public function ResultData( $code:int = 200, $data:Object = null, $msg:String = '' )
		{
			CODE	= $code || 200;
			DATA	= $data	|| null;
			MSG		= $msg	|| '';
		}		
		/**
		 * 把类内容输出为Object
		 */
		public function getData():Object
		{
			return {
				CODE: CODE,
				DATA: DATA,
				MSG	: MSG
			};
		}
	}
}
/*
"CODE": 200, 
"URL": '',
"DATA": null,
"MSG":
*/