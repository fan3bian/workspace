<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<style type="text/css">
    .detail-line{
      margin: 10px 25px;
    }
    .tc-table {
       
        margin-bottom: 10px;
    }
    
    .tc-table td {
        padding: 5px 0;
        line-height: 26px;
    }
    
    .input-normol {
        height: 26px;
        line-height: 26px;
        border: 1px solid #ccc;
        border-radius: 3px;
        padding: 0 5px;
    }
    
    .input-normol:focus {
        border-color: #f0a73b
    }
    
    .gxwl li {
        height: 26px;
        line-height: 26px;
        border: 1px solid #ccc;
        border-radius: 3px;
        text-align: center;
        width: 110px;
        display: inline-block;
        cursor: pointer;
    }
    
    .gxwl li.active {
        background: #f8b551;
        color: #fff;
        border-color: #f0a73b;
    }
    
    .c-must {
        color: #f0a73b;
    }
</style>
<html>
	<script type="text/javascript">
		var flagck = 0;  //  初始化为0
		var isdistributed = 1; //是否为分布式交换机  默认1 true
		var poolid = '';
		var platformid = '';
		var ws = null;
		var url = null;
		var transports = [];
		updateUrl('/icpmg/sockjs/echo');
		connect();
		  
		function updateUrl(urlPath) {
			if (urlPath.indexOf('sockjs') != -1) {
				url = urlPath;
			} else {
				if (window.location.protocol == 'http:') {
					url = 'ws://' + window.location.host + urlPath;
				} else {
					url = 'wss://' + window.location.host + urlPath;
				}
			}
		} 
		  
		function connect() {
		    if(window.eventactive){
				 window.eventactive.close();
				 window.eventactive=null;
			}
			if (!url) {
				alert('Select whether to use W3C WebSocket or SockJS');
				return;
			}
			ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
				protocols_whitelist : transports
			}) : new WebSocket(url);
	        window.eventactive = ws;
	        ws.onopen = function() {
	          
			};
			ws.onmessage = function(event) {
			var retr = event.data;
			var data = JSON.parse(retr);
			var info = data.msg;
			if(data.success){
			    $.messager.alert('提示',info,"info");
			}else{
		        $.messager.alert('提示',info,"info");
			}		
		    $('#dg_dhcp').datagrid('load', {});
			};
			ws.onclose = function(event) {

			};
		}
		
		var toolbar = [
		{
			text:'创建',
			iconCls:'icon-add',
			handler:function()
			{
				$('#vlan_start').dialog({
	                closed: false
	            });
				$('#vlan_start').html(windowHtml2);
				$('#poolNameDhcp').combobox({
	                valueField: 'poolid',
	                textField: 'poolname',
	                required: true
	            });
				$('#dvswitchDhcp').combobox({
	                valueField: 'dvswitchid',
	                textField: 'dvswitchname',
	                required: true
	            });
				$('#vlanNameDhcp').combobox({
	                valueField: 'vlanid',
	                textField: 'vlanname',
	                required: true
            	});
				$('#platformnameDhcp').combobox({
	                url: '${ctx}/vmconfig/queryPlatform.do',
	                valueField: 'platformid',
	                textField: 'platformname',
	                required: true,
	                onSelect:function (record){
	                	platformid = record.platformid;	                	
	                	$('#poolNameDhcp').combobox({
	    	                url: '${ctx}/vmconfig/queryResourcePoolVlan.do?platformid='+platformid,
	    	                valueField: 'poolid',
	    	                textField: 'poolname',
	    	                required: true,
	    	                onSelect:function (data){
	    	                	poolid = data.poolid;
	    	                	$('#dvswitchDhcp').combobox({
	    	    	            	url: '${ctx}/vlan/queryDvswitch.do?platformid='+platformid+'&isdistributed='+isdistributed,//分布式交换机列表
	    	    	                valueField: 'dvswitchid',
	    	    	                textField: 'dvswitchname',
	    	    	                required: true,
	    	    	                onSelect:function (retr){
	    	    	                	var dvswitchname = retr.dvswitchname;
	    	    	                	$('#vlanNameDhcp').combobox({
	    	    	                		url: '${ctx}/vlan/queryVlanname.do?dvswitchname='+dvswitchname+'&platformid='+platformid+'&poolid='+poolid+'&isdistributed='+isdistributed,
	    	    	    	                valueField: 'vlanid',
	    	    	    	                textField: 'vlanname',
	    	    	    	                required: true,
	    	    	    	                onSelect:function (retr){
	    	    	    	                	var vlanidTemp = retr.vlanid;
	    	    	    	                	$('#vlanidDhcp').val(vlanidTemp);
	    	    	    	                	//$('#vlanidDhcp').text('readonly',true);
	    	    	    	                }
	    	    	                	});
	    	    	                }
	    	    	               
	    	    	            });
	    	                }
	    	            });
	                }
				});
				$('.j-required').validatebox({
	                required: true
	            }); 
				$('.j-normal').validatebox({
	                required: false
	            });
			}
		},
		{
			text:'模板下载',
			iconCls:'icon-muban',
			handler:function()
			{
				downloadExcel();
	            
			}
		},
		{
			text:'导入',
			iconCls:'icon-daoru',
			handler:function()
			{
				$('#importwindow').window('open');
			}
		}
		];
		$(function(){
			$('#dg_dhcp').datagrid({
				url:'${ctx}/vlan/getVlanLists.do',
				pagination:true,
				pageSize:10,
				pageList:[5,10,20,30,40,50],
				fitColumns:true,
				nowarp:false,
				border:false,
				scrollbarSize:0,
				idField:'vlanid',
				sortOrder:'desc',
				singleSelect:true,
				toolbar:toolbar,
				onLoadSuccess:function(data){
					var pageopt = $('#dg_dhcp').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = $('#dg_dhcp').datagrid("getRows").length;
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							$(this).datagrid('appendRow', {vlanid:''  })
						}
						$('#dg_dhcp').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
					    	total: total,
					     });
					}else{
						//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					}
					//设置不显示复选框
			        var rows = data.rows;
			        if (rows.length) {
						 $.each(rows, function (idx, val) {
							if(val.vlanid==''){ 
								//addid为datagrid上一层的div id
								$('#addid  input:checkbox').eq(idx+1).css("display","none");
								 
							}
						}); 
			        }
				},
				//没数据的行不能被点击选中
				onClickRow: function (rowIndex, rowData) {
					if(rowData.vlanid==''){
						 $('#dg_dhcp').datagrid('unselectRow', rowIndex);
					}else{
						//点击有数据的行  标志位变为0
						flagck=0;
					}
					//判断时候已经有全部选择
					if(flagck ==1){
						$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
					}
				},
				 //点击全选
				onCheckAll: function(rows) {
						//全选时，标志位变为1
						flagck = 1;
						$.each(rows, function (idx, val) {
							if(val.vlanid==''){
								//如果是空行，不能被选中
								$("#dg_dhcp").datagrid('uncheckRow', idx);
								//增加全选复选框被选中
								$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");	
							}
						});
				},
				 //取消全选
				onUncheckAll: function(rows) {
					//取消全选时，标志位变为0
					flagck = 0;
				},
				frozenColumns:[[ 
	    			{field:'ck',checkbox:true} 
	    		]],
	    		columns:[[
	    			{
	    				title:'vlan编码',
	    				field:'vlanid',
	    				width:100,
	    				align:'center',
	    			},
	    			{
	    				title:'vlan名称',
	    				field:'vlanname',
	    				width:100,
	    				align:'center',
	    			},
	    			{
	    				title:'平台名称',
	    				field:'platformname',
	    				width:100,
	    				align:'center',
	    			},
	    			{
	    				title:'子网',
	    				field:'subnetname',
	    				width:100,
	    				align:'center',
	    			},
	    			{
	    				title:'掩码',
	    				field:'subnetmark',
	    				width:100,
	    				align:'center',
	    			},
	    			
	    			{
	    				title:'网关',
	    				field:'gateway',
	    				width:100,
	    				align:'center',
	    			},
	    			{
	    				title:'IP起始地址',
	    				field:'rangestart',
	    				width:100,
	    				align:'center',
	    			},
	    			{
	    				title:'IP结束地址',
	    				field:'rangend',
	    				width:100,
	    				align:'center',
	    			}
	    			
	    		]],
			});
		});
		//查询
		function searchFunc(){
		    $('#dg_dhcp').datagrid('load',icp.serializeObject($('#searchForm')));
		}
		//重置
		function cleanSearchFun(){
			$('#searchForm input').val('');
			$('#vlanname').textbox('clear');
			$('#dg_dhcp').datagrid('load',{});
		}
		//下载模板
		function downloadExcel(){
			var url = '${ctx}/vlan/downloadExcel.do';
			$.ajax({
				type : 'post',
				url : url,
		  		dataType:'text',
		  		async: false,
		  		success:function(result){
		  			url = '${pageContext.request.contextPath}/'+result;
		  		    window.location.href = url;
		  		}
			});
		}
		//信息导入 确定按钮
		function confirmUpload(){
			$('#uploadForm').form('submit',{
				url:'${ctx}/vlan/infoImportVlan.do',
				onSubmit:function(){
					var filetype = $("#uploadForm input[name='filepath']")[0].value;
					var fileTemp = filetype.substring(filetype.lastIndexOf(".")+1);
					var arr = new Array("xls","xlsx");
					var flag = 0;
					if(!filetype){
						$.messager.alert('消息', "请选择要上传的excel文件！","info");
						return false;
					}else{
						for(var i=0;i<arr.length;i++){
							if(arr[i]==fileTemp){
								flag = "1";
							}
						}
						if(flag=="0"){
							$.messager.alert('消息', '请选择正确格式的excel文件！',"info");
							return false;
						}
					}
				},
				success:function(retr){
			    	var _data =  JSON.parse(retr); 
			    	$.messager.alert('消息',_data.msg);  
					if(_data.success){
						$('#importwindow').window('close');
						$('#object_grid').datagrid('reload');
			    	}
			    }
			});	
		}
		$(function() {
			$(document).on('click', '#isdistributedDhcp li', function(event) {
			      
	        	$(this).addClass('active').siblings().removeClass('active');
	            if($(this).index()==0){
	            	isdistributed = 1;
	            }else{
	            	isdistributed = 0;
	            }
	            //数据操作方法
            	$('#dvswitchDhcp').combobox({
	                url: '${ctx}/vlan/queryDvswitch.do?platformid='+platformid+'&isdistributed='+isdistributed,//分布式交换机列表
	                valueField: 'dvswitchid',
	                textField: 'dvswitchname',
	                required: true,
	                onSelect:function (retr){
	                	var dvswitchname = retr.dvswitchname;
	                	$('#vlanNameDhcp').combobox({
	                		url: '${ctx}/vlan/queryVlanname.do?dvswitchname='+dvswitchname+'&platformid='+platformid+'&poolid='+poolid+'&isdistributed='+isdistributed,
	    	                valueField: 'vlanid',
	    	                textField: 'vlanname',
	    	                required: true,
	    	                onSelect:function (retr){
	    	                	var vlanidTemp = retr.vlanid;
	    	                	$('#vlanidDhcp').val(vlanidTemp);
	    	                	//$('#vlanidDhcp').textbox('readonly',true);
	    	                }
	                	});
	                }
	            });
	            
	        });
	        windowHtml2 = $('#vlan_start').html();
	        $('#vlan_start').dialog({
	            title: "网络配置",
	            width: 515,
	            height: 590,
	            closed: true,
	            modal: true,
	            collapsible: false,
	            minimizable: false,
	            maximizable: false,
	            resizable: false,
	            buttons: [{
	                text: '确定',
	                iconCls: 'icon-ok',
	                handler: function() {
	                	//var isshared = $("#isshared").find("li.active").val();
	                	var isdistributed = $("#isdistributedDhcp").find("li.active").val();
	                	if($('#vlanform').form('validate')){
	                		
	                		confirmBtn(isdistributed);
	                	}
	                }
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function() {
	                    $('#vlan_start').dialog('close');
	                }
	            }]
	        });
	    })
	    function confirmBtn(isdistributed){
			var vlanid = $("#vlanidDhcp").val();
			var vlanname = $("#vlanNameDhcp").combobox('getText');
			var subnetname = $("#subnetnameDhcp").val();
			var subnetmark = $("#subnetmarkDhcp").val();
			var gateway = $("#gatewayDhcp").val();
			var rangestart = $("#rangestartDhcp").val();
			var rangend = $("#rangendDhcp").val();
			var poolname = $("#poolNameDhcp").combobox('getValue');
			var platformname = $("#platformnameDhcp").combobox('getValue');
			var dvswitch = $("#dvswitchDhcp").combobox('getValue');
			var dns = $("#dnsDhcp").val();
			var broadcast = $("#broadcastDhcp").val();
			var vRouterIp = $("#vRouterIp").val();
			$.post('${ctx}/vlan/startVlanDhcp.do',{vlanid:vlanid,vlanname:vlanname,subnetname:subnetname,subnetmark:subnetmark,
	  			gateway:gateway,rangestart:rangestart,rangend:rangend,poolname:poolname,vRouterIp:vRouterIp,
	  			platformname:platformname,dvswitch:dvswitch,isdistributed:isdistributed,
	  			dns:dns,broadcast:broadcast},function(){});
            $('#vlan_start').window('close');
		}
	</script>
	<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false" style="background:#eee;height:30px;overflow:hidden;border:false">
			<form method="post" id="searchForm">
				<table>
					<tr>
						<td style="margin-left: 10px">
							vlan名称:<input class="easyui-textbox"  id="vlanname" style="width: 200px;height: 30px; "  name="vlanname">
						</td>
					 
						<td style="float:right">&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="searchFunc()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true" onclick="cleanSearchFun()">重置</a>&nbsp;&nbsp;
						</td>
					</tr>
				</table>
			</form>
		</div>

		<div data-options="region:'center',border:false" style="background:#eee;margin-top: 15px" id="addid">
			<table id="dg_dhcp" style="background:#eee;width:100%;"></table>
		</div>
	</div>
		<!-- 信息导入 弹出框 -->
	<div id="importwindow" class="easyui-window" title="上传文件" data-options="closed:true,modal:true,iconCls:'icon-save',inline:true,modal:true"
		style="width:600px;height:400px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;">
				<form id="uploadForm" method="post" enctype="multipart/form-data">	
					<table align="center" style="width:100%">
						<tr>
							<div class="detail-line"  style="margin: 15px 20px">
							    <span>选择文件：</span>		
							    <input type="file"  style="width:250px;height: 30px"  id="fileurl" name="filepath" />
							    <font color="red">选择一个附件*</font></td>	
							</div>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false"
				style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="confirmBtn" href="javascript:void(0)" 
					onclick="confirmUpload();" style="width:80px">确定</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)"
					onclick="$('#importwindow').window('close');" style="width:80px">关闭</a>
			</div>
		</div>
	</div>
	<div id="vlan_start" >
 		<form action="" id="vlanform">
	        <table width="100%" class="tc-table" >
	            <tbody>
	            	<tr>
	                    <td align="right">平台：</td>
	                    <td align="center">
	                        <input id="platformnameDhcp" name="platformname" style="width: 230px;">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td align="right">资源池：</td>
	                    <td align="center">
	                        <input id="poolNameDhcp" name="poolname" style="width: 230px;">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr id="distribute">
	                    <td align="right">分布式：</td>
	                    <td align="center">
	                        <ul class="gxwl" id="isdistributedDhcp" name="isdistributed">
	                            <li class="active" value="1">是</li>
	                            <li value="0">否</li>
	                        </ul>
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td align="right">交换机名称：</td>
	                    <td align="center">
	                        <input id="dvswitchDhcp" name="dvswitch" style="width: 230px;">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td align="right">网络名称：</td>
	                   <td align="center">
	                        <input id="vlanNameDhcp" name="vlanname" style="width: 230px;" >
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td width="135px" align="right">VlanID：</td>
	                    <td width="250" align="center">
	                        <input id="vlanidDhcp" name="vlanid" type="text" style="width: 220px;" readonly="readonly" class="input-normol">
	                    </td>
	                    <td width="110px"><span class="c-must">*</span></td>
	                </tr>
	                
	                <tr>
	                    <td align="right">子网：</td>
	                    <td align="center">
	                        <input data-options="required:'ture',validType:'ip'" id="subnetnameDhcp" name="subnetname"  type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td align="right">掩码：</td>
	                    <td align="center">
	                        <input data-options="required:'ture',validType:'ip'" id="subnetmarkDhcp" name="subnetmark" type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td align="right">网关：</td>
	                    <td align="center">
	                        <input data-options="required:'ture',validType:'ip'" id="gatewayDhcp" name="gateway" type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td align="right">IP起始段：</td>
	                    <td align="center">
	                        <input data-options="required:'ture',validType:'ip'" id="rangestartDhcp" name="rangestart" type="text" style="width: 97px;" class="input-normol j-required"> -
	                        <input data-options="required:'ture',validType:'ip'" id="rangendDhcp" name="rangend" type="text" style="width: 97px;" class="input-normol j-required">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr>
	                <tr>
	                    <td align="right">vRouterIp：</td>
	                    <td align="center">
	                        <input data-options="required:'ture',validType:'ip'" id="vRouterIp" name="vRouterIp" type="text" style="width: 220px;" class="input-normol j-required">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr> 
	                
	                <!-- <tr>
	                    <td align="right">租户：</td>
	                    <td align="center">
	                        <input id="tenantsDhcp" name="tenants" style="width: 230px;">
	                    </td>
	                    <td><span class="c-must">*</span></td>
	                </tr> -->
	            </tbody>
	        </table>
	        <p style="margin-top: 10px;border-top: 1px solid #ccc; margin-bottom: 10px;"></p>
	        <table width="100%" class="tc-table">
	            <tbody>
	                <tr>
	                    <td width="135px" align="right">DNS：</td>
	                    <td width="250" align="center">
	                        <input data-options="validType:'ip'" id="dnsDhcp" name="dns" type="text" style="width: 220px;" class="input-normol j-normal">
	                    </td>
	                    <td width="110px"></td>
	                </tr>
	                <tr>
	                    <td align="right">广播地址：</td>
	                    <td align="center">
	                        <input id="broadcastDhcp" name="broadcast" type="text" style="width: 220px;" class="input-normol">
	                    </td>
	                    <td></td>
	                </tr>
	            </tbody>
	        </table>
 		</form>
    </div>
</html>
