(function(){
	var proxyIframe = null
		,proxyUrl = document.getElementById("ext-app-proxy-js").src;
	try{
		proxyUrl = proxyUrl.slice(0, proxyUrl.lastIndexOf("/"))+"/ext-app-proxy.html";//'http://192.168.1.100:8080/ac/public/proxy/ext-app-proxy.html';//;
	}catch(e){
	}
	
	/**
	 * 获取浏览器名称
	 */
	function browserName() {
		var ua = navigator.userAgent.toLowerCase(), // userAgent
		regMsie = /.*(msie) ([\w.]+).*/, // ie
		regFirefox = /.*(firefox)\/([\w.]+).*/, // firefox
		regOpera = /(opera).+version\/([\w.]+)/, // opera
		regChrome = /.*(chrome)\/([\w.]+).*/, // chrome
		regSafari = /.*version\/([\w.]+).*(safari).*/;// safari
		var browserMatch = regMsie.exec(ua) || regFirefox.exec(ua) 
					|| regOpera.exec(ua) || regChrome.exec(ua) || null;
		if(browserMatch != null) {
			return browserMatch[1] || "";
		} else {
			browserMatch = regSafari.exec(ua) || null;
			if(browserMatch != null) {
				return browserMatch[2] || "";
			}
		}
		return "";
	}
	
	var body = window.document.body,
	docEle = window.document.documentElement,
	browser_name = browserName();
	
	/**
	 * 获取网页内容高度
	 * @returns
	 */
	function getContentHeight(){
		try{
			//return Math.max(docEle.scrollHeight,docEle.clientHeight,body.scrollHeight,body.clientHeight);
			if(browser_name == "chrome") {
				return docEle.scrollHeight;
			} else {
				return Math.max(body.scrollHeight,body.clientHeight);
			}
		}catch(e){
			return body.clientHeight + 40;
		}
	};


	function _exeProxyCommand(hash){
		//如果没有添加代理iframe则需要先把iframe加入到内容页面中
		if(proxyIframe != null){
			body.removeChild(proxyIframe);
			proxyIframe = null;
		}
		proxyIframe = document.createElement("iframe");
		proxyIframe.id = "proxyIframe";
		proxyIframe.width = "0px";
		proxyIframe.style.display = "none";
		body.appendChild(proxyIframe);
		
		var d = new Date();
		proxyIframe.src = proxyUrl+"?t="+d.getTime()+hash;
	}

	window.exeProxyCommand = function() {
		var arg_len = arguments.length;
		if(arg_len <= 0) return false;
		var param = "";
		for(var i=0; i<arg_len; i++) {
			param += "#"+arguments[i];
		}
		_exeProxyCommand(param);
	}
	
	var proxy_iframe_height = 0;
	function adjustWindow(){
			//计算高度
		var h = getContentHeight();
		var cha = proxy_iframe_height - h;
		if(0 <= cha && cha <= 100) {
			return;
		}
		proxy_iframe_height = h;
		var wid = getWindowId(window);
		try{
			if(window.parent.document){
				var $document = window.parent.document;
				var iframepage = $document.getElementById(wid);
				iframepage.style.height = h+"px";
			}else{
				_exeProxyCommand("#adjust#"+h+"#"+wid);
			}
		}catch(e){  
			_exeProxyCommand("#adjust#"+h+"#"+wid);
		}
	}
	function getWindowId(w){
		if(w.ext_iframe_id__ == undefined){
			w.ext_iframe_id__ = w.name;
		}
		return w.ext_iframe_id__;
	}
	function onEvent(node, event, cb) {
		if (node == null) {
			return false;
		}
		if ((typeof cb).toLowerCase() != "function") {
			return;
		}
		if (node.attachEvent) {
			node.attachEvent("on" + event, cb);
		} else {
			if (node.addEventListener) {
				node.addEventListener(event, cb, false);
			} else {
				node["on" + event] = cb;
			}
		}
		return true;
	}
	setInterval(adjustWindow, 1000);
	
	onEvent(window, "load", adjustWindow);
	onEvent(window, "load", function(){
		onEvent(body, "DOMSubtreeModified", adjustWindow);
		onEvent(body, "DOMNodeInserted", adjustWindow);
		onEvent(body, "DOMNodeRemoved", adjustWindow);
	});
	
})();