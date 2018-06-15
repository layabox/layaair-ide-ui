package laya.editorUI {
	import laya.events.EventDispatcher;
	import laya.ide.managers.ResFileManager;
	import laya.net.HttpRequest;
	import laya.net.URL;
	import laya.resource.HTMLImage;
	import laya.resource.Texture;
	import laya.events.Event;
	
	/**加载进度事件*/
	[Event(name = "progress")]
	/**加载结束事件*/
	[Event(name = "complete")]
	/**加载出错事件*/
	[Event(name = "error")]
	
	/**
	 * 加载器，实现了文本，JSON，XML,二进制,图像的加载及管理
	 */
	public class Loader extends EventDispatcher {
		public static var basePath:String = "";
		public static const TEXT:String = "text";
		public static const JSOn:String = "json";
		public static const XML:String = "xml";
		public static const BUFFER:String = "arraybuffer";
		public static const IMAGE:String = "image";
		public static const TEXTURE:String = "texture";
		public static const ATLAS:String = "atlas";
		public static var typeMap:Object =/*[STATIC SAFE]*/ {"png": "image", "jpg": "image", "txt": "text", "json": "json", "xml": "xml", "als": "atlas"};
		private static const loadedMap:Object = {};
		
		/**加载后的数据对象，只读*/
		private var _data:*;
		private var _url:String;
		private var _type:String;
		private var _cache:Boolean;
		private var _http:HttpRequest;
		
		/**
		 * 加载资源
		 * @param	url 地址
		 * @param	type 类型，如果为null，则根据文件后缀，自动分析类型
		 * @param	cache 是否缓存数据
		 */
		public function load(url:String, type:String = null, cache:Boolean = true):void {
			url = URL.formatURL(url);
			this._url = url;
			this._type = type || (type = getTypeFromUrl(url));
			this._cache = cache;
			
			if (loadedMap[url]) {
				this._data = loadedMap[url];
				event(Event.PROGRESS, 1);
				event(Event.COMPLETE, this._data);
				return;
			}
			
			if (type === IMAGE) return _loadImage(url);
			
			if (!_http) {
				_http = new HttpRequest();
				_http.on(Event.PROGRESS, this, onProgress);
				_http.on(Event.ERROR, this, onError);
				_http.on(Event.COMPLETE, this, onLoaded);
			}
			_http.send(url, null, "get", type !== ATLAS ? type : "json");
		}
		
		protected function getTypeFromUrl(url:String):String {
			var suffix:String = url.substr(url.lastIndexOf(".") + 1, url.length);
			return typeMap[suffix];
		}
		
		protected function _loadImage(url:String):void {
			var image:HTMLImage = HTMLImage.create();
			var _this:Loader = this;
			image.onload = function():void {
				clear();
				_this.onLoaded(image);
			};
			image.onerror = function():void {
				clear();
				_this.event(Event.ERROR, "Load image filed");
			}
			
			function clear():void {
				image.onload = null;
				image.onerror = null;
			}
			image.src = url;
		}
		
		private function onProgress(value:Number):void {
			event(Event.PROGRESS, value);
		}
		
		private function onError(message:String):void {
			event(Event.ERROR, message);
		}
		
		protected function onLoaded(data:*):void {
			var type:String = this._type;
			if (type === IMAGE) {
				complete(new Texture(data));
			} else if (type === TEXTURE) {
				complete(new Texture(data));
			} else if (type === ATLAS) {
				//处理图集
				if (!data.src) {
					this._data = data;
					return _loadImage(this._url.replace(".json", ".png"));
				} else {
					var frames:Object = this._data.frames;
					var directory:String = (this._data.meta && this._data.meta.prefix) ? URL.basePath + this._data.meta.prefix : this._url.substring(0, this._url.lastIndexOf(".")) + "/"
					for (var name:String in frames) {
						var obj:Object = frames[name];
						loadedMap[directory + name] = Texture.create(data, obj.frame.x, obj.frame.y, obj.frame.w, obj.frame.h, obj.spriteSourceSize.x, obj.spriteSourceSize.y);
					}
					complete(true);
				}
			} else {
				complete(data);
			}
		}
		
		protected function complete(data:*):void {
			this._data = data;
			if (this._cache) loadedMap[this._url] = this._data;
			event(Event.PROGRESS, 1);
			event(Event.COMPLETE, this._data);
		}
		
		/**加载地址，只读*/
		public function get url():String {
			return _url;
		}
		
		/**加载类型，只读*/
		public function get type():String {
			return _type;
		}
		
		/**是否缓存，只读*/
		public function get cache():Boolean {
			return _cache;
		}
		
		/**返回的数据*/
		public function get data():* {
			return _data;
		}
		
		/**
		 * 清理缓存
		 * @param	url 地址
		 */
		public static function clearRes(url:String):void {
			ResFileManager.clearRes(url);
		}
		
		/**
		 * 获取已加载资源(如有缓存)
		 * @param	url 地址
		 * @return	返回资源
		 */
		public static function getRes(url:String):* {
			//return loadedMap[URL.formatURL(url)];
			return ResFileManager.getRes(url);
		}
		
		/**
		 * 缓存资源
		 * @param	url 地址
		 * @param	data 要缓存的内容
		 */
		public static function cacheRes(url:String, data:*):void {
			//loadedMap[URL.formatURL(url)] = data;
			ResFileManager.cacheRes(url,data);
		}
	}
}