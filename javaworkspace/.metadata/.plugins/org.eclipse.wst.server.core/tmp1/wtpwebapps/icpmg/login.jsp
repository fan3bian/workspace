<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();

	pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<base href=".">
		<meta http-equiv="X-UA-Compatible"
			content="IE=10; IE=9; IE=8; IE=7; IE=EDGE">
		<meta name="renderer" content="webkit">
		<meta name="viewport"
			content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title>用户登录</title>
		<meta content="浪潮云服务，云服务，云主机，云服务器，负载均衡，云存储" name="keywords">
		<meta content="浪潮云服务是中国政务云市场领导者。" name="description">
		<meta name="generator" content="inspur,http://cloud.inspur.com">
		<!-- <link rel="shortcut icon" href="https://login.cloud.inspur.com/favicon.ico" type="image/x-icon">
<link rel="bookmark" href="https://login.cloud.inspur.com/favicon.ico" type="image/x-icon"> -->
		<link rel="stylesheet" type="text/css"
			href="${basePath}/css/login/ucloud.css">
		<style type="text/css">
body,html {
	height: 100%;
	padding: 0;
	margin: 0
}

.login-wrapper {
	height: 100%;
	margin: 0 auto;
	display: table
}

.login-container {
	height: 100%;
	display: table-cell;
	vertical-align: middle;
	background: url(${basePath}/images/login/loginbackimage.png) no-repeat
		center center
}

.login-logo {
	display: block;
	margin: 0 auto 25px
}

.login-panel-container {
	background: url(${basePath}/images/login/logincontentimage.png)
		no-repeat 0 88px;
}

.login-panel {
	width: 382px;
	display: block;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #d7d7d7;
	border-radius: 4px;
	background-color: #fff;
	box-shadow: 1px 1px 9px rgba(0, 0, 0, .15)
}

.login-body {
	padding: 0 50px;
	margin-top: 27px;
	margin-bottom: 22px
}

.login-body input {
    width: 268px;
	margin-top: 3px
}

.login-body span {
	margin: 0 8px 0 18px
}

.login-body button {
	width: 100%;
	height: 43px;
	margin-top: 10px;
	letter-spacing: 4px
}

.login-body .qr-img {
	width: 210px;
	height: 210px;
	margin: auto
}

.login-body .copy-right.tl {
	text-align: left
}

.login-body .select-account {
	margin: 20px 0
}

.login-footer {
	padding: 0 50px;
	font-size: 12px;
	text-align: right;
	padding-bottom: 16px
}

.login-wrapper .hr {
	width: 430px;
	margin: 35px auto 25px
}

/*浏览器升级提示页*/
.say_bay {
	background-image: url(images/browser/upgrade-bg.jpg);
	width: 100%;
	min-height: 700px;
	overflow: hidden;
	clear: both;
	text-align: center;
}

.say_bay h3 {
	height: 80px;
	line-height: 80px;
	text-align: center;
	font-weight: bold;
	font-size: 15px;
	margin: 15px 0;
	color: #000000;
}

.say_bay .p {
	font-size: 13px;
	padding-bottom: 60px;
	text-align: center;
	margin: 13px 0;
}

.say_bay .browser {
	width: 1000px;
	margin: 0 auto;
}

.say_bay a .download-browser {
	vertical-align: top;
	float: left;
	padding: 0;
	width: 50%;
	text-align: center;
}

.say_bay .download-browser li {
	font-size: 20px;
	line-height: 26px;
	text-align: center;
	color: #333;
	padding-top: 20px;
	list-style: none;
}

.say_bay .help-text {
	color: #666;
	font-size: 14px;
}

.say_bay .outer-north {
	text-align: center;
	padding-top: 50px;
}
</style>
		<script>

