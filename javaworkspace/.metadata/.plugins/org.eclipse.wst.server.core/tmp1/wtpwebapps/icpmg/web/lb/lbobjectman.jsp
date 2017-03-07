<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<body>
	<input type="hidden" id="tabs_lbid" value="${rmdLbVo.lbid}"/>
	<input type="hidden" id="reservePort" value="${reservePort}">
	<input type="hidden" id="cuserid" value="${rmdLbVo.cuserid}">
	<input type="hidden" id="funip" value="${rmdLbVo.funip}">
    <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 30px 20px;margin:0px 20px 30px 20px;">
        <div data-options="region:'north',border:false" style="overflow:hidden;background-color: #eee; height: 75px;">
            <div class="gproducts-survey">
                <div class="title" style="width: 12%;">资源详情</div>
                <div class="item" style="width: 18%;">
                    <div class="item-box">
                        <p>ID： ${rmdLbVo.lbid}</p>
                        <p>名称：
                        <!-- 增加编辑按钮 zhanghl 2016.08.24 -->
                        	<span id="displaynameShow" >
                            	<em class="ellipsis">${rmdLbVo.displayname}</em>  
                                <a href="#" onclick="editLbname()" class="easyui-linkbutton"  data-options="iconCls:'icon-edit', plain:true"></a>
                            </span>
                        <!-- 编辑 -->
                            <span id="displaynameEdit" style="display: none">
                            	<input  class="easyui-validatebox" style="width: 60px; height: 22px" type="text" data-options="required:false"> 
                            	<a onclick="saveLbname()" href="javascript:void(0)" class="easyui-linkbutton" style="height: 22px">保存</a>
                            </span>
                        </p>
                    </div>
                </div>
                <div class="item" style="width: 18%;">
                	<div class="item-box">
                		<p>业务IP：${rmdLbVo.funip}</p>
                        <p>网络类型：
                        	<span>
                        		<c:if test="${rmdLbVo.instatype eq '1'}">基础网络</c:if>
                        		<c:if test="${rmdLbVo.instatype eq '2'}">私有网络</c:if>
                        	</span>
                        </p>
                    </div>
                </div>
                <div class="item" style="width: 18%;">
                	<div class="item-box">
                		<p>管理IP：${rmdLbVo.lbip}</p>
                        <p>外网IP：未绑定</p>
                    </div>
                </div>
                <div class="item" style="width: 18%;">
                    <div class="item-box">
                        <p>所在区域： ${rmdLbVo.regionname}</p>
                        <p>描述：
                        <!-- 增加编辑按钮 zhanghl 2016.08.24 -->
                        	<span id="descriptionShow">
                            	<em class="ellipsis">${rmdLbVo.description}</em>  
                                <a href="#" onclick="editLbdescription()" class="easyui-linkbutton"  data-options="iconCls:'icon-edit', plain:true"></a>
                            </span>
                        <!-- 编辑 -->
                            <span id="descriptionEdit" style="display: none">
                            	<input  class="easyui-validatebox" style="width: 70px; height: 22px" type="text" data-options="required:false"> 
                            	<a onclick="saveLbdescription()" href="javascript:void(0)" class="easyui-linkbutton" style="height: 22px">保存</a>
                            </span>
                        </p>
                    </div>
                </div>
                <div class="item item-stop" style="width: 16%;">
                    <div class="item-box">
                        <!-- 开关按钮 -->
                        <div class="yswitch yswitch-default">
                        	<c:if test="${rmdLbVo.curstat eq 'Running'}">
                            	<input type="checkbox" id="ww" checked>
                            	<label for="ww" onclick="operate('stop');"></label>
                            </c:if>
                            <c:if test="${rmdLbVo.curstat eq 'Stopped'}">
                            	<input type="checkbox" id="ww">
                            	<label for="ww" onclick="operate('start');"></label>
                            </c:if>
                        </div>
                    </div>
                </div>
                <!-- 
                <div class="item item-link" style="width: 12%;">
                    <div class="item-box">
                        <p> <a href="javascript:void(0)" class="easyui-linkbutton" style="height: 22px; width: 90px">销毁</a></p>
                        <p> <a href="javascript:void(0)" onclick="bindEip()" class="easyui-linkbutton" style="height: 22px; width: 90px;">绑定公网地址</a></p>
                    </div>
                </div>
                 -->
                <!--  
                <div class="item" style="width: 20%;">
                    <div class="item-box">
                        <p>管理地址：${rmdLbVo.lbip}</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态： <span class="item-state">
                        <c:if test="${rmdLbVo.curstat eq 'Running'}">运行中</c:if>
						<c:if test="${rmdLbVo.curstat eq 'Stopped'}">停止</c:if>
						<c:if test="${rmdLbVo.curstat eq 'Stopping'}">正在停止</c:if>
						<c:if test="${rmdLbVo.curstat eq 'Starting'}">启动中</c:if>
						<c:if test="${rmdLbVo.curstat eq 'Destroyed'}">已删除</c:if>
						<c:if test="${rmdLbVo.curstat eq 'Expunging'}">正在销毁</c:if>
                        </span></p>
                    </div>
                </div>
                <div class="item" style="width: 20%;">
                    <div class="item-box">
                    	<p>业务地址：${rmdLbVo.funip}</p>
                        <p>所在区域：${rmdLbVo.regionname}</p>
                    </div>
                </div>
                <div class="item" style="width: 15%;">
                    <div class="item-box">
                    	<p>用途：${rmdLbVo.description}</p>
                        <p>实例类型：<c:if test="${rmdLbVo.instatype eq '1'}">私有网络</c:if><c:if test="${rmdLbVo.instatype eq '2'}">公有网络</c:if></p>
                        <%-- <p>网络类型：<c:if test="${rmdLbVo.networktype eq '1'}">基础网络</c:if><c:if test="${rmdLbVo.networktype eq '2'}">高级网络</c:if></p> --%>
                    </div>
                </div>
                <div class="item item-stop" style="width: 15%;">
                    <c:if test="${rmdLbVo.curstat eq 'Running'}">
                    <a id="lbstop_" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tip'" onclick="operate('stop');">停止</a>
					</c:if>
					<c:if test="${rmdLbVo.curstat eq 'Stopped'}">
					<a id="lbstart_" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tip'" onclick="operate('start');">启动</a>
					</c:if>
                </div>
                -->
                <!--  
                <div class="item item-link" style="width: 10%;">
                    <div class="item-box">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-help2',plain:true,"></a>
                        <p><a href="javascript:void(0)" href="#">帮助文档</a></p>
                    </div>
                </div>
                -->
            </div>
        </div>
        <div data-options="region:'center',border:false" style="background-color: #eee; ">
            <div id="easyuiTabs" class="easyui-tabs gproducts-main" data-options="fit:true" >
                <div title="应用服务设置" data-options="href:'${pageContext.request.contextPath}/web/lb/lbmanlisten.jsp'" style="display:block;background:#eee">
                </div>
                <div title="转发策略" data-options="href:'${pageContext.request.contextPath}/web/lb/lbAclStrategy.jsp'" style="display:block;background:#eee">
                </div>
                <div title="服务器证书管理" data-options="href:'${pageContext.request.contextPath}/web/lb/lbcertificate.jsp'" style="display:block;background:#eee">
                </div>
            </div>
        </div>
    </div>
	<form id="lb_operate" method="post">
	<input type="hidden" id="lbid" value="${rmdLbVo.lbid}">
	<input type="hidden" id="lbip" value="${rmdLbVo.lbip}">
	<input type="hidden" id="lbdisplayname" value="${rmdLbVo.displayname}">
	</form>
	
