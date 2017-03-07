<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String flowid = request.getParameter("flowid");
//String flowid = request .getParameter("flowid" );
	if (flowid == null) {
		flowid = "";
}
String detailid = request.getParameter("detailid");
//String detailid = request .getParameter("detailid" );

if (detailid == null) {
	detailid = "";
}
String unitid = request.getParameter("unitid");
//String detailid = request .getParameter("detailid" );

if (unitid == null) {
	unitid = "";
}

String operType = request.getParameter("operType")==null?"":request.getParameter("operType").toString();//工单拆分实施操作 gdcf
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ipOper.jsp' starting page</title>
    
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
  	<script type="text/javascript" src="<%=basePath%>/js/validate.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" /> 
  
  </head>
  
  <body>
    <div id="serviceWindow_ip" style="padding:3px 0px;">
         
           <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">基本配置</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                        
                       
                        <tr>
                            <td align="right"> <span class="must-star">*</span>运营商：</td>
                            <td align="left">
                                <input id="yys" type="text" class="ty-top-input" style="width: 170px;">
                            </td>
                            <td align="right"> <span class="must-star">*</span>带宽：</td>
                            <td align="left">
                                 <input id="dk" type="text" class="ty-top-input" style="width: 170px;">
                            </td>
                        </tr>
                         <tr>
                            <td align="right"> <span class="must-star">*</span>互联网IP：</td>
                            <td align="left">
                                 <input id="hlwip" type="text" class="ty-top-input" style="width: 170px;">
                            </td>
                            <td align="right">域名备案：</td>
                            <td align="left">
                                 <input id="ymba" type="text" class="ty-top-input" style="width: 170px;">
                            </td>
                        </tr>
                     
                    </table>
                </div>
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">配置详情</div>
                    <div style="height: 305px; overflow:auto;">
                        <table id="internetWindowtt" style="width:650px;height:auto" data-options="fitColumns:true,rownumbers: true,border: false,singleSelect:true,url:'',scrollbarSize:0">
                            <thead>
                                <tr>
                                   <th data-options="field:'application',width:100,formatter:appFormatters,
	                           editor:{
	                           type: 'combobox',
	                          options:{
                           valueField:'appid',
                           textField:'appname',
                           required:true,
                           validType: 'isBlankorchoose',
                           url:'${pageContext.request.contextPath}/ordermg/getapps.do?unitid=<%=unitid%>',
                           loadFilter:function(data){
					        data.unshift({appid:' ',appname:'请选择'});
					        return data;
	                     }
                          }
	                           
	                           }">
                                   <span class="must-star">*</span>应用</th>
                                    <th data-options="field:'snote',width:100,editor:{type:'validatebox', options:{required:true }}"> <span class="must-star">*</span>用途</th>

                                    <th data-options="field:'equipmentname',width:180,editor:{
                                        type:'combobox', 
                                            options:{
					                           valueField:'neid',
					                           textField:'nename',
					                           url:'${pageContext.request.contextPath}/workorder/getObjectForObject.do?unitid=<%=unitid%>',
					                           required:true,
                                               validType: 'isBlankorchoose',
					                           loadFilter:function(data){
										        data.unshift({neid:' ',nename:'请选择'});
										        return data;
						                     },
						                     onSelect:function(record){
						                        
						                         var row = $('#internetWindowtt').datagrid('getSelected');
						                           
                                var rindex = $('#internetWindowtt').datagrid('getRowIndex', row);
                                  
                                var ed = $('#internetWindowtt').datagrid('getEditor', {  
                                        index : rindex,  
                                        field : 'interIp'  
                                    });  
                                   
                                $(ed.target).val(record.ipaddr);
						                     }
					                          }
                                       }"> 
                                       
                                       <span class="must-star">*</span>设备名称</th>
                                    <th data-options="field:'interIp',width:100,editor:{type:'validatebox', options:{required:true }}"> <span class="must-star">*</span>内网IP</th>
                                    <th data-options="field:'networkport',width:100,
                        editor:{
                            type:'validatebox',
                            options:{
                              required:true 
                            }
                        
                        }"> <span class="must-star">*</span>公网端口</th>
                                    <th data-options="field:'reflectport',width:100,editor:{type:'validatebox', options:{required:true  }}"><span class="must-star">*</span>映射端口</th>
                                    </tr>
                            </thead>
                        </table>
                    </div>
                </div>
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
		
			  
              var Ipdetail= $("#internetWindowtt").datagrid('getRows');
              var Ipdetailstr =  JSON.stringify(Ipdetail);
              var Ipstr =  JSON.stringify($row);
              var internetip = $('#hlwip').val();
              var ymba = $('#ymba').val();
              if(internetip.trim()==''){
                 $.messager.alert('消息',"请填写互联网IP","info");
                   return;
              }
              var corpertionid = $('#yys').val();
              var bandth = $('#dk').val();
              if(corpertionid==''){
                $.messager.alert('消息',"请选择运营商","info");
	              return;
              }
              if(bandth==''){
                $.messager.alert('消息',"请填写带宽","info");
	              return;
              }
            
              if(Ipdetail.length==0){
                $.messager.alert('消息',"请输入设备配置信息","info");
	              return;
              }
             if(isendEdit("internetWindowtt",Ipdetail)){
             
                endEdit("internetWindowtt",Ipdetail);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
             
              Ipdetail= $("#internetWindowtt").datagrid('getRows');
              Ipdetailstr =  JSON.stringify(Ipdetail);
             
                 //确定提交事件
          $.ajax({
			url:'${pageContext.request.contextPath}/workorder/internetIPOper.do',
			type:'post',
			cache:false,
			async:false,
			data:{
				jsonstr1:Ipdetailstr,
				jsonstr2:Ipstr,
				bandth:bandth,
				ymba:ymba,
				internetip:internetip,
				flowid:$flowsid,
				stepno:$stepsno,
				operType:'<%=operType%>'
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
      
        $('#internetWindowtt').datagrid({
        	url:'${pageContext.request.contextPath}/workorder/internetIPinit.do?flowid=<%=flowid%>&detailid=<%=detailid%>',
            toolbar: [{
                text: '增加',
                iconCls: 'icon-add',
                handler: function() {
                    $('#internetWindowtt').datagrid('endEdit', lastIndex);
                    $('#internetWindowtt').datagrid('appendRow', {
                        application: '',
                        snote: '',
                        equipmentname:'',
                        interIp:'',
                        networkport: '',
                        reflectport: ''
                    });
                    lastIndex = $('#internetWindowtt').datagrid('getRows').length - 1;
                    $('#internetWindowtt').datagrid('selectRow', lastIndex);
                    $('#internetWindowtt').datagrid('beginEdit', lastIndex);
                    setEditing(lastIndex);
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function() {
                    var row = $('#internetWindowtt').datagrid('getSelected');
                    if (row) {
                        var index = $('#internetWindowtt').datagrid('getRowIndex', row);
                        $('#internetWindowtt').datagrid('deleteRow', index);
                    }
                }
            },  '-', {
                text: '保存',
                iconCls: 'icon-save',
                handler: function() {
                    $('#internetWindowtt').datagrid('acceptChanges');
                }
            }],
            onBeforeLoad: function() {
                $(this).datagrid('rejectChanges');
            },
            onClickRow: function(rowIndex) {
                if (lastIndex != rowIndex) {
                    $('#internetWindowtt').datagrid('endEdit', lastIndex);
                }
                    $('#internetWindowtt').datagrid('beginEdit', rowIndex);
                lastIndex = rowIndex;
            },
            onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
						/* var data = JSON.parse(data); */
						 if(data.rows.length>0){
						 $('#yys').val(data.rows[0].iptype);
						 $('#dk').val(data.rows[0].bandwidth);
						 $('#ymba').val(data.rows[0].domainfo);
						 
						 } 
						  var len = $('#internetWindowtt').datagrid('getRows').length;
		                 for(var i=0;i<len;i++){
		                    $('#internetWindowtt').datagrid('selectRow', i);
		                    $('#internetWindowtt').datagrid('beginEdit', i);
		                }
						 }
					
        });
   
	  function appFormatters(value) {
        
           var appname = value;
         	$.ajax({
			  		type : 'post',
			  		url:'${pageContext.request.contextPath}/ordermg/getapps.do?unitid=<%=unitid%>',
			  		async:false,
			  		dataType:'json',
			  	
			  		success:function(data){
			  		 
			           for (var i = 0; i < data.length; i++) {
			           
			            if (data[i].appid == value) {
			              appname =data[i].appname;
			                
			            }
			          }
			  		}
			 })
			 
       return appname;
    }
      </script>
  </body>
</html>
