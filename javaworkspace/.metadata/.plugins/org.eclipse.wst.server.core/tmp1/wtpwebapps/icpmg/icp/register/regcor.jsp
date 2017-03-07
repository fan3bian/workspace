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
<script type="text/javascript" src="${ctx}/icp/js/regicor.js"></script>
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
			<form id="ff" action="${ctx}/uu/saveCorpRegInfo.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
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
						<p class="title"><span>*</span>公司全称：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;" id="cmpyname" name="cmpyname"  value='${cmpyname}'/></p>
						</div>
					</div>
					<div class="line">
						<p class="title">公司代码：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;" id="cmpycode" name="cmpycode" value='${cmpycode}'/></p>
						</div>
					</div>
					<div class="line">
						<p class="title">营业执照：</p>
						<div class="infor">
							<div class="file-cell">
								<p><label><input type="file" id="bizlic" name="uplm" onclick="$('#bizmsg').remove();"></label>
								<span>上  传</span><p>
							</div>
							<div id="bizlic-mark" class="file-mark">未选择文件</div>
						</div>
							
						<div class="ss">上传营业执照，进行人工审核</div>
						<%-- <s:actionerror/> --%>
					</div>
					<div class="line">
						<p class="title"><span>*</span>联系人：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;" id="contactperson" name="contactperson" value='${contactperson}' /></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>联系人手机：</p>
						<div class="infor">
							<p><input type="text" class='text' onkeypress="if(event.keyCode == 13) return false;" id="contactmobile" name="contactmobile" value='${contactmobile}'/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><%-- <span>*</span> --%>所在地：</p>
						<div class="infor">
							<div class='pcstr-select'>
								<select name="provid" id="provid">
									<option value="">请选择</option>
								</select>
							</div>	
							<div class='pcstd-select'>
								<select name="cityid" id="cityid">
	  								<option value="">请选择</option>
	  							</select>
							</div>	
							<input type="hidden" id="provname" name="provname">
							<input type="hidden" id="cityname" name="cityname">
						</div>
					</div>
					<div class="line">
						<p class="title">公司地址：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="cmpyaddr" name="cmpyaddr" value='${cmpyaddr}'/></p>
						</div>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<p class="title">公司电话：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="cmpytel" name="cmpytel" value='${cmpytel}'/></p>
							<span class="s1">如：xxxx-xxxxxxxx</span>
						</div>
					</div>
					<div class="line">
						<p class="title">邮政编码：</p>
						<div class="infor">
							<p><input type="text" onkeypress="if(event.keyCode == 13) return false;" class='text' id="zipcode" name="zipcode" value='${zipcode}'/></p>
						</div>
					</div>
					<div class="line">
						<p class="title"><span>*</span>公司行业：</p>
						<div class="infor">
							<div class='tradestr-select'>
								<select id="oneid" name="oneid">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
					</div>
					<div class="line">
						<p class="title"></p>
						<div class="infor">
							<div class='tradestr-select'>
								<select id="twoid" name="twoid">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
					</div>
					<div class="line">
						<p class="title"></p>
						<div class="infor">
							<div class='tradestr-select'>
								<select id="threeid" name="threeid" >
									<option value="">请选择</option>
								</select>
								<input type="hidden" id="oneidname" name="oneidname">
								<input type="hidden" id="twoidname" name="twoidname">
								<input type="hidden" id="threeidname" name="threeidname">
							</div>
						</div>
					</div>
					<div class="line">
						<p class="title">了解途径：</p>
						<div class="infor">
							<div class='str-select'>
								<select id="channel" name="channel">
									<option value="999">请选择</option>
									<option value="1">官网导购</option>
									<option value="2">电话销售</option>
									<option value="3">销售营销</option>
									<option value="4">其他介绍</option>
								</select>
							</div>
						</div>
					</div>
					<div class="line">
						<p class="title">LOGO图标：</p>
						<div class="infor">
							<div class="file-cell">
								<label><input type="file" id="logofile" name="uplm" onclick="$('#logomsg').remove();" ></label>
								<span>浏  览</span>
							</div>
							<div class="file-mark">未选择文件</div>
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
<script type="text/javascript">
	function onSelectChange(value,toSelId){
	
		setSelect(value,toSelId);
	}
	function setSelect(fromSelVal,toSelId){
		document.getElementById(toSelId).innerHTML="";
		jQuery.ajax({
		  url:"${ctx}/uu/provcity.do",
		  cache: false,
		  data:"parentId="+fromSelVal,
		  success: function(data){
		  	createSelectObj(data,toSelId);
		  }
		});
	}
	function onTradeSelChange(value,toSelId){
		if('twoid' == toSelId){
			var threeidobj = document.getElementById("threeid");
			threeidobj.options.length=0;
			var nullOp = document.createElement("option");
			nullOp.setAttribute("value","");
			nullOp.appendChild(document.createTextNode("请选择"));
			threeidobj.appendChild(nullOp);
			$("#threeid").next().children('.up').val("");
			$("#threeid").next().children('.up').text("请选择");
		}
		setTradeSelect(value,toSelId);
	}
	function setTradeSelect(fromSelVal,toSelId){
		document.getElementById(toSelId).innerHTML="";
		jQuery.ajax({
		  url:"${ctx}/uu/trade.do",
		  cache: false,
		  data:"tradePrtId="+fromSelVal,
		  success: function(data){
		  	createSelectObj(data,toSelId);
		  }
		});
	}
	function createSelectObj(data,toSelId){
		var arr = $.parseJSON(data);
		//var arr = $.parseJSON(data);//将字符串转化为json对象
		var obj = document.getElementById(toSelId);
			obj.innerHTML="";
			var nullOp = document.createElement("option");
			nullOp.setAttribute("value","");
			nullOp.appendChild(document.createTextNode("请选择"));
			
			obj.appendChild(nullOp);
		if(arr != null && arr.length>0){
			for(var o in arr){
				var op = document.createElement("option");
				op.setAttribute("value",arr[o].id);
				//op.text=arr[o].name;//这一句在ie下不起作用，用下面这一句或者innerHTML
				op.appendChild(document.createTextNode(arr[o].name));
				obj.appendChild(op);
			}
		}
		$("#"+toSelId).next().children('.up').val("");
		$("#"+toSelId).next().children('.up').text("请选择");
	}
	setSelect('1','provid');
	setTradeSelect('1', 'oneid');
</script>