<!--  
<div id="lb_tabs" class="easyui-tabs" style="width:100%;" data-options="tabWidth:112,fit:true,border:false" >
	<input type="hidden" id="tabs_lbid" value="${rmdLbVo.lbid}"/>
	<input type="hidden" id="reservePort" value="${reservePort}">
	<div id="tabs0" title="资源详情" data-options="fit:true,selected:true" style="padding:10px;background:#eee" >
		<jsp:include page="lbdetail.jsp" />
	</div>
	<div id="tabs1" title="应用服务配置" data-options="fit:true" style="padding:10px;background:#eee" >
		<div id="lb_listen" style="overflow:hidden;"></div>
	</div>
	<div id="tabs2" title="后端服务器配置" data-options="fit:true" style="padding:10px;background:#eee" >
		<div id="lb_vm" style="overflow:hidden;"></div>
	</div>
	<div id="tabs3" title="运行监控" data-options="fit:true" style="padding:10px;background:#eee;overflow:hidden;" >
		<div id="lb_alarm" style="overflow:hidden;"></div>
	</div>
	<div id="tabs4" title="ACL策略" data-options="fit:true" style="padding:10px;background:#eee;overflow:hidden;" >
		<div id="lb_ACL" style="overflow:hidden;"></div>
	</div>
