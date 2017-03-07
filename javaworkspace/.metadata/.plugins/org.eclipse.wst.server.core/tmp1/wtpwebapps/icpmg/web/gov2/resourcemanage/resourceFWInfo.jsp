<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/icp/include/taglib.jsp"%>
<head></head>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <body>
		<form method="post" id="fzjhForm">
			<input name="objectid" id="objectid" type="hidden">
				<fieldset>
					<legend class="info-Legend">基本信息</legend>
						<div style="margin: 10px 25px;width:600px;" >
							<span style="width:300px;">名  &nbsp; 称：&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" name="fzjhName" id="fzjhName" style="width: 200px ;height: 25px;" readonly>	
							&nbsp;&nbsp;&nbsp;
							<span>状  &nbsp; 态：&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" name="fzjhStatus" id="fzjhStatus" style="width: 200px ;height: 25px;" readonly>
								  
					    </div>
					    <div style="margin: 10px 25px;width:600px;" >
							<span style="width:300px;">资 源 ID：&nbsp;</span>
								<input class="easyui-textbox" name="fzjhNeid" id="fzjhNeid" style="width: 200px ;height: 25px;" readonly>	
							&nbsp;&nbsp;&nbsp;
							<span>区  &nbsp; 域：&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" name="fzjhNetWorkName" id="fzjhNetWorkName" style="width: 200px ;height: 25px;" readonly>
								  
					    </div> 
					    <div style="margin: 10px 25px;width:600px;" >
							<span style="width:300px;">单   &nbsp;&nbsp; 位：&nbsp;&nbsp;</span>
								<input class="easyui-textbox" name="fzjhUseUnitName" id="fzjhUseUnitName" style="width: 200px ;height: 25px;"readonly>	
							&nbsp;&nbsp;&nbsp;
							<span>项  &nbsp; 目：&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" name="fzjhProjectName" id="fzjhProjectName" style="width: 200px ;height: 25px;"readonly>
								  
					    </div>
						<div style="margin: 10px 25px;width:600px;" >
							<span style="width:300px;">服务类型：</span>
								<input class="easyui-textbox" name="fzjhservertypenamelevelfirst" id="fzjhservertypenamelevelfirst" style="width: 200px ;height: 25px;"readonly>	
							&nbsp;&nbsp;&nbsp;
							<span>服务名称：</span>
								<input class="easyui-textbox" name="fzjhservertypenamesecond" id="fzjhservertypenamesecond" style="width: 200px ;height: 25px;"readonly>
								  
					    </div>
					    <div style="margin: 10px 25px;width:600px;">
							<span>开通时间：</span>
							<input class="easyui-textbox" name="fzjhBuyTime" id="fzjhBuyTime" style="width: 200px ;height: 25px;" readonly>
								&nbsp;&nbsp;&nbsp;
							<span>计费时间：</span>
							<input class="easyui-textbox" data-options="validType:'isBlank'" name="fzjhUsetime" id="fzjhUsetime" style="width: 200px ;height: 25px;"readonly >
					    </div>
					</fieldset>
					<br>
					<fieldset>
						<legend class="info-Legend">应用配置</legend>
						<div style="margin: 10px 25px;width:600px;" >
							<span>应用名称：&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-textbox" data-options="validType:'isBlank',multiline:true" name="fzjhAppname" id="fzjhAppname" style="width: 475px ;height: 130px;" readonly >
							</span>
					    </div>
					</fieldset>
					<br>
			</form>
		<script type="text/javascript">
			//增加 弹窗，单位-项目级联
			$('#projectname').combobox({
				width:170,
				panelHeight: '100'
			});
		
			$('#unitname').combobox({
				url:'${ctx}/infopublish/getDepartsTJ.do',
				valueField: 'unitId',
				textField: 'unitName',
				width:170,
				panelHeight: '100',
				onSelect:function (record){
					var _unitId = record.unitId;
					$('#projectname').combobox({
						url:'${ctx}/project/getprojectsAll.do?unitId='+_unitId,
						valueField: 'proid',
						textField: 'proname',
					});
				}
			});
		
		
			//增加弹窗，一级分类-二级分类级联
			$('#servertypenamesecond').combobox({
				//url:'${ctx}/resourceinfo/getSevertypeSecondList.do',
				//valueField: 'servertypeid',
				//textField: 'servertypename',
				width:170,
				panelHeight: '100'
			});
		
			$('#servertypenamelevelfirst').combobox({
				url:'${ctx}/resourceinfo/getSevertypeList.do',
				valueField: 'servertypeid',
				textField: 'servertypename',
				width:170,
				panelHeight: '100',
				onSelect:function (record){
					var _servertypeid = record.servertypeid;
					$('#servertypenamesecond').combobox({
						url:'${ctx}/resourceinfo/getSevertypeSecond.do?servertypeid='+_servertypeid,
						valueField: 'servertypeid',
						textField: 'servertypename',
					});
				}
				
			});
		</script>
  </body>
</html>
