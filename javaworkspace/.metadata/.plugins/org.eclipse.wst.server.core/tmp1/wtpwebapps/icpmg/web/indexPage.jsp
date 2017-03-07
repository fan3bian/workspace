<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../icp/include/taglib.jsp"%>

<%
	String contextPath = request.getContextPath();
%>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>浪潮云服务</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<!--<link rel="stylesheet" type="text/css" media="screen" href="${ctx}/icp/style/miniui.css" />-->	
<link rel="stylesheet" type="text/css" href="${ctx}/icp/js/easyui-1.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/icp/js/easyui-1.4/themes/icon.css">
<script type="text/javascript" src="${ctx}/icp/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/easyui-1.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/icp/js/easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="${ctx}/icp/style/icpindex.css" type="text/css" />
<script type="text/javascript">		
$(document).ready(function() {
	resourceOverview();
    indexGetHeight();
});

function indexGetHeight() {
    var screenH = $(window).height() - 60;
    var leftH = $('.index-left').height();
    var rightH = $('.index-right').height();
    var maxH = screenH - (leftH - rightH > 0 ? leftH : rightH) > 0 ? screenH : leftH - rightH > 0 ? leftH : rightH;
    $('.index-left').height(maxH);
    $('.index-right').height(maxH);
}
//统计资源
function resourceOverview() {
	$.ajax( {
		type : 'post',
		url : '<%=contextPath%>/getResourceOverview.do',
		success : function(result) {
			var obj = JSON.parse(result);
			//业务
			//待办工单
			$("#todoorder").html(obj.todoorder);
			$("#messagetodo").html(obj.todoorder);
			//已办工单
			$("#doorder").html(obj.doorder);
			//资源申请
			$("#applyresource").html(obj.applyresource);
			//资源变更
			$("#modifyresource").html(obj.modifyresource);
						
			//资源
			$("#vmnum").html(obj.vmnum);
			$("#resourcepilotrunnum").html(obj.resourcepilotrunnum);
			$("#resourcestartfeenum").html(obj.resourcestartfeenum);
			
			//部门费用					
			$("#monthfee").html(obj.monthfee);		
			$("#yearfee").html(obj.yearfee);
			
			//监控
			$("#alarm").html(obj.alarm);
			$("#breakdown").html(obj.breakdown);
			$("#event").html(obj.event);
			$("#degradation").html(obj.degradation);
			$("#notice").html(obj.notice);
			
			//项目
			$("#projectnum").html(obj.projectnum);
			//应用
			$("#appnum").html(obj.appnum);
						
			//通知公告			
			$("#messagenum").html(obj.messagenum);
			$("#infonum").html(obj.infonum);
			

		}
	});
}


//修改密码
function passwordChange() {

	$('<div></div>').dialog({
		id: 'passwdID',
		title: '密码修改',
		width: 500,
		height: 260,
		closed: false,
		cache: false,
		href: '${ctx}/web/systemMg/passwordChange.jsp',
		modal: true,
		buttons: [{
			text: '确定',
			iconCls: 'icon-ok',
			handler: function () {
							
				$('#passwdChange_email').val("${sessionUser.email}");
				$('#passwdChange_Form').form('submit',{
							url:'${pageContext.request.contextPath}/authMgr/changePasswd.do',
							onSubmit:function(){
						           var flag = passwdChangeCheck();
						           if(!flag){
						            return flag;  
						           }
						           return true;
						         },
							success:function(r){
								var obj = jQuery.parseJSON(r);
								if(obj.success){
									$('#passwdID').dialog('close');							
									$.messager.alert("提示", obj.msg+",请重新登录!", "info", function () {  
										//logout();
										//window.parent.location.href = "${pageContext.request.contextPath}/userMgr/logout.do";
									    window.parent.location.href = "${pageContext.request.contextPath}/login.jsp";
							        });  
								}else{
									$.messager.show({
										title:'提示',
										msg:obj.msg
									});
								}
							}
						});		
			}
		}, {
			text: '取消',
			iconCls: 'icon-cancel',
			handler: function () {
				$("#passwdID").dialog('destroy');
			}
		}]
	});
}

