/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2016-11-08 09:45:13 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');

	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();

	pageContext.setAttribute("basePath", basePath);

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("\t<head>\r\n");
      out.write("\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("\t\t<base href=\".\">\r\n");
      out.write("\t\t<meta http-equiv=\"X-UA-Compatible\"\r\n");
      out.write("\t\t\tcontent=\"IE=10; IE=9; IE=8; IE=7; IE=EDGE\">\r\n");
      out.write("\t\t<meta name=\"renderer\" content=\"webkit\">\r\n");
      out.write("\t\t<meta name=\"viewport\"\r\n");
      out.write("\t\t\tcontent=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\r\n");
      out.write("\t\t<title>用户登录</title>\r\n");
      out.write("\t\t<meta content=\"浪潮云服务，云服务，云主机，云服务器，负载均衡，云存储\" name=\"keywords\">\r\n");
      out.write("\t\t<meta content=\"浪潮云服务是中国政务云市场领导者。\" name=\"description\">\r\n");
      out.write("\t\t<meta name=\"generator\" content=\"inspur,http://cloud.inspur.com\">\r\n");
      out.write("\t\t<!-- <link rel=\"shortcut icon\" href=\"https://login.cloud.inspur.com/favicon.ico\" type=\"image/x-icon\">\r\n");
      out.write("<link rel=\"bookmark\" href=\"https://login.cloud.inspur.com/favicon.ico\" type=\"image/x-icon\"> -->\r\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\"\r\n");
      out.write("\t\t\thref=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/css/login/ucloud.css\">\r\n");
      out.write("\t\t<style type=\"text/css\">\r\n");
      out.write("body,html {\r\n");
      out.write("\theight: 100%;\r\n");
      out.write("\tpadding: 0;\r\n");
      out.write("\tmargin: 0\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-wrapper {\r\n");
      out.write("\theight: 100%;\r\n");
      out.write("\tmargin: 0 auto;\r\n");
      out.write("\tdisplay: table\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-container {\r\n");
      out.write("\theight: 100%;\r\n");
      out.write("\tdisplay: table-cell;\r\n");
      out.write("\tvertical-align: middle;\r\n");
      out.write("\tbackground: url(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/images/login/loginbackimage.png) no-repeat\r\n");
      out.write("\t\tcenter center\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-logo {\r\n");
      out.write("\tdisplay: block;\r\n");
      out.write("\tmargin: 0 auto 25px\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-panel-container {\r\n");
      out.write("\tbackground: url(");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/images/login/logincontentimage.png)\r\n");
      out.write("\t\tno-repeat 0 88px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-panel {\r\n");
      out.write("\twidth: 382px;\r\n");
      out.write("\tdisplay: block;\r\n");
      out.write("\tmargin-left: auto;\r\n");
      out.write("\tmargin-right: auto;\r\n");
      out.write("\tborder: 1px solid #d7d7d7;\r\n");
      out.write("\tborder-radius: 4px;\r\n");
      out.write("\tbackground-color: #fff;\r\n");
      out.write("\tbox-shadow: 1px 1px 9px rgba(0, 0, 0, .15)\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-body {\r\n");
      out.write("\tpadding: 0 50px;\r\n");
      out.write("\tmargin-top: 27px;\r\n");
      out.write("\tmargin-bottom: 22px\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-body input {\r\n");
      out.write("    width: 268px;\r\n");
      out.write("\tmargin-top: 3px\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-body span {\r\n");
      out.write("\tmargin: 0 8px 0 18px\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-body button {\r\n");
      out.write("\twidth: 100%;\r\n");
      out.write("\theight: 43px;\r\n");
      out.write("\tmargin-top: 10px;\r\n");
      out.write("\tletter-spacing: 4px\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-body .qr-img {\r\n");
      out.write("\twidth: 210px;\r\n");
      out.write("\theight: 210px;\r\n");
      out.write("\tmargin: auto\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-body .copy-right.tl {\r\n");
      out.write("\ttext-align: left\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-body .select-account {\r\n");
      out.write("\tmargin: 20px 0\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-footer {\r\n");
      out.write("\tpadding: 0 50px;\r\n");
      out.write("\tfont-size: 12px;\r\n");
      out.write("\ttext-align: right;\r\n");
      out.write("\tpadding-bottom: 16px\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".login-wrapper .hr {\r\n");
      out.write("\twidth: 430px;\r\n");
      out.write("\tmargin: 35px auto 25px\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("/*浏览器升级提示页*/\r\n");
      out.write(".say_bay {\r\n");
      out.write("\tbackground-image: url(images/browser/upgrade-bg.jpg);\r\n");
      out.write("\twidth: 100%;\r\n");
      out.write("\tmin-height: 700px;\r\n");
      out.write("\toverflow: hidden;\r\n");
      out.write("\tclear: both;\r\n");
      out.write("\ttext-align: center;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".say_bay h3 {\r\n");
      out.write("\theight: 80px;\r\n");
      out.write("\tline-height: 80px;\r\n");
      out.write("\ttext-align: center;\r\n");
      out.write("\tfont-weight: bold;\r\n");
      out.write("\tfont-size: 15px;\r\n");
      out.write("\tmargin: 15px 0;\r\n");
      out.write("\tcolor: #000000;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".say_bay .p {\r\n");
      out.write("\tfont-size: 13px;\r\n");
      out.write("\tpadding-bottom: 60px;\r\n");
      out.write("\ttext-align: center;\r\n");
      out.write("\tmargin: 13px 0;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".say_bay .browser {\r\n");
      out.write("\twidth: 1000px;\r\n");
      out.write("\tmargin: 0 auto;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".say_bay a .download-browser {\r\n");
      out.write("\tvertical-align: top;\r\n");
      out.write("\tfloat: left;\r\n");
      out.write("\tpadding: 0;\r\n");
      out.write("\twidth: 50%;\r\n");
      out.write("\ttext-align: center;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".say_bay .download-browser li {\r\n");
      out.write("\tfont-size: 20px;\r\n");
      out.write("\tline-height: 26px;\r\n");
      out.write("\ttext-align: center;\r\n");
      out.write("\tcolor: #333;\r\n");
      out.write("\tpadding-top: 20px;\r\n");
      out.write("\tlist-style: none;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".say_bay .help-text {\r\n");
      out.write("\tcolor: #666;\r\n");
      out.write("\tfont-size: 14px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".say_bay .outer-north {\r\n");
      out.write("\ttext-align: center;\r\n");
      out.write("\tpadding-top: 50px;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("\t\t<script>\r\n");
      out.write("\r\n");
      out.write("(function(window, document, getBrowserInfo, undefined) {\r\n");
      out.write("        'use strict';\r\n");
      out.write("        var browserInfo = getBrowserInfo(window.navigator.userAgent),\r\n");
      out.write("            ver = parseInt(browserInfo[\"version\"], 10) || 0,\r\n");
      out.write("            fillBody = null;\r\n");
      out.write("        if ((browserInfo[\"msie\"] && ver < 9) ||\r\n");
      out.write("            (browserInfo[\"chrome\"] && ver < 40) ||\r\n");
      out.write("            (browserInfo[\"firefox\"] && ver < 20) ||\r\n");
      out.write("            (browserInfo[\"safari\"] && ver < 20)) {\r\n");
      out.write("            fillBody = function() {\r\n");
      out.write("                document.body.innerHTML = '<div class=\"say_bay\"><div class=\"outer-north\"><img class=\"login-logo\" src=\"images/login/login_logo_sm.png\"></div><h3>您使用的浏览器版本过低，可能导致部分页面展示效果不佳，建议您使用以下浏览器进行访问。</h3><p class=\"p\">点击以下链接，升级浏览器</p><div class=\"browser\"><a href=\"http://www.microsoft.com/zh-cn/download/internet-explorer-9-details.aspx\" target=\"_blank\"><ul class=\"download-browser\"><li><img src=\"images/browser/iecompatibility.png\"></li><li>Internet Explorer<p class=\"help-text\">(9.0及以上)</p></li></ul></a> <a href=\"http://www.chromeliulanqi.com/\" target=\"_blank\"><ul class=\"download-browser\"><li><img src=\"images/browser/chromecompatibility.png\"></li><li>Chrome<p class=\"help-text\">(40.0及以上)</p></li></ul></a> </div></div>';\r\n");
      out.write("            };\r\n");
      out.write("            if (document.addEventListener) {\r\n");
      out.write("                document.addEventListener(\"DOMContentLoaded\", fillBody, false);\r\n");
      out.write("            } else {\r\n");
      out.write("                document.attachEvent(\"onreadystatechange\", fillBody);\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("        \r\n");
      out.write("    }(window, document, function(userAgent) {\r\n");
      out.write("        var browser = {},\r\n");
      out.write("            matched = (function(ua) {\r\n");
      out.write("                var match = /(chrome)[ \\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                    ///(webkit)[ \\/]([\\w.]+)/.exec( ua ) ||\r\n");
      out.write("                    ///version[\\/][\\d.]+.*(safari)[ \\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                    /version[\\/]([\\d.]+).*(safari)[ \\/][\\w.]+/.exec(ua) ||\r\n");
      out.write("                    /(msie) ([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                    /(firefox)[\\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                    /(opera)(?:.*version|)[ \\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                    ua.indexOf(\"compatible\") < 0 && /(mozilla)(?:.*? rv:([\\w.]+)|)/.exec(ua) || [];\r\n");
      out.write("                if (match[2] === \"safari\") {\r\n");
      out.write("                    return {\r\n");
      out.write("                        browser: match[2] || \"\",\r\n");
      out.write("                        version: match[1] || \"0\"\r\n");
      out.write("                    };\r\n");
      out.write("                };\r\n");
      out.write("                return {\r\n");
      out.write("                    browser: match[1] || \"\",\r\n");
      out.write("                    version: match[2] || \"0\"\r\n");
      out.write("                };\r\n");
      out.write("            })(userAgent.toLowerCase());\r\n");
      out.write("        if (matched.browser) {\r\n");
      out.write("            browser[matched.browser] = true;\r\n");
      out.write("            browser.version = matched.version;\r\n");
      out.write("        }\r\n");
      out.write("        return browser;\r\n");
      out.write("    }));\r\n");
      out.write("    </script>\r\n");
      out.write("\t\t<script type=\"text/javascript\"\r\n");
      out.write("\t\t\tsrc=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/logreg/js/jquery-1.8.3.min.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\">\r\n");
      out.write("$(function() {\r\n");
      out.write("\t$(\"html\").die().live(\"keydown\", function(event) {\r\n");
      out.write("\t\tif (event.keyCode == 13) {\r\n");
      out.write("\t\t\tdocument.getElementById(\"loginbtn\").click(); //调用登录按钮的登录事件 \r\n");
      out.write("\t\t}\r\n");
      out.write("\t});\r\n");
      out.write("   \r\n");
      out.write("   \r\n");
      out.write("      function getBrowserInfo(userAgent) {\r\n");
      out.write("            var browser = {},\r\n");
      out.write("                matched = (function(ua) {\r\n");
      out.write("                    var match = /(chrome)[ \\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                        ///(webkit)[ \\/]([\\w.]+)/.exec( ua ) ||\r\n");
      out.write("                        ///version[\\/][\\d.]+.*(safari)[ \\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                        /version[\\/]([\\d.]+).*(safari)[ \\/][\\w.]+/.exec(ua) ||\r\n");
      out.write("                        /(msie) ([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                        /(firefox)[\\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                        /(opera)(?:.*version|)[ \\/]([\\w.]+)/.exec(ua) ||\r\n");
      out.write("                        ua.indexOf(\"compatible\") < 0 && /(mozilla)(?:.*? rv:([\\w.]+)|)/.exec(ua) || [];\r\n");
      out.write("                    if (match[2] === \"safari\") {\r\n");
      out.write("                        return {\r\n");
      out.write("                            browser: match[2] || \"\",\r\n");
      out.write("                            version: match[1] || \"0\"\r\n");
      out.write("                        };\r\n");
      out.write("                    };\r\n");
      out.write("                    return {\r\n");
      out.write("                        browser: match[1] || \"\",\r\n");
      out.write("                        version: match[2] || \"0\"\r\n");
      out.write("                    };\r\n");
      out.write("                })(userAgent.toLowerCase());\r\n");
      out.write("            if (matched.browser) {\r\n");
      out.write("                browser[matched.browser] = true;\r\n");
      out.write("                browser.version = matched.version;\r\n");
      out.write("            }\r\n");
      out.write("            return browser;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        function isGtIE9() { //大于ie10的ie\r\n");
      out.write("            var browserInfo = getBrowserInfo(window.navigator.userAgent),\r\n");
      out.write("                ver = parseInt(browserInfo[\"version\"], 10) || 0;\r\n");
      out.write("\r\n");
      out.write("            if (browserInfo[\"msie\"] && ver > 9) {\r\n");
      out.write("\r\n");
      out.write("                return true;\r\n");
      out.write("            } else {\r\n");
      out.write("                return false;\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("        (function() {\r\n");
      out.write("            var inputPWD = document.getElementById('passwd');\r\n");
      out.write("            var capital = false;\r\n");
      out.write("            var capitalTip = {\r\n");
      out.write("                elem: document.getElementById('capital'),\r\n");
      out.write("                toggle: function(s) {\r\n");
      out.write("\r\n");
      out.write("                    var sy = this.elem.style;\r\n");
      out.write("                    var d = sy.display;\r\n");
      out.write("                    if (s) {\r\n");
      out.write("                        sy.display = s;\r\n");
      out.write("                    } else {\r\n");
      out.write("                        sy.display = d == 'none' ? '' : 'none';\r\n");
      out.write("                    }\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("            var detectCapsLock = function(event) {\r\n");
      out.write("                if (capital) {\r\n");
      out.write("                    return\r\n");
      out.write("                };\r\n");
      out.write("                var e = event || window.event;\r\n");
      out.write("                var keyCode = e.keyCode || e.which;\r\n");
      out.write("                var isShift = e.shiftKey || (keyCode == 16) || false;\r\n");
      out.write("                if (((keyCode >= 65 && keyCode <= 90) && !isShift) || ((keyCode >= 97 && keyCode <= 122) && isShift)) {\r\n");
      out.write("                    capitalTip.toggle('block');\r\n");
      out.write("                    capital = true\r\n");
      out.write("                } else {\r\n");
      out.write("                    capitalTip.toggle('none');\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("            if (!isGtIE9()) {\r\n");
      out.write("                inputPWD.onkeypress = detectCapsLock;\r\n");
      out.write("                inputPWD.onkeyup = function(event) {\r\n");
      out.write("                    var e = event || window.event;\r\n");
      out.write("                    if (e.keyCode == 20 && capital) {\r\n");
      out.write("                        capitalTip.toggle();\r\n");
      out.write("                        return false;\r\n");
      out.write("                    }\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("        })()\r\n");
      out.write("});\r\n");
      out.write("function submitForm() {\r\n");
      out.write("\t//alert(\"aa\");\r\n");
      out.write("\t$('#loginForm')\r\n");
      out.write("\t\t\t.form(\r\n");
      out.write("\t\t\t\t\t'submit',\r\n");
      out.write("\t\t\t\t\t{\r\n");
      out.write("\t\t\t\t\t\turl : '");
      out.print(basePath);
      out.write("/userMgr/userLogin.do',\r\n");
      out.write("\t\t\t\t\t\tonSubmit : function() {\r\n");
      out.write("\t\t\t\t\t\t\tvar isValid;\r\n");
      out.write("\t\t\t\t\t\t\tvar username = document.getElementById(\"username\");\r\n");
      out.write("\t\t\t\t\t\t\tvar passwd = document.getElementById(\"passwd\");\r\n");
      out.write("\t\t\t\t\t\t\tif (username.value == '') {\r\n");
      out.write("\t\t\t\t\t\t\t\tdocument.getElementById(\"username_tips\").innerHTML = '用户名不能为空！';\r\n");
      out.write("\t\t\t\t\t\t\t\tisValid = false;\r\n");
      out.write("\t\t\t\t\t\t\t\treturn isValid;\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\tif (passwd.value == '') {\r\n");
      out.write("\t\t\t\t\t\t\t\tdocument.getElementById(\"passwd_tips\").innerHTML = '密码不能为空！';\r\n");
      out.write("\t\t\t\t\t\t\t\tisValid = false;\r\n");
      out.write("\t\t\t\t\t\t\t\treturn isValid;\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t},\r\n");
      out.write("\t\t\t\t\t\tsuccess : function(b) {\r\n");
      out.write("\t\t\t\t\t\t\tvar r = jQuery.parseJSON(b);\r\n");
      out.write("\t\t\t\t\t\t\tif (r) {\r\n");
      out.write("\t\t\t\t\t\t\t\tif (r.success) {\r\n");
      out.write("\t\t\t\t\t\t\t\t\tlocation\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t.replace('");
      out.print(contextPath);
      out.write("/web/Frames/authBase.jsp');\r\n");
      out.write("\t\t\t\t\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t\t\t\t\t\tdocument.getElementById(\"errtips\").innerHTML = r.msg;\r\n");
      out.write("\t\t\t\t\t\t\t\t\tdocument.getElementById(\"username_tips\").innerHTML = '';\r\n");
      out.write("\t\t\t\t\t\t\t\t\tdocument.getElementById(\"passwd_tips\").innerHTML = '';\r\n");
      out.write("\t\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t});\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function clearTips() {\r\n");
      out.write("\t//document.getElementById(tip).innerHTML='';\r\n");
      out.write("\tdocument.getElementById(\"errtips\").innerHTML = '';\r\n");
      out.write("\tdocument.getElementById(\"username_tips\").innerHTML = '';\r\n");
      out.write("\tdocument.getElementById(\"passwd_tips\").innerHTML = '';\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/logreg/js/slide.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\"\r\n");
      out.write("\t\t\tsrc=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/logreg/js/TweenMax.min.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/logreg/js/myScroll.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/logreg/js/util.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/logreg/js/gather.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\"\r\n");
      out.write("\t\t\tsrc=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/easyui-1.4/jquery.easyui.min.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t\t<script type=\"text/javascript\"\r\n");
      out.write("\t\t\tsrc=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/easyui-1.4/locale/easyui-lang-zh_CN.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\t</head>\r\n");
      out.write("\t<body>\r\n");
      out.write("\t\t<div class=\"login-wrapper\">\r\n");
      out.write("\t\t\t<div class=\"login-container\">\r\n");
      out.write("\t\t\t\t<img class=\"login-logo\"\r\n");
      out.write("\t\t\t\t\tsrc=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/images/login/login_logo_sm.png\">\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<div class=\"login-panel-container\">\r\n");
      out.write("\t\t\t\t\t<div class=\"login-panel\">\r\n");
      out.write("\t\t\t\t\t\t<form id=\"loginForm\" class=\"login-body\" method=\"post\">\r\n");
      out.write("\t\t\t\t\t\t\t<div id=\"errtips\" style=\"color: #ff4040;\"></div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label for=\"username\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t登录账号\r\n");
      out.write("\t\t\t\t\t\t\t\t</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input id=\"username\" name=\"username\" type=\"text\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tclass=\"form-control\" onfocus=\"clearTips();\" />\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<div id=\"username_tips\" style=\"color: #ff4040;\"></div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"form-group\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<label for=\"passwd\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t登录密码\r\n");
      out.write("\t\t\t\t\t\t\t\t</label>\r\n");
      out.write("\t\t\t\t\t\t\t\t<input id=\"passwd\" name=\"passwd\" type=\"password\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tautocomplete=\"off\" class=\"form-control\" onfocus=\"clearTips();\">\r\n");
      out.write("                <div id=\"capital\" style=\"display:none; color:red\">大写锁定已开启</div>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t \r\n");
      out.write("\t\t\t\t\t\t\t<div id=\"passwd_tips\" style=\"color: #ff4040;\"></div>\r\n");
      out.write("\t\t\t\t\t\t\t<button id=\"loginbtn\" type=\"button\" onclick=\"submitForm()\"\r\n");
      out.write("\t\t\t\t\t\t\t\tclass=\"u-btn u-btn-primary\">\r\n");
      out.write("\t\t\t\t\t\t\t\t登录\r\n");
      out.write("\t\t\t\t\t\t\t</button>\r\n");
      out.write("\t\t\t\t\t\t</form>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<!--v-component-->\r\n");
      out.write("\t\t\t\t\t\t<div class=\"login-footer\">\r\n");
      out.write("\t\t\t\t\t\t\t<a class=\"pr20\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/icp/portal/home.html\">返回首页</a>\r\n");
      out.write("\t\t\t\t\t\t\t<!--<a href=\"https://login.cloud.inspur.com/register\">立即注册</a>-->\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"hr\"></div>\r\n");
      out.write("\t\t\t\t\t<!--v-start-->\r\n");
      out.write("\t\t\t\t\t<div class=\"footer-links\">\r\n");
      out.write("\t\t\t\t\t\t<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/icp/portal/home.html\">首页</a>\r\n");
      out.write("\t\t\t\t\t\t<span class=\"v-separator\"></span>\r\n");
      out.write("\t\t\t\t\t\t<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/icp/portal/product/00.html\">产品与服务</a>\r\n");
      out.write("\t\t\t\t\t\t<span class=\"v-separator\"></span>\r\n");
      out.write("\t\t\t\t\t\t<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/icp/portal/notice/lst/notice/notice_1.html\">通知公告</a>\r\n");
      out.write("\t\t\t\t\t\t<span class=\"v-separator\"></span>\r\n");
      out.write("\t\t\t\t\t\t<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${basePath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/icp/portal/news/lst/website_1.html\">新闻动态</a>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t<p class=\"copy-right\">\r\n");
      out.write("\t\t\t\t\t\t©浪潮集团版权所有&nbsp;&nbsp;技术支持：023-89316292\r\n");
      out.write("\t\t\t\t\t</p>\r\n");
      out.write("\t\t\t\t\t<!--v-end-->\r\n");
      out.write("\t\t\t\t\t<!--v-component-->\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
