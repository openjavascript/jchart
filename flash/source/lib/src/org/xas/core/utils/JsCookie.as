package org.xas.core.utils
{
	import flash.external.ExternalInterface;

	/**
	 * @example
			if( ExternalInterface.available )
			{
				JsCookie.addCookie( 'newKey1', 'new value' );				
				trace( JsCookie.readCookie( 'newKey1' ) );
			}
	 */	
	/**
	 * Javascript 读写 Cookie 类
	 * @author 	suches@btbtd.org
	 */
	public class JsCookie
	{
		
		/**
		 * 172800 = 2day
		 */
		public static function addCookie( $key:String, $val:String, $second:int = 172800, 
										  $encode:Boolean = true, $path:String = '/' ):void
		{
			if( ExternalInterface.available )
			{
				ExternalInterface.call( _addCookieFuncStr, $key, $val, $second, $encode, $path );	
			}			
		}
		
		/**
		 * 
		 */
		public static function readCookie( $key:String, $decode:Boolean = true, 
										   $isKeySet:Boolean = false ):String
		{
			if( !ExternalInterface.available ) return '';
			return ExternalInterface.call( _readCookieFuncStr, $key, $decode, $isKeySet );
		}
		
		private static var _readCookieFuncStr:String =
		[
			"function(sKey,  bDecode,  bIsKeySet)\n"
			,"{/* shawl.qiu script, void return; */\n"
			,"  if(!bIsKeySet) bIsKeySet  =  false;\n"
			,"  \n"
			,"  if(!sKey) return '';\n"
			,"  var sCookie  =  document.cookie,  CookieSet  =  sCookie.split(\";\"),  CookieSetCount  =  0,  CookieSetLen  =  CookieSet.length;\n"
			,"  \n"
			,"  if(bIsKeySet)\n"
			,"  {\n"
			,"    var AllKeyRe  =  new RegExp(\"^\"  +  sKey  +  \"\\\\b\\=\",  \"\"),  "
			,"		PartKeyRe  =  new RegExp(\"[=&]\\\\b\"  +  sKey  +  \"\\\\b\\=([^=]+)(&|$)\",  \"\");\n"
			,"    \n"
			,"    while(CookieSetCount  <  CookieSetLen)\n"
			,"    {\n"
			,"      var sCur  =  CookieSet[CookieSetCount].replace(/^\\s+|\\s+$/g,  \"\");      \n"
			,"      if(AllKeyRe.test(sCur))\n"
			,"      {\n"
			,"        var MyKey  =  sCur.replace(AllKeyRe,  \"\");        \n"
			,"        if(bDecode) return decodeURIComponent(MyKey);\n"
			,"        return MyKey;\n"
			,"      }\n"
			,"      else if(PartKeyRe.test(sCur))\n"
			,"      {\n"
			,"        var MyKey  =  \"\";\n"
			,"        sCur.replace(PartKeyRe, function($1,  $2){ MyKey = $2; });        \n"
			,"        if(bDecode) return decodeURIComponent(MyKey);\n"
			,"        return MyKey;\n"
			,"      }\n"
			,"      CookieSetCount++  ;\n"
			,"    }/* while(CookieSetCount  <  CookieSetLen) */\n"
			,"  }\n"
			,"  else\n"
			,"  {\n"
			,"    var AllKeyRe  =  new RegExp(\"^\"  +  sKey  +  \"\\\\b\\=\",  \"\");    \n"
			,"    while(CookieSetCount  <  CookieSetLen)\n"
			,"    {\n"
			,"      var sCur  =  CookieSet[CookieSetCount];      \n"
			,"      if(sCur  ==  \"\")return \"\";\n"
			,"      sCur  =  sCur.replace(/^\\s+|\\s+$/g,  \"\");\n"
			,"      \n"
			,"      if(sCur.split(\"=\").length  >  2) { CookieSetCount++  ; continue; }\n"
			,"      \n"
			,"      if(AllKeyRe.test(sCur))\n"
			,"      {\n"
			,"        var MyKey  =  sCur.replace(AllKeyRe,  \"\");        \n"
			,"        if(bDecode) return decodeURIComponent(MyKey);\n"
			,"        return MyKey;\n"
			,"      }\n"
			,"      CookieSetCount++  ;\n"
			,"    }\n"
			,"  }\n"
			,"  return \"\";\n"
			,"}/* function fReadCookie(sKey,  bDecode,  bIsKeySet) */\n"
		].join('');
		
		private static var _addCookieFuncStr:String =
		[
			"function(sKey,  sValue,  iSecond,  bEncode,  sPath)\n"
			,"{/* shawl.qiu script, void return; Func: fFormat */ \n"
			,"  if(!sKey) {throw new Error('cookie key is null!'); return; }  \n"
			,"  if(typeof sValue==\"undefined\") sValue = \"\";\n"
			,"  sValue = sValue.toString();\n"
			,"  if(!iSecond)iSecond  =  60  *  60  *  24  *  30  *  7;/* 60*60*24*30*365; 一年 */\n"
			,"  if(!sPath) sPath  =  \"/\";\n"
			,"  \n"
			,"  if(bEncode)\n"
			,"  {\n"
			,"    sKey  =  encodeURIComponent(sKey);\n"
			,"    sValue  =  encodeURIComponent(sValue).replace(/\\%3D/g,  \"=\").replace(/\\%26/g,  \"&\");\n"
			,"  }\n"
			,"  var sCookie  =  \"\",  ExpiresDt  =  new Date();\n"
			,"  ExpiresDt.setSeconds(ExpiresDt.getSeconds()  +  iSecond);\n"
			,"  sCookie  =  fFormat(\"{0}={1}; expires={2}; path={3}\",  sKey,  sValue,  ExpiresDt.toGMTString(),  sPath);\n"
			,"  document.cookie  =  sCookie;\n"
			,"    function fFormat(sStr)\n"
			,"    {/* shawl.qiu code, return string */\n"
			,"      var Len = arguments.length, Re = null;  \n"
			,"      switch(Len)\n"
			,"      {\n"
			,"        case 0: return \"\";\n"
			,"        case 1: return sStr;\n"
			,"      }\n"
			,"      for(var i=1, j=0; i<Len; i++, j++)\n"
			,"      {\n"
			,"        Re = new RegExp([\"\\\\{\", j, \"\\\\}\"].join(\"\"), \"g\");\n"
			,"        sStr = sStr.replace(Re, arguments[i]);\n"
			,"      }   \n"
			,"      return sStr;\n"
			,"    }/* function fFormat(sStr) */\n"
			,"}/* function fAddCookie(sKey, sValue, iSecond, bEncode, sPath) */\n"
		].join('');
	}
}

/**

*/