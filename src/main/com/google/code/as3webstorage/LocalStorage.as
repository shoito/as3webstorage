/*
   Copyright (c) 2010 shoito

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.
 */
package com.google.code.as3webstorage
{
    import flash.external.ExternalInterface;

	/**
	 * ActionScriptからWeb Storage API(localStorage)を簡単に利用できるラッパーユーティリティです.
	 * 
	 * <p>以下のインターフェース仕様に従ってラッパーを提供していますが, 一部独自に追加しているものがあります.</p>
	 * <p>Ref. W3C Web Storage - <a href="http://dev.w3.org/html5/webstorage/#storage-0">4.1 The Storage interface</a></p>
	 * <pre>
	 * interface Storage {
	 *   readonly attribute unsigned long length;
	 *   getter DOMString key(in unsigned long index);
	 *   getter any getItem(in DOMString key);
	 *   setter creator void setItem(in DOMString key, in any data);
	 *   deleter void removeItem(in DOMString key);
	 *   void clear();
	 * };</pre>
	 * 
	 * @author shoito
	 */
    public class LocalStorage
    {
		/**
		 * Storageに格納されているデータの数を返します.
		 * 
		 * @return Storageに格納されているアイテムの数 
		 */
        public static function length():uint
        {
            return ExternalInterface.call("function() { return localStorage.length; }");
        }

		/**
		 * index番目のデータのキーを返します.
		 * 
		 * @param index インデックス
		 * @return キー
		 */
        public static function key(index:uint):*
        {
            return ExternalInterface.call("localStorage.key", index);
        }

		/**
		 * キーに対するデータを返します.
		 * 
		 * @param key キー
		 * @return キーに対するアイテム
		 */
        public static function getItem(key:String):*
        {
            return ExternalInterface.call("localStorage.getItem", key);
        }

		/**
		 * Storageにデータをセットします.
		 * 
		 * @param key データに対するキー
		 * @param data データ
		 */
        public static function setItem(key:String, data:*):void
        {
            ExternalInterface.call("localStorage.setItem", key, data);
        }

		/**
		 * Storageからキーに対するデータを削除します.
		 * 
		 * @param key データに対するキー
		 */
        public static function removeItem(key:String):void
        {
            ExternalInterface.call("localStorage.removeItem", key);
        }

		/**
		 * Storageのデータを全て消去します.
		 */
        public static function clear():void
        {
            ExternalInterface.call("localStorage.clear");
        }
		
		/**
		 * as3webstorageが実行中のブラウザで機能するかどうか返します.
		 * 
		 * @return as3webstorageが機能する場合は<code>true</code>, 機能しない場合は<code>false</code>
		 */
		public static function available():Boolean
		{
			return ExternalInterface.available && ExternalInterface.call("function() { return typeof localStorage != 'undefined'; }");
		}
		
		/**
		 * storage eventのリスナーを追加します.
		 * 
		 * @param func JavaScript側のwindowオブジェクトからstorage eventが発行された場合に, 実行される関数
		 * 
		 * @example Storageのデータが追加/削除された際に, reloadData()関数を呼ぶようにします.
		 * <listing>
		 * LocalStorage.addStorageEventListener(reloadData);
		 * ...
		 * private function reloadData(event:*=null):void
		 * {
		 *   ...
		 * }
		 * </listing>
		 */
		public static function addStorageEventListener(func:Function, useCapture:Boolean = false):void
		{
			ExternalInterface.call("as3webstorage.assignSwf", ExternalInterface.objectID);
			ExternalInterface.addCallback("callbackToAs", func);
			ExternalInterface.call("as3webstorage.addStorageEventListener", "callbackToAs", useCapture);
		}
    }
}