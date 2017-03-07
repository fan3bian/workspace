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
		<form method="post" id="formApp">
			<input name="objectid" id="objectid" type="hidden">
				
					<fieldset>
						<legend class="info-Legend">基本信息</legend>
						<div style="margin: 10px 25px;width:500px;" >
							<span style="width:300px;">单  位：&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" name="unitname" id="unitname" style="width: 200px ;height: 25px;"">	
							&nbsp;&nbsp;&nbsp;
							<span>项  目：&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" name="projectname" id="projectname" style="width: 170px ;height: 25px;"">
								  
					    </div>
					    <div style="margin: 10px 25px;width:500px;">
							<span>一级分类：</span><input class="easyui-textbox" data-options="validType:'isBlank'" name="servertypenamelevelfirst" id="servertypenamelevelfirst" style="width: 170px ;height: 25px;" >
							&nbsp;&nbsp;&nbsp;
							<span>二级分类：</span><input class="easyui-textbox" data-options="validType:'isBlank'" name="servertypenamesecond" id="servertypenamesecond" style="width: 170px ;height: 25px;" >
							</ 
							<input type="hidden" name="severtypeidlevelfirst" id="severtypeidlevelfirst" >
							<input type="hidden"  name="servertypeidlevelsecond" id="servertypeidlevelsecond" >	  
					    </div>
					    <div style="margin: 10px 25px;width:500px;">
							<span>区 域：&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" data-options="validType:'isBlank'" name="objectname" id="objectname" style="width: 170px ;height: 25px;" type="text" errMsg="所属行业选项不能为空" >
							&nbsp;&nbsp;&nbsp;
							<span>应 用：&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<input class="easyui-textbox" data-options="validType:'isBlank'" name="appname" id="appname" style="width: 170px ;height: 25px;"  >
							 	  
					    </div>
					</fieldset>
					<br>
					<fieldset>
						<legend class="info-Legend">规格配置</legend>
						<div style="margin: 10px 25px;width:500px;" >
							<span>规 格：&nbsp;&nbsp;&nbsp;&nbsp;<input class="easyui-textbox" data-options="validType:'isBlank',multiline:true" name="extension1" id="extension1" style="width: 425px ;height: 130px;"  >
							</span>
					    </div>
					</fieldset>
					<br>
					<fieldset>
						<legend class="info-Legend">实施信息</legend>
						<div style="margin: 10px 25px;width:500px;" >
							<span>实施信息：<input class="easyui-textbox" data-options="validType:'isBlank',multiline:true" name="extension2" id="extension2" style="width: 425px ;height: 130px;"  >
							</span>
					    </div>
					</fieldset>
					
				
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
