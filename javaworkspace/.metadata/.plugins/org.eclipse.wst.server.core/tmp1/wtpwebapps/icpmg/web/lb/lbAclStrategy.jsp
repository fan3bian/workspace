<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
.FieldInput2 {
	width: 75%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}
.FieldLabel2 {
	width: 25%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>	
<script type="text/javascript">
var rulertypetext;
var aclgrid;
var acltoolbar = [{
					text:'新增转发策略',
					iconCls:'icon-add',
					handler:function(){ 
						$('#aclAddForm').form('clear');
						//initCombobox();
						$('#rulertype').combobox('select','0');
						$('#wAddAcl').attr('style','visibility:visible');
						$('#wAddAcl').window('open');
					}
				}
                     ];
$(document).ready(function() {
	loadComboData();
	loadDataGrid();
	});

function loadComboData(){
	$('#rulertype').combobox({ 
		data: [
		       {id: '0', name: '按域名转发'}
		],   
	    valueField:'id',    
	    textField:'name',
	}); 
}
function addLbACLStrategy(){
	
	var aclname = $("#aclname").val();
	if(null == aclname || "" == aclname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var rulertype = $("#rulertype").combobox('getValue');
	if(null == rulertype || "" == rulertype){
		$.messager.alert('提示信息','请选择规则类型！', 'info');
		return;
	}
	var rulercontent = $("#rulercontent").val();
	if(null == rulercontent || "" == rulercontent){
		$.messager.alert('提示信息','请填写规则内容！', 'info');
		return;
	}
	if(checkDomain(rulercontent)){
		$.messager.alert('提示信息','规则内容不符合域名格式要求，请重新输入！', 'info');
		return;
	}
	$('#aclAddForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/saveLbAcl.do', 
	    onSubmit : function(param) {
	    	param.aclname= aclname;
			param.rulertype=rulertype;
			param.rulercontent=rulercontent;
			param.lbid= $("#tabs_lbid").val();
			param.cuserid=$("#cuserid").val();//传LB实例的cuserid  zhanghl 20160829
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.flag) {
				$.messager.alert('提示信息','保存成功！', 'info');
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#wAddAcl').window('close');
	    }
	});
	
} 
function ACLStrategyModify(){
	var aclname = $("#eaclname").textbox('getValue');
	if(null == aclname || "" == aclname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var rulertype = $("#erulertype").combobox('getValue');
	if(null == rulertype || "" == rulertype){
		$.messager.alert('提示信息','请选择规则类型！', 'info');
		return;
	}
	var rulercontent = $("#erulercontent").textbox('getValue');
	if(null == rulercontent || "" == rulercontent){
		$.messager.alert('提示信息','请填写规则内容！', 'info');
		return;
	}
	if(checkDomain(rulercontent)){
		$.messager.alert('提示信息','规则内容不符合域名格式要求，请重新输入！', 'info');
		return;
	}
	var aclid= $('#aclid').val();
	var lbid =$("#elbid").val();
	$('#aclAddForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/LbAclModify.do', 
	    onSubmit : function(param) {
	    	param.aclname= aclname;
			param.rulertype=rulertype;
			param.rulercontent=rulercontent;
			param.lbid=lbid;
			param.aclid=aclid;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.flag) {
				$.messager.alert('提示信息','保存成功！', 'info');
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#wModAcl').window('close');
	    }
	});
	
}	

function checkDomain(domain)
{
	//var patrn=/^[0-9a-zA-Z]+[0-9a-zA-Z\.-]*\.[a-zA-Z]{2,4}$/;
	
	var patrn=/[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?/;
	if (patrn.test(domain)) return false;
	return true;
}

//查询结果
function loadDataGrid(){
	aclgrid = $('#acl_grid').datagrid({
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
		toolbar:acltoolbar,    
	    url:'${pageContext.request.contextPath}/lb/queryLbACL.do?lbid=' + $("#tabs_lbid").val(),
	    onLoadSuccess: function (data) {
		      var pageopt = $('#acl_grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#acl_grid').datagrid("getRows").length;
		      var total = pageopt.total;
		        
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {lbid :''  });
		         }
		         $('#acl_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
		       
		      }else{
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		      var rows = data.rows;
		      if (rows.length) {
					 $.each(rows, function (idx, val) {
						if   (val.lbid ==''){ 
							$('#acl_grid_div input:checkbox').eq(idx+1).css("display","none");
						}
					}); 
		      }
		      for(var i = 0; i < data.rows.length; i++){//增加提示  zhanghl 20160902
		    	  addTooltip('<div>相关后端服务器：' + data.rows[i].servers + '</div>', 'usestat-' + i);
		      }
		      $('.j-edit-forward').linkbutton({
                    iconCls: 'icon-edit',
                   plain: true
              });
              $('.j-delete-forward').linkbutton({
                   iconCls: 'icon-delete',
                   plain: true
              });
              
              $('#wAddAcl').dialog({
		            title: "新增转发策略",
		            width: 500,
		            height: 215,
		            closed: true,
		            modal: true,
		            collapsible: false,
		            minimizable: false,
		            maximizable: false,
		            resizable: false,
		            buttons: [{
		                text: '提交',
		                iconCls: 'icon-ok',
		                handler: function() {
		                    addLbACLStrategy();
		                }
		            }, {
		                text: '取消',
		                iconCls: 'icon-cancel',
		                handler: function() {
		                    $('#wAddAcl').dialog('close');

                }
          	  }]
      		 });
         	$('#wModAcl').dialog({
		            title: "修改转发策略",
		            width: 500,
		            height: 215,
		            closed: true,
		            modal: true,
		            collapsible: false,
		            minimizable: false,
		            maximizable: false,
		            resizable: false,
		            buttons: [{
		                text: '提交',
		                iconCls: 'icon-ok',
		                handler: function() {
		                    ACLStrategyModify();
		                }
		            }, {
		                text: '取消',
		                iconCls: 'icon-cancel',
		                handler: function() {
		                    $('#wModAcl').dialog('close');

                }
            }]
        	});
		 }
	 }); 
}
function reset(){
	$('#acl_grid').datagrid('load',{});
} 

////////使用状态  zhanghl 20160829////////
function addTooltip(tooltipContentStr,tootipId){   
	  $('#'+tootipId).tooltip({  
	     position: 'right',  
	     content: tooltipContentStr,
	    // trackMouse: true,
	     deltaX: -60,
	     onShow: function(){  
	     	$(this).tooltip('tip').css({
	     		backgroundColor: '#ecf5fd',
	      		borderColor: '#bbd2ea'  
			});
	     }     
	  }); 
}

function usestatformatter(value,row,index){
	switch(value){
	case "0":
		return '<span>未使用</span>';
	case "1":
		return '<div id="usestat-' + index + '" style="width:auto;">' + '<span style="color:#2b9af0"">已使用</span>' + '</div>';
	}
}


////////////////

function typeformatter(value, row, index){
	switch (value) {
	case "1":
		return "根据url转发";
	case "0":
		return "根据域名转发";
	}
} 

 function editAcl(aclid,aclname,rulertype,rulercontent,usestat,lbid) {//zhanghl 20160829
	if(usestat == "1"){
		$('#aclStrategyModTip').dialog({
			closed : false
		});
		$('#aclStrategyModTipText').html('此转发策略已被使用，修改会对使用该转发策略的应用产生影响，您确定要对其进行修改吗？');
		$('#aclStrategyModTip').dialog({
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				handler : function() {
					$('#aclStrategyModTip').dialog('close');
					$('#aclModifyForm').form('clear');
					$('#eaclname').textbox('setValue', aclname);//.textbox('setText', aclname);
					$('#erulercontent').textbox('setValue', rulercontent);//.textbox('setText', rulercontent);
					if(rulertype=="0"){
						rulertypetext="根据域名转发";
					}else if(rulertype=="1"){
						rulertypetext="根据url转发";
					}
					$('#erulertype').combobox('setValue', rulertype).textbox('setText', rulertypetext);
					$('#elbid').val(lbid);
					$('#aclid').val(aclid);
					$('#wModAcl').attr('style','visibility:visible');
					$('#wModAcl').window('open');
				}
			},{
				text : '取消',
				iconCls : 'icon-cancel',
				handler : function() {
					$('#aclStrategyModTip').dialog('close');
				}
			}]
		});
	}else{
		$('#aclModifyForm').form('clear');
		$('#eaclname').textbox('setValue', aclname);//.textbox('setText', aclname);
		$('#erulercontent').textbox('setValue', rulercontent);//.textbox('setText', rulercontent);
		if(rulertype=="0"){
			rulertypetext="根据域名转发";
		}else if(rulertype=="1"){
			rulertypetext="根据url转发";
		}
		$('#erulertype').combobox('setValue', rulertype).textbox('setText', rulertypetext);
		$('#elbid').val(lbid);
		$('#aclid').val(aclid);
		$('#wModAcl').attr('style','visibility:visible');
		$('#wModAcl').window('open');
	}
}

