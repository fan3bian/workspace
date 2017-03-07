<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<%
String msg = request.getAttribute("msg")==null?"":request.getAttribute("msg").toString();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>浪潮云平台-云服务第一平台</title>
<script type="text/javascript" src="${ctx}/easyui-1.4/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/portal/scripts/slide.js"></script>
<script type="text/javascript" src="${ctx}/icp/portal/scripts/TweenMax.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/portal/scripts/myScroll.js"></script>
<script type="text/javascript" src="${ctx}/icp/portal/scripts/util.js"></script>
<script type="text/javascript" src="${ctx}/icp/portal/js/register.js"></script>
<link rel="stylesheet" href="${ctx}/icp/portal/styles/index.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/icp/portal/styles/register.css" type="text/css"></link>
<style type="text/css">
.mibao-select{width:270px;float:left;}
</style>
<script type="text/javascript">
var path = '${ctx}';
function refresh() {
		document.getElementById("authImg").src = '${ctx}/authimg.jpg?now='
			+ (new Date().getTime());
}
function download(){
  var url = '${ctx}/upload/fwtk.doc';
  window.open('${ctx}/icp/orderbuy/download.jsp?url='+url);

}
</script>
</head>
<body>
	<jsp:include page="/icp/include/indexHead.jsp" />
	
	<div class="register-wrap">
		<div class="register">
			<div class="hd"><img src="${ctx}/icp/portal/images/register/login-10.jpg" alt=""></div>
			<div class="bd">
			<span id="msg" class="msgError"><%=msg%></span>
			<form id="ff" action="${ctx}/uu/inputAccountInfo.do" method="post" onsubmit="return check()">
				<div class="left">
					<div class="line">
						<p class="title"><span>*</span>电子邮箱：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;" placeholder="输入电子邮箱作为账户名" value='${email}' id="email" name="email"/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>登录密码：</p>
						<div class="infor">
							<p><input type="password" class='text' id="passwd" name="passwd" onkeypress="if(event.keyCode == 13) return false;"/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>确认登录密码：</p>
						<div class="infor">
							<p><input type="password" class='text' id="repasswd" name="repasswd" onkeypress="if(event.keyCode == 13) return false;"/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>别名：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="alias" name="alias" value='${alias}'/></p>
							<span class="s1">唯一别名，可做登录使用</span>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>真实姓名：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;" id="uname" name="uname" value='${uname}' /></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>手机号码：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;"  id="mobile" name="mobile" value='${mobile}'/></p>
							<span class="s1">绑定安全手机，可做登录使用</span>
						</div>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<p class="title"><span>*</span>客户类型：</p>
						<div class="infor">
							<div class='select'>
								<select id="usertype"  name="usertype">
									<option value="2">企业</option>
									<option value="1">政府</option>
									
								</select>
							</div>
							<span class="s2">请选择客户类型</span>
						</div>
					</div>
					<div class="line">
						<p class="title">是否子帐号：</p>
						<div class="infor">
							<p><input type="checkbox" class='check' id="userlevelch" name="userlevelch" value="2" onclick="showPemailDiv(this);" checked /></p>
							<input type="hidden" id="userlevel" name="userlevel" value="2" />
						</div>
					</div>
					<div class="line" id="pemaildiv">
						<p class="title"><span>*</span>父账号：</p>
						<div class="infor">
							<p><input id="pemail" onkeypress="if(event.keyCode == 13) return false;" name="pemail" type="text" class='text' value='${pemail}' /></p>
							<div><span id="tips" style="color:#FF910C"></span></div>
						</div>
					</div>
					<div class="line" id="biwaydiv">
						<p class="title"><span>*</span>扣费方式：</p>
						<div class="infor">
							<p class="content">
								<input name="biway" type="radio" value='0' ${biway==null||biway==""||biway=="0" ?"checked":"" }/>共享计费
								<input name="biway" type="radio" value='1' ${biway=="1" ?"checked":"" }/>独立计费
							</p>
							<div><span id="tips" style="color:#FF910C"></span></div>
						</div>
					</div>
					<div class="line">
						<p class="title">密保问题：</p>
						<div class="infor">
							<div class='mibao-select'>
								<select id="pwdpp"  name="pwdpp" value='${pwdpp}' >
									<option value="我的名字叫什么？">我的名字叫什么？</option>
									<option value="我的email地址？">我的email地址？</option>
									<option value="我的手机号？">我的手机号？</option>
								</select>
							</div>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>问题答案：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;" placeholder="请输入问题答案" id="pwdppanswer" name="pwdppanswer" value='${pwdppanswer}'/></p>
						</div>
					</div>
					<div class="line testing">
						<p class="title"><span>*</span>验证码：</p>
						<div class="infor">
							<p class='p1'><input id="inputCode" name="randCode" type="text" class='text' /></p>
							<p class="p2">
								<img alt="点击刷新" src="${ctx}/authimg.jpg" id="authImg" />
								<a href="javascript:refresh();">&nbsp;&nbsp;<span style="color:#FF910C">看不清，换一张</span></a>
							</p>
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<div class="button"><input type="submit" value='同意协议并提交' ></div>
			</form>			
			<div class="deal"><a href="javascript:void(0);" onclick="download()">《浪潮云服务协议》</a></div>
			</div>
		</div>
	</div>

	<jsp:include page="/icp/include/indexFoot.jsp" />
</body>