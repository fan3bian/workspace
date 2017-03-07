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
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
 
  <body >
    
 <style type="text/css">

.lcy-search{ margin: 0 20px; }
.lcy-search td{ padding:10px 20px 10px 0; }
.lcy-body .panel-body{ background: #eee; }
/*发起订单*/
.lcy-fqdd{margin: 0 20px; position: relative;}
.lcy-fqdd-select{ border-radius: 3px; border-color: #dddddd; border-width: 1px; border-style: solid; padding:15px 10px; padding-right: 80px; position: relative; padding-left: 34px;background: url('../icons/edit_add.png') no-repeat center center #fff; height: 36px; overflow: hidden;margin-bottom: 10px;z-index:1;}
.lcy-fqdd-select .icon-add-p{ position: absolute; top:25px; left: 10px; width: 16px; height: 16px; }
.lcy-fqdd-select .btn-toggle{ position: absolute; top:20px; right: 18px;}
.lcy-fqdd-select .btn-toggle a{color:#999999;}
.lcy-fqdd-select ul li{ position: relative; }
.lcy-fqdd-select  .header{ width: 100px; color: #999999; font-size: 12px; border-right: 1px solid #dcdcdc; height:25px;line-height: 25px; position: absolute; left:0px;top:5px; }
.lcy-fqdd-select .body{ padding-left: 120px; }
.lcy-fqdd-select .body a{color:#427def; font-size: 12px; display: inline-block; line-height: 35px; width: 175px; margin-bottom: 5px; }
.lcy-fqdd-select .body a:hover{color:#222; text-decoration:none; }

.btn-toggle-s{ display: none; }
.icon-btn-arrow-up{ background:url(../../images/public.png) no-repeat -21px 0; display: block; width: 16px; height: 16px; float: right;margin-left: 2px; }
.icon-btn-arrow-down{background:url(../../images/public.png) no-repeat -2px 0; display: block; width: 16px; height: 16px;float: right;margin-left: 2px;}
/*表格部分*/

#serviceWindow.window-body{ overflow: hidden; }
#serviceWindow.window-body {padding:0;}
.lcy-fqdd-t .header{ font-size: 20px; color: #333; font-family: 宋体; font-weight: bold; text-align: center; padding:10px 0; }
.lcy-fqdd-t{ border-radius: 3px; border-color: #dddddd; border-width: 1px; border-style: solid; padding:15px 15px 15px 15px; overflow: hidden;margin-bottom: 10px; background: #fff; position: absolute;top:80px;left:0;right:0;}
.lcy-fqdd-t .panel-header{ background: #fff; padding:0;  border-width: 1px; border-style: solid; border-color: #e5e5e5;progid:DXImageTransform.Microsoft.gradient(startColorstr=#fff,endColorstr=#fff,GradientType=0);}
.lcy-fqdd-t .panel-title{ color: #00b7ee; font-size: 18px; font-family: 宋体; line-height: 26px;height: 26px; padding-left: 5px; }
.t-wrap-iaas,.t-wrap-paas,.t-wrap-saas { margin: 0 15px 20px 0px}
.t-wrap-iaas .panel-title{ color: #427def;}
.t-wrap-paas .panel-title{ color: #f0b910; }
.t-wrap-saas .panel-title{ color: #0fb373; }
.lcy-fqdd-t .datagrid-header .datagrid-cell { background-color: #fff; height: 45px;line-height: 45px;}
.lcy-fqdd-t .datagrid-header td, .datagrid-body td, .datagrid-footer td { border-width: 0 1px 1px 0; border-style: solid; margin: 0; padding: 0;}
.lcy-body .lcy-fqdd-t .panel-body {background: #fff; border-left: 1px solid #e5e5e5;}
 .lcy-fqdd-t .datagrid-header-row, .lcy-fqdd-t  .datagrid-row { height: 45px;}

.lcy-fqdd-t  .datagrid-header td,.lcy-fqdd-t   .datagrid-body td, .datagrid-footer td {  border-color: #e5e5e5;  height:45px; border-style: solid;}
/*页脚*/
.lcy-fqdd-t .info{ overflow: hidden; margin:10px 0; }
.lcy-fqdd-t .fqr{ width: 30%; float: left; text-align: left;}
.lcy-fqdd-t .fqdw{ width: 40%;float: left;text-align: center; }
.lcy-fqdd-t .fqdate{ width: 30%;float: right;text-align: right;  }
.lcy-fqdd-t .btn-box{ text-align: center; margin: 40px 0; }
.lcy-fqdd-t .btn-box a{ padding:0 10px; margin: 0 10px; }
/*配置弹层*/
.lcy-window-item{ overflow: hidden;background: #eee; }
.lcy-window-item-body{ width: 620px; float: right; background: #fff; padding:10px 0 0 10px; line-height: 32px;}
.lcy-window-item-body ul li{border: 1px solid #ccc; height: 30px; line-height: 30px; padding:0 30px; margin:0 10px 10px 0px; float: left;border-radius: 3px; cursor: pointer; min-width: 30px; text-align: center;}
.lcy-window-item-body ul li.active{   background: #1dcbf8; color:#fff;border: 1px solid #1dcbf8;}
.lcy-window-item-header{ width: 150px; line-height: 32px;   padding-top:10px;text-align: right; font-size: 12px;padding-right: 30px;  }
.item-sildebox{padding-top:20px; padding-left: 10px; height: 50px; position: relative;}
.lcy-fqdd-t .datagrid-header-row,.lcy-fqdd-t  .datagrid-row { height: 45px;}

.lcy-window-item-body  .l-btn-text {   line-height:30px; padding: 0 10px;}
.item-right{position: absolute; top:13px; right: 10px;}
.item-right input{ border:1px solid #ddd; line-height: 30px; height: 30px; padding-left: 5px; width: 50px; }
.item-right span{ border-width: 1px 1px 1px 0; border-style: solid; border-color: #ddd;line-height: 30px;display: inline-block; padding: 0 5px; }
.lcy-window-item-body  .add-sub{ overflow: hidden; }
.lcy-window-item-body  .add-sub a:hover{text-decoration: none;}
.lcy-window-item-body  .subbtn{ font-size: 20px; line-height: 30px; border-width: 1px; border-style: solid; border-color: #ddd;float:left; width: 30px; text-align: center; }
.lcy-window-item-body  .addbtn{font-size: 20px; line-height: 30px; border-width: 1px; border-style: solid; border-color: #ddd;float:left; width: 30px;text-align: center;  }
.lcy-window-item-body .input-num{line-height: 30px; height: 30px; border-width: 1px 0 1px 0; border-style: solid; border-color: #ddd; vertical-align: top;float:left; width: 60px; text-align: center;}
 /*  tan2 */
 
 .ty-select{ border-color: #ddd; height: 25px; line-height: 25px; border-radius: 3px; }
.ty-icon{ height: 23px; line-height: 23px; border: 1px solid #ddd; border-radius: 3px;display: inline-block; color: #000; background:url(images/icons-collect.png) no-repeat 10px center #efefef; padding:0 10px 0 30px; margin-left:20px;}
.ty-icon-warning{background-image:url(images/icons-warning.png)}
.ty-tabscon-top{ text-align: center; }
.ty-top-input{ height: 23px; line-height: 23px; border: 1px solid #ddd; border-radius: 3px; width: 400px;  padding:0 5px; color: #333;}
.ty-top-input:focus{ border-color: #f8b551; box-shadow: 0 0 1px 1px  #f8b551}
.ty-top-button{ height: 23px; line-height: 23px; border: 1px solid #ddd; border-radius: 3px;display: inline-block; color: #000; background:url(images/icons-collect.png) no-repeat 10px center #efefef; padding:0 10px 0 30px; margin-left:20px;}
.ty-tabs-title{ overflow: hidden; position: relative; z-index: 2; padding-left: 10px;  }
.ty-tabs-title li{ height: 23px; line-height: 23px; padding:0 25px;  border-color: #e5e5e5; border-style: solid; border-width: 1px 1px 0 1px; float: left;
margin-right: 3px; border-radius: 3px; background: #fff; cursor: pointer; color: #000;}
.ty-tabs-title li.active{ height: 23px; border-top: 2px solid #0075a9; }
.ty-tabs-content{border-top: 1px solid #e5e5e5; margin-top: -1px;}
.ty-tabscon-top{ padding:10px; border-bottom: 1px solid #e5e5e5; }
.ty-tabscon-main{ padding:0px 20px 0 20px; }
.ty-tabscon-item{ margin-top: 25px; position: relative; border:1px solid #ddd; padding:10px 0px 5px 0px; color: #333; }
.ty-tabscon-item-title{ position: absolute; top:-15px; left: 13px; line-height: 20px; border:1px solid #ddd; padding:0px 20px; color: #0582c3; background: #fff; }
.must-star{ color: #f0a73b; }
.ty-tabcon-table-layout td{ padding:5px; font-size:12px; }
.ty-tabscon-item-ul{list-style: none;    overflow: hidden;
    padding-left: 0;}
.ty-tabscon-item-ul li{ float: left; margin-right: 10px; border: 1px solid #ddd; border-radius: 3px;     height: 23px;
    line-height: 23px;    width: 73px;    padding: 0 5px;    color: #333; text-align: center;cursor: pointer; }
.ty-tabscon-item-ul li.active{border-color:#f0a73b; background: #f8b551; color: #fff; }
.table-yy { width:100%;border-bottom:1px solid #ddd; border-right:1px solid #ddd; border-spacing:0;}
.table-yy th,.table-yy  td{ padding:2px 0px; font-size:12px; border-top:1px solid #ddd; border-left:1px solid #ddd;}
.table-yy th{ background:#eee;}
.table-yy input{ width:100%}
</style>
    <!-- 机位托管 -->
    <div id="positionManagedWindow" style="padding:3px 0px;">
        <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">基本信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                        <tr>
                            <td align="right" width="20%"> <span class="must-star">*</span>单位：</td>
                            <td align="left" width="34%">
                                  <input id="unitname" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                            <td align="right" width="18%"> <span class="must-star">*</span>项目：</td>
                            <td align="left" width="34%">
                                  <input id="projectname" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                        </tr>
                        <tr>
                        	<td align="right" width="18%"> <span class="must-star">*</span>一级分类：</td>
                            <td align="left" width="34%">
                                  <input id="servertypenamelevelfirst" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                            <td align="right" width="18%"> <span class="must-star">*</span>二级分类：</td>
                            <td align="left" width="34%">
                                  <input id="servertypenamesecond" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                        </tr>
                        <tr>
                        	<td align="right" width="18%"> <span class="must-star">*</span>名称：</td>
                            <td align="left" width="34%">
                                  <input id="displayname" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                            <td align="right" width="18%"> <span class="must-star">*</span>区域：</td>
                            <td align="left" width="34%">
                                  <input id="networktypename" type="text" class="ty-top-input" style="width: 168px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">配置信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
	                    <tr>
	                        <td align="right" width="18%"> <span class="must-star">*</span>硬盘容量：</td>
	                        <td align="left" width="34%">
	                              <input id="disknum" type="text" class="ty-top-input" style="width: 168px;">
	                        </td>
	                        <td align="right" width="20%"> <span class="must-star">*</span>所挂载云服务器：</td>
	                        <td align="left" width="34%">
	                              <input id="serverid" type="text" class="ty-top-input" style="width: 168px;">
	                        </td>
	                    </tr>
	                    <tr>
	                        <td align="right" width="20%"> <span class="must-star">*</span>所挂载云服务器IP：</td>
	                        <td align="left" width="34%">
	                              <input id="ipaddr" name="ipadr" type="text" class="ty-top-input" style="width: 168px;">
	                        </td>
	                    </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
   
  <script type="text/javascript">
  
	       $.ajax({
	    	  type:'post',
			  url:'${ctx}/indisk/getIndiskOper.do?objectid=<%=request.getParameter("objectid")%>',
			  async: false,//使用同步的方式,true为异步方式
			  dataType:'json',
			  success:function(retr){
				  console.log(retr);
				  $('#disknum').val(retr.disknum);
				  $('#serverid').val(retr.serverid);
				  $('#ipaddr').val(retr.ipaddr);
			  }
	       });   
     
  </script>
  
  </body>
</html>

