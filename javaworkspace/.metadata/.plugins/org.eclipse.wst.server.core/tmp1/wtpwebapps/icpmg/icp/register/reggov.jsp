<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
<script type="text/javascript">
var path = '${ctx}';
</script>
<script type="text/javascript" src="${ctx}/icp/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/slide.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/TweenMax.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/myScroll.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/util.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/regigov.js"></script>
<link rel="stylesheet" href="${ctx}/icp/style/index.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/icp/style/register.css" type="text/css"></link>

<style type="text/css">
.pcstr-select{width:140px;float:left;}
.pcstd-select{width:100px;float:left;margin-left:30px;}
.tradestr-select{width:270px;float:left;}
</style>
</head>
<body>
	<jsp:include page="/icp/include/indexHead.jsp" />
	
	<div class="register-wrap">
		<div class="register">
			<div class="hd"><img src="${ctx}/icp/images/login-13.jpg" alt=""></div>
			<div class="bd">
			<span id="msg" class="msgError"><%=msg%></span>
			<form id="ff" action="${ctx}/uu/saveGovmRegInfo.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
				<input type="hidden" id="email" name="email" value='${email}' />
				<input type="hidden" id="passwd" name="passwd" value='${passwd}' />
				<input type="hidden" id="mobile" name="mobile" value='${mobile}' />
				<input type="hidden" id="alias" name="alias" value='${alias}' />
				<input type="hidden" id="uname" name="uname" value='${uname}' />
				<input type="hidden" id="userlevel" name="userlevel" value='${userlevel}' />
				<input type="hidden" id="usertype" name="usertype" value='${usertype}' />
				<input type="hidden" id="pemail" name="pemail" value='${pemail}' />
				<input type="hidden" id="pwdpp" name="pwdpp" value='${pwdpp}' />
				<input type="hidden" id="pwdppanswer" name="pwdppanswer" value='${pwdppanswer}' />
				<div class="left">
					<div class="line">
						<p class="title"><span>*</span>单位名称：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="unitname" name="unitname"  value='${unitname}'/></p>
						</div>
					</div>
					
					<div class="line">
						<p class="title"><span>*</span>办公地点：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="officeloc" name="officeloc" value='${officeloc}'/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>LOGO图标：</p>
						<div class="infor">
							<div class="file-cell">
								<label><input type="file" id="logofile" name="uplm" onclick="$('#logomsg').remove();" ></label>
								<span>浏  览</span>
							</div>
							<div class="file-mark">未选择文件</div>
						</div>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<p class="title"><span>*</span>单位联系人：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="unitcontactperson" name="unitcontactperson" value='${unitcontactperson}'/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>联系人部门：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="unitcontactpart" name="unitcontactpart" value='${unitcontactpart}'/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>联系人电话：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="unitcontacttel" name="unitcontacttel" value='${unitcontacttel}'/></p>
						</div>
					</div>
				</div>
				<div class="clear"></div>
				<div class="button"><input type="submit" value='创建账户并继续' ></div>
			</form>
			</div>
		</div>
	</div>

	<jsp:include page="/icp/include/indexFoot.jsp" />
</body>