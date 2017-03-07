<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String flowid = (String)request.getAttribute("flowid");
//String flowid = request .getParameter("flowid" );
	if (flowid == null) {
		flowid = "";
}
String detailid = (String)request.getAttribute("detailid");
//String detailid = request .getParameter("detailid" );

if (detailid == null) {
	detailid = "";
}

String operType = request.getParameter("operType")==null?"":request.getParameter("operType").toString();//gdcf 工单拆分子流程实施操作

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  	<link href="<%=basePath%>/css/default.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=basePath%>/css/regcore.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
	
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
  	<script type="text/javascript" src="<%=basePath%>/js/sockjs-0.3.min.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" /> 
  
  <body>
     <style>
     html {overflow-y: auto;/* overflow-x: auto; */}
    .j-in {
        text-align: left;
    }
    </style>
  <!-- 专享云服务 -->
    <div id="boxManagedWindow" style="padding:3px 0px;">
        <ul class="j-tabs ty-tabs-title">
            <li class="active">设备清单</li>
            <li>费用核算</li>
        </ul>
        <div class="ty-tabs-content ">
            <!-- 选项卡1 -->
            <div class="j-tabs-con">
                <div style=" padding:10px;">
                    <table id="vipDataGrid" style="width:980px;height:390px" data-options="rownumbers: false,border: false,rownumbers:true,singleSelect:true,showFooter:true">
                        <thead>
                            <tr>
                                <th data-options="field:'equipmentname',width:140, editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>设备名称</th>
                                <th data-options="field:'equipmentbrand',width:130,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"> <span class="must-star">*</span>品牌型号</th>
                               <th data-options="field:'equipmentstyle',width:100,formatter:productFormatter,
                        editor:{
                            type:'combobox',
                            options:{editable:false,
                                valueField:'productid',
                                textField:'name',
                                data:optionTypes,
                                required:true
                            }
                            
                        }">   
                        <span class="must-star">*</span> 类型</th>
                                <th data-options="field:'equiparameters',width:310,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>规格参数</th>
                                <th data-options="field:'measureunit',width:60,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>单位</th>
                                <th data-options="field:'equipnums',width:60,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }">数量</th>
                                <th data-options="field:'perprice',width:60,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                           
                            
                        }"><span class="must-star">*</span>单价</th>
                                <th data-options="field:'sumprice',width:80,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                           
                            
                        }"><span class="must-star">*</span>总价</th>
                            </tr>
                        </thead>
                    </table>
                    <p style="padding-top:10px; text-align: right; padding-right: 20px;"> 设备资产购置费:
                        <input type="text" id="total" value="合计" readonly class="ty-top-input" style="width:140px;">
                    </p>
                </div>
            </div>
            <!-- 选项卡2 -->
            <div class="j-tabs-con" style="display: none;padding:10px;">
                <div class="ty-tabscon-box">
                    <div class="title">
                        设备资产购置费:
                        <input type="text" id="sbzc" value="" readonly class="ty-top-input" style="width:140px;"> 专享年服务费:
                        <input type="text" id="yeartotal" value="合计" readonly class="ty-top-input" style="width:140px;">
                    </div>
                    <div class="group">
                        <table class="ty-tabcon-table-layout">
                            <tr>
                                <td rowspan="6" valign="top" style="width: 230px;">
                                    <span class="title-border">建设费用&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                    <input type="text" readonly value="小计" id="sumconstruct" class="ty-top-input" style="width:140px;">
                                </td>
                                <td class="border" width="100px" align="right">资产成本：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="zccb">
                                </td>
                                <td>
                                    <div class="info">按照
                                        <input type="text" value="5" id="zccbIn" class="ty-top-input j-in" style="width:30px;">年分摊</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">项目管理费：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="xmgl">
                                </td>
                                <td>
                                    <div class="info">每年
                                        <input type="text" id="xmglIn" value="6" id="zccbIn" class="ty-top-input j-in" style="width:30px;">%核算</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">咨询费：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="zxf">
                                </td>
                                <td>
                                    <div class="info">总成本的
                                        <input type="text" id="zxfIn" value="3" id="zxfIn" class="ty-top-input j-in" style="width:30px;">%</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">实施费：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="ssf">
                                </td>
                                <td>
                                    <div class="info">总成本的
                                        <input type="text" id="ssfIn" value="15" id="zxfIn" class="ty-top-input j-in" style="width:30px;">%</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">资金成本：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" id="zjcb" style="width:140px;">
                                </td>
                                <td>
                                    <div class="info">按照银行基准利率
                                        <input type="text" id="zjcbIn" value="7" id="zxfIn" class="ty-top-input j-in" style="width:30px;">%计算</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">税金：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="sj">
                                </td>
                                <td>
                                    <div class="info">按照全部成本的
                                        <input type="text" id="sjIn" value="6" id="sjIn" class="ty-top-input j-in" style="width:30px;">%核算</div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="group">
                        <table class="ty-tabcon-table-layout">
                            <tr>
                                <td rowspan="2" valign="top" style="width: 230px;">
                                    <span class="title-border">运行保障费&nbsp;</span>
                                    <input type="text" readonly value="小计" id="sumoperate" class="ty-top-input" style="width:140px;">
                                </td>
                                <td class="border" align="right" width="100px" align="right">维保费：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="wbf">
                                </td>
                                <td>
                                    <div class="info">每年按系统总造价的
                                        <input type="text" id="wbfIn" value="10" id="sjIn" class="ty-top-input j-in" style="width:30px;">%计取</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">运维人力费用：</td>
                                <td>
                                    <input type="text" value="0" class="ty-top-input j-in" id="ywrl" style="width:140px;">
                                </td>
                                <td>
                                    <div class="info">按照人员平均工资的<span>3</span>倍核算，<span>10</span>人运维</div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="group" style="border-bottom: none;">
                        <table class="ty-tabcon-table-layout">
                            <tr>
                                <td rowspan="2" valign="top" style="width: 230px;">
                                    <span class="title-border">托管费用&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                    <input type="text" readonly value="小计" id="sumhosting" class="ty-top-input" style="width:140px;">
                                </td>
                                <td class="border" width="100px" align="right">空间费：</td>
                                <td>
                                    <input type="text" value="0" class="ty-top-input j-in" id="kjf" style="width:140px;">
                                </td>
                                <td>
                                    <div class="info">空间费</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">线路费：</td>
                                <td>
                                    <input type="text" value="0" class="ty-top-input j-in" id="xlf" style="width:140px;">
                                </td>
                                <td>
                                    <div class="info">按照使用的网络带宽和IP计费</div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
      //datagrid悬浮框处理
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
     //专享
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
  //结束编辑状态
   function endEdit(table,rows){ 

      for (var i = 0; i < rows.length; i++) { 
        if($("#"+table).datagrid('validateRow', i)){
           
           $("#"+table).datagrid('endEdit', i); 
        } 
     } 
     
  } 
    	//资金成本temp
		var pmt = 0;
    	// 专享云服务
   		 //取消按钮事件
  		var closeWindows = function($dialog) {
  			$dialog.dialog('destroy');
  		}
    //提交按钮事件
    var submitForm = function($dialog, $row,$stepsno,$flowsid) {
		
		 	submitSave($dialog, $row,$stepsno,$flowsid);
			
	}
	var submitSave = function($dialog, $row,$stepsno,$flowsid){
		
			  var vips=[];
              var equipments= $("#vipDataGrid").datagrid('getRows');
              //验证
               if(equipments.length==0){
                $.messager.alert('消息',"请输入设备配置信息","info");
	              return;
              }
         
             if(isendEdit("vipDataGrid",equipments)){
            
                endEdit("vipDataGrid",equipments);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
              var equipmentstr =  JSON.stringify(equipments);
             
              //计算
              total();
             
              var vipsfee = {};
              // 设备资产购置费
       		 vipsfee.equipfee = $("#total").val();
              //专享年服务费
              vipsfee.pervipfee = $("#yeartotal").val();
              //建设费用小计
              vipsfee.buildsumfee = $("#sumconstruct").val();
              //运行保障费小计
              vipsfee.worksumfee = $("#sumoperate").val();
			
			  //托管费用小计
			  vipsfee.depositsumfee = $("#sumhosting").val();
			
              //资产成本
               vipsfee.propertyfee = $("#zccb").val();
              //项目管理费
               vipsfee.managefee = $("#xmgl").val(); 
               //咨询费
               vipsfee.consultfee = $("#zxf").val();
          
             //实施费
             vipsfee.actualfee = $("#ssf").val();
           
             //资金成本
             vipsfee.fundsfee = $("#zjcb").val();
          
             //税金
             vipsfee.taxfee = $("#sj").val();
              
             //维保费
             vipsfee.maintenancefee = $("#wbf").val();
         
			//运维人力费用
			vipsfee.operationfee = $("#ywrl").val();
		
			//空间费
			vipsfee.spacefee = $("#kjf").val();
			
			//线路费
			vipsfee.linefee = $("#xlf").val();
			   vipsfee.configure = $row.configure;
               vipsfee.shopid = $row.shopid;
               vipsfee.shopname = $row.shopname; 
               vipsfee.useunitname = $row.useunitname;
               vipsfee.useunitid = $row.useunitid;
               vipsfee.proid = $row.proid;
               vipsfee.proname = $row.proname;  
               vipsfee.orderid = $row.orderid;
		       vipsfee.detailid = $row.detailid;
		       vipsfee.userid = $row.userid;
		       vipsfee.uname = $row.uname;
		       vipsfee.typeid = $row.typeid;
		       vipsfee.appid = $row.appid;
	           vipsfee.appname = $row.appname;
	           vipsfee.stepno = $stepsno;
		       vipsfee.flowid = $flowsid;
		     
	                      
               vips.push(vipsfee);
               var vipsfees =   JSON.stringify(vips);
               
          //确定提交事件
          $.ajax({
			url:'${pageContext.request.contextPath}/workorder/vipsOperAdd.do',
			type:'post',
			cache:false,
			async:false,
			data:{
				vipEquipJson:equipmentstr,
				vipsJson:vipsfees,
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
              // $.post('${pageContext.request.contextPath}/workorder/vipsOperAdd.do',{vipEquipJson:equipmentstr,vipsJson:vipsfees},function(){});
              // $('#boxManagedWindow').dialog('close');
            
	
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
	
        $('.j-tabs li').click(function(event) {
        	//保存
	$('#vipDataGrid').datagrid('acceptChanges');
	//计算
	total(); 
            $(this).addClass('active').siblings().removeClass('active');
            $('.j-tabs-con').eq($(this).index()).show().siblings().hide();

        });
        // 初始化
        var lastIndex;
       
        //debugger;
        $('#vipDataGrid').datagrid({
        	url:'${pageContext.request.contextPath}/workorder/getPreVipDetails.do?flowid=<%=flowid%>&detailid=<%=detailid%>',
            toolbar: [{
                text: '增加',
                iconCls: 'icon-add',
                handler: function() {
                    $('#vipDataGrid').datagrid('endEdit', lastIndex);
                    $('#vipDataGrid').datagrid('appendRow', {
                        equipmentname: '',
                        equipmentbrand: '',
                        equipmentstyle: '',
                        equiparameters: '',
                        measureunit: '',
                        equipnums: '1',
                        perprice: '0',
                        sumprice: '0'

                    });
                    lastIndex = $('#vipDataGrid').datagrid('getRows').length - 1;
                    $('#vipDataGrid').datagrid('selectRow', lastIndex);
                    $('#vipDataGrid').datagrid('beginEdit', lastIndex);
                    setEditing(lastIndex);
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function() {
                    var row = $('#vipDataGrid').datagrid('getSelected');
                    if (row) {
                        var index = $('#vipDataGrid').datagrid('getRowIndex', row);
                        $('#vipDataGrid').datagrid('deleteRow', index);
                    }
                }
            }, '-', {
                text: '保存',
                iconCls: 'icon-save',
                handler: function() {
            	 var equipmentss= $("#vipDataGrid").datagrid('getRows');
              //验证
               if(equipmentss.length==0){
                $.messager.alert('消息',"请输入设备配置信息","info");
	              return;
              }
         
             if(isendEdit("vipDataGrid",equipmentss)){
            
                endEdit("vipDataGrid",equipmentss);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
                   // $('#vipDataGrid').datagrid('acceptChanges');

					//计算
                    total();

                }
            }],
            onBeforeLoad: function() {
                $(this).datagrid('rejectChanges');
            },
            onClickRow: function(rowIndex) {
                if (lastIndex != rowIndex) {
                    $('#vipDataGrid').datagrid('endEdit', lastIndex);
                    $('#vipDataGrid').datagrid('beginEdit', rowIndex);
                    setEditing(rowIndex);
                }
                lastIndex = rowIndex;
            },
            onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					}
        });

        function total() {
            var rows = $('#vipDataGrid').datagrid('getRows') //获取当前的数据行

            var total = 0;
            //资产成本
            var zccb = 0;
            //项目管理费
            var xmgl = 0;
            //咨询费
            var zxf = 0;
             //实施费
            var ssf = 0;
             //资金成本
            var zjcb = 0;
             //税金
            var sj = 0;
              //税金计算用
            var sjsum = 0;
             //维保费
            var wbf = 0;
           
             //专享年服务费
			var yeartotal = 0;
			//建设费用小计
			var sumconstruct = 0;
			//运行保障费小计
			var sumoperate = 0;
			//托管费用小计
			var sumhosting = 0;
			//运维人力费用
			var ywrl = 0;
			//空间费
			var kjf = 0;
			//线路费
			var xlf = 0;
			//资金成本temp
			var pmttemp = 0;
			
            for (var i = 0; i < rows.length; i++) {
                total += parseFloat(rows[i]['sumprice']);
            }
            //四舍五入
            total =  Math.round(total);
			//设备资产购置费total
            $('#total').val(total);
			//设备资产购置费sbzc
            $('#sbzc').val(total);
			//资产成本
			zccb = Math.round(total / $('#zccbIn').val());
            $('#zccb').val(zccb);
			//项目管理费
			xmgl = Math.round(total * $('#xmglIn').val() / 100);
            $('#xmgl').val(xmgl);
           
			//咨询费
			zxf = Math.round(total * $('#zxfIn').val() / 500);
           
            $('#zxf').val(zxf);
			//实施费
			ssf = Math.round(total * $('#ssfIn').val() / 500);
           
            $('#ssf').val(ssf);
          
			//资金成本 银行利率
			pmttemp=PMT ($('#zjcbIn').val()/ 100, 5, total, 0 );
			pmttemp=pmttemp*5-total;
			pmttemp=pmttemp/ 5;
			
			zjcb = Math.round(pmttemp);
           
            $('#zjcb').val(zjcb);
			//税金
			sjsum = zccb + xmgl + zxf + ssf + zjcb;
			sj = Math.round(sjsum * $('#sjIn').val() / 100);
           
            $('#sj').val(sj);
            
             //建设费用小计
            sumconstruct = zccb + xmgl + zxf + ssf + zjcb +sj;
            $('#sumconstruct').val(sumconstruct);
			//维保费
			wbf = Math.round(total * $('#wbfIn').val()*2 / 500);
           
            $('#wbf').val(wbf);

			//运维人力费用
			ywrl=parseFloat($('#ywrl').val());
			//运行保障费小计
            sumoperate = wbf + ywrl;
            $('#sumoperate').val(sumoperate);
			//空间费
			kjf=parseFloat($('#kjf').val());
			//线路费
			xlf=parseFloat($('#xlf').val());
			//托管费用小计
            sumhosting = kjf + xlf;
            $('#sumhosting').val(sumhosting);
            //专享年服务费
            yeartotal = sumconstruct + sumoperate + sumhosting;
            $('#yeartotal').val(yeartotal);
            
            
            $('.j-in').change(function(event) {
           //资产成本
			zccb = Math.round(total / $('#zccbIn').val());
            $('#zccb').val(zccb);
			//项目管理费
			xmgl = Math.round(total * $('#xmglIn').val() / 100);
            $('#xmgl').val(xmgl);
           
			//咨询费
			zxf = Math.round(total * $('#zxfIn').val() / 500);
           
            $('#zxf').val(zxf);
			//实施费
			ssf = Math.round(total * $('#ssfIn').val() / 500);
           
            $('#ssf').val(ssf);
          
			//资金成本 银行利率
			pmttemp=PMT ($('#zjcbIn').val()/ 100, 5, total, 0 );
			pmttemp=pmttemp*5-total;
			pmttemp=pmttemp/ 5;
			
			zjcb = Math.round(pmttemp);
          
            $('#zjcb').val(zjcb);
			//税金
			sjsum = zccb + xmgl + zxf + ssf + zjcb;
			sj = Math.round(sjsum * $('#sjIn').val() / 100);
           
            $('#sj').val(sj);
            
             //建设费用小计
            sumconstruct = zccb + xmgl + zxf + ssf + zjcb +sj;
            $('#sumconstruct').val(sumconstruct);
			//维保费
			wbf = Math.round(total * $('#wbfIn').val()*2 / 500);
           
            $('#wbf').val(wbf);

			//运维人力费用
			ywrl=parseFloat($('#ywrl').val());
			//运行保障费小计
            sumoperate = wbf + ywrl;
            $('#sumoperate').val(sumoperate);
			//空间费
			kjf=parseFloat($('#kjf').val());
			//线路费
			xlf=parseFloat($('#xlf').val());
			//托管费用小计
            sumhosting = kjf + xlf;
            $('#sumhosting').val(sumhosting);
            //专享年服务费
            yeartotal = sumconstruct + sumoperate + sumhosting;
            $('#yeartotal').val(yeartotal);
            });
			
			

        }
        //The EXCEL PMT function
        function PMT (ir, np, pv, fv ) {
 		/*
 			ir - interest rate per month
 			np - number of periods (months)
 			pv - present value
 			fv - future value (residual value)
 			type -  1 need to implement that
 		*/
 		pmt = ( ir * ( pv * Math.pow ( (ir+1), np ) + fv ) ) / ( ( ir + 1 ) * ( Math.pow ( (ir+1), np) -1 ) );
 		return pmt;
		}

        function setEditing(rowIndex) {
            var editors = $('#vipDataGrid').datagrid('getEditors', rowIndex);
            var priceEditor = editors[5];
            var amountEditor = editors[6];
            var costEditor = editors[7];
            priceEditor.target.bind('change', function() {
                calculate();
            });
            amountEditor.target.bind('change', function() {
                calculate();
            });
            //console.log(costEditor.target.val());
            costEditor.target.bind('change', function() {
                if (costEditor.target.val() != priceEditor.target.val() * amountEditor.target.val())
                    calculate();
            });

            function calculate() {
                var cost = priceEditor.target.val() * amountEditor.target.val();

                $(costEditor.target).val(cost);
            }
        }


   
    function productFormatter(value) {
        for (var i = 0; i < optionTypes.length; i++) {
        	
            if (optionTypes[i].productid == value) return optionTypes[i].name;
        }
        return value;
    }
     
    
    </script>
</body>

</html>
  