function delAcl(aclid,aclname,rulertype,rulercontent,usestat,lbid){//zhanghl 20160829
	if(usestat == "1"){
		$('#aclStrategyDelTip2').dialog({
			closed : false
		});
		$('#aclStrategyDelTip2Text').html('此转发策略已被使用，不允许删除。');
		$('#aclStrategyDelTip2').dialog({
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			buttons : [ {
				text : '知道了',
				iconCls : 'icon-ok',
				handler : function() {
					$('#aclStrategyDelTip2').dialog('close');
				}
			}]
		});
	}else{
		$('#aclStrategyDelTip1').dialog({
			closed : false
		});
		$('#aclStrategyDelTip1Text').html('此转发策略一经删除将不可恢复，您确定要执行此操作吗？');
		$('#aclStrategyDelTip1').dialog({
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				handler : function() {
					$('#aclQueryForm').form('submit',{
					    url:'${pageContext.request.contextPath}/lb/deleteAcl.do', 
					    onSubmit : function(param) {
					    	param.aclid= aclid;
							param.aclname=aclname;
							param.rulertype=rulertype;
							param.rulercontent=rulercontent;
							param.lbid=lbid;
						},
					    success:function(retr){
					    	var _data = $.parseJSON(retr);
					    	if (_data.flag) {
								$.messager.alert('提示信息','删除成功！', 'info');
								loadDataGrid();
							} else {
								$.messager.alert('提示信息','删除发生错误，请重试！', 'error'); 
							}
					    }
					});
					$('#aclStrategyDelTip1').dialog('close');
				}
			},{
				text : '取消',
				iconCls : 'icon-cancel',
				handler : function() {
					$('#aclStrategyDelTip1').dialog('close');
				}
			}]
		});
	}
	
}
 function optionformatter(value, row, index) {
	if(!value){
		return "";
	}
	var str = "<div style=\"height:30px;overflow:hidden;\"><a href=\"javascript:void(0);\" class=\"j-edit-forward\" onclick=\"editAcl(\'" 
		+ row.aclid + "\', \'" 
		+ row.aclname + "\', \'" 
		+ row.rulertype + "\', \'" 
		+ row.rulercontent + "\', \'"
		+ row.usestat + "\', \'"     //zhanghl 20160829
		+ row.lbid + "\');\" title=\"修改\"></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" class=\"j-delete-forward\" onclick=\"delAcl(\'" 
				+ row.aclid + "\', \'" 
				+ row.aclname + "\', \'" 
				+ row.rulertype + "\', \'" 
				+ row.rulercontent + "\', \'"
				+ row.usestat + "\', \'"   //根据使用状态进行提示  zhanghl 20160829
				+ row.lbid +  "\');\" title=\"删除\"></a></div>"; 
	return str;
}  
</script>
<form id="aclQueryForm"></form>
	<div data-options="region:'center',border:false" id="acl_grid_div">
		<table title="" style="width:100%"  id="acl_grid">
			<thead>
				<tr>
					<th data-options="field:'aclid',width:60,align:'center',hidden:'true'">aclid </th>
					<th data-options="field:'aclname',width:60,align:'center'">名称</th>
					<th data-options="field:'rulertype',width:60,align:'center',formatter:typeformatter">规则类型</th>
					<th data-options="field:'rulercontent',width:60,align:'center'">规则内容</th>
					<th data-options="field:'ctime',width:60,align:'center'">创建时间</th> 
					<th data-options="field:'usestat',width:60,align:'center',formatter:usestatformatter">使用状态</th><!-- zhanghl 20160829 -->
					<th data-options="field:'lbid',width:50,align:'center',formatter:optionformatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>  
