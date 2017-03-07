<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/icp/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>方案提交</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!--多文件上传引用-->

</head>
<style type="text/css">
 
</style>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 30px 10px 20px;heigt:900px">
		<div data-options="region:'north',border:false" style="background:#eee;height:500px;overflow:hidden;border:0">
		<img alt="top" src="${ctx}/images/upload-shenqing-pic.png" style="margin-top:30px">
            <form action="" method="post" enctype="multipart/form-data" id="filesform">
                <input type="hidden" name="proname" id="proname">
                <input type="hidden" name="department" id="unitname">

                <div id="loadwrapper" style="margin: 60px 360px;">
                    <div class="load-line">
				<span>单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：
                    <input id="unitid" style="width: 340px;height: 30px; " name="unitid" class="easyui-combobox"
                           data-options="">
				</span>
                    </div>
                    <div class="load-line" style="margin-top: 20px">
				<span>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目：
                    <input class="easyui-combobox" data-options="valueField:'proid',textField:'proname'" id="proid"
                           style="width: 340px;height: 30px; " name="proid">
				</span>
                    </div>
                    <div class="load-line" style="margin-top: 20px">
				<span>文档类别：
                    <select class="easyui-combobox" data-options="validType:'isBlank'," id="filetype"
                            style="width: 340px;height: 30px; " name="filetype">

                        <option value="7">资源使用申请</option>
                        <option value="8">资源终止申请</option>
                    </select>
				</span>
                    </div>
                    <div class="load-line" style="margin-top: 20px">
				<span>文档上传：<input type="file" id="fileload" style="width: 340px;height: 30px; " name="fileload">
				</span>
                    </div>
            </form>
            <div style="text-align:center;padding:45px;margin-left: -40px">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" id="submitbtn"  style="width:80px">确定</a>&nbsp;&nbsp;&nbsp;
                <a class="easyui-linkbutton" data-options="iconCls:'icon-redo'" href="javascript:void(0)" onclick="javascript:$('#filesform').form('reset')" style="width:80px">重置</a>
            </div>
		 </div>
	</div>
	
    
      
	 
<script type="text/javascript">

    $(function(){

        var _unitIdLast;
        var _projectIdLast;

        $("#unitid").combobox({
            valueField: 'unitId',
            textField: 'unitName',
            url: '${ctx}/project/getUnits.do',
            onSelect: function(rec){
                var url = '${ctx}/project/getProjects.do';
                $('#proid').combobox({
                    url:url,
                    valueField:'proid',
                    textField:'proname',
                    onBeforeLoad:function(param){
                        param.unitid=rec.unitId
                    },
                    onLoadSuccess: function () { //加载完成后,设置选中第一项
                        var data = $('#proid').combobox('getData');
                        if (data.length > 0) {
                            $('#proid').combobox('select', data[0].proid);
                            if(_projectIdLast){
                                console.log(_projectIdLast);
                                $('#proid').combobox('select',_projectIdLast);//如果是提交附件成功以后，表单reset，然后还是选中上次的项目名称
                            }
                        }
                    }
                });
            },
            onLoadSuccess: function () { //加载完成后,设置选中第一项
                var data = $('#unitid').combobox('getData');
                if (data.length > 0) {
                    $('#unitid').combobox('select', data[0].unitId);
                }
            }
        });


        $("#submitbtn").on("click",fileup);

          function fileup() {

            $("#filesform").form('submit', {
                url: '${ctx}/resourceinfo/resourceApply.do',
                onSubmit: function () {
                    //var fileTypeName =  $("#fileload").textbox('getValue');
                    _projectIdLast = $("#proid").combobox("getValue");
                    _unitIdLast = $("#unitid").combobox("getValue");

                    var value = $("#proid").textbox("getValue");
                    var unitid = $("#unitid").textbox("getValue");
                    if (unitid == "") {
                        $.messager.alert('警告', "请选择单位！", "warning");
                        return false;
                    }
                    if (value == "") {
                        $.messager.alert('警告', "请选择项目！", "warning");
                        return false;
                    }
                    /* if(fileTypeName=="" || fileTypeName==null){

                     $.messager.alert('提示',"文档不能为空","info");
                     return false;
                     } */
                    if (!$("#filesform input[name='fileload']")[0].value) {
                        $.messager.alert('警告', "文档不能为空！", "info");
                        return false;
                    }
                    $('#proname').val($('#proid').combobox('getText'));
                    $('#unitname').val($('#unitid').combobox('getText'));

                },
                success: function (data) {
                    var data = JSON.parse(data);
                    if (data.success) {
                        $.messager.alert('提示', data.msg, "info");
                        //重置表单
                        $('#filesform').form('reset');
                     //   console.log(_projectIdLast+", and unitid is "+_unitIdLast);
                        $("#unitid").combobox('select',_unitIdLast);
                        $("#proid").combobox('select',_projectIdLast);
                    } else {
                        $.messager.alert('提示', data.msg, "info");
                    }
                }
            })
        }

    });



</script>
</body>
</html>
