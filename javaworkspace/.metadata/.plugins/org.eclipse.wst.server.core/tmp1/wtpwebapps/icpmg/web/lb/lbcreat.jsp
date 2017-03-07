<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<style>
.lb_left {
	float: left;
	width: 20%;
	height: 100%;
	background-color: #eee;
}

.lb_left p {
	width: 70px;
	text-align: right;
	line-height: 29px;
	margin-left: 72px;
	margin-top: 31px;
	font-size: 14px;
}

.lb_right {
	width: 80%;
}

.lb_input {
	height: 100%;
	margin-top: 32px;
	padding-left: 190px;
}

.tx {
	width: 300px;
}

.lb_flow {
	width: 100%;
	height: 72px;
	overflow: hidden;
	padding: 0;
	margin: 0;
}
</style>
<script type="text/javascript" 
    src="${pageContext.request.contextPath}/js/validate.js"></script>
<body>
<script type="text/javascript">
$(function(){
	queryUserBscinfo();
});
function queryUserBscinfo(){
	$("#user").combobox({
		url:'${pageContext.request.contextPath}/authMgr/queryUserBscinfo.do',    
	    valueField:'email',    
	    textField:'uname',
	    editable:false,
	    required:true,
	    panelHeight:'auto',
	    onSelect:function(record){
	    	queryNetwork(record.email);
	    }
	});
}
function queryNetwork(email){
	$('#mannetwork').combobox({
		url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=0&email='+email,
	    valueField:'vlanname',    
	    textField:'displayname',
	    onSelect :function(record){
	    	$('#unitid').val(record.userunitid);
	    	/*if('openstack'==record.plattype){
	    		$('#madr_lb').hide();
	    		$('#fadr_lb').hide();
	    		$('#manip').parent().hide();
	    		$('#funip').parent().hide();
	    	}
	    	else{
		    	$('#madr_lb').show();
	    		$('#fadr_lb').show();
	    		$('#manip').parent().show();
	    		$('#funip').parent().show();
	    	}*/
	    }
	});
	$('#funnetwork').combobox({
		url:'${pageContext.request.contextPath}/lb/queryNetwork.do?servicetype=1&email='+email,
	    valueField:'vlanname',    
	    textField:'displayname',
	    onSelect :function(record){
	    	$('#poolid').val(record.poolid);
	    	$('#poolname').val(record.poolname);
	    	$('#platformid').val(record.platformid);
	    }
	});
/* 	$.ajax({
		url:'${pageContext.request.contextPath}/lb/queryNetwork.do',
		type : 'post',
		dataType:'json',
		data:{unitid:unitid},
		success:function(data){
		}
	});  */
}
function lbCreate(){	
	
	$('#lbCreate').linkbutton("disable", true);
	if(!$("#lb_form").form('validate')){
   	 return false;
    }
	//var manip = $('#manip').textbox('getValue');
	//var funip = $('#funip').textbox('getValue');
	var mannetwork = $('#mannetwork').textbox('getText');
	var funnetwork = $('#funnetwork').textbox('getText');
	var user = $('#user').textbox('getValue');
	var displayname= $('#displayname').textbox('getValue');
	var suserid = $("#user").combobox('getValue');
		$('#lb_form').form('submit', {
			url : '${pageContext.request.contextPath}/lb/lbCreate.do',
			onSubmit : function(param) {
				//改由配置文件获取
				//param.regionid = '1001';        
				//param.regionname = '济南';
				//param.description = '应用负载均衡';
				param.typeid='InSLB';
				param.suserid=suserid;
			},
			success : function() {
				$('#lb_win').window('close');
				loadObjectDataGrid();
				$("#lb_detail_text_suserid").text(suserid);
				$("#lb_detail_text_displayname").text(displayname);
				$("#lb_detail_text_manvlan").text(mannetwork);
				//$("#lb_detail_text_manip").text(manip);
				$("#lb_detail_text_funvlan").text(funnetwork);
				//$("#lb_detail_text_funip").text(funip);
				$('#lbServiceOpen_success').window('open');
			}
		}); 
		
	}
</script>
<div id="lb_win" class="easyui-window" title="创建负载均衡" data-options="closed:true,closable:false,minimizable:false,maximizable:false,collapsible:false,resizable:false,modal:true" style="width:808px;height:572px;padding:0px;">
	<div class="lb_flow">
		<img alt="image" src="${pageContext.request.contextPath}/web/lb/image/lb_flow_01.png" />
	</div>
	<div style="width: 100%; height:435px;overflow: hidden;">
	   <div class="lb_left">
	        <p>租&emsp;&emsp;户</p>
	        <p>管理网络</p>
	        <!-- <p id="madr_lb" hidden>管理地址</p> -->
			<p>业务网络</p>
			<!-- <p id="fadr_lb" hidden>业务地址</p> -->
	        <p>名&emsp;&emsp;称</p>
	      	<!-- <p>描&emsp;&emsp;述:</p> -->
	   </div>	
	   <div class="lb_right">
			<form id="lb_form"> 
				<div class="lb_input"><input id="user" class="tx easyui-combobox" data-options="height:28" name="user"/></div>
				<div class="lb_input"><input id="mannetwork" class="tx easyui-combobox" name="mannetwork" data-options="editable:false,required:true,panelHeight:'auto',height:28"/></div>
				<!--<div class="lb_input" hidden><input id="manip" class="tx easyui-textbox" data-options="height:28,validType:'ip',missingMessage:'请输入正确的ip地址'" name="manip"/></div>  -->
				<div class="lb_input"><input id="funnetwork" class="tx easyui-combobox" name="funnetwork" data-options="editable:false,required:true,panelHeight:'auto',height:28"/></div>
				<!--<div class="lb_input" hidden><input id="funip" class="tx easyui-textbox" data-options="height:28,validType:'ip',missingMessage:'请输入正确的ip地址'" name="funip"/></div> -->
				<div class="lb_input"><input id="displayname" class="tx easyui-textbox" data-options="height:28,prompt:'应用负载均衡（必填）',required:true,validType:'length[0,100]',missingMessage:'该输入项不允许为空，最多输入100个字符'" name="displayname"/></div>
				<!-- <div style="margin-top: 26px;padding-left: 190px;"><textarea id="desciption" rows=3 class="easyui-validatebox" data-options="multiline:true" name="funip" style="width:340px;"/></textarea></div> -->
				<input id="poolid" name="poolid" type="hidden"/>
				<input id="poolname" name="poolname" type="hidden"/>
				<input id="platformid" name="platformid" type="hidden"/>
				<input id="platformname" name="poolname" type="hidden"/>
				<input id="unitid" name="unitid" type="hidden"/>
			</form>
		</div>
	</div>
	<div style="text-align:center;background-color:#ccc;height:auto;"><!-- data-options="region:'south'" data-options="iconCls:'icon-ok'"  data-options="iconCls:'icon-cancel'"  -->
		<a href="javascript:void(0)" class="easyui-linkbutton" style="width:80px;height:34px;" data-options="iconCls:'icon-cancel',plain:true" onclick="$('#lb_win').window('close')">取消</a>
		<a href="javascript:void(0)" id="lbCreate" class="easyui-linkbutton"  style="width:80px;height:34px;" data-options="iconCls:'icon-ok',plain:true" onclick="lbCreate()">创建</a>
	</div>
</div>


