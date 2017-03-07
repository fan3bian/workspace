<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>
	<input type="hidden" id="tabs_service_id"
		value="${rmdSecurityVo.objectid}" />
	<input type="hidden" id="tabs_security_id"
		value="${rmdSecurityVo.securityid}" />
	<input type="hidden" id="tabs_displayname"
		value="${rmdSecurityVo.displayname}" />
	<input type="hidden" id="tabs_manip" value="${rmdSecurityVo.manip}" />
	<input type="hidden" id="tabs_funip" value="${rmdSecurityVo.funip}" />
	<input type="hidden" id="tabs_connip" value="${rmdSecurityVo.connip}" />

	<link rel="stylesheet" href="${ctx}/css/gproducts.css">
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding: 10px 20px 30px 20px; margin: 0px 20px 30px 20px;">
		<div data-options="region:'north',border:false" style="overflow: hidden; background-color: #eee; height: 65px;">
			<div class="gproducts-survey">
				<div class="title" style="width: 10%;">资源详情</div>
				<div class="item" style="width: 30%;">
					<div class="item-box">
						<p>&nbsp;&nbsp;&nbsp;ID： ${rmdSecurityVo.securityid}</p>
						<p>名称：
							<span id="displaynameShow"> 
								<em class="ellipsis">${rmdSecurityVo.displayname}</em>
								<a href="#" onclick="editDisplayName()" class="easyui-linkbutton" data-options="iconCls:'icon-edit', plain:true"></a>
							</span>
							<!-- 编辑 -->
							<span id="displaynameEdit" style="display: none"> 
								<input class="easyui-validatebox" style="width: 60px; height: 22px" type="text" data-options="required:false"> 
								<a onclick="saveDisplayAndDescriptionName()" href="javascript:void(0)" class="easyui-linkbutton" style="height: 22px">保存</a>
							</span>
						</p>
					</div>
				</div>
				<div class="item" style="width: 30%;">
					<div class="item-box">
						<%-- <p>&nbsp;&nbsp;&nbsp;区域： ${rmdSecurityVo.regionName} --%>
						
						<p>防护资源：${rmdSecurityVo.neid}</p>
						
						<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;描述：
							<span id="descriptionShow">
								<em class="ellipsis">${rmdSecurityVo.description}</em>
								<a href="#" onclick="editDescription()" class="easyui-linkbutton" data-options="iconCls:'icon-edit', plain:true"></a>
							</span>
							<!-- 编辑 -->
							<span id="descriptionEdit" style="display: none"> 
								<input class="easyui-validatebox" style="width: 60px; height: 22px" type="text" data-options="required:false"> 
								<a onclick="saveDisplayAndDescriptionName()" href="javascript:void(0)" class="easyui-linkbutton" style="height: 22px">保存</a>
							</span>
						</p>
						
					</div>
				</div>
				<div class="item" style="width: 30%;">
					<div class="item-box">
					<p>
							状态： <span class="item-state"> <c:if
									test="${rmdSecurityVo.curstat eq 'Running'}">运行中</c:if> <c:if
									test="${rmdSecurityVo.curstat eq 'Stopped'}">停止</c:if> <c:if
									test="${rmdSecurityVo.curstat eq 'Stopping'}">正在停止</c:if> <c:if
									test="${rmdSecurityVo.curstat eq 'Starting'}">启动中</c:if> <c:if
									test="${rmdSecurityVo.curstat eq 'Destroyed'}">已删除</c:if> <c:if
									test="${rmdSecurityVo.curstat eq 'Expunging'}">正在销毁</c:if>
							</span>
					</p>
					</div>
				</div>
			</div>
		</div>
		
		
		<div data-options="region:'center',border:false"
			style="background-color: #eee;">
			<jsp:include page="policy_EW.jsp" />
		</div>
	</div>


	<!--修改示例名称的传参表单  -->
	<form id="object_operate" method="post">
	</form>
	
	
	
	<script type="text/javascript">
		$(".j-gjhhtab .tab-line li")
				.click(
						function(event) {
							$(this).addClass('active').siblings().removeClass(
									'active');
							$(".j-gjhhtab .tab-line-box .content").eq(
									$(this).index()).show().siblings().hide();
							$('#netparam')
									.panel(
											{
												href : '${pageContext.request.contextPath}/web/security/netparam.jsp'
											});
							$('#dnat')
									.panel(
											{
												href : '${pageContext.request.contextPath}/web/security/dnat.jsp'
											});

						});

		$(document).ready(function() {
			$('#displaynameShow em').attr('title','${rmdSecurityVo.displayname}');
			$('#descriptionShow em').attr('title','${rmdSecurityVo.description}');
			$('#fw_tabs').tabs({
				border : false,
				onSelect : function(title,index) {
					if (index == 1) {//攻击防护
						$("#fw_arp").panel({
							href : '${pageContext.request.contextPath}/web/security/arpdomain.jsp'
						});
					} else if (index == 2) {//后端服务器配置
						$("#fw_slimit").panel({
							href : '${pageContext.request.contextPath}/web/security/sessionlimit.jsp'
						});
					}
				}
			});
		});
		
		
		/* 点击修改示例名称*/
		
		function editDisplayName() {
			$('#displaynameEdit input').val($('#displaynameShow em').text());
			$('#displaynameShow').hide();
			$('#displaynameEdit').show();

		}
		
		
		/* 点击修改实例描述*/
		
		function editDescription() {
			$('#descriptionEdit input').val($('#descriptionShow em').text());
			$('#descriptionShow').hide();
			$('#descriptionEdit').show();

		}

		/* 保存修改后的实例名称*/
		
		function saveDisplayAndDescriptionName() {
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
										
									  if ($('#displaynameEdit input').val() != '') {
											$('#displaynameShow em').text($('#displaynameEdit input').val());
											$('#displaynameShow em').attr('title',$('#displaynameEdit input').val());
											$('#displaynameShow').show();
											$('#displaynameEdit').hide();
										}

										if ($('#descriptionEdit input').val() != '') {
											$('#descriptionShow em').text($('#descriptionEdit input').val());
											$('#descriptionShow em').attr('title',$('#descriptionEdit input').val());
											$('#descriptionShow').show();
											$('#descriptionEdit').hide();
										}

									} else {
										$.messager.alert('提示', '修改错误', 'error');
									}
								}
							});
		}
	</script>
</body>