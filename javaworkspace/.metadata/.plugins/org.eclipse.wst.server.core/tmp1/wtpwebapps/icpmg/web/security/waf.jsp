<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
/* select{
	width:10.5%;
	height:30px;
} */
.sptx{
	display:inline-block;
	width:120px;
} 
.FieldInput3 {
	width:12%;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-top: 0px !important;
	border: #BCD2EE 1px solid !important;
}
.FieldLabel3 {
	width:8%;
	height: 30px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align:left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-top: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>	
<script type="text/javascript">
var flagck = 0;  //  初始化为0
var grid;
var waftoolbar = [
						{
							text:'新增防护配置',
							iconCls:'icon-add',
							handler:addInit
						}
                       ];
$(document).ready(function() {
	loadWafGrid();
});
//查询结果
function loadWafGrid(){
	grid = $('#waf_grid').datagrid({
		singleSelect:true,
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar:waftoolbar,    
	    url:'${pageContext.request.contextPath}/security/queryWafList.do',
	    queryParams:{httpname:$('#tabs_security_ipsid').val()+'_http'},
	    onLoadSuccess : function(data) {
			var pageopt = $('#waf_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#waf_grid').datagrid("getRows").length;
			var total = pageopt.total; //显示的查询的总数
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {neid : ''});
				}
				 $('#waf_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
									    		total: total,
				});
				
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			 //设置不显示复选框
								      var rows = data.rows;
								      if (rows.length) {
											 $.each(rows, function (idx, val) {
												if   (val.neid ==''){ 
													//addid为datagrid上一层的div id
													$('#addid  input:checkbox').eq(idx+1).css("display","none");
													 
												}
											}); 
								      }
		}
	 }); 
}
/* function reset(){
	$('#waf_grid').datagrid('load',{});
} */
function fwoptionformater(value, row, index) {
	var str=""; 
	if(row.wafstat=='0'){
		str = "<a href=\"javascript:void(0);\" onclick=\"wafOn(\'" + row.neid + "\', \'" + row.securityid + "\', \'"+ row.httpname + "\', \'"+ row.wafstat + "\');\">启用</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"showEditWaf(\'" + row.neid + "\', \'" + row.httpname + "\');\">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"delbefore(\'" + row.neid + "\', \'" + row.securityid + "\', \'"+ row.httpname + "\');\">删除</a>"; 
	}else if(row.wafstat=='1'){
		str = "<a href=\"javascript:void(0);\" onclick=\"wafOn(\'" + row.neid + "\', \'" + row.securityid + "\', \'"+ row.httpname + "\', \'"+ row.wafstat +"\');\">停用</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"showEditWaf(\'" + row.neid + "\', \'" + row.httpname + "\');\">修改</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"delbefore(\'" + row.neid + "\', \'" + row.securityid + "\', \'"+ row.httpname + "\');\">删除</a>"; 
	}
	return str;
} 
function onoffstatus(value, row, index) {
	if(value=='1')
		return "开启";
	else if(value=='0')
		return "关闭";
}

function wafOn(neid,securityid,httpname,wafstat){
	$.ajax({
		url:"${pageContext.request.contextPath}/security/wafOnOff.do",
		type:"post",
		async:false,
		data:{
			neid:neid,
			securityid:securityid,
			httpname:httpname,
			wafstat:wafstat
			},
		dataType:"json",
		success:function(data){
		  	if (data.success){    
	        	$.messager.alert('提示信息',data.msg, 'info');
	        } else{
	        	$.messager.alert('提示信息',data.msg, 'error'); 
	        }
        	loadWafGrid();
		}
	});
}
function delbefore(neid,securityid,httpname){
	$.messager.confirm('系统提示信息', '当前配置删除后不可恢复，请谨慎操作，确定删除吗？', function(r){
		if (r){
			$('#wafManForm').form('submit',{
			    url:'${pageContext.request.contextPath}/security/wafDelete.do', 
			    onSubmit : function(param) {
			    	param.neid=neid;
			    	param.securityid = securityid; 
			    	param.httpname=httpname;
			    //	param.serviceid = $("#tabs_service_id").val();
			    //	param.displayname = $("#tabs_displayname").val();
			   //	param.manip = $("#tabs_manip").val(); 
				//	param.ipsid=ipsid;
				},
			    success:function(restr){
					var data = eval('(' + restr + ')'); 
			        if (data.success){    
			        	$.messager.alert('提示信息',data.msg, 'info');
			        } else{
			        	$.messager.alert('提示信息',data.msg, 'error'); 
			        }
			        loadWafGrid();
			    }
			});
		}
	});
}
function addInit(){ 
	$('#waf_add_win').window('open');
	$('#waf_add_form').form('clear');
	$('#optype').val("add");
	$('#nename').textbox('readonly',false);
	$('#wafstat').val("1");
	$('#shieldtvxss').textbox('setValue',"60");
	$('#shieldtvsql').textbox('setValue',"60");
	$('#reqtvcc').textbox('setValue',"2000");
	$('#acsltvcc').textbox('setValue',"0");
	$('#agsltvcc').textbox('setValue',"0");
	$('#acsllengthcc').textbox('setValue',"60");
	$('#agsllengthcc').textbox('setValue',"60");
	$("[name='siaction'][value=0]").attr("checked", "checked");
	$("[name='shieldtsql'][value=0]").attr("checked", "checked");
	$("[name='sensitivitysql'][value=0]").attr("checked", "checked");
	$("[name='xiaction'][value=0]").attr("checked", "checked");
	$("[name='shieldtxss'][value=0]").attr("checked", "checked");
	$("[name='sensitivityxss'][value=0]").attr("checked", "checked");
	$("[name='ocaction'][value=0]").attr("checked", "checked");
	$("[name='acaction'][value=0]").attr("checked", "checked");
	$("[name='amethodcc'][value=0]").attr("checked", "checked");
	$("[name='acslactioncc'][value=1]").attr("checked", "checked");
	$("[name='agslactioncc'][value=1]").attr("checked", "checked");
	$('#sqlinject_').hide();
	$('#shieldsql_').hide();
	$('#xssinject_').hide();
	$('#shieldxss_').hide();
	$('#ochainchk_').hide();
	$('#acontrol_').hide();
	$('#ccdefend_').hide();
	$('#acslimitcc_').hide();
	$('#agslimitcc_').hide();
}
function showEditWaf(neid,httpname){
	$('#waf_add_form').form('clear');
	$.ajax({   
		url:'${pageContext.request.contextPath}/security/queryWaf.do',
	    type:'post',  
	    async: false,
	    data: {neid: neid, securityid: $("#tabs_security_id").val(),httpname:httpname},    
	    dataType:'json',  
	    success:function(data){ 
	    	$('#optype').val("edit");
	    	$('#waf_add_win').panel({title:"修改防护配置"});
	    	$('#nename').textbox('readonly').textbox('setValue', data.neid);//名称只读
	    	//if(data.domainnames!='null'){
	    		$('#domainnames').textbox('setValue', data.domainnames);
	    	//}	
	    	$('#wafstat').val(data.wafstat);
	    
	    	if(data.sqlinject=='1'){//sql注入检查功能
	    		$("[name='sqlinject']").attr("checked",true);
	    		$('#sqlinject_').show();
	    	}else if(data.sqlinject=='0'){
	    		$("[name='sqlinject']").attr("checked",false);
				$('#sqlinject_').hide();		
	    	}
	   		$("[name='siaction'][value="+data.siaction+"]").attr("checked", "checked");	
	   		if(data.shieldsql=='1'){
	    		$("[name='shieldsql']").attr("checked",true);
	    		$("#shieldsql_").show();
	    	}else if(data.shieldsql=='0'){
	    		$("[name='shieldsql']").attr("checked",false);
    			$("#shieldsql_").hide();
	    	}
	   		$("[name='shieldtsql'][value="+data.shieldtsql+"]").attr("checked", "checked");
	    	$('#shieldtvsql').textbox('setValue', data.shieldtvsql);
	   		$("[name='sensitivitysql'][value="+data.sensitivitysql+"]").attr("checked", "checked");
	   		var chkpsql_array=data.chkpsql.split(",");
	   		for(var i=0;i<chkpsql_array.length;i++){
	   			if(chkpsql_array[i]=='1'){
	   			$("#chkpsql"+i).attr("checked", "checked");
	   		//	$("[name='chkpsql'][value="+chkpsql_array[i]+"]").attr("checked", "checked");
	   			}
	   		}
	   		
	   		if(data.xssinject=='1'){//xss注入检查功能
	    		$("[name='xssinject']").attr("checked",true);
				$('#xssinject_').show();	    		
	    	}else if(data.xssinject=='0'){
	    		$("[name='xssinject']").attr("checked",false);
	    		$('#xssinject_').hide();
	    	}
	   		$("[name='xiaction'][value="+data.xiaction+"]").attr("checked", "checked");	
	   		if(data.shieldxss=='1'){
	    		$("[name='shieldxss']").attr("checked",true);
	    		$("#shieldxss_").show();
	    	}else if(data.shieldxss=='0'){
	    		$("[name='shieldxss']").attr("checked",false);
    			$("#shieldxss_").hide();
	    	}
	   		$("[name='shieldtxss'][value="+data.shieldtxss+"]").attr("checked", "checked");
	    	$('#shieldtvxss').textbox('setValue', data.shieldtvxss);
	   		$("[name='sensitivityxss'][value="+data.sensitivityxss+"]").attr("checked", "checked");
	   		var chkpxss_array=data.chkpxss.split(",");
	   		for(var i=0;i<chkpxss_array.length;i++){
	   			if(chkpxss_array[i]=='1'){
	   			$("#chkpxss"+i).attr("checked", "checked");
	   			}
	   		}
	   		if(data.ochainchk=='1'){//外链检查
	    		$("[name='ochainchk']").attr("checked",true);
	    		$('#ochainchk_').show();
	    	}else if(data.ochainchk=='0'){
	    		$("[name='ochainchk']").attr("checked",false);
	    		$('#ochainchk_').hide();
	    	}
	    	$('#ochainchkurl').textbox('setValue', data.ochainchkurl);
	    	$("[name='ocaction'][value="+data.ocaction+"]").attr("checked", "checked");	
	   		     
	   		if(data.acontrol=='1'){//外链检查
	    		$("[name='acontrol']").attr("checked",true);
		    	var acontrolpath = data.acontrolpath.replaceAll("1;","").replaceAll("2;","");
		    	acontrolpath = acontrolpath.substring(0,acontrolpath.length-1);
		    	$('#acontrolpath').textbox('setValue',acontrolpath);
		    	$("#acpath").val(data.acontrolpath);
		    	$('#acontrol_').show();
	    	}else if(data.acontrol=='0'){
	    		$("[name='acontrol']").attr("checked",false);
	    		$('#acontrol_').hide();
	    	} 	
	    	
	    	
	    	
	    	$("[name='acaction'][value="+data.acaction+"]").attr("checked", "checked");	
	    	  
	    	if(data.ccdefend=='1'){//CC防护
	    		$("[name='ccdefend']").attr("checked",true);
	    		$("#ccdefend_").show();
	    	}else if(data.ccdefend=='0'){
	    		$("[name='ccdefend']").attr("checked",false);
	    		$("#ccdefend_").hide();
	    	} 	
	    	$('#reqtvcc').textbox('setValue', data.reqtvcc);
	    	$("[name='amethodcc'][value="+data.amethodcc+"]").attr("checked", "checked");	
	    	if(data.crawlerfcc=='1'){//爬虫友好
	    		$("[name='crawlerfcc']").attr("checked",true);
	    	}else if(data.crawlerfcc=='0'){
	    		$("[name='crawlerfcc']").attr("checked",false);
	    	}
	    	  
	    	if(data.acslimitcc=='1'){//代理限速
	    		$("[name='acslimitcc']").attr("checked",true);
	    		$("#acslimitcc_").show();
	    	}else if(data.acslimitcc=='0'){
	    		$("[name='acslimitcc']").attr("checked",false);
	    		$("#acslimitcc_").hide();
	    	}
	    	$('#acsltvcc').textbox('setValue', data.acsltvcc);
	    	$("[name='acslactioncc'][value="+data.acslactioncc+"]").attr("checked", "checked");	
	    	$('#acsllengthcc').textbox('setValue', data.acsllengthcc);
	    	if(data.acsllogcc=='1'){
	    		$("[name='acsllogcc']").attr("checked",true);
	    	}else if(data.acsllogcc=='0'){
	    		$("[name='acsllogcc']").attr("checked",false);
	    	}
	    	if(data.agslimitcc=='1'){//访问限速
	    		$("[name='agslimitcc']").attr("checked",true);
	    		$("#agslimitcc_").show();
	    	}else if(data.agslimitcc=='0'){
	    		$("[name='agslimitcc']").attr("checked",false);
	    		$("#agslimitcc_").hide();
	    	}
	    	$('#agsltvcc').textbox('setValue', data.agsltvcc);
	    	$("[name='agslactioncc'][value="+data.agslactioncc+"]").attr("checked", "checked");	
	    	$('#agsllengthcc').textbox('setValue', data.agsllengthcc);
	    	if(data.agsllogcc=='1'){
	    		$("[name='agsllogcc']").attr("checked",true);
	    	}else if(data.agsllogcc=='0'){
	    		$("[name='agsllogcc']").attr("checked",false);
	    	}
	    }
	});
	$('#waf_add_win').window('open');
}

</script>
<form id="wafManForm"></form>
<div data-options="region:'center',border:false">
	<div data-options="region:'center',border:false" id="addid">
	<table title="" style="width:100%;"  id="waf_grid">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'nename',width:10,align:'center'">资源名称</th>
				<th data-options="field:'wafstat',width:10,align:'center',formatter:onoffstatus">规则状态</th>
				<th data-options="field:'domainnames',width:10,align:'center'">域名</th>
				<th data-options="field:'sqlinject',width:10,align:'center',formatter:onoffstatus">SQL注入检查</th>
				<th data-options="field:'xssinject',width:10,align:'center',formatter:onoffstatus">XSS注入检查</th>
				<th data-options="field:'ochainchk',width:10,align:'center',formatter:onoffstatus">外链检查</th>
				<th data-options="field:'acontrol',width:10,align:'center',formatter:onoffstatus">访问控制</th>
				<th data-options="field:'ccdefend',width:10,align:'center',formatter:onoffstatus">CC防护</th>
				<th data-options="field:'neid',width:10,align:'center',formatter:fwoptionformater">操作</th>
			</tr>
		</thead>
	</table>
	</div>
</div>
<div id="waf_add_win" class="easyui-window" title="新增防护配置" data-options="closed:true,minimizable:false,maximizable:false,closable:true,collapsible:false,iconCls:'icon-save'" style="width:700px;height:600px;padding:5px;top:127px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="waf_add_form" method="post" data-options="novalidate:true">
			<input type="hidden" id="optype" value="add"/>
				<span id="msg"></span>
				<div style="margin-top:5px;"><!--<label style="width:150px;">Web服务器名称：</label>  -->
					<span class="sptx">Web服务器名称:</span><input id="nename" class="easyui-textbox" style="width:150px;height:22px;"/>&nbsp;(1-31)字符
				</div>
				<div style="margin-top:5px;">
					<span class="sptx">域&nbsp;&nbsp;名:</span><input id="domainnames" class="easyui-textbox" style="width:150px;height:22px;"/>&nbsp;多个用逗号隔开
				</div>
				<input type="hidden" id="wafstat" name="wafstat"><!--策略是否使用-->
				<div style="margin-top:5px;">
					<span class="sptx">SQL注入检查</span><span>启用:</span><input type="checkbox" style="width:20px;line-height:20px;" id="sqlinject" name="sqlinject" />
				</div>
				<div id="sqlinject_">
					<div style="margin-top:5px;">
					<span class="sptx"></span><span style="display:inline-block;width: 76px;">行为：</span>
						<label><input type="radio" style="width:20px;line-height:20px;" name="siaction" value="0" checked/>只记录日志</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" name="siaction" value="1"/>重置</label>
				</div>
				<div style="margin-top:5px;">
					<span class="sptx"></span><span style="display:inline-block;width: 84px;">屏蔽攻击者：</span><span>启用</span><input type="checkbox" style="width:20px;line-height:20px;" id="shieldsql" name="shieldsql" />
				</div>
				<div id="shieldsql_" style="margin-top:5px;margin-left:120px;">
					<p style="margin-left:79px;">
						<label><input type="radio" style="width:20px;line-height:20px;" name="shieldtsql" value="0" checked/>阻断IP：</label>
						<label><input type="radio" style="width:20px;line-height:20px;" name="shieldtsql" value="1"/>阻断服务：</label>
						<input id="shieldtvsql" class="easyui-numberbox" style="width:70px;height:22px;"/>&nbsp;(60-3600)秒
					</p>
				</div>	
				<div style="margin-top:5px;">
					<p style="margin-left:120px;">
						<span style="display:inline-block;width: 76px;">敏感度：</span>
						<label><input type="radio" style="width:20px;line-height:20px;" id="" name="sensitivitysql" value="0" checked/>低</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="sensitivitysql" value="1"/>中</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="sensitivitysql" value="2"/>高</label>
					</p>
				</div>	
				<div style="margin-top:5px;">
					<p style="margin-left:120px;">
						<span style="display:inline-block;width: 76px;">检查点：</span>
						<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpsql0" name="chkpsql0" />URI</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpsql1" name="chkpsql1" />Cookie</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpsql2" name="chkpsql2" />Cookie2</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpsql3" name="chkpsql3" />Referer</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpsql4" name="chkpsql4" />Post</label>
					</p>
				</div>	
				</div>
				
				<div style="margin-top:5px;">
					<span class="sptx">XSS注入检查</span><span>启用:</span><input type="checkbox" style="width:20px;line-height:20px;" id="xssinject" name="xssinject"/>
				</div>
				<div id="xssinject_">
				<div style="margin-top:5px;">
					<span class="sptx"></span><span style="display:inline-block;width: 76px;">操作：</span>
						<label><input type="radio" style="width:20px;line-height:20px;" name="xiaction" value="0" checked/>只记录日志</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" name="xiaction" value="1"/>重置</label>
				</div>
				<div style="margin-top:5px;">
					<span class="sptx"></span><span style="display:inline-block;width: 84px;">屏蔽攻击者：</span><span>启用</span><input type="checkbox" style="width:20px;line-height:20px;" id="shieldxss" name="shieldxss" />
				</div>
				<div id="shieldxss_" style="margin-top:5px;margin-left:120px;" >
					<p style="margin-left:79px;">
						<label><input type="radio" style="width:20px;line-height:20px;" name="shieldtxss" value="0" checked/>阻断IP：</label>
						<label><input type="radio" style="width:20px;line-height:20px;" name="shieldtxss" value="1"/>阻断服务：</label>
						<input id="shieldtvxss" class="easyui-numberbox" style="width:70px;height:22px;"/>&nbsp;(60-3600)秒
					</p>
				</div>	
				<div style="margin-top:5px;">
					<p style="margin-left:120px;">
						<span style="display:inline-block;width: 76px;">敏感度：</span>
						<label><input type="radio" style="width:20px;line-height:20px;" id="" name="sensitivityxss" value="0" checked/>低</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="sensitivityxss" value="1"/>中</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="sensitivityxss" value="2"/>高</label>
					</p>
				</div>	
				<div style="margin-top:5px;">
					<p style="margin-left:120px;">
						<span style="display:inline-block;width: 76px;">检查点：</span>
						<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpxss0" name="chkpxss0" />URI</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpxss1" name="chkpxss1" />Cookie</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpxss2" name="chkpxss2" />Cookie2</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpxss3" name="chkpxss3" />Referer</label>
						&nbsp;<label><input type="checkbox" style="width:20px;line-height:20px;" id="chkpxss4" name="chkpxss4" />Post</label>
					</p>
				</div>	
				</div>
				<div style="margin-top:5px;">
					<span class="sptx">外链检查</span><span>启用:</span><input type="checkbox" style="width:20px;line-height:20px;" id="ochainchk" name="ochainchk"/>
				</div>
				<div id="ochainchk_" style="margin-top:5px;">
					<span class="sptx"></span><span style="display:inline-block;width: 84px;">外链特性：</span><input class="easyui-textbox" id="ochainchkurl" name="ochainchkurl"  data-options="editable:false"/>
					<a class="easyui-linkbutton" href="javascript:void(0)" onclick="chooseochainchk('add', 's');" style="width:50px">选择</a>
					<p style="margin-left:120px;"><span style="display:inline-block;width: 76px;">行为：</span>
						<label><input type="radio" style="width:20px;line-height:20px;margin-top:5px;" id="" name="ocaction" value="0" checked/>只记录日志</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="ocaction" value="1"/>重置</label>
					</p>
				</div>	
				<div style="margin-top:5px;">
					<span class="sptx">访问控制</span><span>启用:</span><input type="checkbox" style="width:20px;line-height:20px;" id="acontrol" name="acontrol"/>
				</div>
				<div style="margin-top:5px;" id="acontrol_">
					<span class="sptx"></span><span style="display:inline-block;width: 84px;">访问控制路径：</span>
					<input type="hidden" id="acpath" name="acpath"/><input class="easyui-textbox" id="acontrolpath" name="acontrolpath"  data-options="editable:false"/>
					<a class="easyui-linkbutton" href="javascript:void(0)" onclick="chooseacontrol('add', 's');" style="width:50px">选择</a>
					<p style="margin-left:120px;"><span style="display:inline-block;width: 76px;">行为：</span>
						<input type="radio" style="width:20px;line-height:20px;margin-top: 5px;" id="" name="acaction" value="0" checked/>只记录日志
						&nbsp;<input type="radio" style="width:20px;line-height:20px;" id="" name="acaction" value="1"/>重置
					</p>
				</div>
				<div style="margin-top:5px;">
					<span class="sptx">CC防护</span><span>启用:</span><input type="checkbox" style="width:20px;line-height:20px;" id="ccdefend" name="ccdefend" value="0"/>
				</div>
				<div style="margin-top:5px;" id="ccdefend_" >
					<p style="margin-left:120px;">
						请求阈值：<input id="reqtvcc" class="easyui-numberbox" style="width:70px;height:22px;"/>&nbsp;(0-1000000)rps
					</p>
				</div>
				<div style="margin-top:5px;">
					<p style="margin-left:120px;">
						<span style="display:inline-block;width: 76px;">认证方法：</span>
						<label><input type="radio" style="width:20px;line-height:20px;" id="" name="amethodcc" value="0" checked/>自动(JS Cookie)</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="amethodcc" value="1"/>自动(重定向)</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="amethodcc" value="2"/>手动(访问确认)</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="amethodcc" value="3"/>手动(验证码)</label>
					</p>
				</div>
				<div style="margin-top:5px;"> 
					<p style="margin-left:120px;"><span style="display:inline-block;width: 84px;">爬虫友好：</span>启用<input type="checkbox" style="width:20px;line-height:20px;" id="crawlerfcc" name="crawlerfcc" /></p>
				</div>
				<div style="margin-top:5px;">
					<p style="margin-left:120px;"><span style="display:inline-block;width: 84px;">访问限速：</span>启用<input type="checkbox" style="width:20px;line-height:20px;" id="acslimitcc" name="acslimitcc" /></p>
				</div>
				<div style="margin-top:5px;" id="acslimitcc_" > 
					<p style="margin-left:203px;">
						阈值：<input id="acsltvcc" class="easyui-numberbox" value="0" style="width:70px;height:22px;"/>&nbsp;(0-1000000)rps
					</p>
					<p style="margin-left:203px;">
						行为：
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="acslactioncc" value="1"/>阻断IP</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="acslactioncc" value="0" checked/>重置</label>
					</p>
					<p style="margin-left:203px;">
						<span>时长：<input class="easyui-numberbox" id="acsllengthcc" style="width:70px;height:22px;"/>&nbsp;(60-3600)秒</span>
					</p>
					<p style="margin-left:203px;">
						记录日志：&nbsp;<input type="checkbox" style="width:20px;line-height:20px;" id="acsllogcc" name="acsllogcc" />
					</p>
				</div>
				<div style="margin-top:5px;">
					<p style="margin-left:120px;"><span style="display:inline-block;width: 84px;">代理限速：</span>启用<input type="checkbox" style="width:20px;line-height:20px;" id="agslimitcc" name="agslimitcc" value="0"/></p>
				</div>
				<div style="margin-top:5px;" id="agslimitcc_" >
					<p style="margin-left:203px;">
						阈值：<input id="agsltvcc" class="easyui-numberbox" style="width:70px;height:22px;"/>&nbsp;(0-1000000)rps
					</p>
					<p style="margin-left:203px;">
						行为：
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="agslactioncc" value="1"/>阻断IP</label>
						&nbsp;<label><input type="radio" style="width:20px;line-height:20px;" id="" name="agslactioncc" value="0" checked/>重置</label>
					</p>
					<p style="margin-left:203px;">
						<span>时长：<input class="easyui-numberbox" id="agsllengthcc" style="width:70px;height:22px;"/>&nbsp;(60-3600)秒</span>
					</p>
					<p style="margin-left:203px;">
						记录日志：&nbsp;<input type="checkbox" style="width:20px;line-height:20px;" id="agsllogcc" name="agsllogcc"/>
					</p>
				</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="addwaf();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="cancelWaf()" style="width:80px">取消</a>
		</div>
	</div>
</div>
<div id="acontrolConfig" class="easyui-window" title="访问控制设置" data-options="closed:true,minimizable:false,maximizable:false,closable:true,collapsible:false,iconCls:'icon-save'" style="width:500px;height:300px;padding:5px;top:157px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="acontrolForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="oper_acontrol"/>
			<input type="hidden" id="type_acontrol"/>
			<div style="margin-bottom:5px;">
				<div style="float:left;">属性：
					<select id="acontrolcontype" class="easyui-combobox"  data-options="panelHeight:'auto',width:60,editable:false,onSelect: 
						function(r){
							for(var i=1; i<3; i++){
								document.getElementById('type' + i).style.display='none';
								}
							document.getElementById('type' + r.value).style.display=''; 
				    	}">
						<option value="1">静态</option>
						<option value="2">禁止</option>
					</select>
				</div>
				<div id="type1" >
					<span style="display:inline-block;width: 280px;padding-left: 20px;">
					路径：&nbsp;<input id="1type" class="easyui-textbox" style="width:160px;height:22px;"/>
					&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addacontrol('1', '静态');" style="width:50px">添加</a>
					</span>
				</div>
				<div id="type2" style="display:none;">
				<span style="display:inline-block;width: 280px;padding-left: 20px;">
					路径：&nbsp;<input id="2type" class="easyui-textbox" style="width:160px;height:22px;"/>
					&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addacontrol('2', '禁止');" style="width:50px">添加</a>
					</span>
				</div>
			</div>
			<div style="height:160px;overflow-y:scroll;margin-top:5px;clear:both;">
				<table id="data_acontrol" style="width:100%">  
					<tbody id="tbody_acontrol">
						<tr>
							<td class="FieldLabel3" style="display:none;"></td>
							<td class="FieldLabel3" style="width:5%;">属性</td>
							<td class="FieldLabel3" style="width:15%;">路径</td>
							<td class="FieldLabel3" style="width:5%;">操作</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" id="tj_acontrol" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#acontrolConfig').window('close');$('#acontrolForm').form('clear');" style="width:80px">取消</a>
		</div>
	</div>
</div>

<div id="ochainchkConfig" class="easyui-window" title="外链特性设置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:500px;height:300px;padding:5px;top:157px;">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="ochainchkForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="oper_ochainchk"/>
			<input type="hidden" id="type_ochainchk"/>
			<div style="margin-bottom:5px;">
				<div id="type0" >
					url：&nbsp;&nbsp;<span style="display:inline-block;width: 240px;"><input id="0type" class="easyui-textbox" style="width:230px;height:22px;"/></span>
					&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addochainchk('0', 'url');" style="width:50px">添加</a>
				</div>
			</div>
			<div style="height:160px;overflow-y:scroll;margin-top:5px;clear:both;">
				<table id="data_ochainchk" style="width:100%">  
					<tbody id="tbody_ochainchk">
						<tr>
							<td class="FieldLabel3" style="display:none;"></td>
							<td class="FieldLabel3" style="width:15%;">url</td>
							<td class="FieldLabel3" style="width:5%;">操作</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" id="tj_ochainchk" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#ochainchkConfig').window('close');$('#ochainchkForm').form('clear');" style="width:80px">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
function addwaf(){
	var nename =$("#nename").textbox("getValue");
	if(null == nename || "" == nename || nename.length>31 || nename.length<1){
		$.messager.alert('提示信息','web服务器名称(1~31)字符！', 'info');
		return;
	}
	var stopsubmit=false;;
	if($('#optype').val()=='add'){
		$.ajax({
			url:"${pageContext.request.contextPath}/security/checkWafName.do",
			type:"post",
			async:false,
			data:{
				neid:nename,
				securityid:$("#tabs_security_id").val(),
				httpname:$('#tabs_security_ipsid').val()+'_http',
				},
			dataType:"json",
			success:function(data){
			  	if (data.success){    
		        	$.messager.alert('提示信息','web服务器名称已存在,请更换','info');
		        	stopsubmit=true;
		        }
			}
		});
	}
	if(stopsubmit){
		return;
	}
	
	var sqlinject=changeValueType($("#sqlinject").is(":checked"));
	var shieldsql=changeValueType($("#shieldsql").is(":checked"));
	var xssinject=changeValueType($("#xssinject").is(":checked"));
	var shieldxss=changeValueType($("#shieldxss").is(":checked"));
	var ochainchk=changeValueType($("#ochainchk").is(":checked"));
	var acontrol=changeValueType($("#acontrol").is(":checked"));
	var ccdefend=changeValueType($("#ccdefend").is(":checked"));
	var crawlerfcc=changeValueType($("#crawlerfcc").is(":checked"));
	var acslimitcc=changeValueType($("#acslimitcc").is(":checked"));
	var acsllogcc=changeValueType($("#acsllogcc").is(":checked"));
	var agslimitcc=changeValueType($("#agslimitcc").is(":checked"));
	var agsllogcc=changeValueType($("#agsllogcc").is(":checked"));
	var chkpsql0 =changeValueType($("#chkpsql0").is(":checked"));
	var chkpsql1 =changeValueType($("#chkpsql1").is(":checked"));
	var chkpsql2 =changeValueType($("#chkpsql2").is(":checked"));
	var chkpsql3 =changeValueType($("#chkpsql3").is(":checked"));
	var chkpsql4 =changeValueType($("#chkpsql4").is(":checked"));
	var chkpsqls =chkpsql0+","+chkpsql1+","+chkpsql2+","+chkpsql3+","+chkpsql4;
	var chkpxss0 =changeValueType($("#chkpxss0").is(":checked"));
	var chkpxss1 =changeValueType($("#chkpxss1").is(":checked"));
	var chkpxss2 =changeValueType($("#chkpxss2").is(":checked"));
	var chkpxss3 =changeValueType($("#chkpxss3").is(":checked"));
	var chkpxss4 =changeValueType($("#chkpxss4").is(":checked"));
	var chkpxsss =chkpxss0+","+chkpxss1+","+chkpxss2+","+chkpxss3+","+chkpxss4;
	
	var shieldtvsql=$("#shieldtvsql").textbox("getValue");
	var shieldtvxss=$("#shieldtvxss").textbox("getValue");
	var reqtvcc=$("#reqtvcc").textbox("getValue");
	var acsltvcc=$("#acsltvcc").textbox("getValue");
	var agsltvcc=$("#agsltvcc").textbox("getValue");
	var acsllengthcc=$("#acsllengthcc").textbox("getValue");
	var agsllengthcc=$("#agsllengthcc").textbox("getValue");
	
	
	if(sqlinject==1 && shieldsql==1){
		if(null == shieldtvsql || "" == shieldtvsql || shieldtvsql>3600 || shieldtvsql<60){
			$.messager.alert('提示信息','SQL注入检查屏蔽攻击(60~3600)秒,', 'info');
			return;
		}
	}
	if(xssinject==1 && shieldxss==1){
		if(null == shieldtvxss || "" == shieldtvxss || shieldtvxss>3600 || shieldtvxss<60){
			$.messager.alert('提示信息','XSS注入检查屏蔽攻击(60~3600)秒', 'info');
			return;
		}
	}
	if(ochainchk==1){
	    var ochainchkurl_=$("#ochainchkurl").textbox("getValue");
		if(ochainchkurl_==null || ochainchkurl_==""){
			$.messager.alert('提示信息','外链特性不可为空！', 'info');
			return;
		}
	}
	if(acontrol==1){
	    var acontrolpath_=$("#acontrolpath").textbox("getValue");
	    if(acontrolpath_==null || acontrolpath_==""){
			$.messager.alert('提示信息','访问控制路径不可为空！', 'info');
			return;
		}
	}
	
	if(ccdefend==1){
		if(null == reqtvcc || "" == reqtvcc || reqtvcc>1000000 || reqtvcc<0){
			$.messager.alert('提示信息','CC防护请求阈值(0-1000000)rps', 'info');
			return;
		}
	}
	if(acslimitcc==1){
		
		if(null == acsltvcc || "" == acsltvcc || acsltvcc>1000000 || acsltvcc<0){
			$.messager.alert('提示信息','访问限速阈值(0-1000000)rps', 'info');
			return;
		}
		
		if(null == acsllengthcc || "" == acsllengthcc || acsllengthcc>3600 || acsllengthcc<60){
			$.messager.alert('提示信息','访问限速时长(60~3600)秒', 'info');
			return;
		}
	}
	if(agslimitcc==1){
		if(null == agsltvcc || "" == agsltvcc || agsltvcc>1000000 || agsltvcc<0){
			$.messager.alert('提示信息','代理限速阈值(0-1000000)rps', 'info');
			return;
		}
		
		if(null == agsllengthcc || "" == agsllengthcc || agsllengthcc>3600 || agsllengthcc<60){
			$.messager.alert('提示信息','代理限速时长(60~3600)秒', 'info');
			return;
		}
	}
	
	$('#waf_add_form').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/wafAdd.do",    
	    onSubmit: function(param){ 
	    	param.neid=$("#nename").textbox("getValue");
	    	param.securityid=$("#tabs_security_id").val();
	    	param.httpname=$("#tabs_security_ipsid").val()+"_http";
	    	param.domainnames=$("#domainnames").textbox("getValue");
	    	param.wafstat=$("#wafstat").val();
	    	param.sqlinject_=sqlinject;
	    	if(sqlinject==1){  
	    		param.siaction_=$("input[name='siaction']:checked").val();
		    	param.shieldsql_=shieldsql;
		    	if(shieldsql==1){
		    		param.shieldtsql_=$("input[name='shieldtsql']:checked").val();
		    		param.shieldtvsql_=shieldtvsql;
		    	}
		    	else{
		    		param.shieldtsql_=0;
		    	}
		    	param.sensitivitysql_=$("input[name='sensitivitysql']:checked").val();
		    	param.chkpsqls_=chkpsqls;
	    	}
	    	else{
	    		param.siaction_=0;
		    	param.shieldsql_=0;
		    	param.shieldtsql_=0;
		    	param.sensitivitysql_=0;
		    	param.chkpsqls_="0,0,0,0,0";
	    	}
	    	param.xssinject_=xssinject;
	    	if(xssinject==1){
	    		param.xiaction_=$("input[name='xiaction']:checked").val();
		    	param.shieldxss_=shieldxss;
		    	if(shieldxss==1){
			    	param.shieldtxss_=$("input[name='shieldtxss']:checked").val();
			    	param.shieldtvxss_=$("#shieldtvxss").textbox("getValue");
			    }
			    else{
			    	param.shieldtxss_=0;
			    }
		    	param.sensitivityxss_=$("input[name='sensitivityxss']:checked").val();
		    	param.chkpxsss_=chkpxsss;
	    	}
	    	else{
	    		param.xiaction_=0;
		    	param.shieldxss_=0;
		    	param.shieldtxss_=0;
		    	param.sensitivityxss_=0;
		    	param.chkpxsss_="0,0,0,0,0";
	    	}
	    	param.ochainchk_=ochainchk;
	    	if(ochainchk==1){
	    		param.ochainchkurl_=$("#ochainchkurl").textbox("getValue");
	    		param.ocaction_=$("input[name='ocaction']:checked").val();
	    	}
	    	else{
	    		param.ocaction_=0;
	    	}
	    	param.acontrol_=acontrol;
	    	if(acontrol==1){
	    		param.acontrolpath_=$("#acpath").val();
	    		param.acaction_=$("input[name='acaction']:checked").val();
	    	}
	    	else{
	    		param.acaction_=0;
	    	}
	    	param.ccdefend_=ccdefend;
	    	if(ccdefend==1){
	    		param.reqtvcc_=$("#reqtvcc").textbox("getValue");
	    	}
	    	param.amethodcc_=$("input[name='amethodcc']:checked").val();
	    	param.crawlerfcc_=crawlerfcc;
	    	param.acslimitcc_=acslimitcc;
	    	if(acslimitcc==1){
	    		param.acsltvcc_=acsltvcc;
	    		param.acslactioncc_=$("input[name='acslactioncc']:checked").val();
		    	param.acsllengthcc_=$("#acsllengthcc").textbox("getValue");
		    	param.acsllogcc_=acsllogcc;
	    	}
	    	else{
	    		param.acsltvcc_=0;
	    		param.acslactioncc_=0;
		    	param.acsllogcc_=0;
	    	}
	    	param.agslimitcc_=agslimitcc;
	    	if(agslimitcc==1){
		    	param.agsltvcc_=agsltvcc;
		    	param.agslactioncc_=$("input[name='agslactioncc']:checked").val();
		    	param.agsllengthcc_=$("#agsllengthcc").textbox("getValue");
		    	param.agsllogcc_=agsllogcc;
	    	}
	    	else{
	    		param.agsltvcc_=0;
		    	param.agslactioncc_=0;
		    	param.agsllogcc_=0;
	    	}
    		param.optype=$('#optype').val();
	    },  
		success: function(restr){
			var data = eval('(' + restr + ')'); 
	        if (data.success){    
	        	$.messager.alert('提示信息',data.msg, 'info');
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
	        $('#waf_add_win').window('close');
	        $('#waf_add_form').form('reset');
	        loadWafGrid();  
	    }    

	});  
	$('#waf_add_win').window('close');
}
function cancelWaf(){
    $('#waf_add_win').window('close');
}
function changeValueType(param){
	if(param)
		return "1";
	else
		return "0";
}
$(function(){
//页面效果：隐现
	$("#sqlinject").click(function(){
	var data =$(this).attr("checked");
		if(data){
			$("#sqlinject_").show();
		}else{
			$("#sqlinject_").hide();
		}
	});
	$("#shieldsql").click(function(){
	var data =$(this).attr("checked");
		if(data){
			$("#shieldsql_").show();
		}else{
			$("#shieldsql_").hide();
		}
	});
	$("#xssinject").click(function(){
		var data =$(this).attr("checked");
		if(data){
			$("#xssinject_").show();
		}else{
			$("#xssinject_").hide();
		}
	});
	$("#shieldxss").click(function(){
		var data =$(this).attr("checked");
		if(data){
			$("#shieldxss_").show();
		}else{
			$("#shieldxss_").hide();
		}
	});
	$("#ochainchk").click(function(){
		var data =$(this).attr("checked");
		if(data){
			$("#ochainchk_").show();
		}else{
			$("#ochainchk_").hide();
		}
	});
	$("#acontrol").click(function(){
		var data =$(this).attr("checked");
		if(data){
			$("#acontrol_").show();
		}else{
			$("#acontrol_").hide();
		}
	});
	$("#ccdefend").click(function(){
		var data =$(this).attr("checked");
		if(data){
			$("#ccdefend_").show();
		}else{
			$("#ccdefend_").hide();
		}
	});
	$("#acslimitcc").click(function(){
		var data =$(this).attr("checked");
		if(data){
			$("#acslimitcc_").show();
		}else{
			$("#acslimitcc_").hide();
		}
	});
	$("#agslimitcc").click(function(){
		var data =$(this).attr("checked");
		if(data){
			$("#agslimitcc_").show();
		}else{
			$("#agslimitcc_").hide();
		}
	});
});
//打开访问路径设置窗口
function chooseacontrol(oper, type){
	$('#acontrolForm').form('clear');
	$("#data_acontrol  tr:not(:first)").remove();
	
	var str = $("#acpath").val();
	var strArr = str.split(";");
	for(var i=0;i<strArr.length-1;i++){
		var sArr = strArr[i].split(",");
		var contypeid = sArr[1];
		var contypename = "";
		if("1" == sArr[1]){
			contypename = "静态";
		}else if("2" == sArr[1]){
			contypename = "禁止";
		}
		var val = sArr[0];
		var trHtml = "<tr class='tr'><td class='FieldInput3' style='display:none;'>" + contypeid + "</td><td class='FieldInput3' style='width:5%;'>" + contypename + "</td><td class='FieldInput3' style='width:15%;'>" + val + "</td><td class='FieldInput3' style='width:5%;'><a style='cursor: pointer;' onclick='delacontrol(this.parentElement.parentElement.rowIndex)'>删除</a></td></tr>";
		var $tr=$("#data_acontrol tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
		$tr.after(trHtml);
	}
	
	
	$('#oper').val(oper);//操作，add/edit
	$('#type').val(type);//地址类型，s/d
	$('#acontrolConfig').window('open');
}

//所有路径回填
$("#tj_acontrol").live("click", function(){
	var addrstr = '';
	var addrstrv = '';
 	$(".tr").each(function(){
		addrstr += $(this).children().eq(2).text() + ",";
		addrstrv += $(this).children().eq(2).text() + "," + $(this).children().eq(0).text() + ";";
	});
 	addrstr = addrstr.substring(0, addrstr.length-1);
	
 	var temp = "";
	if($('#oper_acontrol').val() == 'edit'){
		temp = "1";
 	}
	$("#acpath" + temp).val(addrstrv);  //传数据库
	$("#acontrolpath" + temp).textbox('setValue', addrstr).textbox('setText', addrstr); //显示
	$('#acontrolConfig').window('close');
});


//路径添加
function addacontrol(contypeid, contypename){
	var val = "";
	if('2' == contypeid){
		val = $('#2type').val(); 
	}else if('1' == contypeid){
		val = $('#1type').val(); 
	}
	var patrn=/^\//;   
	if(!patrn.exec(val)){
	    $.messager.alert('提示信息','访问控制路径不符合格式要求(以/开头)', 'info');
		return;
	}
	if(val.length <=1){
		return;
	}
	var trHtml = "<tr class='tr'><td class='FieldInput3' style='display:none;'>" + contypeid + "</td><td class='FieldInput3' style='width:5%;'>" + contypename + "</td><td class='FieldInput3' style='width:15%;'>" + val + "</td><td class='FieldInput3' style='width:5%;'><a style='cursor: pointer;' onclick='delacontrol(this.parentElement.parentElement.rowIndex)'>删除</a></td></tr>";
	var $tr=$("#data_acontrol tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
	$tr.after(trHtml);
}

function delacontrol(rowIndex){
	document.getElementById("data_acontrol").deleteRow(rowIndex); 
}


//打开外链特性设置窗口
function chooseochainchk(oper, type){
	//先清空
	$('#ochainchkForm').form('clear');
	$("#data_ochainchk  tr:not(:first)").remove();
	
	var str = $("#ochainchkurl").val();
	var sArr = str.split(",");
	for(var i=0;i<sArr.length;i++){
		var contypeid = "0";
		var val = sArr[i];
		if(val!=""){
			var trHtml = "<tr class='tr1'><td class='FieldInput3' style='display:none;'>" + contypeid  + "</td><td class='FieldInput3' style='width:15%;'>" + val + "</td><td class='FieldInput3' style='width:5%;'><a style='cursor: pointer;' onclick='delochainchk(this.parentElement.parentElement.rowIndex)'>删除</a></td></tr>";
			var $tr=$("#data_ochainchk tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
			$tr.after(trHtml);
		}
	}
	
	$('#oper').val(oper);//操作，add/edit
	$('#type').val(type);//地址类型，s/d
	$('#ochainchkConfig').window('open');
}
//所有外链回填
$("#tj_ochainchk").live("click", function(){
	var urlstr = '';
 	$(".tr1").each(function(){
		urlstr += $(this).children().eq(1).text() + ",";
	});
 	urlstr = urlstr.substring(0, urlstr.length-1);
	
 	var temp = "";
	if($('#oper_ochainchk').val() == 'edit'){
		temp = "1";
 	}
	$("#ochainchkurl" + temp).textbox('setValue', urlstr).textbox('setText', urlstr);
	$('#ochainchkConfig').window('close');
});


//外链添加
function addochainchk(contypeid, contypename){
	var val = "";
	if('0' == contypeid){
		val = $('#0type').val(); 
	}
	
	var patrn=/^((https|http|ftp)?:\/\/)[^\s]+/;   
	if(!patrn.exec(val)){
		 $.messager.alert('提示信息','外链特性不符合格式要求(http://或https://或ftp://)', 'info');
		 return;
	}

	if(val.length <=1){
		return;
	}
	var trHtml = "<tr class='tr1'><td class='FieldInput3' style='display:none;'>" + contypeid  + "</td><td class='FieldInput3' style='width:15%;'>" + val + "</td><td class='FieldInput3' style='width:5%;'><a style='cursor: pointer;' onclick='delochainchk(this.parentElement.parentElement.rowIndex)'>删除</a></td></tr>";
	var $tr=$("#data_ochainchk tr:last"); //$("#"+tab+" tr").eq(row);   tab 表id    row 行数，如：0->第一行 1->第二行 -2->倒数第二行 -1->最后一行
	$tr.after(trHtml);
}

function delochainchk(rowIndex){
	document.getElementById("data_ochainchk").deleteRow(rowIndex); 
}


</script>
</body>