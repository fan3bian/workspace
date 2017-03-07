<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<script>
	var content ="${pageContext.request.contextPath}";
</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/web/osdeploy/css/osdeploy.css" type="text/css"/>
<script src="${pageContext.request.contextPath}/web/osdeploy/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sockjs-0.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
<script type="text/javascript">
var ws = null;
var url = null;
var transports = [];
var scrollIndex=0;
var canbeinit =true;
$(function() {
    updateUrl('${pageContext.request.contextPath}/sockjs/echo');
    connect();
});
//更新环境信息
function queryEnviron() {
    $.ajax({
        type: "GET",
        dataType: "json",
        url: "${pageContext.request.contextPath}/osdeploy/queryEnviron.do",
        async: true,
        data: {
            environId: $("#environId").val()
        },
        success: function(data) {
            if (data) {
//                 $("#ctime").text("创建于" + data.ctime.substring(0, 10));
                $("#controlnum").text(data.controlnum);
                $("#computenum").text(data.computenum);
                $("#storagenum").text(data.storagenum);
                $("#env_status").val(data.status);
            }
        }
    });
}
// contype|comtype|stgtype
// 打开节点窗口
function showNodeDg(nodeType) {
 //   console.log(nodeType);
    $('#node_dialog').dialog('open');
    $("#nodeType").val(nodeType);
    if (nodeType === 'contype') {
        $('#node_dialog').panel({
            title: '分配控制节点'
        });
    } else if (nodeType === 'comtype') {
        $('#node_dialog').panel({
            title: '分配计算节点'
        });
    } else if (nodeType === 'stgtype') {
        $('#node_dialog').panel({
            title: '分配存储节点'
        });
    }
    $('#node_dg').datagrid({
        url: '${pageContext.request.contextPath}/osdeploy/queryNodeType.do',
        queryParams: {
            nodeType: nodeType,
            environid:$("#environId").val(),
            isNode:1
        },
        method: 'post',
    });

}
// contype|comtype|stgtype
//添加节点窗口
function showAddNodeDg() {
    $('#node_dialog').dialog('close');
    $('#add_node_dialog').dialog('open');
    var nodeType =$('#nodeType').val();
    $('#add_node_dg').datagrid({
        url: '${pageContext.request.contextPath}/osdeploy/queryNodeType.do',
        queryParams: {
            nodeType: nodeType,
            environId:$("#environId").val(),
            isNode:0
        },
        method: 'post',
    });
}
//打开添加主机对话框，展示非本环境物理机列表
function showAddHostDg(){
	$('#add_host_dialog').dialog('open');
	$('#add_host_dg').datagrid({
        url: '${pageContext.request.contextPath}/osdeploy/queryHosts.do',
        queryParams: {
           	isEnviron:'0',
            environId:$("#environId").val(),
        },
        method: 'post',
    });
}
//主机状态
// function configConNode() {
//     loadMask("为控制节点进行【环境初始化】，请稍后...");
//     $.ajax({
//         type: "GET",
//         dataType: "json",
//         url: "${pageContext.request.contextPath}/osdeploy/configConNode.do",
//         async: true,
//         data: {
//             hostId: hostId,
//             ipAddr: ipAddr
//         },
//         success: function(data) {
//             if (data.success) {
//                 $.messager.alert('消息', data.msg, 'info');
//             } else {
//                 $.messager.alert('错误', data.msg, 'error');
//             }
//             disLoad();
//             $('#compute_node').datagrid('reload');
//         }
//     });
// }

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
	if(os_deploy_ws){
		return;
	}
    if (!url) {
        alert('Select whether to use W3C WebSocket or SockJS');
        return;
    }
    os_deploy_ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
        protocols_whitelist: transports
    }) : new WebSocket(url);
    os_deploy_ws.onopen = function() {};
    os_deploy_ws.onmessage = function(event) {
        var msg = event.data;
        $('#operate_log').datagrid('appendRow',{
        	time:msg.split(",")[0],
        	ip:msg.split(",")[1],
        	event:msg.split(",")[2],
        	result:(msg.split(",")[3]=='1'?"成功":"失败")
        });
        debugger;
        $('#operate_log').datagrid('scrollTo',scrollIndex);
        scrollIndex++;
    };
    os_deploy_ws.onclose = function(event) {};
}
//查询某一状态下环境内设备
function queryByStatus(status) {
    var a = [];
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "${pageContext.request.contextPath}/osdeploy/queryByStatus.do",
        async: false,
        data: {
            status: status,
            environId: $("#environId").val()
        },
        success: function(data) {
            a = data;
        }
    });
    return a;
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false"
	style="padding:10px 20px 50px 20px;margin:10px 20px 30px 20px;">
	<div data-options="region:'north',border:false"
		style="height:290px;overflow:hidden;background-color: #eee">
		<div class="kvm-layout-left">
			<div class="header">
				<span class="title">${OsDeployEnvironVo.environname}</span> <span class="date">创建于:${fn:substring(OsDeployEnvironVo.ctime, 0, 10)}</span>
			</div>
			<ul class="body">
				<li><i class="kvm-icon icon-kz"></i>控制 <em id="controlnum">${OsDeployEnvironVo.controlnum}</em></li>
				<li><i class="kvm-icon icon-js"></i>计算 <em id="computenum">${OsDeployEnvironVo.computenum}</em></li>
				<li><i class="kvm-icon icon-cc"></i>存储 <em id="storagenum">${OsDeployEnvironVo.storagenum}</em></li>
			</ul>
		</div>
		<div class="kvm-layout-right">
			<ul class="kvm-step" id="stepTab">
				<li class="step1 active">
					<div class="title">
						<span class="quan">1</span>
					</div>
					<div class="text">资源选择</div>
				</li>
				<li class="step2">
					<div class="title">
						<span class="quan">2</span>
					</div>
					<div class="text">安装前配置检查</div>
				</li>
				<li class="step3">
					<div class="title">
						<span class="quan">3</span>
					</div>
					<div class="text">执行安装</div>
				</li>
				<li class="step4">
					<div class="title">
						<span class="quan">4</span>
					</div>
					<div class="text">资源配置</div>
				</li>
			</ul>
			<div class="j-main">
				<div class="body" id="step1">
					<div class="title">请点击以下节点进行资源选择：</div>
					<div class="content">
						<div class="kvm-btn-box" onclick="showAddNode('conType')">
							<button class="kvm-btn icon-btn-kz">
								<i class="kvm-btn-icon "></i>控制节点
							</button>
							<button class="select">选择</button>
						</div>
						<div class="kvm-btn-box" onclick="showAddNode('comType')">
							<button class="kvm-btn icon-btn-js">
								<i class="kvm-btn-icon"></i>计算节点
							</button>
							<button class="select">选择</button>
						</div>
						<div class="kvm-btn-box" onclick="showAddNode('stgType')">
							<button class="kvm-btn icon-btn-cc">
								<i class="kvm-btn-icon "></i>存储节点
							</button>
							<button class="select">选择</button>
						</div>
					</div>
					<div class="kvm-footer">
						<i class="kvm-ts"></i> <a href="#"
							class="easyui-linkbutton" onclick="goStep(2)">下一步 &gt;</a>
					</div>
				</div>
				<div class="body kvm-pzjc" id="step2">
					<div class="title">安装前检查以下配置：</div>
					<div class="content">
						<div class="kvm-btn-box active" id="kvmWlpz" <c:if test="${OsDeployEnvironVo.status eq 0}">onclick="checkNet('#net-icon')"</c:if>>
							<button class="kvm-btn icon-btn-wlpz">
								<i class="kvm-btn-icon "></i>网络配置
							</button>
							<button class="select" id="net-icon"><c:if test="${OsDeployEnvironVo.status lt 1}">开始</c:if><c:if test="${OsDeployEnvironVo.status gt 0}">检测通过<span class="kvm-ok"></span></c:if></button>
						</div>
						<div class="kvm-icon-arrow"></div>
						<div id="kvmSfqpz" <c:if test="${OsDeployEnvironVo.status gt 0}">class="kvm-btn-box active"</c:if> onclick="checkServer('#server-icon')"
							<c:if test="${OsDeployEnvironVo.status lt 1}">class="kvm-btn-box"</c:if>>
							<button class="kvm-btn icon-btn-fwqpz">
								<i class="kvm-btn-icon "></i>服务器配置
							</button>
							<button class="select" id="server-icon"><c:if test="${OsDeployEnvironVo.status lt 2}">开始</c:if><c:if test="${OsDeployEnvironVo.status gt 1}">检测通过<span class="kvm-ok"></span></c:if></button>
						</div>
					</div>
					<div class="kvm-footer">
						<a href="#" class="easyui-linkbutton" onclick="goStep(1)">&lt;
							上一步 </a> <a href="#" class="easyui-linkbutton" onclick="goStep(3)">下一步&gt;</a>
					</div>
				</div>
				<div class="body " id="step3" style="display: none">
					<div class="title">安装列表</div>
					<div class="content ">
						<div class="kvm-set">
							<dl>
								<dt>
									控制节点
									<div class="kvm-set-os" id ="con_icon">
										<span class="kvm-ok" <c:if test="${OsDeployEnvironVo.status lt 3}">style="display: none"</c:if>></span>
										<a href="#" class="easyui-linkbutton" <c:if test="${OsDeployEnvironVo.status ne '2'}">style="display: none"</c:if>
											data-options="iconCls:'icon-objopen',plain:true" onclick="installWare('#con_icon','conType')">安装</a>
									</div>
								</dt>
								<dd id="con_install">
								</dd>
							</dl>
							<dl>
								<dt>
									计算节点<!--style="display: none"  -->
									<div class="kvm-set-os" id ="com_icon">
										<span class="kvm-ok" <c:if test="${OsDeployEnvironVo.status lt 4}">style="display: none"</c:if>></span>
										<a href="#" class="easyui-linkbutton" <c:if test="${OsDeployEnvironVo.status ne '3'}">style="display: none"</c:if>
											data-options="iconCls:'icon-objopen',plain:true" onclick="installWare('#com_icon','comType')">安装</a>
									</div>
								</dt>
								<dd id="com_install">
								</dd>
							</dl>
							<dl>
								<dt>
									存储节点
									<div class="kvm-set-os" id ="stg_icon">
										<span class="kvm-ok"<c:if test="${OsDeployEnvironVo.status lt 5}">style="display: none"</c:if>></span>
										<a href="#" class="easyui-linkbutton" <c:if test="${OsDeployEnvironVo.status ne '4'}">style="display: none"</c:if>
											data-options="iconCls:'icon-objopen',plain:true" onclick="installWare('#stg_icon','stgType')">安装</a>
									</div>
								</dt>
								<dd id="stg_install">
								</dd>
							</dl>
						</div>
					</div>
					<div class="kvm-footer">
						<a href="#" class="easyui-linkbutton" onclick="goStep(2)">&lt;上一步
						</a> <a href="#" class="easyui-linkbutton" onclick="goStep(4)">下一步
							&gt;</a>
					</div>
				</div>
				<div class="body kvm-pzjc" id="step4" style="display: none">
					<div class="title">云平台信息：</div>
					<div class="content">
						<table width="100%" class="kvm-create">
							<div class="kvm-btn-box active" id="init_icon" onclick="initEnviron('#init-icon')">
								<button class="kvm-btn icon-btn-wlpz">
									<i class="kvm-btn-icon "></i>一键启动
								</button>
								<button class="select" id="init-icon"><c:if test="${OsDeployEnvironVo.status lt 6}">开始</c:if><c:if test="${OsDeployEnvironVo.status gt 5}">启动成功<span class="kvm-ok"></span></c:if></button>
							</div>
							<div class="kvm-icon-arrow"></div>
								<div class="kvm-btn-box" id="" onclick="initEnviron('#check-icon')">
								<button class="kvm-btn icon-btn-fwqpz">
									<i class="kvm-btn-icon "></i>一键检测
								</button>
								<button class="select" id="check-icon">开始</button>
							</div>
						</table>
					</div>
					<div class="kvm-footer">
						<a href="#" class="easyui-linkbutton" onclick="goStep(3)">&lt;上一步
						</a> <a href="#" class="easyui-linkbutton"
							data-options="iconCls:'icon-ok'">完成</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'center',border:false">
		<div class="easyui-panel  kvm-t-wrap" style="width:100%;"
			data-options="fit:true">
			<table id="operate_log"class="easyui-datagrid" title="操作信息"
				style="width:100%; height:100%"
				data-options="fitColumns:true,nowrap:false,rownumbers:true">
				<thead>
					<tr>
						<th data-options="field:'time',width:200,align:'center'">时间</th>
						<th data-options="field:'ip',width:200,align:'center'">主机</th>
						<th data-options="field:'event',width:200,align:'center'">事件</th>
						<th data-options="field:'result',width:200,align:'center'">结果</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	    <div id="add_host_dialog" class="easyui-dialog" title="选择物理主机到【环境】" data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false,fitColumns:true,width:480,height:320,buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: addHostToEnvrion
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#add_host_dialog').dialog('close');
            }
        }]">
        <table id="add_host_dg" class="easyui-datagrid" style="margin-top:5px;width: 100%;" data-options="fitColumns:true,height:240">
            <thead>
                <tr>
                    <th data-options="field:'ck',width:100,checkbox:true"></th>
                    <th data-options="field:'hostid',width:80,align:'center'">编码</th>
                    <th data-options="field:'hostname',width:100,align:'center'">主机</th>
                    <th data-options="field:'ipaddr',width:100,align:'center'">IP地址</th>
                </tr>
            </thead>
        </table>
    </div>
