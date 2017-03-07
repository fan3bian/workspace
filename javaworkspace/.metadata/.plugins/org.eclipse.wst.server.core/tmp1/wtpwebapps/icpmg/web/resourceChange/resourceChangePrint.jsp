<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%    
	String flowid = request.getParameter("flowid");//
	String updateorderid = request.getParameter("updateorderid");//订单号
	String uname = URLDecoder.decode(request.getParameter("uname"), "UTF-8") ;//发起人
	String useunitname = URLDecoder.decode(request.getParameter("useunitname"), "UTF-8") ;//使用单位
	String snote = URLDecoder.decode(request.getParameter("snote").equals("null") ? "" : request.getParameter("snote"),"UTF-8");//系统用途
	String userid = request.getParameter("userid").equals("null") ? "" : request.getParameter("userid");//邮箱
	String usertel = request.getParameter("usertel").equals("null") ? "" : request.getParameter("usertel");//联系电话
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <base href="<%=basePath%>">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery-1.8.3.min.js" charset="utf-8"></script>
	<link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/easyui-1.4/themes/icon.css" type="text/css">
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>/easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
</head>
<body>
    <style>
    * {
        margin: 0;
        padding: 0;
    }
    
    .printwrap {
        width: 210mm;
        margin: 0px auto;
        font-size: 14px;
        color: #333;
        line-height: 1.5;
        font-family: 微软雅黑;
    }
    
    .print-t {
        border-top: 1px solid #333;
        border-right: 1px solid #333;
        /* table-layout: fixed; */
    }
    
    .print-t th {
        font-weight: bold;
    }
    
    .print-t th,
    .print-t td {
        border-bottom: 1px solid #333;
        padding: 2mm;
        border-left: 1px solid #333;
    }
    
    .inner {
        border: none;
    }
    
    .inner th,
    .inner td {
        border: none;
        padding: 2mm;
    }
    
    h2 {
        font-size: 18px;
        font-family: 微软雅黑;
        text-align: center;
        margin: 10mm 0 5mm 0;
    }
    
    h3 {
        font-size: 14px;
        font-weight: normal;
        font-style: normal;
        font-family: 微软雅黑;
    }
    
    p {
        margin-top: 1mm;
    }
    
    .print-footer {
        width: 50mm;
        float: right;
        text-align: center;
    }
    
    .print-footer span {
        margin: 0 5mm;
    }
    
    .print-footer-left {
        width: 150mm;
        float: left;
    }
    
    .print-footer-left span {
        margin-right: 12mm;
        display: inline-block;
        width: 22mm;
        border-bottom: 1px solid #333;
    }
    </style>
    <div class="printwrap">
        <h2><span id="tableName"></span></h2>
        <input id = "flowid" value=<%=flowid %> type="hidden">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="print-t">
            <tr>
                <th>单位名称</th>
                <td colspan="5"><%= useunitname%></td>
            </tr>
            <tr>
                <th wihth="16%">信息化负责人</th>
                <td width="16%"><%=uname%></td>
                <th wihth="12%">联系电话</th>
                <td width="18%"><%= usertel%></td>
                <th wihth="12%">邮箱</th>
                <td width="22%"><%= userid%></td>
            </tr>
            <tr>
                <th>实施负责人</th>
                <td>&nbsp;</td>
                <th>联系电话</th>
                <td>&nbsp;</td>
                <th>邮箱</th>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <th>系统名称</th>
                <td colspan="5"><label id="name"></label></td>
            </tr>
            <tr>
                <th>主要用途</th>
                <td colspan="5">
                    <div><%= snote%></div>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <table id="detail" width="100%" border="0" class="inner">
                        <tr>
                            <td width="8%">序号</td>
                            <td width="14%">应用名称</td>
                            <td width="14%">产品名称</td>
                            <td width="24%">原有配置</td>
                            <td width="24%">现有配置</td>
                            <td width="8%">数量</td>
                            <td width="8%">单位</td>
                        </tr>                       
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <h3>申请单位意见:</h3>
                    <div style=" height: 20mm"></div>
                    <div class="print-footer">
                        <p>（公 章）</p>
                        <p><span>年</span>
                            <span>月</span>
                            <span>日</span></p>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <h3>经济信息委意见:</h3>
                    <div style=" height: 20mm"></div>
                    <div class="print-footer">
                        <p>（公 章）</p>
                        <p><span>年</span>
                            <span>月</span>
                            <span>日</span></p>
                    </div>
                    <div class="print-footer-left">
                       	 经办人：<span></span> 处室负责人：
                        <span></span> 委领导：
                        <span style="margin-right: 2mm"></span>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <h3>云平台实施负责人反馈</h3>
                    <div class="print-footer">
                        <div style=" height: 20mm"></div>
                        <p><span>年</span>
                            <span>月</span>
                            <span>日</span></p>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <h3>申请单位确认（下属事业单位需同时由主管部门盖章）</h3>
                    <div style=" height: 20mm"></div>
                    <div class="print-footer">
                        <p>（公 章）</p>
                        <p><span>年</span>
                            <span>月</span>
                            <span>日</span></p>
                    </div>
                </td>
            </tr>
        </table>
    </div>
	<script type="text/javascript" >
		var orderid = $('#updateorderid').val();
		var systemName = '';
		var paramType = "printChangeOrder";
		$(document).ready(function() {   	
			initTableName();
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/resourcechange/findResourceChangeToDo.do?transferid='+$("#flowid").val(),
				data:{},
				dataType:'json',
				async:false,
				success:function(result){
					$.each(result,function(index,obj){
						systemName += obj.appname+",";
						insertData(index,obj);
					})
					insertName(systemName);
				}
			});
		});
		
		//录入订单信息
		function insertData(index,obj){
			var ID = parseInt(index)+1;
			$('#detail').append('<tr><td>'+ID+'</td><td>'
					+obj.appname+'</td><td>'
					+obj.pname+'</td><td>'
					+obj.oldconfigure+'</td><td>'
					+obj.newconfigure+'</td><td>'
					+obj.tnumber+'</td><td>'
					+obj.measureunit+'</td></tr>');
		}	
		
		//录入系统名称
		function insertName(systemName){
			var arr = new Array();
			systemName = systemName.substring(0,systemName.length-1);
			arr = systemName.split(",");
			//数组去重
			var arrTemp = []; //一个新的临时数组
			for(var i = 0; i < arr.length; i++) //遍历当前数组
			{
				//如果当前数组的第i已经保存进了临时数组，那么跳过，
				//否则把当前项push到临时数组里面
				if (arrTemp.indexOf(arr[i]) == -1) {
					arrTemp.push(arr[i]);
				}
			}
			document.getElementById("name").innerText = arrTemp; 
		}
		
		//表格名称
		function initTableName(){
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/ordermg/getProSiteParamValue.do',
				data:{
					paramType : paramType
					},
				dataType:'json',
				async: false,
				success:function(data){
					$("#tableName").text( data.paramValue);
				}
			});
		}
	</script>
</body>
</html>
