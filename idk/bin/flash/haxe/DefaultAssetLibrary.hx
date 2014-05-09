package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.text.Font;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Unserializer;
import openfl.Assets;

#if (flash || js)
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
#end

#if ios
import openfl.utils.SystemPath;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public static var className (default, null) = new Map <String, Dynamic> ();
	public static var path (default, null) = new Map <String, String> ();
	public static var type (default, null) = new Map <String, AssetType> ();
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("img/playbutton.png", __ASSET__img_playbutton_png);
		type.set ("img/playbutton.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/scorebutton.png", __ASSET__img_scorebutton_png);
		type.set ("img/scorebutton.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/boxsheep.png", __ASSET__img_boxsheep_png);
		type.set ("img/boxsheep.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/box.png", __ASSET__img_box_png);
		type.set ("img/box.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/sky.png", __ASSET__img_sky_png);
		type.set ("img/sky.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/mountains.png", __ASSET__img_mountains_png);
		type.set ("img/mountains.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/henchman.png", __ASSET__img_henchman_png);
		type.set ("img/henchman.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/mountains.xcf", __ASSET__img_mountains_xcf);
		type.set ("img/mountains.xcf", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("img/fence.png", __ASSET__img_fence_png);
		type.set ("img/fence.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("img/menu.png", __ASSET__img_menu_png);
		type.set ("img/menu.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("audio/bongos.mp3", __ASSET__audio_bongos_mp3);
		type.set ("audio/bongos.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("audio/bongos.sng", __ASSET__audio_bongos_sng);
		type.set ("audio/bongos.sng", Reflect.field (AssetType, "binary".toUpperCase ()));
		className.set ("audio/bongos.wav", __ASSET__audio_bongos_wav);
		type.set ("audio/bongos.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		
		
		#elseif html5
		
		path.set ("img/playbutton.png", "img/playbutton.png");
		type.set ("img/playbutton.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/scorebutton.png", "img/scorebutton.png");
		type.set ("img/scorebutton.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/boxsheep.png", "img/boxsheep.png");
		type.set ("img/boxsheep.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/box.png", "img/box.png");
		type.set ("img/box.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/sky.png", "img/sky.png");
		type.set ("img/sky.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/mountains.png", "img/mountains.png");
		type.set ("img/mountains.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/henchman.png", "img/henchman.png");
		type.set ("img/henchman.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/mountains.xcf", "img/mountains.xcf");
		type.set ("img/mountains.xcf", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("img/fence.png", "img/fence.png");
		type.set ("img/fence.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("img/menu.png", "img/menu.png");
		type.set ("img/menu.png", Reflect.field (AssetType, "image".toUpperCase ()));
		path.set ("audio/bongos.mp3", "audio/bongos.mp3");
		type.set ("audio/bongos.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		path.set ("audio/bongos.sng", "audio/bongos.sng");
		type.set ("audio/bongos.sng", Reflect.field (AssetType, "binary".toUpperCase ()));
		path.set ("audio/bongos.wav", "audio/bongos.wav");
		type.set ("audio/bongos.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
		
		
		#else
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<AssetData> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							path.set (asset.id, asset.path);
							type.set (asset.id, asset.type);
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest");
				
			}
			
		} catch (e:Dynamic) {
			
			trace ("Warning: Could not load asset manifest");
			
		}
		
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = DefaultAssetLibrary.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		//return null;		
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

class __ASSET__img_playbutton_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_scorebutton_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_boxsheep_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_box_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_sky_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_mountains_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_henchman_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_mountains_xcf extends flash.utils.ByteArray { }
class __ASSET__img_fence_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__img_menu_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class __ASSET__audio_bongos_mp3 extends flash.media.Sound { }
class __ASSET__audio_bongos_sng extends flash.utils.ByteArray { }
class __ASSET__audio_bongos_wav extends flash.media.Sound { }


#elseif html5
















#end