</div>
<input type="hidden" id="env_status" value="${OsDeployEnvironVo.status}">
<input type="hidden" id="environId" value="${OsDeployEnvironVo.environid}">
<input type="hidden" id="environName" value="${OsDeployEnvironVo.environname}">
<input type="hidden" id="nodeType">
 <!-- 存放主机ip,-->
<input type="hidden" id="con_nodes">
<input type="hidden" id="com_nodes">
<input type="hidden" id="stg_nodes">
<!-- 弹层 -->
<div id="kvmWindow" class="kvm-window easyui-dialog"
	data-options=" 
        title: '添加计算节点',
        modal: true,
        width: 780,
        height: 500,
        closed: true,
        buttons: [{
            text: '保存',
            iconCls: 'icon-ok',
            handler: addNodeHost
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#kvmWindow').dialog('close');
            }
        }]">
	<div class="kvm-window-left">
		<div class="title">研发OS平台主机
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',height:24" onclick="showAddHostDg()">添加</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-delete',height:24" onclick="addHostToEnvrion(0)">移除</a>
		</div>
		<table id="kvmAddTable">
		</table>
	</div>
	<div class="kvm-window-center">
		<a href="#" class="easyui-linkbutton" onclick="leftToRight()">&nbsp;增加&nbsp;&gt;&nbsp;</a>
		<a href="#" class="easyui-linkbutton" onclick="rightToLeft()">&nbsp;&lt;&nbsp;移除&nbsp;</a>
	</div>
	<div class="kvm-window-right">
		<div class="title">控制节点列表</div>
		<table id="kvmAddShowTable">
		</table>
	</div>
