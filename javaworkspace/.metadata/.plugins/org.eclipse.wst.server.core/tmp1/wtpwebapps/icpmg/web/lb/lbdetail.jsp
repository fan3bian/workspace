<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<div style="margin-left:20px;margin-top:5px;">
	<span style="font-weight:bold;">基本信息</span>
	<div style="margin-top:10px;margin-bottom:40px;">
		<p style="width:auto;margin-left:30px;float:left;">ID：${rmdLbVo.lbid}</p>
		<p id="lb_status" style="width:auto;margin-left:30px;float:left;">
		状态：
		<c:if test="${rmdLbVo.curstat eq 'Running'}">运行中</c:if>
		<c:if test="${rmdLbVo.curstat eq 'Stopped'}">停止</c:if>
		<c:if test="${rmdLbVo.curstat eq 'Stopping'}">正在停止</c:if>
		<c:if test="${rmdLbVo.curstat eq 'Starting'}">启动中</c:if>
		<c:if test="${rmdLbVo.curstat eq 'Destroyed'}">已删除</c:if>
		<c:if test="${rmdLbVo.curstat eq 'Expunging'}">正在销毁</c:if>
		</p>
		<p style="width:auto;margin-left:30px;float:left;">所在区域：${rmdLbVo.regionname}</p>
		<p style="width:auto;margin-left:30px;float:left;">IP：${rmdLbVo.funip}</p><br/><br/>
		<div style="margin-left:30px;margin-top:5px;margin-bottom:15px;">
			<table>
				<tbody>
					<tr>
						<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;height:35px;">名称：${rmdLbVo.displayname}</td>
						<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;">用途：${rmdLbVo.description}</td>
					</tr>
					<tr>
						<td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;height:35px;width:250px;">
							实例类型：<c:if test="${rmdLbVo.instatype eq '1'}">私有网络</c:if><c:if test="${rmdLbVo.instatype eq '2'}">公有网络</c:if>
						</td>
						<%-- <td style="text-align:left;padding-left:10px;border: 1px solid #95B8E7;width:250px;">
							网络类型：<c:if test="${rmdLbVo.networktype eq '1'}">基础网络</c:if><c:if test="${rmdLbVo.networktype eq '2'}">高级网络</c:if>
						</td> --%>
					</tr>
				</tbody>
			</table>
		</div>
		
		
		
	<%-- 	<p style="width:auto;margin-left:30px;float:left;">最大连接数：${rmdLbVo.connnum}</p> --%>
	</div>
	
	<div>
		<!--  
		<c:if test="${rmdLbVo.curstat != 'Destroyed' && rmdLbVo.curstat != 'Expunging'}">
		<a id="lbdestory_" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:500px;" onclick="cancellb();">释     放</a>
		</c:if>
		-->
		<c:if test="${rmdLbVo.curstat eq 'Running'}">
		<a id="lbstop_" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:500px;" onclick="operate('stop');">停      止</a>
		</c:if>
		<c:if test="${rmdLbVo.curstat eq 'Stopped'}">
		<a id="lbstart_" href="javascript:void(0);" class="easyui-linkbutton" style="float:right;margin-right:500px;" onclick="operate('start');">启     动</a>
		</c:if>
	</div>
	<form id="lb_operate" method="post">
	<input type="hidden" id="lbid" value="${rmdLbVo.lbid}">
	<input type="hidden" id="lbip" value="${rmdLbVo.lbip}">
	<input type="hidden" id="lbdisplayname" value="${rmdLbVo.displayname}">
	</form>
</div>
<script type="text/javascript">
function cancellb(){
	var dialog = parent.icp.modalDialog({
		title : '资源销毁',
		url : '${pageContext.request.contextPath}/web/lb/lbdestoryconfirm.jsp?lbid=' + $("#tabs_lbid").val(),
		buttons : [{
			text : '销毁',
			iconCls:'icon-ok',
			handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
				dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
			}
		},{
			text : '取消',
			iconCls:'icon-cancel',
			handler : function() {//contentWindow属性是指指定的frame或者iframe所在的window对象
				dialog.find('iframe').get(0).contentWindow.closeWindows(dialog);
			}
		}]
	}); 
}
//停止，启动
function operate(type){
	$('#lb_operate').form('submit',
			{
				url : '${pageContext.request.contextPath}/lb/operate.do',
				onSubmit : function(param) {
					param.type=type;
					param.name=$("#lbdisplayname").val();
					param.lbid=$("#lbid").val();
					param.lbip=$("#lbip").val();
				},
				success : function(retr) {
					var _data = $.parseJSON(retr);
					if (_data.success) {
					     if(type == 'stop'){
					    	 $("#lbstop_").hide();
					    	 $("#lbstart_").show();
					    	 $("#lb_status").text("状态：停止");
					     }else if(type == 'start'){
					    	 $("#lbstop_").show();
					    	 $("lbstart_").hide();
					    	 $("#lb_status").text("状态：运行中");
					     }
				   
                  		 //重新渲染组件
                     	 $.parser.parse();
						 $.messager.alert('提示', _data.msg, 'info');
					} else {
						 $.messager.alert('提示', _data.msg, 'error');
					}
				}
			});
}
</script> 
