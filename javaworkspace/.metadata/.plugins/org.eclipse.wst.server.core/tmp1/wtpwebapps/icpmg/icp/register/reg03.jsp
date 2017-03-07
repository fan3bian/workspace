<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>浪潮云平台-云服务第一平台</title>
<script type="text/javascript" src="${ctx}/icp/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/slide.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/TweenMax.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/myScroll.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/util.js"></script>
<link rel="stylesheet" href="${ctx}/icp/style/index.css" type="text/css"></link>
<link rel="stylesheet" href="${ctx}/icp/style/register.css"
	type="text/css"></link>
<script>
	var _cBw = function() {
		var a = this, second = +a.data('count');
		second--;
		a.data('count', second);
		if (second) {
			a.text('（' + second + '秒后）重发邮件');
			setTimeout(function() {
				_cBw.call(a);
			}, 1000);
		} else {
			a.text('重新发送邮件').removeClass('a-cli-disabled');
			$("#" + a.attr('id') + "_span").remove();
		}
	};

	$(document)
			.ready(
					function() {

						$('#rvr')
								.on(
										'click',
										function() {
											var a = $(this);
											if (a.hasClass('a-cli-disabled')) {
												$("#" + a.attr('id') + "_span")
														.remove();
												a
														.parent()
														.append(
																'<span id="'
																		+ a
																				.attr('id')
																		+ '_span"><img src=""${ctx}/icp/images/icon/error.png"/> '
																		+ "每分钟只能发送一次"
																		+ '</span>');
												return;
											}
											$("#" + a.attr('id') + "_span")
													.remove();
											$
													.ajax({
														url : "${ctx}/uu/sendRegEmail.do",
														cache : false,
														async : true,
														data : "email=" + '${email}',
														success : function(b) {
															var r = $
																	.parseJSON(b);
															if (r.success) {
																a
																		.parent()
																		.append(
																				'<span id="'
																						+ a
																								.attr('id')
																						+ '_span"><img src="${ctx}/icp/images/icon/succ.png"/> '
																						+ r.msg
																						+ '</span>');
															}else
															{
																a
																		.parent()
																		.append(
																				'<span id="'
																						+ a
																								.attr('id')
																						+ '_span"><img src=""${ctx}/icp/images/icon/succ.png"/> '
																						+ r.msg
																						+ '</span>');
															}
														}
													});
											a.addClass('a-cli-disabled').data(
													'count', 60);
											_cBw.call(a);
										});
					});
					function redierctUrl()
					{
						var email = '${email}';
						
						window.open("http://mail."+email.split('@')[1]); 
					}
</script>
</head>

<body>
	<jsp:include page="/icp/include/indexHead.jsp" />

	<div class="register-wrap">
		<div class="register">
			<div class="hd">
				<img src="${ctx}/icp/images/logo2.png" alt="">
			</div>
			<div class="bd">
				<span class="s1"><img src="${ctx}/icp/images/icon/succ.png" />
					邮件已发送到邮箱<strong>${email}</strong>，请在48小时内点击邮件中的链接继续完成注册。</span>
			</div>
			<div class="clear"></div>
			<div class="button">
				<input type="submit" onclick="javascript:redierctUrl();" value='立即查收邮件'>
			</div>
			<div class="clear"></div>
			<div class="clear"></div>
			<div class="bd">
				<span class="span_b">一直没有收到邮件？</span><br> <span class="span_a">请先检查是否在垃圾邮件中</span><br>
				<span class="span_a">如果还未收到<a id="rvr" href="javascript:;">重新发送邮件</a></span><br>
				<span class="span_a">一直未收到您可以<a
					href="${ctx}/icp/register/reg01.jsp">重新注册</a></span>
			</div>
		</div>
	</div>

	<jsp:include page="/icp/include/indexFoot.jsp" />
</body>
</html>