</div>	
-->
<script type="text/javascript">
	$(document).ready(function() {
		$('#lb_tabs').tabs({
			border : false,
			onSelect : function(title, index) {
				if (index == 1) {//服务监听配置
					$("#lb_listen").panel({
						href : '${pageContext.request.contextPath}/web/lb/lbmanlisten.jsp'
					});
				}else if (index == 2) {//后端服务器配置
					$("#lb_vm").panel({
						href : '${pageContext.request.contextPath}/web/lb/lbmanvm.jsp'
					});
				}else if (index == 3) {//运行监控
					$("#lb_alarm").panel({
						href : '${pageContext.request.contextPath}/web/lb/lbmanalarm.jsp'
					});
				}else if (index == 4) {//ACL
					$("#lb_ACL").panel({
						href : '${pageContext.request.contextPath}/web/lb/lbAclStrategy.jsp'
					});
				}
			}
		});
	}); 
	
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
	
	function editLbname() {
        $('#displaynameEdit input').val($('#displaynameShow em').text());
        $('#displaynameShow').hide();
        $('#displaynameEdit').show();

    }

    function saveLbname() {
    	$('#lb_operate').form('submit',
    			{
    				url : '${pageContext.request.contextPath}/lb/updateLbInfo.do',
    				onSubmit : function(param) {
    					param.displayname=$('#displaynameEdit input').val();
    					param.discription='';
    					
    					param.lbid=$("#lbid").val();
    				},
    				success : function(retr) {
    					var _data = $.parseJSON(retr);
    					if (_data.success) {
    						$('#displaynameShow em').text($('#displaynameEdit input').val());
    						$('#displaynameShow em').attr('title', $('#displaynameEdit input').val());
    						$('#displaynameShow').show();
    						$('#displaynameEdit').hide();
    					} else {
    						 $.messager.alert('提示', _data.msg, 'error');
    					}
    				}
    			});
    }
    
    function editLbdescription() {
        $('#descriptionEdit input').val($('#descriptionShow em').text());
        $('#descriptionShow').hide();
        $('#descriptionEdit').show();

    }

    function saveLbdescription() {
    	$('#lb_operate').form('submit',
    			{
    				url : '${pageContext.request.contextPath}/lb/updateLbInfo.do',
    				onSubmit : function(param) {
    					param.displayname='';
    					param.description=$('#descriptionEdit input').val();
    					param.lbid=$("#lbid").val();
    				},
    				success : function(retr) {
    					var _data = $.parseJSON(retr);
    					if (_data.success) {
    						$('#descriptionShow em').text($('#descriptionEdit input').val());
    						$('#descriptionShow em').attr('title', $('#descriptionEdit input').val());
    						$('#descriptionShow').show();
    						$('#descriptionEdit').hide();
    					} else {
    						 $.messager.alert('提示', _data.msg, 'error');
    					}
    				}
    			});
    }
</script>
</body>