</script>		
	<body style="position: static;">	
			<div class="index-left">
				<!-- 头像 -->
				<div class="info">
					<img class="info-photo" src="${ctx}/icp/style/images/icpindex/photo.jpg" width="65" height="65">
					<h3>${sessionUser.uname}</h3>
					<h4>${sessionUser.sysname}</h4>
					<button class="info-btn">账户设置</button>
				</div>
				<!-- 修改密码和电话 -->
				<div class="det">
					<div class="det-text">
						<p>${sessionUser.email}</p>
						<p>${sessionUser.mobile}</p>
					</div>
					<div class="det-password" onclick="passwordChange()">
						<p class="text">距离密码过期还有<em>${sessionUser.timelength}</em>天</p> <span class="btn-password"></span>
					</div>
				</div>
				<!-- 提醒 -->
				<ul class="dealt">
					<li><a href="#"><i class="icon-dealt icon-dealt-tzgg"></i>站内消息<span class="quan" id="infonum">0</span></a></li>
					<li><a href="#"><i class="icon-dealt icon-dealt-dbxx"></i>待办工单<span class="quan" id="messagetodo">0</span></a></li>
					<li><a href="#"><i class="icon-dealt icon-dealt-gjxx"></i>告警信息<span class="quan" id="alarm">0</span></a></li>
				</ul>
			</div>
			<div class="index-right">
        <div class="con">
            <div class="rowbox">
                <div class=" span span33">
                    <!-- 业务 -->
                    <div class="item-wrap business-wrap">
                        <em class="item-icon"></em>
                        <dl>
                            <dt>资源审批
                            </dt>
                            <dd>待办工单：<em class="text-big" id="todoorder"><span id="todoorder">0</span></em></dd>
                            <dd>已办工单：<em class="text-big" id="doorder"><span id="doorder">0</span></em></dd>
                        </dl>
                        <dl>
                            <dt>资源申请
                            </dt>
                            <dd>资源申请：<em class="text-big" id="applyresource"><span id="applyresource">0</span></em></dd>
                            <dd>资源变更：<em class="text-big" id="modifyresource"><span id="modifyresource">0</span></em></dd>
                        </dl>
                    </div>
                </div>
                <div class=" span span66">
                    <div class="rowbox">
                        <div class=" span span100">
                            <!-- 云服务器 -->
                            <div class="item-wrap ecs-wrap ">
                                <em class="item-icon"></em>
                                <ul>
                                    <li>云服务器：<em class="text-big" id="vmnum">0</em></li>
                                    <li>&nbsp;&nbsp;&nbsp;试运行：<em id="resourcepilotrunnum" class="text-big">0</em></li>
                                    <li>开始计费：<em class="text-big" id="resourcestartfeenum">0</em></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="rowbox">
                        <div class=" span span50">
                            <!-- 项目 -->
                            <div class="item-wrap project-wrap">
                                <em class="item-icon"></em>
                                <ul>
                                    <li>项目：<em class="text-big" id="projectnum">0</em></li>
                                    <li>应用：<em class="text-big" id="appnum">0</em></li>
                                </ul>
                            </div>
                        </div>
                        <div class=" span span50" style="padding-left: 15px;">
                            <!-- 告警 -->
                            <div class="item-wrap alarm-wrap">
                                <em class="item-icon"></em>
                                <ul>
                                    <li>故障：<em class="text-big" id="breakdown">0</em></li>
                                    <li>事件：<em class="text-big" id="event">0</em></li>
                                    <li>劣化：<em class="text-big" id="degradation">0</em></li>
                                    <li>通知：<em class="text-big" id="notice">0</em></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="rowbox">
                <div class="span span66">
                    <div class="item-wrap charging-wrap"> <em class="item-icon"></em>
                        <dl>
                            <dd id="yearfee"><span id="yearfee">0</span></dd>
                            <dt>当年费用</dt>
                        </dl>
                        <dl>
                            <dd id="monthfee"><span id="monthfee">0</span></dd>
                            <dt>
                                当月费用
                            </dt>
                        </dl>
                    </div>
                </div>
                <div class="span span33">
                    <!-- 通知公告 -->
                    <div class="item-wrap notice-wrap">
                        <em class="item-icon"></em>
                        <div class="text-big" id="messagenum"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
			
				
	</body>
	
</html>