(function(window, document, getBrowserInfo, undefined) {
        'use strict';
        var browserInfo = getBrowserInfo(window.navigator.userAgent),
            ver = parseInt(browserInfo["version"], 10) || 0,
            fillBody = null;
        if ((browserInfo["msie"] && ver < 9) ||
            (browserInfo["chrome"] && ver < 40) ||
            (browserInfo["firefox"] && ver < 20) ||
            (browserInfo["safari"] && ver < 20)) {
            fillBody = function() {
                document.body.innerHTML = '<div class="say_bay"><div class="outer-north"><img class="login-logo" src="images/login/login_logo_sm.png"></div><h3>您使用的浏览器版本过低，可能导致部分页面展示效果不佳，建议您使用以下浏览器进行访问。</h3><p class="p">点击以下链接，升级浏览器</p><div class="browser"><a href="http://www.microsoft.com/zh-cn/download/internet-explorer-9-details.aspx" target="_blank"><ul class="download-browser"><li><img src="images/browser/iecompatibility.png"></li><li>Internet Explorer<p class="help-text">(9.0及以上)</p></li></ul></a> <a href="http://www.chromeliulanqi.com/" target="_blank"><ul class="download-browser"><li><img src="images/browser/chromecompatibility.png"></li><li>Chrome<p class="help-text">(40.0及以上)</p></li></ul></a> </div></div>';
            };
            if (document.addEventListener) {
                document.addEventListener("DOMContentLoaded", fillBody, false);
            } else {
                document.attachEvent("onreadystatechange", fillBody);
            }
        }
        
    }(window, document, function(userAgent) {
        var browser = {},
            matched = (function(ua) {
                var match = /(chrome)[ \/]([\w.]+)/.exec(ua) ||
                    ///(webkit)[ \/]([\w.]+)/.exec( ua ) ||
                    ///version[\/][\d.]+.*(safari)[ \/]([\w.]+)/.exec(ua) ||
                    /version[\/]([\d.]+).*(safari)[ \/][\w.]+/.exec(ua) ||
                    /(msie) ([\w.]+)/.exec(ua) ||
                    /(firefox)[\/]([\w.]+)/.exec(ua) ||
                    /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) ||
                    ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) || [];
                if (match[2] === "safari") {
                    return {
                        browser: match[2] || "",
                        version: match[1] || "0"
                    };
                };
                return {
                    browser: match[1] || "",
                    version: match[2] || "0"
                };
            })(userAgent.toLowerCase());
        if (matched.browser) {
            browser[matched.browser] = true;
            browser.version = matched.version;
        }
        return browser;
    }));
    </script>
		<script type="text/javascript"
			src="${basePath}/logreg/js/jquery-1.8.3.min.js">
</script>
		<script type="text/javascript">
$(function() {
	$("html").die().live("keydown", function(event) {
		if (event.keyCode == 13) {
			document.getElementById("loginbtn").click(); //调用登录按钮的登录事件 
		}
	});
   
   
      function getBrowserInfo(userAgent) {
            var browser = {},
                matched = (function(ua) {
                    var match = /(chrome)[ \/]([\w.]+)/.exec(ua) ||
                        ///(webkit)[ \/]([\w.]+)/.exec( ua ) ||
                        ///version[\/][\d.]+.*(safari)[ \/]([\w.]+)/.exec(ua) ||
                        /version[\/]([\d.]+).*(safari)[ \/][\w.]+/.exec(ua) ||
                        /(msie) ([\w.]+)/.exec(ua) ||
                        /(firefox)[\/]([\w.]+)/.exec(ua) ||
                        /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) ||
                        ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) || [];
                    if (match[2] === "safari") {
                        return {
                            browser: match[2] || "",
                            version: match[1] || "0"
                        };
                    };
                    return {
                        browser: match[1] || "",
                        version: match[2] || "0"
                    };
                })(userAgent.toLowerCase());
            if (matched.browser) {
                browser[matched.browser] = true;
                browser.version = matched.version;
            }
            return browser;
        }

        function isGtIE9() { //大于ie10的ie
            var browserInfo = getBrowserInfo(window.navigator.userAgent),
                ver = parseInt(browserInfo["version"], 10) || 0;

            if (browserInfo["msie"] && ver > 9) {

                return true;
            } else {
                return false;
            }
        }
        (function() {
            var inputPWD = document.getElementById('passwd');
            var capital = false;
            var capitalTip = {
                elem: document.getElementById('capital'),
                toggle: function(s) {

                    var sy = this.elem.style;
                    var d = sy.display;
                    if (s) {
                        sy.display = s;
                    } else {
                        sy.display = d == 'none' ? '' : 'none';
                    }
                }
            }
            var detectCapsLock = function(event) {
                if (capital) {
                    return
                };
                var e = event || window.event;
                var keyCode = e.keyCode || e.which;
                var isShift = e.shiftKey || (keyCode == 16) || false;
                if (((keyCode >= 65 && keyCode <= 90) && !isShift) || ((keyCode >= 97 && keyCode <= 122) && isShift)) {
                    capitalTip.toggle('block');
                    capital = true
                } else {
                    capitalTip.toggle('none');
                }
            }
            if (!isGtIE9()) {
                inputPWD.onkeypress = detectCapsLock;
                inputPWD.onkeyup = function(event) {
                    var e = event || window.event;
                    if (e.keyCode == 20 && capital) {
                        capitalTip.toggle();
                        return false;
                    }
                }
            }
        })()
});
function submitForm() {
	//alert("aa");
	$('#loginForm')
			.form(
					'submit',
					{
						url : '<%=basePath%>/userMgr/userLogin.do',
						onSubmit : function() {
							var isValid;
							var username = document.getElementById("username");
							var passwd = document.getElementById("passwd");
							if (username.value == '') {
								document.getElementById("username_tips").innerHTML = '用户名不能为空！';
								isValid = false;
								return isValid;
							}
							if (passwd.value == '') {
								document.getElementById("passwd_tips").innerHTML = '密码不能为空！';
								isValid = false;
								return isValid;
							}
						},
						success : function(b) {
							var r = jQuery.parseJSON(b);
							if (r) {
								if (r.success) {
									location
											.replace('<%=contextPath%>/web/Frames/authBase.jsp');
								} else {
									document.getElementById("errtips").innerHTML = r.msg;
									document.getElementById("username_tips").innerHTML = '';
									document.getElementById("passwd_tips").innerHTML = '';
								}
							}
						}
					});

}

