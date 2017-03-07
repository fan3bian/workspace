<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String flowid = request.getParameter("flowid");
	if (flowid == null) {
		flowid = "";
}
String disknum = request.getParameter("disknum");

if (disknum == null) {
	disknum = "0,0";
}
String servernum = request.getParameter("servernum");

if (servernum == null) {
	servernum = "1";
}

String operType = request.getParameter("operType")==null?"":request.getParameter("operType").toString();//工单拆分实施gdcf
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title> </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
   <link href="<%=basePath%>/css/default.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=basePath%>/css/regcore.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
	
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
  	<script type="text/javascript" src="<%=basePath%>/js/sockjs-0.3.min.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" /> 
   <style type="text/css">
   .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber{ padding:0;}
   </style>
  </head>
  
  <body>
    <div id="serviceWindow_ivm" style="padding:0px 0px;">
         
           <div class="j-tabs-con">
           
                  <div style="height: 400px; overflow:auto;">
                        <table id="ivmWindowtt" style="width:618px;height:auto" data-options="fitColumns:true,rownumbers: true,border: false,singleSelect:true,url:'',scrollbarSize:0">
                            <thead>
                                <tr>
                                   <th data-options="field:'servername',width:120,editor:{type:'validatebox', options:{required:true }}"><span class="must-star">*</span>云服务器名称</th>
                                 
                                   <th data-options="field:'ipaddr',width:110,editor:{type:'validatebox', options:{required:true }}"> <span class="must-star">*</span>内网地址</th>
                                   <th data-options="field:'hostid',width:110,editor:{type:'validatebox', options:{required:true  }}"><span class="must-star">*</span>宿主机IP</th>
                                   <th data-options="field:'resourceid',width:120,editor:{type:'validatebox', options:{required:true  }}"><span class="must-star">*</span>资源池名称</th>
                                 
                                   <th data-options="field:'vlanid',width:120,editor:{type:'validatebox', options:{required:true  }}"><span class="must-star">*</span>VLAN</th>
                                    
  
                                </tr>
                            </thead>
                        </table>
                    </div>
            
        </div>
      </div>
      
      <script type="text/javascript">
        
        var closeWindows = function($dialog) {
  			$dialog.dialog('destroy');
  		}
  		
           var submitForm = function($dialog, $row,$stepsno,$flowsid) {
		
		 	submitSave($dialog, $row,$stepsno,$flowsid);
			
	   }
	   
	   
	   var submitSave = function($dialog, $row,$stepsno,$flowsid){
		  
			 var ivms= $("#ivmWindowtt").datagrid('getRows');
             var ivmsstr =  JSON.stringify(ivms);
             var vmstr =  JSON.stringify($row); 
             if(ivms.length==0){
                 $.messager.alert('消息',"请输入云服务器信息","info");
	              return;
              }
             if(isendEdit("ivmWindowtt",ivms)){
             
                endEdit("ivmWindowtt",ivms);
             }else{
               $.messager.alert('消息',"请输入云服务器必填信息","info");
               return;
             }
             ivms= $("#ivmWindowtt").datagrid('getRows');
             ivmsstr =  JSON.stringify(ivms);
         //确定提交事件
          $.ajax({
			url:'${pageContext.request.contextPath}/vmmanage/offlineVmRecord.do',
			type:'post',
			cache:false,
			async:false,
			data:{
				baseinfo:vmstr,
				objectsJson:ivmsstr,
				flowid:$flowsid,
				stepno:$stepsno,
				operType: '<%=operType%>'
			},
			beforeSend: function(){
             load("正在提交，请稍待。。。");
            },
			success:function(b){
            	
            	 disLoad("操作完成");
            	 $dialog.dialog('destroy');
				}
			});
		 }
			//弹出加载层
 	function load(msg) {  
     	$("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");  
    	 $("<div class=\"datagrid-mask-msg\"></div>").html(msg).appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });  
 	}
 	  
    function endEdit(table,rows){ 

      for (var i = 0; i < rows.length; i++) { 
        if($("#"+table).datagrid('validateRow', i)){
           
           $("#"+table).datagrid('endEdit', i); 
        } 
     } 
     
  } 
  
  
   function  isendEdit(table,rows){
   
     var isOk = true;
    for (var i = 0; i < rows.length; i++) { 
        if(!$("#"+table).datagrid('validateRow', i)){
            isOk = false;
            break;
        }
      }
        return isOk;
   } 
 	//取消加载层  
 	function disLoad() {  
     	$(".datagrid-mask").remove();  
     	$(".datagrid-mask-msg").remove();  
 	}
     
     $.extend($.fn.datagrid.methods, {
	        /**
	         * 开打提示功能
	         * @param {} jq
	         * @param {} params 提示消息框的样式
	         * @return {}
	         */
	        doCellTip: function(jq, params){
	            function showTip(data, td, e){
	                if ($(td).text() == "") 
	                    return;
	                data.tooltip.text($(td).text()).css({
	                    top: (e.pageY + 10) + 'px',
	                    left: (e.pageX + 20) + 'px',
	                    'z-index': $.fn.window.defaults.zIndex,
	                    display: 'block'
	                });
	            };
	            return jq.each(function(){
	                var grid = $(this);
	                var options = $(this).data('datagrid');
	                if (!options.tooltip) {
	                    var panel = grid.datagrid('getPanel').panel('panel');
	                    //var fields=$(this).datagrid('getColumnFields',false);////获取列
	                    var defaultCls = {
	                        'border': '1px solid #333',
	                        'padding': '2px',
	                        'color': '#333',
	                        'background': '#f7f5d1',
	                        'position': 'absolute',
	                        'max-width': '200px',
							'border-radius' : '4px',
							'-moz-border-radius' : '4px',
							'-webkit-border-radius' : '4px',
	                        'display': 'none'
	                    }
	                    var tooltip = $("<div id='celltip'></div>").appendTo('body');
	                    tooltip.css($.extend({}, defaultCls, params.cls));
	                    options.tooltip = tooltip;
	                    panel.find('.datagrid-body').each(function(){
	                        var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
	                        $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {
	                            'mouseover': function(e){
	                                if (params.delay) {
	                                    if (options.tipDelayTime) 
	                                        clearTimeout(options.tipDelayTime);
	                                    var that = this;
	                                    options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                                }
	                                else {
	                                    showTip(options, this, e);
	                                }
	                                
	                            },
	                            'mouseout': function(e){
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                options.tooltip.css({
	                                    'display': 'none'
	                                });
	                            },
	                            'mousemove': function(e){
									var that = this;
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                //showTip(options, this, e);
									options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                            }
	                        });
	                    });
	                    
	                }
	                
	            });
	        },
	        /**
	         * 关闭消息提示功能
	         *
	         * @param {}
	         *            jq
	         * @return {}
	         */
	        cancelCellTip: function(jq){
	            return jq.each(function(){
	                var data = $(this).data('datagrid');
	                if (data.tooltip) {
	                    data.tooltip.remove();
	                    data.tooltip = null;
	                    var panel = $(this).datagrid('getPanel').panel('panel');
	                    panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')
	                }
	                if (data.tipDelayTime) {
	                    clearTimeout(data.tipDelayTime);
	                    data.tipDelayTime = null;
	                }
	            });
	        }
	    });
	    
	  /*   alert('1');
	   $('#dk').numberbox({    
            min:0   
        });
        alert('12'); */
	   var lastIndex;
      
        $('#ivmWindowtt').datagrid({
        	url:'',
            toolbar: [{
                text: '增加',
                iconCls: 'icon-add',
                handler: function() {
                    $('#ivmWindowtt').datagrid('endEdit', lastIndex);
                    $('#ivmWindowtt').datagrid('appendRow', {
                        servername: '',                    
                        ipaddr:'',
                        hostid:'',
                        resourceid:'',
                        templatid:'DIY',
                        vlanid:'' 
                    
                    });
                    lastIndex = $('#ivmWindowtt').datagrid('getRows').length - 1;
                    $('#ivmWindowtt').datagrid('selectRow', lastIndex);
                    $('#ivmWindowtt').datagrid('beginEdit', lastIndex);
                   // setEditing(lastIndex);
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function() {
                    var row = $('#ivmWindowtt').datagrid('getSelected');
                    if (row) {
                        var index = $('#ivmWindowtt').datagrid('getRowIndex', row);
                        $('#ivmWindowtt').datagrid('deleteRow', index);
                    }
                }
            },  '-', {
                text: '保存',
                iconCls: 'icon-save',
                handler: function() {
                    $('#ivmWindowtt').datagrid('acceptChanges');
                }
            }],
            onBeforeLoad: function() {
                $(this).datagrid('rejectChanges');
            },
            onClickRow: function(rowIndex) {
                if (lastIndex != rowIndex) {
                    $('#ivmWindowtt').datagrid('endEdit', lastIndex);
                }
                    $('#ivmWindowtt').datagrid('beginEdit', rowIndex);
                lastIndex = rowIndex;
            },
            onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
						var tnum = <%=servernum%>;
						for(i=0;i<tnum;i++){
					    $('#ivmWindowtt').datagrid('appendRow', {
                        servername: '',
                        uuid: '',
                        ipaddr:'',
                        hostid:'',
                        resourceid:'',
                        templatid:'',
                        vlanid:'',
                        sdiskname: '',
                        sdisknum: '',
                        ddiskname1:'',
                        ddisknum1: '',
                        ddiskname2: '',
                        ddisknum2:''
                    });
                    lastIndex = $('#ivmWindowtt').datagrid('getRows').length - 1;
                    $('#ivmWindowtt').datagrid('selectRow', lastIndex);
                    $('#ivmWindowtt').datagrid('beginEdit', lastIndex);
                    }
				 }
					
        });
   
	   
      </script>
  </body>
</html>
