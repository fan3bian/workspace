<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/icp/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String flowid = request.getParameter("flowid");
	if (flowid == null) {
		flowid = "";
}
String detailid = request.getParameter("detailid");
//String detailid = request .getParameter("detailid" );

if (detailid == null) {
	detailid = "";
}

String appname = request.getParameter("appname");
if (appname == null) {
	appname = "";
}
String unitid = request.getParameter("unitid");
if (unitid == null) {
	unitid = "";
}
String operType = request.getParameter("operType")==null?"":request.getParameter("operType").toString();//gdcf 工单拆分实施操作
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
    <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" /> 
    <style type="text/css">
   .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber{ padding:0;}
   </style>
  </head>
  
  <body onresize="resizeGrid();">
 <!-- 整机柜托管 -->
    <!-- 机位托管 -->
    <div id="positionManagedWindow" style="padding:3px 0px;">
        <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">客户及业务信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                        <tr>
                            <!-- <td align="right" width="16%"> <span class="must-star">*</span>业务应用系统：</td>
                            <td align="left" width="34%">
                                  <input id="u_ywyyxt" type="text" class="ty-top-input" style="width: 180px;"readonly="readonly">
                            </td> -->
                            <td align="right" width="16%"><span class="must-star">*</span>计划上架方式：</td>
                            <td align="left" width="34%">
                                <ul class="ty-tabscon-item-ul j-item-ul">
                                    <li class="active">浪潮协助上架</li>
                                    <li>客户自行上架</li>
                                </ul>
                            </td>
                                <td align="right">域名备案：</td>
                            <td align="left">
                                <ul class="ty-tabscon-item-ul j-item-ul">
                                    <li class="active">是</li>
                                    <li>否</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"> <span class="must-star">*</span>计划上架时间：</td>
                            <td align="left">
                                <input  class="ty-top-input" style="width:181px" id="u_putime">
                            </td>
                        <!--     <td align="right">域名备案：</td>
                            <td align="left">
                                <ul class="ty-tabscon-item-ul j-item-ul">
                                    <li class="active">是</li>
                                    <li>否</li>
                                </ul>
                            </td> -->
                              <td align="right"> <span class="must-star">*</span>网络设备：</td>
                            <td align="left">
                                <ul class="ty-tabscon-item-ul j-item-ul">
                                    <li class="active">共享云中心</li>
                                    <li>自有设备连接</li>
                                </ul>
                            </td>
                        </tr>
                           <tr>
                           <td align="right"><span class="must-star must-beianhao">*</span>备案号：</td>
                           <td align="left">
                                    <input id="u_jg_beianquyu" type="text" class="ty-top-input" style="width: 180px;">
                            </td>
                            <td align="right">托管类型：</td>
                            <td align="left">
                                <input id="u_jg_tuoglx" type="text" value="机位" class="ty-top-input" style="width: 180px;"readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                          <!--   <td align="right"> <span class="must-star">*</span>网络设备：</td>
                            <td align="left">
                                <ul class="ty-tabscon-item-ul j-item-ul">
                                    <li class="active">共享云中心</li>
                                    <li>自有设备连接</li>
                                </ul>
                            </td> -->
                            <td align="right"> <span class="must-star">*</span>安全设备：</td>
                            <td align="left">
                                <ul class="ty-tabscon-item-ul j-item-ul">
                                    <li class="active">共享云中心</li>
                                    <li>自有设备连接</li>
                                </ul>
                            </td>
                              <td align="right">申请U位个数</td>
                            <td align="left">
                                <input id="u_num" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                        </tr>
                        <!-- <tr>
                            <td align="right">申请U位个数</td>
                            <td align="left">
                                <input id="u_num" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                            <td align="right"></td>
                            <td align="left">
                            </td>
                        </tr> -->
                    </table>
                </div>
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">设备配置信息</div>
                    <div style="height: 200px; overflow-x:hidden;overflow-y:auto;">
                        <table id="positionManagedtt" style="width:100%;height:auto" data-options="fitColumns:false,rownumbers: true,border: false,singleSelect:true,url:'',scrollbarSize:0">
                         <thead>
                                <tr>
                                    <th data-options="field:'equipmentname',width:110, editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>设备名称</th>
                                    <th data-options="field:'equipmentpro',width:105,align:'left',editor:{type:'validatebox'}"> </span>品牌型号</th>
                                    <th data-options="field:'equipmentstyle',width:100,formatter:productFormatter2,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'productid',
                                textField:'name',
                                data:optionTypes,
                                required:true
                            }
                        }"> <span class="must-star">*</span> 类型</th>
                                    <th data-options="field:'equipmentcode',width:90,editor:{type:'validatebox'}">序列号</th>
                                    <th data-options="field:'equipmentpower',width:100,align:'center',editor:{type:'numberbox'}">额定功率（W）</th>
                                    <th data-options="field:'equipmentheight',width:100,align:'center',editor:{type:'numberbox'}">设备高度（U）</th>
                                    <th data-options="field:'equipmentapp',width:90,formatter:appFormatters,
	                           editor:{
	                           type: 'combobox',
	                          options:{
                           valueField:'appid',
                           textField:'appname',
                           required:true,
                           validType: 'isBlankorchoose',
                           url:'<%=basePath%>/ordermg/getapps.do?unitid=<%=unitid%>',
                           loadFilter:function(data){
                           
					        data.unshift({appid:' ',appname:'请选择'});
					        return data;
	                     }
                          }
	                           
	                           }">
                                   <span class="must-star">*</span>应用</th>
                                    
                                    <th data-options="field:'cabinetnumber',width:120,align:'center',editor:{type:'validatebox',options:{required:true}}"><span class="must-star">*</span>上架机柜号</th>
                                      <th data-options="field:'unumber',width:100,align:'center',editor:{type:'validatebox',options:{required:true}}"><span class="must-star">*</span>上架U位</th>
                                       <th data-options="field:'interip',width:100,align:'center',editor:{type:'validatebox',options:{required:true,validType:'ip'}}"><span class="must-star">*</span>内网IP</th>
                                    <th data-options="field:'equipmentregion',width:100,formatter:productFormatter,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'productid',
                                textField:'name',
                                data:optionNetwork,
                                required:true
                            }
                        }"> <span class="must-star">*</span> 区域</th>
                                    <th data-options="field:'snote',width:300, editor:{
                            type:'viptext',options:{ required:true}
                            
                        }"><span class="must-star">*</span>规格参数</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
        <div id="dd" class="easyui-dialog" title="规格" style="width:420px;height:220px;padding:10px;"   
        data-options="iconCls:'icon-edit',modal:true,closed:true">   
        <textarea  id="addtext" style="width:380px;height:120px;margin-left:8px;font-size:14px;border:1px solid #ccc;overFlow-y:scroll;"></textarea>
     	<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
     		<span style="color:red; float:left">&nbsp;&nbsp;(*不得超过500个字符)</span>
			<a id="savebtn" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="confirmVip()" style="width:60px">保存</a>
			<a id="btn" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="cancelVip()" style="width:60px">取消</a>
		</div>
	</div>
      <script type="text/javascript">
         
    var optionNetwork = [{
        productid: '0001',
        name: '政务外网'
    }, {
        productid: '0002',
        name: '互联网'
    }, {
        productid: '0003',
        name: '行业专网'
    }];
    
    var optionTypes = [{
        productid: '10001',
        name: '服务器'
    }, {
        productid: '10002',
        name: '存储'
    }, {
        productid: '10003',
        name: '网络设备'
    }, {
        productid: '10004',
        name: '安全设备'
    }, {
        productid: '10005',
        name: 'SAN交换机'
    },{
        productid: '10006',
        name: '其它'
    }
    
    ];
   
            var increat = 0;
		    var yy = '';
    		$.extend($.fn.datagrid.defaults.editors, {    
            viptext: {    
                init: function(container, options){ 
                    var input = $('<input type="viptext"  id="_'+increat+'" class="datagrid-editable-input" > ').appendTo(container);    
    				$("#_"+increat).click(function(){
    					var val = $(this).attr("id");
    					yy=val;
    					$('#dd').window('open');
    					$('#addtext').val($("#"+val ).val());
    				});          
     				increat++;
    				return input;    
                },    
                getValue: function(target){    
                    return $(target).val();    
                },    
                setValue: function(target, value){    
                    $(target).val(value);    
                },    
                resize: function(target, width){    
                    var input = $(target);    
                    if ($.boxModel == true){    
                        input.width(width - (input.outerWidth() - input.width()));    
                    } else {    
                        input.width(width);    
                    }    
                }    
            }    
        });
     
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
	                 var zindex=$.fn.window.defaults.zIndex+999;//改
	                 var leftxz=($('body', parent.document).width()-$('body').width())/2 //改
	                data.tooltip.text($(td).text()).css({
	                    top: (e.pageY + 10) + 'px',
	                     left: (e.pageX + leftxz) + 'px',//改
	                    'z-index': zindex,
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
	                    var parentBody=$('body', parent.document); //改
	                    var tooltip = $("<div id='celltip'></div>").appendTo(parentBody);//改
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
	 
        var closeWindows = function($dialog) {
  			$dialog.dialog('destroy');
  		}
  		 
           var submitForm = function($dialog, $row,$stepsno,$flowsid) {
		
		 	submitSave($dialog, $row,$stepsno,$flowsid);
			
	   }
	  	   
	   var submitSave = function($dialog, $row,$stepsno,$flowsid){
		
	          if(''==$("#u_jg_beianquyu").val()&&"是"==$("#positionManagedWindow .ty-tabscon-item-ul").eq(1).find("li.active").text()){
               $.messager.alert('消息',"请填写备案号","info");
                return;
              }
              
              var cabis=[];
              var eqipments= $("#positionManagedtt").datagrid('getRows');
              if(eqipments.length==0){
                $.messager.alert('消息',"请输入设备配置设备配置信息","info");
	              return;
              }
             if(isendEdit("positionManagedtt",eqipments)){
             
                endEdit("positionManagedtt",eqipments);
                eqipments= $("#positionManagedtt").datagrid('getRows');
             }else{
               $.messager.alert('消息',"请输入必填信息","info");
               return;
             }
              var eqipmentstr =  JSON.stringify(eqipments);
             
               var cabinet = {};
               //objdata.networkid = $("#network_ip").find("li.active").val().toString().substring(1); 
       /*         var configure="";var appid_zjtg="";var appname_zjtg=""; var jg_num=""; var putaway="";
               var putawaytime=""; var domainrecord=""; var safety=""; var netmachine="";var power=""; */
               cabinet.recordregion = $("#u_jg_beianquyu").val();
               cabinet.cabinettype = $("#u_jg_tuoglx").val();                
	          /*  cabinet.appid = $row.appid;
	           cabinet.appname = $row.appname; */
               cabinet.cabinetnum = $("#u_num").val();
               cabinet.putawaytime=$("#u_putime").val();
               cabinet.putaway = $("#boxManagedWindow .ty-tabscon-item-ul").eq(0).find("li.active").text();
               cabinet.domainrecord =  $("#boxManagedWindow .ty-tabscon-item-ul").eq(1).find("li.active").text();       
               cabinet.netmachine =  $("#boxManagedWindow .ty-tabscon-item-ul").eq(2).find("li.active").text();
               cabinet.safety =  $("#boxManagedWindow .ty-tabscon-item-ul").eq(3).find("li.active").text();
              /*  cabinet.power = $("#jg_power").val(); */
               cabinet.configure = $row.configure+";备案区域:"+cabinet.recordregion+";托管类型:"+cabinet.cabinettype;
                
               cabinet.shopid = $row.shopid;
               cabinet.shopname = $row.shopname; 
               cabinet.useunitname = $row.useunitname;
               cabinet.useunitid = $row.useunitid;
               cabinet.proid = $row.proid;
               cabinet.proname = $row.proname;  
               cabinet.orderid = $row.orderid;
		       cabinet.detailid = $row.detailid;
		       cabinet.userid = $row.userid;
		       cabinet.uname = $row.uname;
		       cabinet.typeid = $row.typeid;
		       cabinet.stepno = $stepsno;
		       cabinet.flowid = $flowsid;
               cabis.push(cabinet);
               var cabinets =   JSON.stringify(cabis);
             
                  
           $.ajax({
			url:'${pageContext.request.contextPath}/workorder/cabinetsOper.do',
			type:'post',
			cache:false,
			async:false,
			data:{
				cabinetEquipJson:eqipmentstr,
				cabinetsJson:cabinets,
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
	 
      <%--   $("#positionManagedWindow #u_ywyyxt").val('<%=appname%>'); --%>
        // 弹层内容easyui初始化

        $('#u_jg_beianquyu').val('');
       
         //初始化用户数据
        $.ajax({
       
              type:'post',
			  url:'${pageContext.request.contextPath}/workorder/getCabinets.do?flowid=<%=flowid%>&detailid=<%=detailid%>',
			  async: false,//使用同步的方式,true为异步方式
			  dataType:'json',
			  success:function(retr){
			    
		       $('#u_putime').val(retr.putawaytime);
               $("#u_num").val(retr.cabinetnum);
	       
                if(retr.putaway=="浪潮协助上架")
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(0).find("li").eq(0).addClass('active').siblings().removeClass('active');
			    }
			    else
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(0).find("li").eq(1).addClass('active').siblings().removeClass('active');
			    }
			      if(retr.domainrecord=="是")
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(1).find("li").eq(0).addClass('active').siblings().removeClass('active');
			    }
			    else
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(1).find("li").eq(1).addClass('active').siblings().removeClass('active');
			        $(".must-beianhao").hide();
			    }
			      if(retr.netmachine=="共享云中心")
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(2).find("li").eq(0).addClass('active').siblings().removeClass('active');
			    }
			    else
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(2).find("li").eq(1).addClass('active').siblings().removeClass('active');
			    }
			      if(retr.safety=="共享云中心")
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(3).find("li").eq(0).addClass('active').siblings().removeClass('active');
			    }
			    else
			    {
			        $("#positionManagedWindow .ty-tabscon-item-ul ").eq(3).find("li").eq(1).addClass('active').siblings().removeClass('active');
			    }
               
			  }
          
        });
        
  
         // 初始化
        var lastIndex;
        $('#positionManagedtt').datagrid({
            url:'<%=basePath%>/workorder/getCabinetEquip.do?flowid=<%=flowid%>&detailid=<%=detailid%>',    
            toolbar: [{
                text: '增加',
                iconCls: 'icon-add',
                handler: function() {
                    $('#positionManagedtt').datagrid('endEdit', lastIndex);
                    $('#positionManagedtt').datagrid('appendRow', {
                        equipmentname: '',
                        equipmentpro:'',
                        equipmentstyle: '',
                        equipmentcode: '',
                        equipmentpower: '',
                        equipmentheight: '',
                        equipmentapp: '',
                        cabinetnumber:'',
                        unumber:'',
                        interip:'',
                        equipmentregion: '',
                        snote: ''
                      
                    });
                    lastIndex = $('#positionManagedtt').datagrid('getRows').length - 1;
                    $('#positionManagedtt').datagrid('selectRow', lastIndex);
                    $('#positionManagedtt').datagrid('beginEdit', lastIndex);
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function() {
                    var row = $('#positionManagedtt').datagrid('getSelected');
                    if (row) {
                        var index = $('#positionManagedtt').datagrid('getRowIndex', row);
                        $('#positionManagedtt').datagrid('deleteRow', index);
                    }
                }
            }, '-', {
                text: '保存',
                iconCls: 'icon-save',
                handler: function() {
                    $('#positionManagedtt').datagrid('acceptChanges');
                }
            }],
            onBeforeLoad: function() {
                $(this).datagrid('rejectChanges');
            },
            onClickRow: function(rowIndex) {
                if (lastIndex != rowIndex) {
                    $('#positionManagedtt').datagrid('endEdit', lastIndex);
                }
                    $('#positionManagedtt').datagrid('beginEdit', rowIndex);
                lastIndex = rowIndex;
            },
             onLoadSuccess: function() {
               $(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
                 var len = $('#positionManagedtt').datagrid('getRows').length;
                if(len>0){
                    $('#positionManagedtt').datagrid('selectRow', 0);
                    $('#positionManagedtt').datagrid('beginEdit', 0);
                }     
            }
        }); 
  
			//弹出加载层 
   //托管开始
      $(document).on('click', '.j-item-ul li', function(event) {
     
        $(this).addClass('active').siblings().removeClass('active');
        
       if("是" === $("#positionManagedWindow .ty-tabscon-item-ul ").eq(1).find("li.active").text()){
             $('.must-beianhao').show();
        }else{
             $(".must-beianhao").hide();
        }
    });
   

 	    function load(msg) {  
     	$("<div class=\"datagrid-mask\"></div>").css({ display: "block", width: "100%", height: $(window).height() }).appendTo("body");  
    	 $("<div class=\"datagrid-mask-msg\"></div>").html(msg).appendTo("body").css({ display: "block", left: ($(document.body).outerWidth(true) - 190) / 2, top: ($(window).height() - 45) / 2 });  
 	}  
   
 	//取消加载层  
 	function disLoad() {  
     	$(".datagrid-mask").remove();  
     	$(".datagrid-mask-msg").remove();  
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

   
      function productFormatter(value) {
        for (var i = 0; i < optionNetwork.length; i++) {
            if (optionNetwork[i].productid == value) return optionNetwork[i].name;
        }
        return value;
    }

  function appFormatters(value) {
         var appname = value;
         	$.ajax({
			  		type : 'post',
			  		url:'<%=basePath%>/ordermg/getapps.do?unitid=<%=unitid%>',
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
    function productFormatter2(value) {
        for (var i = 0; i < optionTypes.length; i++) {
            if (optionTypes[i].productid == value) return optionTypes[i].name;
        }
        return value;
    }
      
        function confirmVip(){
        	var value = $("#addtext").val();
        	if(value.length>500){
        		$.messager.alert('提示','字数超限制！');
        		return;
        	}
        	$("#"+yy ).attr("value",$("#addtext").val());
        	$('#dd').window('close');
        };
        	
       	function cancelVip(){
       		$("#addtext").attr("value",'');
       		$('#dd').window('close');
       	}
		function resizeGrid(){
		    $('#positionManagedtt').datagrid('resize');
		}
      </script>
  </body>
</html>