</div>
<script type="text/javascript">
//上一步、下一步
function goStep(step) {
	if(step===2){
		var controlnum=Number($('#controlnum').text());
		var computenum=Number($('#computenum').text());
		var storagenum=Number($('#storagenum').text());
		if(controlnum<1||computenum<1||storagenum<1){
			$.messager.alert("提示", "不满足部署需求，请重新分配节点。");
			return;
		}
	}else if(step===3){
		if(Number($('#env_status').val())<2){
			$.messager.alert("提示", "请先完成检查。");
			return;
		}
	    $("#con_install p").remove();
        $("#com_install p").remove();
        $("#stg_install p").remove();
		var data = queryByStatus(2); //查询环境检查完成的机器
        var con_nodes = "";
        var com_nodes = "";
        var stg_nodes = "";
        for (var i in data) {
            var p = "<p id=\"" + data[i].ipaddr + "\">"+"名称：" +data[i].hostname+" IP : "+ data[i].ipaddr + "</p>";
            if (data[i].contype === '1') {
                $("#con_install").append(p);
                con_nodes += data[i].ipaddr + ",";
            } 
            if(data[i].comtype === '1') {
                $("#com_install").append(p);
                com_nodes += data[i].ipaddr + ",";
            } 
            if (data[i].stgtype === '1') {
                $("#stg_install").append(p);
                stg_nodes += data[i].ipaddr + ",";
            }
        }
        $("#con_nodes").val(con_nodes);
        $("#com_nodes").val(com_nodes);
        $("#stg_nodes").val(stg_nodes);
	}else if(step===4){
		if(Number($('#env_status').val())<5){
			$.messager.alert("提示", "请先完成安装。");
			return;
		}
	}
	 	
	$('#step' + step).show().siblings().hide();
	index = step - 1;
	$('#stepTab li').eq(index).addClass('active').siblings().removeClass(
			'active');

}
function showAddNode(nodeType) {
	var title ="标题";
	if(nodeType==='conType'){
		title ="控制节点";
	}else if(nodeType==='comType'){
		title ="计算节点";
	}else if(nodeType==='stgType'){
		title ="存储节点";
	}
	$('#nodeType').val(nodeType);
	$('#kvmWindow').dialog({
		modal : true,
		closed : false,
		title :title
	});
	//选中增加
	$('#kvmAddTable').datagrid({
		width : 320,
		height : 380,
		fitColumns : true,
		nowrap : false,
		scrollbarSize : 0,
		url : 'datagrid_data3.json',
		columns : [ [ {
			field : 'ck',
			checkbox : true
		}, {
			field : 'hostid',
			title : '编码',
			width : 80
		}, {
			field : 'hostname',
			title : '名称',
			width : 100
		}, {
			field : 'ipaddr',
			title : 'IP',
			width : 100

		} ] ],
		url: '${pageContext.request.contextPath}/osdeploy/queryNodeType.do',
    	queryParams: {
        	nodeType: nodeType,
        	environId:$("#environId").val(),
        	isNode:0
    	},
	});
	//可选展示
	$('#kvmAddShowTable').datagrid({
		width : 320,
		height : 380,
		fitColumns : true,
		nowrap : false,
		scrollbarSize : 0,
		url : 'datagrid_data3.json',
		columns : [ [ {
			field : 'ck',
			checkbox : true
		}, {
			field : 'hostid',
			title : '编码',
			width : 80
		}, {
			field : 'hostname',
			title : '名称',
			width : 100
		}, {
			field : 'ipaddr',
			title : 'IP',
			width : 100

		} ] ],
		url: '${pageContext.request.contextPath}/osdeploy/queryNodeType.do',
    	queryParams: {
        	nodeType: nodeType,
        	environId:$("#environId").val(),
        	isNode:1
    	},
	});

}
	//添加主机到环境（云平台）,从环境移除主机
	function addHostToEnvrion(isAdd){//typeof:number
		var rows=null;
		if(0===isAdd){//remove hosts from kvmAddTable
			rows =	$('#kvmAddTable').datagrid('getChecked');			
		}else{
			isAdd=1;
			rows = $('#add_host_dg').datagrid('getChecked');
		}
	    if (rows.length < 1) { 
	        return;
	    }
	    var hostIds = "";
	    for (var index = 0; index < rows.length; index++) {
	    	hostIds = hostIds + rows[index].hostid + ",";
	    }
	    $.ajax({
	        type: "POST",
	        url: '${pageContext.request.contextPath}/osdeploy/addHostToEnviron.do',
	        data: {
	        	hostIds: hostIds,
	            environId: $("#environId").val(),
	            environName : $('#environName').val(),
	            isAdd :isAdd
	        },
	        dataType: "json",
	        success: function(data) {
	        	 $('#add_host_dialog').dialog('close');
	             $('#kvmAddTable').datagrid('reload');
	        }
	    });
	}
	function leftToRight(){
		var rows = $('#kvmAddTable').datagrid('getChecked');
		if (rows.length < 1) {
	        return;
	    }
		for(var i in rows){
			var index = $('#kvmAddTable').datagrid('getRowIndex',rows[i]); 
			$('#kvmAddTable').datagrid('deleteRow',index);
			$('#kvmAddShowTable').datagrid('appendRow',rows[i]);
		}
	}
	function rightToLeft(){
		var rows = $('#kvmAddShowTable').datagrid('getChecked');
		if (rows.length < 1) {
	        return;
	    }
		for(var i in rows){
			var index = $('#kvmAddShowTable').datagrid('getRowIndex',rows[i]); 
			$('#kvmAddShowTable').datagrid('deleteRow',index);
			$('#kvmAddTable').datagrid('appendRow',rows[i]);
		}
	}
	//添加节点
	function addNodeHost() {
	    var rows = $('#kvmAddShowTable').datagrid('getRows');
	    var hostIds = "";
	    for (var index = 0; index < rows.length; index++) {
	    	hostIds = hostIds + rows[index].hostid + ",";
	    }
	    var nodeType = $('#nodeType').val();
	    $.ajax({
	        type: "POST",
	        url: '${pageContext.request.contextPath}/osdeploy/addNode.do',
	        data: {
	        	hostIds: hostIds,
	            nodeType: nodeType,
	            environId: $("#environId").val() 
	        },
	        dataType: "json",
	        success: function(data) {
	        	if(data.success){
	        		$.messager.alert("消息",data.msg,'info');
	        	}else{
	        		$.messager.alert("消息",data.msg,'error');
	        	}
	            $('#kvmWindow').dialog('close');
            	queryEnviron();
	        }
	    });
	}
	//网络配置检查
	function checkNet(obj) {
		if($('#env_status').val()!='0'){//
			return;
		}
		$(obj).html('<img src="${pageContext.request.contextPath}/web/osdeploy/image/kwm-loading.gif" alt="">');
	    $.ajax({
	        type: "POST",
	        dataType: "json",
	        url: "${pageContext.request.contextPath}/osdeploy/checkNet.do",
	        async: true,
	        data: {
	            environId: $("#environId").val(),
	            status: 0
	        },
	        success: function(data) {
	        	if(data.success){
		        	$(obj).html('检查通过！ <span class="kvm-ok"></span>');
					$('#kvmSfqpz').addClass('active');
					$('#env_status').val('1');
	        	}else{
	        		$(obj).html('检查失败！ <span class="kvm-error"></span>');
	        	}
	        }
	    });
	}
	//服务器配置检查
	function checkServer(obj) {
		if($('#env_status').val()!='1'){//
			return;
		}
		$(obj).html('<img src="${pageContext.request.contextPath}/web/osdeploy/image/kwm-loading.gif" alt="">');
	    $.ajax({
	        type: "POST",
	        dataType: "json",
	        url: "${pageContext.request.contextPath}/osdeploy/checkServer.do",
	        async: true,
	        data: {
	            environId: $("#environId").val(),
	            status: 1
	        },
	        success: function(data) {
	        	if(data.success){
		        	$(obj).html('检查通过！ <span class="kvm-ok"></span>');
		        	$('#env_status').val('2');
		        	$('#con_icon a').show();
		        	//show 
	        	}else{
	        		$(obj).html('检查失败！ <span class="kvm-error"></span>');
	        	}
	        }
	    });
	}
	//安装软件
	function installWare(obj,nodeType) {
		$(obj+' .kvm-error').remove();
		var ins_host_ip = "";
	    if (nodeType === 'conType') {
	        ins_host_ip = $("#con_nodes").val();
	    } else if (nodeType === 'comType') {
	        ins_host_ip = $("#com_nodes").val();
	    } else if (nodeType === 'stgType') {
	        ins_host_ip = $("#stg_nodes").val();
	    }
	    if (ins_host_ip) {
	        ins_host_ip = ins_host_ip.substring(0, ins_host_ip.length - 1);
	    } else {
	        $.messager.alert("info", "没有设备进行安装");
	        return;
	    }
	    $(obj+' a').hide();
		$(obj).append('<img src="${pageContext.request.contextPath}/web/osdeploy/image/kwm-loading.gif" alt="">');
		$.ajax({
	        type: "POST",
	        dataType: "json",
	        url: "${pageContext.request.contextPath}/osdeploy/installWare.do",
	        async: true,
	        data: {
	            nodeType: nodeType,
	            ins_host_ip: ins_host_ip,
	            environId :$("#environId").val()
	        },
	        success: function(data) {
	        	$(obj+' img').remove();
	        	if(data.success){
	        		$(obj).prepend('<span class="kvm-ok"></span>');
	        		$(obj).parents('dl').next().find('.kvm-set-os').children('a').show();
	        		if (nodeType === 'stgType') {
		        		 $('#env_status').val('5');
		     	    }
	        	}else{
	        		$(obj).prepend('<span class="kvm-error"></span>');
	        		$(obj+' a').show();
	        	}
	        }  
		});
	}
//一键部署

function initEnviron(obj) {
	if(!canbeinit){
		return ;
	}
	if($('#env_status').val()!='5'){//
		return;
	}
	canbeinit = false;
	$(obj).html('<img src="${pageContext.request.contextPath}/web/osdeploy/image/kwm-loading.gif" alt="">');
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "${pageContext.request.contextPath}/osdeploy/initEnviron.do",
        async: true,
        data: {
            environId: $("#environId").val()
        },
        success: function(data) {
         	if(data.success){
        		$(obj).html('启动成功！ <span class="kvm-ok"></span>');
        		$('#env_status').val('6');
    		}else{
    			$(obj).html('启动失败！ <span class="kvm-error"></span>');
    			canbeinit =true;
    		}
        }
    });
}
</script>
