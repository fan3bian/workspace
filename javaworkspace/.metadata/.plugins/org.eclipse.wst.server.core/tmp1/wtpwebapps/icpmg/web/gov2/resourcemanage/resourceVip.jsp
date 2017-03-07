<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/icp/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

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
  
  <body>
     <style type="text/css">
     html {overflow-y: auto;/* overflow-x: auto; */}
    .j-in {
        text-align: left; }
    
    </style>
     <link rel="stylesheet" type="text/css" media="screen" href="<%=basePath%>/css/orderlist/order-fq.css" />
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
                    <table id="vipDataGrid" style="width:980px;height:390px" data-options="border: false,rownumbers:true,singleSelect:true,showFooter:true">
                        <thead>
                            <tr>
                                <th data-options="field:'equipmentname',width:140, editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>设备名称</th>
                                <th data-options="field:'equipmentbrand',width:150,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"> <span class="must-star">*</span>品牌型号</th>
                               <th data-options="field:'equipmentstyle',width:80,formatter:productFormatter,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'productid',
                                textField:'name',
                                data:optionTypes,
                                required:true
                            }
                            
                        }"> <span class="must-star">*</span> 类型</th>
                                <th data-options="field:'equiparameters',width:330,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>规格参数</th>
                                <th data-options="field:'measureunit',width:60,align:'center',editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>单位</th>
                                <th data-options="field:'equipnums',width:50,align:'center',editor:{
                           type: 'numberbox',
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
                                    <div class="info">软硬件资产购置费</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">项目管理费：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="xmgl">
                                </td>
                                <td>
                                    <div class="info">服务提供机构进行建设产生的项目管理费用</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">咨询费：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="zxf">
                                </td>
                                <td>
                                    <div class="info">建设平台前期进行咨询、设计等的费用
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">实施费：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="ssf">
                                </td>
                                <td>
                                    <div class="info">建设电子政务云平台过程中的集成和实施费用</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">资金成本：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" id="zjcb" style="width:140px;">
                                </td>
                                <td>
                                    <div class="info">服务提供机构一次投入资金分若干年收回而产生的资金占用费</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">税金：</td>
                                <td>
                                    <input type="text" readonly class="ty-top-input" style="width:140px;" id="sj">
                                </td>
                                <td>
                                    <div class="info">服务提供机构按照平台建设实际情况缴纳的企业各项税金</div>
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
                                    <div class="info">软硬件资产维保费</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="border" align="right">运维人力费用：</td>
                                <td>
                                    <input type="text" value="0" class="ty-top-input j-in" id="ywrl" style="width:140px;">
                                </td>
                                <td>
                                    <div class="info">运维人力资源费</div>
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

        $('.j-tabs li').click(function(event) {

            $(this).addClass('active').siblings().removeClass('active');
            $('.j-tabs-con').eq($(this).index()).show().siblings().hide();

        });
        
         //初始化用户数据
        $.ajax({
       
              type:'post',
			  url:'${ctx}/workorder/getVipsOper.do?objectid=<%=request.getParameter("objectid")%>',
			  async: false,//使用同步的方式,true为异步方式
			  dataType:'json',
			  success:function(retr){
			    
		      //设备资产购置费total
            $('#total').val(retr.equipfee=='null'?'':retr.equipfee);
			//设备资产购置费sbzc
            $('#sbzc').val(retr.equipfee=='null'?'':retr.equipfee);
			//资产成本
			
            $('#zccb').val(retr.propertyfee=='null'?'':retr.propertyfee);
			//项目管理费
			
            $('#xmgl').val(retr.managefee=='null'?'':retr.managefee);
           
			//咨询费
            $('#zxf').val(retr.consultfee=='null'?'':retr.consultfee);
			//实施费
            $('#ssf').val(retr.actualfee=='null'?'':retr.actualfee);
          
			//资金成本 银行利率
			
            $('#zjcb').val(retr.fundsfee=='null'?'':retr.fundsfee);
			//税金
			
            $('#sj').val(retr.taxfee=='null'?'':retr.taxfee);
            
             //建设费用小计
            $('#sumconstruct').val(retr.buildsumfee=='null'?'':retr.buildsumfee);
			//维保费
		
            $('#wbf').val(retr.maintenancefee=='null'?'':retr.maintenancefee);

			//运维人力费用
			$('#ywrl').val(retr.operationfee=='null'?'':retr.operationfee);
			//运行保障费小计
            $('#sumoperate').val(retr.worksumfee=='null'?'':retr.worksumfee);
			//空间费
			$('#kjf').val(retr.spacefee=='null'?'':retr.spacefee);
			//线路费
			$('#xlf').val(retr.linefee=='null'?'':retr.linefee);
			//托管费用小计
            $('#sumhosting').val(retr.depositsumfee=='null'?'':retr.depositsumfee);
            //专享年服务费
            $('#yeartotal').val(retr.pervipfee=='null'?'':retr.pervipfee);
               
			  }
          
        });
        
        // 初始化
        var lastIndex;
       
        //debugger;
        $('#vipDataGrid').datagrid({
        	url:'${pageContext.request.contextPath}/workorder/getAfterVipDetails.do?objectid=<%=request.getParameter("objectid")%>',
            onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					}
        });
   
    function productFormatter(value) {
        for (var i = 0; i < optionTypes.length; i++) {
            if (optionTypes[i].productid == value) return optionTypes[i].name;
        }
        return value;
    }
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
    </script>
</body>

</html>
  