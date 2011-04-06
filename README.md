# as3webstorage
as3webstorage is ActionScript wrapper utility that can easily use HTML5 Web Storage with Flash/Flex. 

## Supports the following API.
 * LocalStorage
 * SessionStorage


## Web Storage
<http://dev.w3.org/html5/webstorage/>

## Samples
 * [LocalStorage Sample](http://dl.dropbox.com/u/227786/code/flex/as3webstorage/as3localstorage.html) - [Source code](http://code.google.com/p/as3webstorage/source/browse/trunk/samples/src/as3localstorage.mxml)
 * [SessionStorage Sample](http://dl.dropbox.com/u/227786/code/flex/as3webstorage/as3sessionstorage.html) - [Source code](http://code.google.com/p/as3webstorage/source/browse/trunk/samples/src/as3sessionstorage.mxml Source code)

## How to use

### HTML
	<head>
	...
  	  <script type="text/javascript" src="as3webstorage-0.1.2.js"></script>
  	...
	</head>

### Flash/Flex
	import com.google.code.as3webstorage.LocalStorage;

	protected function lengthButton_clickHandler(event:MouseEvent):void
	{
	    length_lengthText.text = String(LocalStorage.length());
	}
	
	protected function keyButton_clickHandler(event:MouseEvent):void
	{
	    var index:uint = uint(key_indexText.text);
	    key_keyText.text = LocalStorage.key(index);
	}
	
	protected function getItemButton_clickHandler(event:MouseEvent):void
	{
	    var key:String = getItem_keyText.text;
	    getItem_dataText.text = LocalStorage.getItem(key);
	}
	
	protected function setItemButton_clickHandler(event:MouseEvent):void
	{
	    var key:String = setItem_keyText.text;
	    var data:String = setItem_dataText.text;
	    LocalStorage.setItem(key, data);
	}
	
	protected function removeItemButton_clickHandler(event:MouseEvent):void
	{
	    var key:String = removeItem_keyText.text;
	    LocalStorage.removeItem(key);
	}
	
	protected function clearButton_clickHandler(event:MouseEvent):void
	{
	    LocalStorage.clear();
	}
	
	private function setup():void
	{
	    LocalStorage.addStorageEventListener(reloadData, false);
	}
	
	private function reloadData(event:*=null):void
	{
	    Alert.show(event.newValue, "Confirm");
	}