<!-- ACL策略     -->
    <div id="wAddAcl" class="pop" style="visibility: hidden;">
       <div class="j-tabs-con">
            <div class="item3">
                <div class="item-wrap">
                	<form id="aclAddForm" method="post" data-options="novalidate:true">
                	<input type="hidden" id ="lbid"/>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
                        <tr>
                            <td align="right" width="30%">名称：</td>
                            <td align="left" width="70%">
                                <input id="aclname" type="text" class="easyui-textbox" style="width: 218px;">
                                <span class="must-star">*</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">规则类型：</td>
                            <td align="left" width="70%">
                                <select  id="rulertype" class="easyui-combobox" data-options="editable:false,panelHeight:'auto'" style="width: 218px;">
                                    <option value="">请选择</option>
                                    <option value="">1</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">规则内容：</td>
                            <td align="left" width="70%">
                                <input id="rulercontent" class="easyui-textbox" type="text"  style="width: 218px;">
                                <span class="must-star">*</span>
                            </td>
                        </tr>
                    </table>
                    </form>
                </div>
            </div>
        
        </div>
    </div>
    
     <div id="wModAcl" class="pop" style="visibility: hidden;">
       <div class="j-tabs-con">
            <div class="item3">
                <div class="item-wrap">
                	<form id="aclAddForm" method="post" data-options="novalidate:true">
                	<input type="hidden" id ="elbid"/>
					<input type="hidden" id ="aclid"/>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
                        <tr>
                            <td align="right" width="30%">名称：</td>
                            <td align="left" width="70%">
                                <input id="eaclname" type="text" class="easyui-textbox" style="width: 218px;">
                                <span class="must-star">*</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">规则类型：</td>
                            <td align="left" width="70%">
                                <select  id="erulertype" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',disabled:true" style="width: 218px;">
                                    <option value="">请选择</option>
                                    <option value="">1</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%">规则内容：</td>
                            <td align="left" width="70%">
                                <input id="erulercontent" class="easyui-textbox" type="text"  style="width: 218px;">
                                <span class="must-star">*</span>
                            </td>
                        </tr>
                    </table>
                    </form>
                </div>
            </div>
        
        </div>
    </div>
    <!-- 删除和修改提示碳层  zhanghl 20160829 -->
    <!-- 转发策略已使用，编辑时的提示信息 -->
    <div id="aclStrategyModTip" class="easyui-dialog" data-options=" modal:true,closed: true,title:'提示'" style="padding:20px 20px 30px;width:450px;">
        <p><span class="ywarning"></span><span class="ytip-text" id="aclStrategyModTipText"></span></p>
    </div>
    <!-- 转发策略未使用，删除时的提示信息 -->
    <div id="aclStrategyDelTip1" class="easyui-dialog" data-options=" modal:true,closed: true,title:'提示'" style="padding:20px 20px 30px;width:450px;">
        <p><span class="ywarning"></span><span class="ytip-text" id="aclStrategyDelTip1Text"></span></p>
    </div>
    <!-- 转发策略已使用，删除时的提示信息 -->
    <div id="aclStrategyDelTip2" class="easyui-dialog" data-options=" modal:true,closed: true,title:'提示'" style="padding:20px 20px 30px;width:450px;">
        <p><span class="ywarning"></span><span class="ytip-text" id="aclStrategyDelTip2Text"></span></p>
    </div>
    

</body>
