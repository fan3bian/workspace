<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.inspur.icpmg.gov2.vo.up.Resourceservertype"%>
<%@page import="com.inspur.icpmg.ordersMg.action.ServiceTypeAction"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Map reMap = ServiceTypeAction.getServiceTypes();
List<Resourceservertype> lists =(List<Resourceservertype>)reMap.get("topType");
int listsLen=lists.size();
%>
 
<%@ include file="/icp/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>资源变更</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
  </head>
  
  <body>
  	 <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" />
     <div class="easyui-layout lcy-body" data-options="fit:true,border:false">
        <div data-options="region:'north',border:false" style="height: 50px;">
            <form id="resourceRearchform">
                <div style="margin: 0 20px;">
                    <table class="lcy-search">
                        <tr>
                            <td>使用单位：
                                <input name="useUnit" id="useUnit">
                            </td>
                            <td>实例名称：
                                <input name="neName" id="neName" style="width:200px;" class="easyui-textbox">
                            </td>
                            <td>服务名称：
                                <input name="serverName" id="serverName" style="width:200px" class="easyui-textbox">
                            </td>
                            <td align="center" colspan="1">
                                <a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
                                <a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
        
        <div data-options="region:'center',border:false">
            <div class="lcy-fqdd">
                <!-- 分类 -->
                <div class="lcy-fqdd-select j-select" style="height: 20px;">
                    <ul style="margin-bottom: 10px">
                        <li>
                            <div class="header zybg-title">源列表</div>
                            <div class="body" style="line-height: 25px; padding-left: 77px; color: #666;">
                               	请选择需要变更的资源，进行逐条变更
                             </div>
                        </li>
                    </ul>
                    <style>
                    .zybg-wrap .datagrid-header-row,
                    .zybg-wrap .datagrid-row {
                        height: 35px;
                    }
                    </style>
                    
                    <!-- 资源变更列表 -->
                    <div class="zybg-wrap" sytle="width:900px;" id="resourceChangeListDiv">
                        <table id="reschangedg" data-options="rownumbers: false,border: false,nowarp: false,singleSelect: true, 
					        method: 'post',loadMsg: '数据装载中......',idField: 'neid'" sytle="width:900px;">
                            <thead>
                                <tr>
                                	<th data-options="field:'ck',checkbox:true,align:'center',hidden:true"　></th>
                                	<th data-options="field:'configure',align:'center',hidden:true"></th>
                                	<th data-options="field:'typeid',align:'center',hidden:true"></th>
									<th data-options="field:'configure',align:'center',hidden:true" ></th>
									<th data-options="field:'projectid',width:20,align:'center',hidden:true"></th>
                                    <th data-options="field:'projectname',width:130,align:'center'">项目名称</th>
                                    <th data-options="field:'unitname',width:140,align:'center'">使用单位</th>
                                    <th data-options="field:'servertypenamelevelfirst',width:70,align:'center'">服务类型</th>
                                    <th data-options="field:'servertypenamesecond',width:100,align:'center'">服务名称</th>
                                    <th data-options="field:'appname',width:80,align:'center'">应用</th>
                                    <th data-options="field:'neid',width:200,align:'center'">实例名称</th>
                                    <th data-options="field:'testtime',width:100,align:'center'">开通时间</th>
                                    <th data-options="field:'usetime',width:100,align:'center'">计费时间</th>
                                    <th data-options="field:'feestat',width:50,align:'center'"  formatter="statusFormatter">状态</th>
                                    <th data-options="field:'operation',width:70,align:'center',formatter:formatOper">操作</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="btn-toggle "> <a href="javascript:void(0)" class="btn-toggle-z j-toggle-z">展开<span class="icon-btn-arrow-down"></span></a> <a href="javascript:void(0)" class="btn-toggle-s j-toggle-s">收起<span class="icon-btn-arrow-up"></span></a></div>
                </div>
           
           <!-- 资源申请单表格 -->
           <div class="lcy-fqdd-t">
              <div class="header">资源申请单</div>
              <%
                 for(int i=0;i<listsLen;i++){
               %>
               <input type="hidden" id="hidden<%=i%>" value="<%=lists.get(i).getServertypename()%>">
               <input type="hidden" id="hiddenid<%=lists.get(i).getServertypeid()%>" value="<%=i%>">
               <div class="t-wrap-iaas">
                  <table id="iaas<%=i%>" width="100%"></table>
               </div>
              <%}%>
             
              <div class="info">
                  <p class="fqr">发起人: <span>${sessionUser.uname}</span></p>
                  <p class="fqdw">发起单位：<span>${sessionUser.unitname}</span></p>
                  <p class="fqdate"></p>
              </div>
              
              <div class="snote" style="margin-top: 15px">
              	<form id="filesform" method="post"  enctype="multipart/form-data" >
	                 <table>
	                  	<tr>
		                    <td rows="7"><span style="">主要用途:&nbsp;&nbsp;</span></td>
		                   	<td><textarea rows="7" cols="165" id="order_note"></textarea></td>
		               </tr>
		               <tr>
		               	   <td><span style="">技术方案:&nbsp;&nbsp;</span></td>
		                   <td><span><input type="file" id="fileload" style="width: 500px;height: 30px; " name="fileload"></span></td>
		               </tr>
	                 </table>
                 </form>
              </div>
              
              <div class="btn-box">
                  <a href="javascript:updateOrderOk()" id="submitBtn" class="easyui-linkbutton j-yes" data-options="iconCls:'icon-ok'">确定</a>
                 <%--
                 	 <a href="javascript:void(0)" class="easyui-linkbutton j-cancle" data-options="iconCls:'icon-cancel'">取消</a>
                  --%>
              </div>
           </div>
    	</div>
   	  </div>
   </div>
   	
    <!-- 服务器弹层 -->
    <div id="serviceWindowZybg">
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="cpuchooseZybg">
                  
                </ul>
            </div>
            <div class="lcy-window-item-header">CPU</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="memchooseZybg">
                  
                </ul>
            </div>
            <div class="lcy-window-item-header">内存</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                  <input id="templateZybg" style="width: 340px;height: 30px; ">
            </div>
            <div class="lcy-window-item-header">操作系统</div>
        </div>
         <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="disktype">
                    <li class="active" value="0">应用盘</li>
                    <li value="1">数据库盘</li>
                </ul>
            </div>
            <div class="lcy-window-item-header">磁盘类型</div>
        
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body ">
                <div class="j-xtp">
                    <div class="j-xtp-item item-sildebox">
                        <!-- 滑块 -->
                        <div class="j-silde"></div>
                        <!-- 滑块右侧 -->
                        <div class="item-right">
                            <input type="text" value="10" class="j-value"><span>GB</span>
                           <%--<a href="javascript:void(0)" class="lcy-window-item-body-delete" onclick="xtpDelete(this)">x</a> --%> 
                        </div>
                    </div>
                </div>
                <%-- 
                <div id="addLinkPannelZybg" class="easyui-panel" style="width:100px;padding:5px">
                    <a id="addLinkBtnZybg" href="javascript:void(0)" class="easyui-linkbutton" onclick="xtpAddNewZybg(10)">+增加一块</a></div>
                    --%>
            </div>
            <div class="lcy-window-item-header" style="padding-top:20px;">数据盘</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="network">
                    <li value="10001">政务外网</li>
                    <li value="10002">互联网</li>
                </ul>
            </div>
            <div class="lcy-window-item-header">网络</div>
        
        </div>
           <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                 <input id="resourceappZybg" style="width: 320px;height: 30px; ">
                 <%--<span style="position: relative; top: 4px;left: 8px" onclick="addApp()">
                 	<img src="${ctx}/easyui-1.4/themes/icons/edit_add.png">
                 </span> --%>
            </div>
            <div class="lcy-window-item-header">应用名称</div>
        </div>
        
        <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                <div class="add-sub">
                    <!-- <a class="subbtn" id="subBtn" href="javascript:void(0)">-</a> -->
                    <input class="input-num" id="input-num" type="text" value="1" style="border-left:1px solid #ddd;border-right:1px solid #ddd;" disabled>
                    <!-- <a class="addbtn" id="addBtn" href="javascript:void(0)">+</a> -->
                    &nbsp;<span id="serviceDw"></span>
                </div>
            </div>
            <div class="lcy-window-item-header">数量</div>
        </div>
        <!-- 占位 -->
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 61px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
      
    </div>
    <!-- 弹层结束 -->
    
    <!-- 云硬盘弹层 -->
    <div id="IndiskWindowZybg" style="padding:3px 0px;">
	    <style>
			.not-allowed{background: #eee;
	    	cursor: not-allowed;}
		</style>
        <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">配置信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout" style="table-layout:fixed">
                       
                        <tr>
                            <td align="right" style="width:15% ; "> <span class="must-star">*</span>名称：</td>
                            <td align="left" style="width:32%;">
                                <input class="ty-top-input" name="" id='storenameBg' readonly='readonly' class="not-allowed" style="width:160px" >
                            </td>
                            <!-- <td align="right" style="width:10%;"> <span class="must-star">*</span>区域：</td>
                            <td align="left" style="width:30%;">
                                <input class="ty-top-input" name="" id='storeNetWorkBg' readonly='readonly' style="height:28px,width:164px" >
                            </td> -->
                       	</tr>
                       	<!-- <tr>
                       		<td align="right" style="width:15% ; "> <span class="must-star">*</span>所挂载云服务器：</td>
                            <td align="left" style="width:40%;">
                                <input class="ty-top-input" name="" id='storeAttachVmBg'  style="width:164px" >
                            </td>
                            <input id='attachNeidBg' class="ty-top-input" type="hidden">
                            <input id='platformidBg' class="ty-top-input" type="hidden">
                            <input id='ipaddressBg' class="ty-top-input" type="hidden">
                        </tr> -->
                        <tr>
                        	<td align="right" style="width:15% ; "> <span class="must-star">*</span>容量：</td>
                            <td align="left" colspan="3" style="width:40%;height:70px" class="j-xtp-item"> 
                            <div class="j-silde"></div> 
                            <div class="item-right" style="position: static;margin-left: 392px;margin-top: -25px;">
				            	<input type="text" id="diskValueBg" class="j-indisk"><span>GB</span>
				            </div>
                        </tr>
                        
                        <!-- <tr>
                            <td align="right">硬盘描述：</td>
                            <td align="left" colspan="3">
                              <textarea style="height: 90px;width: 473px;border:1px solid #ddd; border-radius: 3px; " id='storeinfoBg' ></textarea>
                            </td>
                        </tr> -->
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- 弹层结束 -->
    <!-- 其他弹出层1 -->
    <div id="serviceWindowZybg_other">
    	<!-- 占位 -->
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 10px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    	<div class="lcy-window-item">
            <div class="lcy-window-item-body">
                  <textarea id="config" style="width: 500px;height: 200px; "></textarea>
                  <input id="userunit" name="userunit" value="" type="hidden"/>
                  <input id="unitname" name="unitname" type="hidden"/>
                  <input id="neid" name="neid" type="hidden" />
                  <input id="projectid" name="projectid" type="hidden"/>
                  <input id="projectname" name="projectname" type="hidden"/>
                  <input id="pshopid" name="pshopid" type="hidden"/>
                  <input id="pshopname" name="pshopname" type="hidden" />
                  <input id="servertypeidlevelsecond" name="servertypeidlevelsecond" type="hidden"/>
            </div>
            <div class="lcy-window-item-header">规格配置</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="network_other">
                    <li value="10001">政务外网</li>
                    <li value="10002">互联网</li>
                </ul>
                </ul>
            </div>
            <div class="lcy-window-item-header">网络</div>
        
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                 <input id="resourceapp_other" style="width: 320px;height: 30px; ">
                 <%--
                 	<span style="position: relative; top: 4px;left: 8px" onclick="addApp()">
                 		<img src="${ctx}/easyui-1.4/themes/icons/edit_add.png">
                 	</span>--%>
                  
            </div>
            <div class="lcy-window-item-header">应用名称</div>
        </div>
         <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 10px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    	<div class="lcy-window-item" >
            <div class="lcy-window-item-body" >
                <div class="add-sub" >
                	<%--
                		<a class="subbtn" id="subBtn_other" href="javascript:void(0)">-</a>
                    <a class="addbtn" id="addBtn_other" href="javascript:void(0)">+</a>&nbsp;<span id="productunit"></span>
                	--%>
                    <input class="input-num" id="inptNum" type="text" value="1" style="border-left:1px solid #ddd;border-right:1px solid #ddd;" disabled />
                	 &nbsp;<span id="serviceOtherDw"></span>
                </div>
            </div>
            <div class="lcy-window-item-header">数量</div>
        </div>
       <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 30px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    
    </div>
    <!-- 其他弹出层 结束 -->


    
    <script type="text/javascript">
    	var oldRowData = new Object();//全局变量，存放行值
    	var operatetype = "";//全局变量 ， 操作类型：1变更，2注销
    	var changeNeids="";//全部变量，记录要变更/删除的资源id
    	var diskCount = 0;//云服务器挂载磁盘数量
    	var disknumTemp = 0;//全局变量  云硬盘容量（变更前）
    	var indisk = $('#IndiskWindowZybg').html();//云硬盘
    	$(document).ready(function(){
			//查询条件，所属单位赋值
    		$('#useUnit').combobox({
    			url:'${pageContext.request.contextPath}/project/getUnitsData.do',
    			valueField: 'unitId',
    			textField: 'unitName',
    			width:170,
    			panelHeight: '100',
    			loadFilter:function(data){
    				data.unshift({unitId:"",unitName:"请选择"});
    				return data;
    			}
    		});
			
    		 loadDataGrid();
    		 
    	});
    	
    	 $('#appname').textbox({    
    	     iconCls:'icon-apps', 
             iconAlign:'left'             
    	})
    	
	    
    	//获取当前日期
    	function getFormattime () {
	       var date = new Date();
	       return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	    }
    	$(".fqdate").html("发起时间："+getFormattime());
    	
    	//初始化列表状态
    	function statusFormatter(val,rows,index){
    		switch (rows.feestat) {
    			case "1":
    				return "试运行";//开始试运行修改为试运行
    			case "2":
    				return "计费开始";
    			case "3":
    				return "计费结束";
    		}
    	}
    	
    	//初始化列表操作(变更+注销)
	    function formatOper(val, row, index) {
    		var atag;
    		if(row['neid']==undefined || row['neid']==""){
    			atag = "";
    		}else if(row['neid'].indexOf('SECURITY')!=-1) {
    		  atag  =  '<a href="#" onclick="cancellation('+index+')" class="j-cancellation"  title="注销"></a>'; 
    		}
    		else{
    			atag  = '<a href="#" onclick="variation(' + index + ')" class="j-variation"  title="变更"></a>'+
				   '<span class="gproducts-partingline">&nbsp;|&nbsp;</span>'+
				   '<a href="#" onclick="cancellation('+index+')" class="j-cancellation"  title="注销"></a>';
    		}
	   		return atag;
	    }
	    
	    //变更按钮点击事件
	    function variation(index) {
	    	oldRowData  = new Object();
	    	//event.stopPropagation();//阻止冒泡
	    	oldRowData = $('#reschangedg').datagrid('getData').rows[index];//获取选中行的所有数据
	    	
	    	var nId = oldRowData['neid']+";";
	    	if(changeNeids.indexOf(nId) != -1){
	    		$.messager.alert('提示',"该资源已添加到变更申请单中，请重新选择资源或者删除后再进行变更!",'info'); 
                return false;
	    	}
	    	
	    	operatetype = "1";//操作类型：1变更，2注销
	     
	        var typeId = oldRowData['typeid'];
	        selectFlag = oldRowData['servertypenamesecond'];
	        if(typeId == "VM"){//服务器
	        	 //初始化cpu
	    	     initCpu();
	    	     $("#cpuchooseZybg").children().remove();
	    	     //初始化內存
	    	     initMem();
	    	     $("#memchooseZybg").children().remove();
	    	     //初始化应用
	    	     $("#resourceappZybg").combobox({
	    	        url:'${ctx}/ordermg/getapps.do?unitid='+oldRowData['unitid'],
	    	        valueField: 'appid',
	    	        textField: 'appname',
	    	        disabled:true,
	    	        loadFilter:function(data){
	    	        data.unshift({appid:'',appname:"---请选择---"});
	    	        return data;
	    	        }
	    	    })
	    	    
	    	    //数据盘大小初始化
	    	    
	    	    diskCount = oldRowData.vmDiskList.length;//挂在磁盘数量
	    	    //先清空，后重新赋值
	    	    $("#serviceWindowZybg .item-sildebox").remove(); //或者  $('.j-xtp').html("");
	    	    if(parseInt(diskCount) > 0){
	    	    	for(var i=0; i<diskCount;i++){
	    	    		xtpAddZybg(i,oldRowData.vmDiskList[i].diskid,oldRowData.vmDiskList[i].disknum);
	    	    	    
	    	    	}
	    	    }
	    	    
	    	    /*
	    	    var disknum =oldRowData['disknum'].split(";");//oldRowData['disknum'].split(";");//1,10;2,0
	    	    var morenValue1 = 10;//默认值
	    	    var morenValue2 = 10;//默认值
	    	    if(disknum.length == 1){
	    	    	var temp1 = disknum[0].split(",")[1];
	    	    	if(temp1!="0"&&temp1!="null"&&temp1!=null){
	    	    		morenValue1 = temp1;
	    	    		xtpAddZybg(morenValue1);
	    	    	}
	    	    }else if(disknum.length == 2){
	    	    	var temp1 = disknum[0].split(",")[1];
	    	    	if(temp1!="0"&&temp1!="null"&&temp1!=null){
	    	    		morenValue1 = temp1;
	    	    		xtpAddZybg(morenValue1);
	    	    	}
	    	    	var temp2 = disknum[1].split(",")[1];
	    	    	if(temp2!="0"&&temp2!="null"&&temp2!=null){
	    	    		morenValue2 = temp2;
	    	    		xtpAddZybg(morenValue2);
	    	    	}
	    	    }*/
	    	    
	    	    $("#serviceDw").text(oldRowData['measureunit']);
	            $('#addLinkBtnZybg').linkbutton({
	            });
	            
	            $('#addLinkPannelZybg').tooltip({
	                position: 'right',
	                content: '<span style="color:#666">最多可增加两块盘</span>',
	                onShow: function() {
	                    $(this).tooltip('tip').css({
	                        backgroundColor: '#afe8ff',
	                        borderColor: '#afe8ff'
	                    });
	                }
	            });
	           
	            //操作系统
	            $("#templateZybg").combobox({
		                url:'${pageContext.request.contextPath}/vmconfig/queryTemplates.do',    
		    	        valueField:'templateid',    
		    	        textField:'templatename',
		    	        disabled:true,//设置为不可编辑
		    	        loadFilter:function(data){
		    	        data.unshift({templateid:'',templatename:"---请选择---"});
		    	        return data;
		    	    },
		    	    onSelect: function(data){ 
		    	      $(this).combobox('setText', data.templatename.substring(data.templatename.indexOf(">")+1));
		    	    },
		    	    onLoadSuccess: function () { 
		    	       /*
		    	       //加载完成后,设置选中第一项
		    	       var data = $('#templateZybg').combobox('getData');
		               if (data.length > 0) {
		                     $('#templateZybg').combobox('select', data[0].templateid);
		                 
		                     $('#templateZybg').combobox('select', data[0].templatename.substring(data[0].templatename.indexOf(">")+1));
		               	} 
		               */
			           $("#templateZybg").combobox('select',oldRowData['osname']);//操作系统赋值
		    	    }   
	            });
	          
	    	    $('#resourceappZybg').combobox('select',oldRowData['appid']);//应用赋值
	            if(oldRowData['tnumber'] != "null" && oldRowData['tnumber'] != null){
	        		$("#input-num").val(oldRowData['tnumber']);//数量赋值
	        	}else{
	        		$("#input-num").val('1');
	        	}
	            var networkid = oldRowData['networktypeid'];//网络类型
	            if(networkid =="0001"){
	                $('#network li').eq(0).addClass('active').siblings().removeClass('active');
	            } else{
	                $('#network li').eq(1).addClass('active').siblings().removeClass('active');
	            }
	            var disktype = oldRowData['configure'];//configue
	            if("应用盘"==disktype.split(";")[4].split(":")[1]){
	              $('#disktype li').eq(0).addClass('active').siblings().removeClass('active');
	            }else{
	              $('#disktype li').eq(1).addClass('active').siblings().removeClass('active');
	            }
	            $('#serviceWindowZybg').dialog({
	                closed: false,
	                height: 592,
	                title: selectFlag
	            });
	            
	        }else if(typeId == "InDisk"){
	        	$('#IndiskWindowZybg').dialog({
	                closed: false,
	                title: selectFlag
	            });
	        	$('#IndiskWindowZybg').html(indisk);
	        	var confInfo = oldRowData['configure'];//名称:0;区域:1;挂载云服务器：2;容量：3;描述信息:4
	 	        /* var confInfoArray = new Array();
	 	        confInfoArray = confInfo.split(";");
	 	        var oldName = confInfoArray[0].split(":")[1];
	 	        var oldServerid = confInfoArray[2].split(":")[1];//oldserverid */
	 	        var store = confInfo.split(":")[1];//容量
	 	        disknumTemp = confInfo.split(":")[1];//容量
	 	        //var storeinfo = confInfoArray[4].split(":")[1];//描述
	        	$("#storenameBg").val(oldRowData['neid']);
	        	/* $("#storeNetWorkBg").val(oldRowData['networktypename']);
	        	$("#storeAttachVmBg").val(oldServerid);
	        	$("#storeinfoBg").text(storeinfo); */
	        	$("#diskValueBg").val(store);
	        	
	        	// 云硬盘滑块初始
	            $('.j-silde').slider({
	                width: 350,
	                showTip: true,
	                value: 1,
	                min: store,
	                max: 2000,
	                step: 1,
	                disabled: false,
	                rule: [store,'|',1000,'|', 2000],
	                tipFormatter: function(value) {
	                    return value + 'GB';
	                },
	                onChange: function(value) {
	                    $(this).parent("td").find('.j-indisk').val(value);
	                }
	            });
	            
	            /* $('#storeNetWorkBg').combobox({
	    			valueField: 'networkid',
	    			textField: 'networkname',
	    			width: '161',
	    			height: '28'
	    		}); */
	            /* var unitid = oldRowData['unitid'];
	            var networktypeid = oldRowData['networktypeid'];
	            $('#storeAttachVmBg').combobox({
		       		panelWidth: 175, 
		       		url: '${pageContext.request.contextPath}/vm/queryVmsByUnitid.do?unitid='+unitid+'&networktypeid='+networktypeid,
		       	 	valueField:'serverid',
			    	textField:'displayname',
			    	formatter: function(row){
						var s = '<span>' + row.displayname + '</span><br/>' +
						'<span style="color:#888">' + row.ipaddr + '</span>';
						return s;
					},
		       	    onSelect: function(rec){
		       	    	if(rec.serverid != oldServerid){		       	    		
			       		  	$.ajax({
			       		  		type: 'post',
			       		  		url: '${pageContext.request.contextPath}/indisk/getCount.do',
			       		  		data: {serverid: rec.serverid},
			       		  		success: function(data){
			       		  			var _data = JSON.parse(data);
						  			if(_data.total > 1){
						  				$.messager.alert('消息','该服务器已挂载两个，请选择其他服务器'); 
						  				$('#storeAttachVmBg').combobox('setValue', oldServerid);
						  			} else {
										$('#attachNeidBg').val(rec.serverid);
										$('#platformidBg').val(rec.platformid);
										$('#ipaddressBg').val(rec.ipaddr);
						  			}
			       		  		}
			       		  	});
		       	    	}
		       		}
		       	}); */
	        	
	        }else{//其他资源-非云服务器
	        	//应用下拉框赋值
		        $("#resourceapp_other").combobox({
			        url:'${ctx}/ordermg/getapps.do?unitid='+oldRowData['unitid'],
			        valueField: 'appid',
			        textField: 'appname',
			        disabled:true,
			        loadFilter:function(data){
				        data.unshift({appid:'',appname:"---请选择---"});
				        return data;
			        }
			    });
	        	$("#neid").val(oldRowData['neid']);
	        	$("#config").val(oldRowData['configure']);
	        	$("#userunit").val(oldRowData['unitid']);
	        	$("#unitname").val(oldRowData['unitname']);
	        	$("#projectid").val(oldRowData['projectid']);
				$("#projectname").val(oldRowData['projectname']);
				$("#pshopid").val(oldRowData['pshopid']);
				$("#pshopname").val(oldRowData['pshopname']);
				$("#servertypeidlevelsecond").val(oldRowData['servertypeidlevelsecond']);
				$("#serviceOtherDw").text(oldRowData['measureunit']);
	        	var networkid = oldRowData['networktypeid'];
	            if(networkid =="0001"){
	                $('#network_other li').eq(0).addClass('active').siblings().removeClass('active');
	            } else{
	                $('#network_other li').eq(1).addClass('active').siblings().removeClass('active');
	            }
	            
	        	$('#resourceapp_other').combobox('select',oldRowData['appid'])
	        	if(oldRowData['tnumber'] != "null" && oldRowData['tnumber'] != null){
	        		$("#inptNum").val(oldRowData['tnumber']);//数量赋值
	        	}else{
	        		$("#inptNum").val('1');
	        	}
	        	
	        	$('#serviceWindowZybg_other').dialog({
	                closed: false,
	                increment: 1,
	                height: 540,
	                title: selectFlag
	              });
	        }
	    }
	
    	//注销按钮事件
	    function cancellation(index) {
    		operatetype = "2";//操作类型:1变更，2注销
	        //event.stopPropagation();//阻止冒泡
	        oldRowData  = new Object();
	    	oldRowData = $('#reschangedg').datagrid('getData').rows[index];//获取选中行的所有数据
	    	
	    	var nId = oldRowData['neid']+";";
	    	if(changeNeids.indexOf(nId) != -1){
	    		$.messager.alert('提示',"该资源已添加到变更申请单中，请重新选择资源或者删除后再进行变更!",'info'); 
                return false;
	    	}
	    	
	    	 $.messager.confirm('请确认','您确定要将服务注销吗?',function(b){
	    		var newConfig="";
	        	if(b){
	        	   oldRowData  = new Object();
	     	       oldRowData = $('#reschangedg').datagrid('getData').rows[index];//获取选中行的所有数
	     	       
	     	       changeNeids = changeNeids + oldRowData['neid']+";";
	     	   
	     	       var typeId = oldRowData['typeid'];
	     	        
	     	       if(typeId == "VM"){//服务器
	     	    	   //CPU:8核;内存:8G ;操作系统:CentOS5.8-64位;磁盘(G):10,0;磁盘类型:应用盘
	     	    	   newConfig = "CPU:0核;内存:0G;操作系统:'';磁盘(G):0,0;磁盘类型:''";
	     	       }else if(typeId == "InDisk"){//云硬盘
	     	    	  newConfig = "容量(G):0";
	     	       }
	     	       var idname =   $("#hiddenid"+oldRowData['pshopid']).val();
        		   $('#iaas'+idname).datagrid('insertRow', {
                       index: 0, // index start with 0
                       row: {
                    	    neid:oldRowData['neid'],
                    	    operatetype:operatetype,
	                        serviceid: oldRowData['servertypeidlevelsecond'],
	                        itemname: oldRowData['servertypenamesecond'],
	                        oldconfigure:oldRowData['configure'],
	                        newconfigure: newConfig,
	                        typeid:oldRowData['typeid'],
	                        pshopid:oldRowData['pshopid'],
	                        pshopname:oldRowData['pshopname'],
	                        proid:oldRowData['projectid'],
	                        proname:oldRowData['projectname'],
	                        unitid: oldRowData['unitid'],
	                        unitname:oldRowData['unitname'],
	                        appid:'',
	                        appname:'',
	                        networktypeid:oldRowData['networktypeid'],
	                        networktype:oldRowData['networktypename'],
	                        measureunit: oldRowData['measureunit'],//单位
	                        tnumber:1,
	                        oldatprice:oldRowData['oldatprice'],
	                        oldtprice:oldRowData['oldtprice'],
	                        operatetypeName:'注销'
                       }  
                   }); 
        		   $(".j-toggle-s").click(); 
	        	}
	        });
	    }
    	
	    $(".j-toggle-z").click(function() {
	        $(".j-select").height("auto");
	        $(this).hide().siblings().show();
	        $('#reschangedg').datagrid({
	            width: $('.j-select').width() + 40
	        })
	
	    })
	    
	    $(".j-toggle-s").click(function() {
	        $(".j-select").height("20px");
	        $(this).hide().siblings().show();
	
	    })
	
	    //服务名称
	    $('#serverName').combobox({
			url:'${ctx}/resourceinfo/getSevertypeSecondList.do',
			valueField: 'servertypeid',
			textField: 'servertypename',
			width:150,
			panelHeight: '100'
		});
	    
	    //申请单表格数据加载
	    function loadDataGrid() {
	        var str;
	        for (i = 0,len = $(".t-wrap-iaas").length; i<len; i++) {
	            //id1 = 'iaas' + i;
	            $('#iaas' + i).datagrid({
	            	title:  $("#hidden"+i).val(),
	                rownumbers: false,
	                scrollbarSize: 0,
	                border: false,
	                nowrap :false,
	                method: 'post',
	                loadMsg: '数据装载中......',
	                fitColumns: true,
	                url: '',
	                columns: [
						[{
							field:'operatetype',
							title:'操作类型',
							width:60,
							hidden:true,
							align:'center'
						},{
						    field: 'serviceid',
						    title: '服务编码 ',
						    width: 60,
						    align: 'center'
						}, {
						    field: 'itemname',
						    title: '服务名称',
						    width: 80,
						    align: 'center'
						},{
						    field: 'neid',
						    title: '实例名称 ',
						    width: 130,
						    align: 'center'
						}, {
						    field: 'oldconfigure',
						    title: '原有规格',
						    width: 190,
						    align: 'center'
						}, {
						    field: 'newconfigure',
						    title: '变更规格',
						    width: 190,
						    align: 'center'
						},{
						    field: 'typeid',
						    title: '单位ID',
						    width: 50,
						    hidden:true,
						    align: 'center'
						},{
						    field: 'pshopid',
						    title: '一级服务大类id-父级商品ID',
						    width: 80,
						    hidden:true,
						    align: 'center'
						},
						    {
						    field: 'pshopname',
						    title: '一级服务大类名称-父级商品名称',
						    width: 80,
						    hidden:true,
						    align: 'center'
						},{
						    field: 'proid',
						    title: '项目ID',
						    width: 80,
						      hidden:true,
						    align: 'center'
						},
						  {
						    field: 'proname',
						    title: '项目名称',
						    width: 80,
						      hidden:true,
						    align: 'center'
						},{
						    field: 'unitid',
						    title: '使用单位ID',
						    width: 80,
						     hidden:true,
						    align: 'center'
						},{
						    field: 'unitname',
						    title: '使用单位',
						    hidden:true,
						    width: 80,
						    align: 'center'
						},{
						    field: 'measureunit',
						    title: '单位',
						    width: 40,
						    align: 'center'
						},{
						    field: 'tnumber',
						    title: '数量',
						    width: 40,
						    align: 'center'
						},{
						    field: 'operatetypeName',
						    title: '操作类型',
						    width: 50,
						    align: 'center'
						},{
							field:"oldatprice",
							title:"原有价格",
							width:60,
							hidden:true,
							align:'center'							
						},{
							field:"oldtprice",
							title:"原有价格",
							width:60,
							hidden:true,
							align:'center'							
						},{
							field:"appid",
							title:"应用id",
							width:60,
							hidden:true,
							align:'center'							
						},{
							field:"appname",
							title:"应用名称",
							width:60,
							hidden:true,
							align:'center'							
						},{
							field:"networktypeid",
							title:"网络类型id",
							width:60,
							hidden:true,
							align:'center'							
						},{
							field:"networktype",
							title:"网络类型名称",
							width:60,
							hidden:true,
							align:'center'
						},{
						    field: 'operate',
						    title: '操作',
						    width: 50,
						    align: 'center',
						    formatter: function(value, rec, index) {
						          str = '<span onclick="del(' + "'" + index + "'" + ',' + "this" + ');"  title="删除"><img src="${ctx}/images/order-delete.png" alt="" style="vertical-align: middle;"/></span>';
						          return str;
						    }
						}]
	                ]
	            })
	        }
	
	    }
	    
	    $(window).resize(function() {
	        $("#iaas").datagrid('resize', {
	            width: $(".t-wrap-iaas").width //收缩引起window resize,重新计算值，并调用resize方法。
	        });
	        $("#paas").datagrid('resize', {
	            width: $(".t-wrap-iaas").width //收缩引起window resize,重新计算值，并调用resize方法。
	        });
	        $("#saas").datagrid('resize', {
	            width: $(".t-wrap-iaas").width //收缩引起window resize,重新计算值，并调用resize方法。
	        });
	    });
	
	    //删除行操作  
	    function del(index, obj) {
	        id = $(obj).parents(".datagrid-view2").next("table").attr("id");
	        index = $(obj).parents("tr").index();
	        $.messager.confirm('确认', '确认删除?', function(row) {
	            if (row) {
	                var selectedRow = $("#" + id).datagrid('getSelected'); //获取选中行  
	                changeNeids = changeNeids.replace((selectedRow['neid']+";"),"");
	                $("#" + id).datagrid('deleteRow', index);
	            }
	        })
	    }
	
	    //查询
	    $('#search').click(function(event) {
	    	if ($('#resourceRearchform').form('validate')) {
	    		$('#reschangedg').datagrid('load',icp.serializeObject($('#resourceRearchform')));
	    	} 
	        $('.j-toggle-z').click();
	    });
	    
	    //重置
        $("#formReset").click(function() {
            $("#resourceRearchform").form("reset");
            $('#reschangedg').datagrid('load',icp.serializeObject($('#resourceRearchform')));
            $('.j-toggle-z').click();
        });
	    
	  	//列表数据加载
	    $(function() {
	        $('#reschangedg').datagrid({
	            pagination: true,
	            pageSize: 10,
	            pageList: [10, 20, 30, 40, 50],
	            url: '${pageContext.request.contextPath}/resourcechange/getResourceChangeList.do',
	            onLoadSuccess: function(data) {
	                var pageopt = $('#reschangedg').datagrid('getPager').data("pagination").options;
					var  _pageSize = pageopt.pageSize;//每页分页条数
					var  _rows = $('#reschangedg').datagrid("getRows").length;//当前页实际条数
					var total = pageopt.total; //显示的查询的总数
					if (_pageSize >= 10) {
						for(i=10;i>_rows;i--){
							//添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
							$(this).datagrid('appendRow', {flowid:''  })
						}
						$('#reschangedg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
					    	total: total,
					     });
					}else{
						//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
						$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					}
					
					$('.j-variation').linkbutton({
	                    iconCls: 'icon-variation',
	                    plain: true
	                });
	                $('.j-cancellation').linkbutton({
	                    iconCls: 'icon-cancellation',
	                    plain: true
	                });
	            }
	        })
	    })
	  	
	    var objdata = new Object();
	    var windowHtml = $('#serviceWindowZybg').html();
	    var windowHtmlIndisk = $('#IndiskWindowZybg').html();
	    //弹层配置 - 云服务器
	    $('#serviceWindowZybg').dialog({
	        width: 820,
	        //height: 592,
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
	            	objdata.cpu = $(".lcy-window-item").eq(0).find("li.active").text();
	                objdata.rom = $(".lcy-window-item").eq(1).find("li.active").text();
	                objdata.network = $("#network").find("li.active").text();
	                objdata.networkid = $("#network").find("li.active").val().toString().substring(1);
	                objdata.disktype = $("#disktype").find("li.active").text();
	                objdata.image = $("#templateZybg").combobox('getText');
	                objdata.appid = $("#resourceappZybg").combobox('getValue');
	                objdata.appname = $("#resourceappZybg").combobox('getText');
	                /*if("---请选择---"==objdata.image){
	                	$.messager.alert('提示',"请选择操作系统！",'info'); 
		                return false;
	                }
	                 if(''==objdata.appid){
	                	$.messager.alert('提示',"请选择应用！",'info'); 
		                return false;
	                }*/
	             
	                changeNeids = changeNeids + oldRowData['neid']+";";
	                 
	                //数据盘
	                //var len = $("#serviceWindowZybg .j-xtp .j-xtp-item").length;
	                //diskid  disknum
	                var disks = "";
	                var disksInfo = "";
	                var diskCount = oldRowData.vmDiskList.length;//挂在磁盘数量
		    	    if(parseInt(diskCount) > 0){
		    	    	for(var i=0; i<diskCount;i++){
		    	    		var diskid = oldRowData.vmDiskList[i].diskid;
		                	var disknum = oldRowData.vmDiskList[i].disknum;
		                	disks = disks + parseInt(disknum) +",";
		                	disksInfo = disksInfo + diskid+","+ parseInt(disknum)+";"
		    	    	}
		    	    }
	               
	                if(disks != ""){
	                	disks = disks.substring(0,disks.length-1);
	                }else{
	                	disks = "0";
	                }
	                if(disksInfo != ""){
	                	disksInfo = disksInfo.substring(0,disksInfo.length-1);
	                }
	                
	                objdata.disk = disks;
	                objdata.diskInfo = disksInfo;
	                
	                objdata.unit = oldRowData['unitname'];//$("#userunit").combobox('getText');
	                objdata.unitid = oldRowData['unitid'];//$("#userunit").combobox('getValue');
	                objdata.proid = oldRowData['projectid'];//$("#projectName").combobox('getValue');
	                objdata.proname = oldRowData['projectname'];//$("#projectName").combobox('getText');
	                objdata.num = $("#serviceWindowZybg .lcy-window-item .input-num").val();
	                var idname =   $("#hiddenid"+oldRowData['pshopid']).val();
	                $('#iaas'+idname).datagrid('insertRow', {
	                    index: 0, // index start with 0
	                    row: {
	                    	neid:oldRowData['neid'],
	                    	operatetype:operatetype,
	                        serviceid: oldRowData['servertypeidlevelsecond'],
	                        itemname: $('#serviceWindowZybg').panel('options').title,
	                        oldconfigure:oldRowData['configure'],
	                        //CPU:1核;内存:2G ;操作系统:CentOS6.6-64位;磁盘(G):20,0;磁盘类型:应用盘
	                        newconfigure: "CPU:"+objdata.cpu+";内存:"+objdata.rom+";操作系统:"+ objdata.image+";磁盘(G):"+objdata.disk+";磁盘类型:"+objdata.disktype,
	                        typeid:oldRowData['typeid'],
	                        pshopid:oldRowData['pshopid'],
	                        pshopname:oldRowData['pshopname'],
	                        proid:oldRowData['projectid'],
	                        proname:oldRowData['projectname'],
	                        unitid: oldRowData['unitid'],
	                        unitname:oldRowData['unitname'],
	                        appid:objdata.appid,
	                        appname:objdata.appname,
	                        networktypeid:objdata.networkid,
	                        networktype:objdata.network,
	                        measureunit: oldRowData['measureunit'],//单位
	                        tnumber:objdata.num,
	                        oldatprice:oldRowData['oldatprice'],
	                        oldtprice:oldRowData['oldtprice'],
	                        operatetypeName:'变更'
	                    }
	                });
	                $('#serviceWindowZybg').dialog('close');
	                $(".j-toggle-s").click(); 
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	               $('#serviceWindowZybg').dialog('close');
	            }
	        }]
	    });
	    //弹层配置 - 云硬盘
	    $('#IndiskWindowZybg').dialog({
	    	width: 700,
	        height: 300,
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
	            	/* var networkid = '';
	                var networkname = $("#storeNetWorkBg").combobox('getText');
	                if('互联网'==networkname){
	                	networkid = '0002';
	                }else if('政务外网'==networkname){
	                	networkid = '0001';
	                }
	                var serverid = $("#storeAttachVmBg").combobox('getValue');
	                var platformid = $("#platformidBg").val();
	                var ipaddress = $("#ipaddressBg").val(); */
	                var storenum = $("#diskValueBg").val();//硬盘容量
	                var storename = $("#storenameBg").val();
	                /* var storeinfo = $("#storeinfoBg").val(); */
	                var configure = "容量(G):"+storenum;
	            	var idname = $("#hiddenid"+oldRowData['pshopid']).val();
	            	//alert(ipaddress);
	                $('#iaas'+idname).datagrid('insertRow', {
	                    index: 0, // index start with 0
	                    row: {
	                    	neid:oldRowData['neid'],
	                    	operatetype:operatetype,
	                        serviceid: oldRowData['servertypeidlevelsecond'],
	                        itemname: $('#IndiskWindowZybg').panel('options').title,
	                        oldconfigure:oldRowData['configure'],
	                        newconfigure: configure,
	                        typeid:oldRowData['typeid'],
	                        pshopid:oldRowData['pshopid'],
	                        pshopname:oldRowData['pshopname'],
	                        proid:oldRowData['projectid'],
	                        proname:oldRowData['projectname'],
	                        unitid: oldRowData['unitid'],
	                        unitname:oldRowData['unitname'],
	                        appid:'',
	                        appname:'',
	                        //networktypeid:networkid,
	                        //etworktype:networkname,
	                        tnumber:'1',
	                        measureunit: oldRowData['measureunit'],//单位
	                        oldatprice:oldRowData['oldatprice'],
	                        oldtprice:oldRowData['oldtprice'],
	                        operatetypeName:'变更'
	                    }
	                });
	            	$('#IndiskWindowZybg').dialog('close');
	                $(".j-toggle-s").click();
	            }
            }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function() {
	               $('#IndiskWindowZybg').dialog('close');
	            }
	        }]
	    });
	    //初始化滑块1
	    function initHk1Zybg(morenValue1){
	    	$('#serviceWindowZybg .j-value:eq(0)').val(morenValue1);
	    	$('#serviceWindowZybg .j-value:eq(0)').attr('disabled',true);
    	 	// 滑块1初始
            $('#serviceWindowZybg .j-silde').slider({
                width: 450,
                showTip: true,
                value: morenValue1,
                min: 0,
                max: 2000,
                step: 10,
                disabled:true,
                rule: [0, '|', 2000],
                tipFormatter: function(value) {
                    return value + 'GB';
                },
                onChange: function(value) {
                    $(this).parents("#serviceWindowZybg .j-xtp-item").find('.j-value').val(value);
                }
            });
	    }
	    
	    // 数据盘增加一块
	    function xtpAddZybg(i,diskid,slidVal) {
	        var addhtmlZybg = ' <div class="j-xtp-item item-sildebox"><div class="j-silde"></div>'+
	       				 	 ' <div class="item-right"><input id="diskid'+i+'" type="hidden" value="'+diskid+'"/><input id="disknum'+i+'" type="text" value="'+slidVal+'"  class="j-value" disabled="disabled"><span>GB</span> <a href="javascript:void(0)" class="lcy-window-item-body-delete" onclick="xtpDelete(this)"></a></div></div>';//×
	        var len = $("#serviceWindowZybg .j-xtp .j-xtp-item").length;
	        if (len < diskCount) {
	            $("#serviceWindowZybg .j-xtp .j-xtp-item").show();
	            $("#serviceWindowZybg .j-xtp").append(addhtmlZybg);
	            $('#serviceWindowZybg .j-silde:last').slider({
	                width: 450,
	                value: slidVal,
	                showTip: true,
	                min: 0,
	                max: 2000,
	                disabled:true,
	                step: 10,
	                rule: [0, 2000],
	                tipFormatter: function(value) {
	                    return value + 'GB';
	                },
	                onChange: function(value) {
	                    $(this).parents("#serviceWindowZybg .j-xtp-item").find('.j-value').val(value);
	                }
	            });
	        } 
	    }
	    
	    // 数据盘增加一块
	    function xtpAddNewZybg(slidVal) {
	        var addhtmlZybg = ' <div class="j-xtp-item item-sildebox"><div class="j-silde"></div><div class="item-right"><input id="nnNew" type="text" value="'+slidVal+'"  class="j-value"><span>GB</span> <a href="javascript:void(0)" class="lcy-window-item-body-delete" onclick="xtpDelete(this)">×</a></div></div>'
	        var len = $("#serviceWindowZybg .j-xtp .j-xtp-item").length;
	        if (len < 2) {
	            $("#serviceWindowZybg .j-xtp .j-xtp-item").show();
	            $("#serviceWindowZybg .j-xtp").append(addhtmlZybg);
	            $('#serviceWindowZybg .j-silde:last').slider({
	                width: 450,
	                value: slidVal,
	                showTip: true,
	                min: 0,
	                max: 2000,
	                step: 10,
	                rule: [0, 2000],
	                tipFormatter: function(value) {
	                    return value + 'GB';
	                },
	                onChange: function(value) {
	                    $(this).parents("#serviceWindowZybg .j-xtp-item").find('.j-value').val(value);
	                }
	            });
	        } 
	    }
	    
	    
	    // 删除滑块
	    function xtpDelete(obj) {
	        $(obj).parents("#serviceWindowZybg .j-xtp-item").remove();
	    }
	    
		// 数据盘容量手动输入
	    $(document).on('blur', '.j-value', function() {
	        if (value % 10 != 0) {
	            var yu = 10 - parseInt(value % 10);
	            value = parseInt(value) + parseInt(yu);
	            $(this).val(value);
	            $(this).parents(".j-xtp-item").find('.j-silde').slider(
	                'setValue', value
	            )
	            return true;

	        }
	    })
	    
	    $(document).on('keyup', '.j-value', function() {
	        this.value = this.value.replace(/\D/g, '')
	        value = this.value;
	
	
	        if (value > 2000) {
	            value = 2000;
	            $(this).val(value);
	
	        }
	        $(this).parents(".j-xtp-item").find('.j-silde').slider(
	            'setValue', value
	        )
	        return true;
	
	    });
	    // 云硬盘容量手动输入
	    $(document).on('blur', '.j-indisk', function() {
	        if (value % 10 != 0) {
	            $(this).val(value);
	            $(this).parents(".j-xtp-item").find('.j-silde').slider(
	                'setValue', value
	            )
	            return true;

	        }

	    })
	    $(document).on('keyup', '.j-indisk', function() {
	    	var oldValue = $('#diskValueBg').val();
	        this.value = this.value.replace(/\D/g, '')
	        value = this.value;
	        if (value > 2000) {
	            value = 2000;
	            $(this).val(value);
	        }
	        if(value < disknumTemp) {
	        	value = disknumTemp;
	            $(this).val(value);
	        }
	        $(this).parents(".j-xtp-item").find('.j-silde').slider(
	            'setValue', value
	        )
	        return true;
	    });
	  	//弹层配置--其他弹层
	  	$('#serviceWindowZybg_other').dialog({
    	   width: 820,
           //height: 540,
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
                  var config =  $("#config").val();
                  var num = $("#inptNum").val();
                  var unit = $("#userunit").val();
                  var appid = $("#resourceapp_other").combobox('getValue');
                  var appname = $("#resourceapp_other").combobox('getText');
                  objdata.network = $("#network_other").find("li.active").text();
                  objdata.networkid = $("#network_other").find("li.active").val().toString().substring(1);
            	   if(""==config||null==config){
            		   $.messager.alert('提示',"规格配置不能为空!",'info');
            		   return false;
            	   }
            	   
            	   if(''==appid){
            		   /*$.messager.alert('提示',"应用不能为空!",'info');
            		   return false;*/
            		   appname = '';
            	   }
            	   
   
            	   changeNeids = changeNeids + oldRowData['neid']+";";
	               var unitid = $("#userunit").val();
	               var proid = $("#projectid").val();
	               var proname = $("#projectname").val();
	               var idname =   $("#hiddenid"+oldRowData['pshopid']).val();
                   $('#iaas'+idname).datagrid('insertRow', {
                       index: 0, // index start with 0
                       row: {
                   		    neid:oldRowData['neid'],
                   		 	operatetype:operatetype,
	                        serviceid: oldRowData['servertypeidlevelsecond'],
	                        itemname: $('#serviceWindowZybg_other').panel('options').title,
	                        oldconfigure:oldRowData['configure'],
	                        newconfigure:config,
	                        typeid:oldRowData['typeid'],
	                        pshopid:oldRowData['pshopid'],
	                        pshopname:oldRowData['pshopname'],
	                        proid:oldRowData['projectid'],
	                        proname:oldRowData['projectname'],
	                        unitid: oldRowData['unitid'],
	                        unitname:oldRowData['unitname'],
	                        measureunit: oldRowData['measureunit'],//单位
	                        tnumber:num,
	                        appid: oldRowData['appid'],
	                        appname:oldRowData['appname'],
	                        networktypeid:oldRowData['networktypeid'],
	                        networktype:oldRowData['networktypename'],
	                        oldatprice:oldRowData['oldatprice'],
	                        oldtprice:oldRowData['oldtprice'],
	                        operatetypeName:'变更'
                       }  
                   });
                   $('#serviceWindowZybg_other').dialog('close');
                   $(".j-toggle-s").click(); 
                   
               }
           }, {
               text: '取消',
               iconCls: 'icon-cancel',
               handler: function() {
                   $('#serviceWindowZybg_other').dialog('close');
               }
           }]
       });
	    
	    //初始化cpu
	    function initCpu() {
         	$.ajax({
		  		type : 'post',
		  		url:'${pageContext.request.contextPath}/vmconfig/queryCpu.do',
		  		asyn:false,
		  		dataType:'json',
		  		cache: false,
		  		success:function(data){
		  		  if($("#cpuchooseZybg").children().length==0){
			  	       $.each(data,function(index,value){
			  	    	 if(value== oldRowData['cpunum'] ){   				  	         
			  	             $("#cpuchooseZybg").append("<li class=\"active\" onclick=\"choosecpu("+value+")\" value="+value+"><a href=\"javascript:void(0)\" >"+value+"核 </a></li>");
			  	    	 }else{
			  	            $("#cpuchooseZybg").append("<li onclick=\"choosecpu("+value+")\"  value="+value+"><a href=\"javascript:void(0)\">"+value+"核</a></li>");
			  	         }
		 	  	       })
		  	       }
 	        	   var obj_2=$("#cpuchooseZybg").children('li');
	               obj_2.click(function(){
 			            $(this).addClass('active').siblings('li').removeClass('active');
 			            var _value = $(this).attr("value");
                        $("#cpuNum").val(_value);
                    })
                    
				}
			})
       	}
       
	    //初始化内存
	    function initMem() {
	    	$.ajax({
		  		type : 'post',
		  		url:'${pageContext.request.contextPath}/vmconfig/queryMem.do',
		  		data:{cpunum:oldRowData['cpunum']},
		  		asyn:false,
		  		dataType:'json',
		  		cache: false,
		  		success:function(data){
		  	      if($("#memchooseZybg").children().length==0){
			  	       $.each(data,function(index,value){
			  	    	 if(value == parseInt(oldRowData['memnum'])){   				  	         
			  	             $("#memchooseZybg").append("<li class=\"active\" onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	         }else{
			  	            $("#memchooseZybg").append("<li onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	         }
			  	       })
		      	     } 
		             var obj_2=$("#memchooseZybg").children('li');
		             obj_2.click(function(){
		             	$(this).addClass('active').siblings('li').removeClass('active');
		             })
		  		}
		 })
       }  
       
	    //cup点击事件
	    function choosecpu(value){
	    	$("#memchooseZybg").children().remove();
         	$.ajax({
  				  		type : 'post',
  				  		url:'${pageContext.request.contextPath}/vmconfig/queryMem.do',
  				  		data:{cpunum:value},
  				  		asyn:false,
  				  		dataType:'json',
  				  		success:function(data){
  				  	       $.each(data,function(index,value){
  				  	         if(index=='0'){
  				  	          $("#memchooseZybg").append("<li class=\"active\" onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
  				  	          $('#stroeSize').val(value);
  				  	         }else{
  				  	           $("#memchooseZybg").append("<li onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
  				  	         }
  				  	         
  				  	         var obj_2=$("#memchooseZybg").children('li');
	 	                 	 obj_2.click(function(){
	 	                 		$(this).addClass('active').siblings('li').removeClass('active');
 			                 })
 			                
  				  	       })
  				  		}
  				 })
	     }
	      
       function choosemem(value){
           $('#stroeSize').val(value);
       }
       
       //初始加载时，初始化cpu和内存
       function choosecpuHx(value){
            $("#memchooseZybg").children().remove();
            var memnum = oldRowData['memnum'];//内存
         	$.ajax({
			  		type : 'post',
			  		url:'${pageContext.request.contextPath}/vmconfig/queryMem.do',
			  		data:{cpunum:value},
			  		asyn:false,
			  		dataType:'json',
			  		success:function(data){
			  	       $.each(data,function(index,value){
			  	           if(value ==memnum){   				  	         
			  	         	   $("#memchooseZybg").append("<li class=\"active\" onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	               $('#stroeSize').val(value);
			  	          }else{
			  	              $("#memchooseZybg").append("<li onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	          }
			  	         
			  	         var obj_2=$("#memchooseZybg").children('li');
	                 	 obj_2.click(function(){
			             	$(this).addClass('on').siblings('li').removeClass('on');
		                 })
			  	       })
			  		}
			  })
	     }
       
       //确定按钮点击事件
       function updateOrderOk(){
    	   $('#submitBtn').linkbutton('disable');
           var jsonArr = new Array();
           var flag = false;
           for(var i=0,len=$(".t-wrap-iaas").length;i<len;i++){
               var ids = "iaas"+i;
               var rows = $("#"+ids).datagrid('getRows');
               
               if(rows.length>0){
    	        flag = true;
    	          jsonArr[i] = JSON.stringify(rows);
               }else{
                  jsonArr[i]="";
               }
               
           }
          if(!flag){
            $.messager.alert('消息',"您还没有选择要变更的资源，请先选择！","info");
            $('#submitBtn').linkbutton('enable');
            return;
          }
          var snote = $("#order_note").val();
          var fileName = null;
          var fileUrl = null;
          if($("#filesform input[name='fileload']")[0].value) {//有附件
        	  $('#filesform').form('submit',{
      		    url:'<%=path%>/resourcechange/saveUploadFile.do',
      		    onSubmit: function(){
      		    },
      		    success:function(retr){
      		    	var data =  JSON.parse(retr); 
      		    	if(!data.success){
      		    		$.messager.alert('消息',"附件大小不能超过10M,请重新上传！","info");
      		    		$('#submitBtn').linkbutton('enable');
      		            return;
      		    	}
      				if(data.obj.fileUrl != "" && data.obj.fileUrl != null && data.obj.fileUrl != "undefined"){
      					fileName = data.obj.fileName;
      	  				fileUrl = data.obj.fileUrl;
      				}
      				saveChangeOrder(jsonArr,snote,fileName,fileUrl);
      		    }
      		});
          }else{//没有附件
        	  saveChangeOrder(jsonArr,snote,fileName,fileUrl);
          }
       }
       
     //资源变更单保存
     function saveChangeOrder(jsonArr,snote,fileName,fileUrl){
       	$.ajax({
   	  		type : 'post',
   	  		url:'${pageContext.request.contextPath}/resourcechange/saveResourceChange.do',
   	  		data:{json1:jsonArr[0],json2:jsonArr[1],json3:jsonArr[2],json4:jsonArr[3],json5:jsonArr[4],snote:snote,fileName:fileName,fileUrl:fileUrl},
   	  		beforeSend: function(){
                load("正在提交，请稍待。。。");
            },
   	  		success:function(retr){
   	  		   disLoad("操作完成");
   	  			var data =  JSON.parse(retr); 
   	  			$.messager.alert('消息',data.msg,"info");
   	  			if(data.success){
   	  				//alert('${pageContext.request.contextPath}');
	   	  			$('#centerTab').panel({
						href:'${pageContext.request.contextPath}/web/resourceChange/resourceChangeOrderList.jsp'
					});
   		    		/*
   		    		for(var i=0,len=$(".t-wrap-iaas").length;i<len;i++){
		    	        var rows = $('#iaas'+i).datagrid('getRows');
		    	        var rowlen = rows.length;
		    	       
		    	        if(rowlen>0){
		    	          for(var j=rowlen;j>0;j--){
		    	          	$('#iaas'+i).datagrid('deleteRow', 0);
		    	          }
		    	        }
		    	     }
	    	        $('#order_note').val('');
	    	        $('#filesform').form('reset');
	    	        $('#submitBtn').linkbutton('enable');*/
   		    	 } 
   		  		}
   		  	}); 
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
     
    </script>
  </body>
</html>
