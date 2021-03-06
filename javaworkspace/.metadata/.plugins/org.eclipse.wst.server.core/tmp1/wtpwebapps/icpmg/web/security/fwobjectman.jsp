<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>	
	<input type="hidden" id="tabs_service_id" value="${rmdSecurityVo.objectid}"/>
	<input type="hidden" id="tabs_security_id" value="${rmdSecurityVo.securityid}"/>
	<input type="hidden" id="tabs_displayname" value="${rmdSecurityVo.displayname}"/>
	<input type="hidden" id="tabs_manip" value="${rmdSecurityVo.manip}"/>
	<input type="hidden" id="tabs_funip" value="${rmdSecurityVo.funip}"/>
	<input type="hidden" id="tabs_connip" value="${rmdSecurityVo.connip}"/>
	
	<link rel="stylesheet" href="${ctx}/css/gproducts.css">
    <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 30px 20px;margin:0px 20px 30px 20px;">
        <div data-options="region:'north',border:false" style="overflow:hidden;background-color: #eee; height: 65px;">
            <div class="gproducts-survey">
                <div class="title" style="width: 10%;">资源详情</div>
                <div class="item" style="width: 20%;">
                    <div class="item-box">
                        <p>&nbsp;&nbsp;&nbsp;ID：  ${rmdSecurityVo.securityid}</p>
                        <p>名称：
							<span id="displaynameShow"> 
								<em class="ellipsis">${rmdSecurityVo.displayname}</em>
								<a href="#" onclick="editDisplayName()" class="easyui-linkbutton" data-options="iconCls:'icon-edit', plain:true"></a>
							</span>
							<!-- 编辑 -->
							<span id="displaynameEdit" style="display: none"> 
								<input class="easyui-validatebox" style="width: 60px; height: 22px" type="text" data-options="required:false"> 
								<a onclick="saveDisplayName()" href="javascript:void(0)" class="easyui-linkbutton" style="height: 22px">保存</a>
							</span>
						</p>
                    </div>
                </div>
                <div class="item" style="width: 20%;">
                    <div class="item-box">
                        <p>管理地址：  ${rmdSecurityVo.manip}</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态： <span class="item-state">
                        <c:if test="${rmdSecurityVo.curstat eq 'Running'}">运行中</c:if>
						<c:if test="${rmdSecurityVo.curstat eq 'Stopped'}">停止</c:if>
						<c:if test="${rmdSecurityVo.curstat eq 'Stopping'}">正在停止</c:if>
						<c:if test="${rmdSecurityVo.curstat eq 'Starting'}">启动中</c:if>
						<c:if test="${rmdSecurityVo.curstat eq 'Destroyed'}">已删除</c:if>
						<c:if test="${rmdSecurityVo.curstat eq 'Expunging'}">正在销毁</c:if>
                        </span></p>
                    </div>
                </div>
                 <div class="item" style="width: 20%;">
                    <div class="item-box">
                         <p>业务地址：  ${rmdSecurityVo.funip}</p>
                        <p>外连地址： ${rmdSecurityVo.connip}</p>
                    </div>
                </div>
                <div class="item" style="width: 30%;">
                    <div class="item-box">
                       <!--   <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区域： ${rmdSecurityVo.regionname}</p>-->
                        <p>开通时间：  ${rmdSecurityVo.ctime}</p>
                    </div>
                </div>
               <!--  
                <div class="item item-link" style="width: 10%;">
                    <div class="item-box">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help2',plain:true,"></a>
                        <p><a href="javascript:void(0)" href="#">帮助文档</a></p>
                    </div>
                </div>
                -->
            </div>
        </div>
        <div data-options="region:'center',border:false" style="background-color: #eee; ">
            <div id=fw_tabs class="easyui-tabs gproducts-main" data-options="fit:true" >
            	<div id="tabs0" title="安全策略" data-options="fit:true"  style="display:block;background-color: #eee; ">
                    <jsp:include page="policy.jsp" />
                </div>
                <div id="tabs1" title="攻击防护" data-options="fit:true"  style="display:block;background-color: #eee; ">
                    <div id="fw_arp" style="overflow:hidden;"></div>
                </div>
                <div id="tabs2" title="会话限制" data-options="fit:true"  style="display:block;background-color: #eee; ">
                    <div id="fw_slimit" style="overflow:hidden;"></div>
                </div>
                <div id="tabs3" title="高级配置" data-options="fit:true"  style="display:block;background-color: #eee; ">
                    <div id="mm" class="tab-line-wrap j-gjhhtab">
				        <ul class="tab-line ">
				            <li class="active">安全域</li>
				            <li>全局网络参数</li>
				            <li>防护资源配置</li>
				        </ul>
				        <div class="tab-line-box">
				            <div class="content" style="  padding-top: 5px;">
				                <div id="domain" class="easyui-panel" data-options="href:'${pageContext.request.contextPath}/web/security/domain.jsp'"></div>
				            </div>
				            <div class="content" class="easyui-panel" style="display: none;">
				                <div id="netparam"></div>
				            </div>
				            <div class="content" class="easyui-panel" style="display: none; ">
				                <div id="dnat"></div>
				            </div>
				        </div>
				    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!--修改示例名称的传参表单  -->
	<form id="object_operate" method="post">
	</form>
<script type="text/javascript">
$(".j-gjhhtab .tab-line li").click(function(event) {
    $(this).addClass('active').siblings().removeClass('active');
    $(".j-gjhhtab .tab-line-box .content").eq($(this).index()).show().siblings().hide();
    $('#netparam').panel({
        href: '${pageContext.request.contextPath}/web/security/netparam.jsp'
    });
    $('#dnat').panel({
        href: '${pageContext.request.contextPath}/web/security/dnat.jsp'
    });

});

$(document).ready(function() {
	$('#displaynameShow em').attr('title','${rmdSecurityVo.displayname}');
	$('#fw_tabs').tabs({
		border : false,
		onSelect : function(title, index) {
			if (index == 1) {//攻击防护
				$("#fw_arp").panel({
					href : '${pageContext.request.contextPath}/web/security/arpdomain.jsp'
				});
			}else if (index == 2) {//后端服务器配置
				$("#fw_slimit").panel({
					href : '${pageContext.request.contextPath}/web/security/sessionlimit.jsp'
				});
			}
		}
	});
}); 

function editDisplayName() {
	$('#displaynameEdit input').val($('#displaynameShow em').text());
	$('#displaynameShow').hide();
	$('#displaynameEdit').show();
}

function saveDisplayName() {
	$('#object_operate').form('submit',
			{
				url : '${pageContext.request.contextPath}/security/updateObjectInfo.do',
				onSubmit : function(param) {
					param.displayname = $('#displaynameEdit input').val();
					param.description = $('#descriptionEdit input').val();
					param.objectid = '${rmdSecurityVo.objectid}';
					param.securityid = '${rmdSecurityVo.securityid}';
				},
				success : function(retr) {
					var _data = $.parseJSON(retr);
					if (_data.success) {
						$('#displaynameShow em').text($('#displaynameEdit input').val());
						$('#displaynameShow em').attr('title',$('#displaynameEdit input').val());
						$('#displaynameShow').show();
						$('#displaynameEdit').hide();
					} else {
						$.messager.alert('提示', '修改错误', 'error');
					}
				}
			});
}
</script>
</body>