function clearTips() {
	//document.getElementById(tip).innerHTML='';
	document.getElementById("errtips").innerHTML = '';
	document.getElementById("username_tips").innerHTML = '';
	document.getElementById("passwd_tips").innerHTML = '';
}
</script>
		<script type="text/javascript" src="${basePath}/logreg/js/slide.js">
</script>
		<script type="text/javascript"
			src="${basePath}/logreg/js/TweenMax.min.js">
</script>
		<script type="text/javascript" src="${basePath}/logreg/js/myScroll.js">
</script>
		<script type="text/javascript" src="${basePath}/logreg/js/util.js">
</script>
		<script type="text/javascript" src="${basePath}/logreg/js/gather.js">
</script>
		<script type="text/javascript"
			src="${basePath}/easyui-1.4/jquery.easyui.min.js">
</script>
		<script type="text/javascript"
			src="${basePath}/easyui-1.4/locale/easyui-lang-zh_CN.js">
</script>
	</head>
	<body>
		<div class="login-wrapper">
			<div class="login-container">
				<img class="login-logo"
					src="${basePath}/images/login/login_logo_sm.png">

				<div class="login-panel-container">
					<div class="login-panel">
						<form id="loginForm" class="login-body" method="post">
							<div id="errtips" style="color: #ff4040;"></div>
							<div class="form-group">
								<label for="username">
									登录账号
								</label>
								<input id="username" name="username" type="text"
									class="form-control" onfocus="clearTips();" />

							</div>
							<div id="username_tips" style="color: #ff4040;"></div>
							<div class="form-group">
								<label for="passwd">
									登录密码
								</label>
								<input id="passwd" name="passwd" type="password"
									autocomplete="off" class="form-control" onfocus="clearTips();">
                <div id="capital" style="display:none; color:red">大写锁定已开启</div>
							</div>
							 
							<div id="passwd_tips" style="color: #ff4040;"></div>
							<button id="loginbtn" type="button" onclick="submitForm()"
								class="u-btn u-btn-primary">
								登录
							</button>
						</form>

						<!--v-component-->
						<div class="login-footer">
							<a class="pr20" href="${basePath}/icp/portal/home.html">返回首页</a>
							<!--<a href="https://login.cloud.inspur.com/register">立即注册</a>-->
						</div>

					</div>
					<div class="hr"></div>
					<!--v-start-->
					<div class="footer-links">
						<a href="${basePath}/icp/portal/home.html">首页</a>
						<span class="v-separator"></span>
						<a href="${basePath}/icp/portal/product/00.html">产品与服务</a>
						<span class="v-separator"></span>
						<a href="${basePath}/icp/portal/notice/lst/notice/notice_1.html">通知公告</a>
						<span class="v-separator"></span>
						<a href="${basePath}/icp/portal/news/lst/website_1.html">新闻动态</a>
					</div>
					<p class="copy-right">
						©浪潮集团版权所有&nbsp;&nbsp;技术支持：023-89316292
					</p>
					<!--v-end-->
					<!--v-component-->
				</div>
			</div>
		</div>
	</body>
</html>