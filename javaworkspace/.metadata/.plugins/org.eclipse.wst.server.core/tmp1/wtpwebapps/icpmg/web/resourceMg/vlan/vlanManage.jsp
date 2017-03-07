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
		  
		var applicationWindow = $('#applicationWindow').html();
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
		        return;
			}		
		    $('#dg_vlan').datagrid('load', {});
			};
			ws.onclose = function(event) {

			};
		}
		
		var toolbar = [
		{
			text:'创建',
			iconCls:'icon-add',
			handler:function()
			{   $('#applicationWindow').html(windowHtml2);
				$('#applicationWindow').dialog({
	                closed: false
	            });
				
	         ddglDhcp();
	         
	            $('#dvswitch').combobox({
	                valueField: 'dvswitchid',
	                textField: 'dvswitchname',
	                required: true
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
			text:'删除',
			iconCls:'icon-delete',
			handler:function()
			{
				var rows = $('#dg_vlan').datagrid('getSelections');
				if(rows.length!=1){
					$.messager.alert('消息','请选择一条记录！','info');
					return;
				}
				var id = rows[0].vlanid;
				var poolname = rows[0].poolname;
				var platformid = rows[0].platformid;
				var networkname = rows[0].vlanname;
				if(rows[0].vlanid){					
					$.messager.confirm('确认','您确认想要删除选中记录吗？',function(r){
						if(r){
							$.post('${ctx}/vlan/deleteVlan.do',{vlanid:id,networkname:networkname,poolname:poolname,platformid:platformid},function(){});
							
						}
					});
				}
			}
		}
		];
		$(function(){
			//datagrid = $('#dg_vlan').datagrid({
			$('#dg_vlan').datagrid({
				url:'${ctx}/vlan/getVlanLists.do',
				pagination:true,
				pageSize:10,
				pageList:[5,10,20,30,40,50],
				fitColumns:true,
				nowarp:false,
				border:false,
				scrollbarSize:0,
				idField:'vlanid',
				singleSelect:true,
				toolbar:toolbar,
				onLoadSuccess:function(data){
					var pageopt = $('#dg_vlan').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;
					var  _rows = $('#dg_vlan').datagrid("getRows").length;
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							$(this).datagrid('appendRow', {vlanid:''  })
						}
						$('#dg_vlan').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
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
						 $('#dg_vlan').datagrid('unselectRow', rowIndex);
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
								$("#dg_vlan").datagrid('uncheckRow', idx);
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
	    				title:'创建时间',
	    				field:'ctime',
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
	    			},
	    			{
	    				title:'交换机类型',
	    				field:'isdistributed',
	    				width:100,
	    				align:'center',
	    				formatter:function(value){
	    				
	    				  if(value=='1'){
	    				    return "分布式";
	    				  }else if(value=='0'){
	    				     return "标准";
	    				  }
	    				}
	    			},
	    			{
	    				title:'DHCP',
	    				field:'ondhcp',
	    				width:100,
	    				align:'center',
	    				formatter:function(value){
	    				
	    				  if(value=='1'){
	    				    return "<font color='green'>有</font>";
	    				  }else if(value=='0'){
	    				     return "<font color='#333'>无</font>";
	    				  }
	    				}
	    			}
	    			
	    		]],
			});
		});
		//查询
		function searchFunc(){
		    $('#dg_vlan').datagrid('load',icp.serializeObject($('#searchForm')));
		    //$('#dg').datagrid('load', $('#searchForm').form('serialize'));
		}
		//重置
		function cleanSearchFun(){
			$('#searchForm input').val('');
			$('#vlanname').textbox('clear');
			$('#dg_vlan').datagrid('load',{});
		}
		//弹出加载层
		 function load(msg) {  
		     $("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");  
		     $("<div class=\"datagrid-mask-msg\"></div>").html(msg).appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });  
		 }  
		   
		 //取消加载层  
		 function disLoad() {  
		     $(".datagrid-mask").remove();  
		     $(".datagrid-mask-msg").remove();  
		 }
		 
		function confirmBtn(isshared,isdistributed,ondhcp){
		  
			var vlanid = $("#vlanid").val();
			var vlanname = $("#vlanName").val();
			var subnetname = $("#subnetname").val();
			var subnetmark = $("#subnetmark").val();
			var gateway = $("#gateway").val();
			var rangestart = $("#rangestart").val();
			var rangend = $("#rangend").val();
			var poolname = $("#poolName").combobox('getValue');
			var platformname = $("#platformname").combobox('getValue');
			var dvswitch = $("#dvswitch").combobox('getValue');
			var dns = $("#dns").val();
			var broadcast = $("#broadcast").val();
			if(vlanid.trim()=="" ||vlanname.trim()==""){
			  $.messager.alert('警告',"含有未填写的必填项","warning");
			  return;
			}
			else if(ondhcp=="1"){
			   
			   var reg = /^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/;  
                   
			   if(subnetname.trim()==""||subnetmark.trim()==""||gateway.trim()==""||rangestart.trim()==""||rangend.trim()==""){
			   
			    $.messager.alert('警告',"含有未填写的必填项","warning");
			     return;
                }
			   else if(!reg.test(subnetname)){
			    $.messager.alert('警告',"子网IP格式错误！","warning");
			    return;
			   }  
			    else if(!reg.test(subnetmark)){
			    $.messager.alert('警告',"掩码IP格式错误！","warning");
			    return;
			   }  
			    else if(!reg.test(gateway)){
			    $.messager.alert('警告',"网关IP格式错误！","warning");
			    return;
			   }  
			    else if(!reg.test(rangend) || !reg.test(rangestart)){
			    $.messager.alert('警告',"起始段IP格式错误！","warning");
			    return;
			   }  
			    
			} 
			
			$.post('${ctx}/vlan/createVlan.do',{vlanid:vlanid,vlanname:vlanname,subnetname:subnetname,subnetmark:subnetmark,
	  			gateway:gateway,rangestart:rangestart,rangend:rangend,poolname:poolname,
	  			platformname:platformname,dvswitch:dvswitch,isshared:isshared,isdistributed:isdistributed,ondhcp:ondhcp,
	  			dns:dns,broadcast:broadcast},function(){});
            $('#applicationWindow').window('close');
		}
		$(function() {
	        $(document).on('click', '#isshared li', function(event) {
	            $(this).addClass('active').siblings().removeClass('active');
	            
	        });
	        $(document).on('click', '#isdistributed li', function(event) {
	      
	        	$(this).addClass('active').siblings().removeClass('active');
	            if($(this).index()==0){
	            	isdistributed = 1;
	            	//$('#switchname').show();
	            }else{
	            	isdistributed = 0;
	            }
	            //数据操作方法
            	$('#dvswitch').combobox({
	                url: '${ctx}/vlan/queryDvswitch.do?platformid='+platformid+'&isdistributed='+isdistributed,//分布式交换机列表
	                valueField: 'dvswitchid',
	                textField: 'dvswitchname',
	                required: true
	            });
	            
	        });
	        windowHtml2 = $('#applicationWindow').html();
	  
	        
	$('#applicationWindow').dialog({
        title: "网络配置",
        width: 700,
        height:390,

        shadow: false,

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
                  var isshared = $("#isshared").find("li.active").val();
                   var ondhcp = "1";
                   if(!$('#ddglDhcp').prop('checked')){
                      ondhcp="0";
                   }
                	var isdistributed = $("#isdistributed").find("li.active").val();
                  
                	confirmBtn(isshared,isdistributed,ondhcp);
                 
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#applicationWindow').dialog('close');
            }
        }]
    });

 
    $(document).on('change','#ddglDhcp',function(){
    
    
        if ($('#ddglDhcp').prop('checked')) {
            $('#ddglDhcp').parents('table').find('tr').removeClass('make-gray');
            $('#ddglDhcp').parents('table').find('input[type=text]').removeAttr('disabled')
        } else {
            $('#ddglDhcp').parents('table').find('tr').addClass('make-gray');
            $('#ddglDhcp').parents('table').find('.normol-input').attr('disabled', 'true');
        }
    });


	    })
	  
	     function isActive(flag) {

        if (flag == "onlyopen") { //默认选中不可修改
          $('#ddglDhcp').prop('checked', 'true')
            $('#ddglDhcp').attr('disabled', 'true');
            $('#ddglDhcp').parents('table').find('tr').removeClass('make-gray');
            $('#ddglDhcp').parents('table').find('input[type=text]').removeAttr('disabled')

        } else if (flag == "primary") { //可修改是否选中
            $('#ddglDhcp').prop('checked', 'true')
            $('#ddglDhcp').parents('table').find('tr').removeClass('make-gray');
            $('#ddglDhcp').parents('table').find('input[type=text]').removeAttr('disabled')

        }

    }  
	function ddglDhcp() {
	 
      $('#poolName').combobox({
	                valueField: 'poolid',
	                textField: 'poolname',
	                required: true
	            });
      $('#platformname').combobox({
	                url: '${ctx}/vmconfig/queryPlatform.do',
	                valueField: 'platformid',
	                textField: 'platformname',
	                required: true,
	                onSelect:function (record){
	                	
	                	platformid = record.platformid;
	                	var confInfoArray = platformid.split(",");
	                	var plattypeTemp = confInfoArray[2];
	                	 if ("openstack"==plattypeTemp) { //Openstack
		                    $('#ddglDhcp').parent().attr('class', 'yswitch yswitch-onlyopen');
		                    $('#ddglDhcp').attr({
		                        checked: 'checked'
		                    });
		                     $('#ddglDhcp').attr('disabled', 'true');
		                   $("#serverZs").hide();
		                    $("#resname").hide();
		                    $("#restext").hide();
		                    $("#sharename").show();
		                    $("#sharetext").show()
		                    isActive("onlyopen");
		
		                } 
		                else if ("vmware"==plattypeTemp) { //VMware
		                    $('#ddglDhcp').parent().attr('class', 'yswitch yswitch-primary');
		                    $('#ddglDhcp').removeAttr('disabled')
		                    $("#serverZs").show();
		                    $("#resname").show();
		                    $("#restext").show();
		                    $("#sharename").hide();
		                    $("#sharetext").hide();
		                    isActive("primary");
		
		
		                }
	                	if("openstack"==plattypeTemp){
	                		$('#shareNet').show();
	                		$('#dvswitch').combo({required:false}); 
	            			$('#switchname').hide();
	            			$('#distribute').hide();
	            			$('#poolName').combobox({
		    	                url: '${ctx}/vmconfig/queryResourcePoolVlan.do?platformid='+platformid,
		    	                valueField: 'poolid',
		    	                textField: 'poolname',
		    	                required: true,
		    	                onLoadSuccess:function(data){
		    	                  if(data.poolid!=undefined){
					                  $(this).combobox('select',data[0].poolid);
					                  }
					                }
		                	});
	                	}else if("vmware"==plattypeTemp){
	                		$('#distribute').show();
	            			$('#shareNet').hide();
	            			$('#switchname').show();
		                	$('#poolName').combobox({
		    	                url: '${ctx}/vmconfig/queryResourcePoolVlan.do?platformid='+platformid,
		    	                valueField: 'poolid',
		    	                textField: 'poolname',
		    	                required: true,
		    	                onSelect:function (data){
		    	                	//poolid = data.poolid;
		    	                	$('#dvswitch').combobox({
		    	    	            	url: '${ctx}/vlan/queryDvswitch.do?platformid='+platformid+'&isdistributed='+isdistributed,//分布式交换机列表
		    	    	                valueField: 'dvswitchid',
		    	    	                textField: 'dvswitchname',
		    	    	                required: true,
		    	    	                onLoadSuccess:function(data){
		    	    	                
		    	    	                 if(data.length==0){
		    	    	                  
		    	    	                    data.unshift({dvswitchid:'error',dvswitchname:'无相关数据'});
		    	    	                    
		    	    	                  }
		    	    	                  $(this).combobox('select',data[0].dvswitchid);
		    	    	                  
					                 } 
					                 
		    	    	            });
		    	                },
		    	                 onLoadSuccess:function(data){
		    	                   
					                  if(data.length==0){
					                 
		    	    	                    data.unshift({poolid:'error',poolname:'无相关数据'});
		    	    	                   
		    	    	                  }  
		    	    	                   $(this).combobox('select',data[0].poolid);
					                }
		    	            });
	                	}
	                	
			             
	                },
	                onLoadSuccess:function(data){
	                  $(this).combobox('select',data[0].platformid);
	                }
	                
	            });
   
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
			<table id="dg_vlan" style="background:#eee;width:100%;"></table>
		</div>
	</div>
<div id="applicationWindow" class="pop">
        <div style="padding:10px 0">
            <form id="myForm">
                <div class="item3">
                    <div class="item-wrap">
                        <table width="100%" border="0" class="table-layout">
                            <tr>
                                <td width="14%" align="right"><span class="must-star">*</span>VlanID：</td>
                                <td width="32%" align="left">
                                    <input type="text" placeholder='例:1024' class="normol-input" id="vlanid" style="width: 150px;">
                                </td>
                                <td width="22%" align="right"><span class="must-star">*</span>网络名称：</td>
                                <td width="32%">
                                    <input type="text"  placeholder='例:VLAN_1024' id="vlanName" class="normol-input" style="width: 190px;">
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><span class="must-star">*</span>平台：</td>
                                <td align="left">
                                    <select class="normol-select" name=""  id="platformname"  style="width: 162px;">
                                    </select>
                                </td>
                                <td align="right" id="resname"><span class="must-star">*</span>资源池：</td>
                                <td id="restext">
                                    <input type="text" class="normol-input" id="poolName"  style="width:202px;">
                                </td>
                                <td align="right" id="sharename" style="display:none"><span class="must-star">*</span>共享网络：</td>
                                <td id="sharetext" style="display:none">
                                    <ul class="item-ul j-toggle" id="isshared">
                                        <li class="active" style="padding:0 2px" value="1">是</li>
                                        <li style="padding:0 1px" value="0">否</li>
                                    </ul>
                                </td>
                            </tr>
                            <tr id="serverZs">
                                <td align="right"><span class="must-star">*</span>分布式：</td>
                                <td>
                                    <ul class="item-ul j-toggle" id="isdistributed">
                                        <li class="active" style="padding:0 2px" value="1">是</li>
                                        <li style="padding:0 1px" value="0">否</li>
                                    </ul>
                                </td>
                                <td align="right"><span class="must-star">*</span>交换机名称：</td>
                                <td align="left">
                                  
                                    <input type="text" class="normol-input" id="dvswitch"  style="width:202px;">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!-- DHCP -->
                <div style="padding:0 10px ">
                    <div class="item2">
                        <div class="item-title">DHCP信息</div>
                        <table width="100%" border="0" class="table-layout">
                            <tr class="">
                                <td width="19%" align="right" rowspan="3" style=" border-right: 1px solid #ddd; padding-right: 20px;">
                                    <div class="item-title2">
                                        <!-- 开关按钮 -->
                                        <div class="yswitch yswitch-primary">
                                            <input type="checkbox" id="ddglDhcp" checked="">
                                            <label for="ddglDhcp"></label>启用
                                        </div>
                                    </div>
                                </td>
                                <td width="12%" align="right"><span class="must-star">*</span>子网：</td>
                                <td width="20%">
                                    <input type="text" class="normol-input" placeholder='例:100.25.2.1' id="subnetname" style="width:100px;">
                                </td>
                                <td width="14%" align="right"><span class="must-star">*</span>掩码：</td>
                                <td width="">
                                    <input type="text" placeholder='例:255.255.255.254' class="normol-input"  id="subnetmark" style="width:219px;" value="">
                                </td>
                            </tr>
                            <tr class="">
                                <td align="right"><span class="must-star">*</span>网关：</td>
                                <td>
                                    <input type="text" placeholder='例:100.25.2.254' class="normol-input" id="gateway" style="width:100px;">
                                </td>
                                <td align="right"><span class="must-star">*</span>起始段：</td>
                                <td>
                                    <input type="text" placeholder='例:100.25.2.2' class="normol-input" id="rangestart" style="width:100px;" value="">-
                                    <input type="text" placeholder='例:100.25.2.100'class="normol-input" id="rangend" style="width:100px;" value="">
                                </td>
                            </tr>
                            <tr class="">
                                <td align="right">DNS：</td>
                                <td>
                                    <input type="text" id="dns" placeholder='例:114.114.114.114' class="normol-input" style="width:100px;">
                                </td>
                                <td align="right">广播地址：</td>
                                <td>
                                    <input type="text"  placeholder='例:114.114.114.254' id="broadcast" class="normol-input" style="width:219px;" value="">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</html>
