<%@page import="com.inspur.icpmg.gov2.vo.up.Resourceservertype"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<%@ include file="/icp/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>发起订单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
      
  </head>
  
  <body>
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
/*0817*/
.lcy-fqdd-select .body span{display: inline-block; line-height: 35px; width: 175px; margin-bottom: 5px; }
.lcy-fqdd-select .body a{color:#427def; font-size: 12px; display:inline!important; }
/*0817 end*/
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
.lcy-fqdd-t .datagrid-header-row, .datagrid-row { height: 45px;}
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
.ty-tabcon-table-layout td{ padding:5px; }

.ty-tabscon-item-ul li{ float: left; margin-right: 10px; border: 1px solid #ddd; border-radius: 3px;     height: 23px;
    line-height: 23px;    width: 73px;    padding: 0 5px;    color: #333; text-align: center;cursor: pointer; }
.ty-tabscon-item-ul li.active{border-color:#f0a73b; background: #f8b551; color: #fff; }
 
 .datagrid-body .datagrid-editable td{line-height: 18px;}
 
/* 2016-10-9 15:51:10  */

#snfwpic,#ewfwpic{
    width: 110px;
    height: 80px;
    border: 1px solid #ccc;
    margin-left:60px;
    display: inline-block;    border-radius: 2px;    cursor: pointer;
  
}

#snfwpic.active,#ewfwpic.active{ border-color:#00e9de}
.ty-tabscon-choose{padding-left: 0px;
    padding: 8px 0 11px;
    border-bottom: 1px solid #ddd;}
.ty-tabscon-choose .fhlx{display: inline-block;
    vertical-align: bottom;
    margin-left: 34px;
    /* margin-bottom: 6px; */
    height: 47px;}
 #snfwpic img{
   display:block;
   margin: 20px auto 10px auto;
    
 }
  #ewfwpic img{
   display:block;
   margin: 20px auto 10px auto;
    
 }
   .combobox-wrap{
        background: #f8b551;
        color: #fff;font-weight:bold; cursor:pointer; margin:0px 5px 0px 0px; padding:5px 0;
    }
    
    .combobox-icon {
        display: inline-block;
        width: 15px;
        height: 15px; line-height: 15px; margin-right: 3px; margin-left: 5px; 
        border-radius: 8px;
        background: #fff;
        color: #f8b551; vertical-align: middle; text-align: center; margin-top: -2px;
    }
 </style>
   
    <div class="easyui-layout lcy-body" data-options="fit:true,border:false">
        <div data-options="region:'north',border:false" style="height: 42px;">
            <form id="resource_searchform">
                <div style="margin: 0 20px;">
                    <table class="lcy-search">
                        <tr>
                            <td>使用单位： 
                                <input name="proid" id="userunit" style="width:200px">
                            </td>
                            <td>项目名称：
                                <input name="proname" id="projectName" style="width:200px">
                                
                            </td>
                            <td>
                            <span id="giveUp"><a href="javascript:void(0)" style="text-decoration: underline;color: red;size: 15px;padding: 2px">放弃</a></span>
                            	
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
        <div data-options="region:'center',border:false">
            <div class="lcy-fqdd">
                <!-- 分类 -->
                <div class="lcy-fqdd-select j-select">
                    <ul>
                     
                    <%
                        List<Resourceservertype> lists =(List<Resourceservertype>)request.getAttribute("topType");
                        for(int i=0, lenType=lists.size();i<lenType;i++){
                     %>
                        <li>
                            
                            <div class="header"><%=lists.get(i).getServertypename()%></div>
                             <input type="hidden" value=<%=lists.get(i).getServertypeid()%>>
                            <div class="body" id="<%=i%>">
                              <%
                               List<Resourceservertype> lists2 = (List<Resourceservertype>)request.getAttribute("topType"+i);
                                for(int j=0,lenLists2=lists2.size();j<lenLists2;j++){
                             %> 
                                 <span><a href="javascript:void(0)" title="<%=lists2.get(j).getServertypename()%>"><%=lists2.get(j).getServertypename()%></a></span>
                                  <input type="hidden" value='<%=lists2.get(j).getServertypeid()%>,<%=lists2.get(j).getUnit()%>,<%=lists2.get(j).getTypeid()%>'>
                               <%} %>
                            </div>
                        </li>
                     <%} %>
                    </ul>
                    <div class="icon-add icon-add-p"></div>
                    <div class="btn-toggle "> <a href="javascript:void(0)" class="btn-toggle-z j-toggle-z">展开<span class="icon-btn-arrow-down"></span></a> <a href="javascript:void(0)" class="btn-toggle-s j-toggle-s">收起<span class="icon-btn-arrow-up"></span></a></div>
                </div>
                <!-- 表格 -->
                <div class="lcy-fqdd-t">
                    <div class="header">资源申请单</div>
                    <%
                       for(int i=0,lenType=lists.size();i<lenType;i++){
                     %>
                     <input type="hidden" id="hidden<%=i%>" value="<%=lists.get(i).getServertypename()%>">
                    <div class="t-wrap-iaas">
                        <table id="iaas<%=i%>" width="100%"></table>
                    </div>
                  <%} %>
                    <div class="info">
                        <p class="fqr">发起人: <span>${sessionUser.uname}</span></p>
                        <p class="fqdw">发起单位：<span>${sessionUser.unitname}</span></p>
                        <p class="fqdate"></p>
                    </div>
                    <!-- 备注 -->
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
	                 </table></form>
	              </div>
                    <div class="btn-box">
                        <a href="javascript:void(0)" id="submitBtn" class="easyui-linkbutton j-yes" data-options="iconCls:'icon-ok'" onclick="orderSubmit()">确定</a>
                        <!-- <a href="javascript:void(0)" class="easyui-linkbutton j-cancle" data-options="iconCls:'icon-cancel'">取消</a> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 弹层 -->
    <div id="serviceWindow">
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="cpuchoose">
                  
                </ul>
            </div>
            <div class="lcy-window-item-header">CPU</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="memchoose">
                  
                </ul>
            </div>
            <div class="lcy-window-item-header">内存</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                  <input id="template" style="width: 340px;height: 30px; "><span id="sysdisk" style="margin-left: 10px"></span>
            </div>
            <div class="lcy-window-item-header">操作系统</div>
        </div>
      <!--   <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                系统盘Windows(60G)、Linux(40G)
            </div>
            <div class="lcy-window-item-header">系统盘</div>
        </div> -->
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
                            <a href="javascript:void(0)" class="lcy-window-item-body-delete" onclick="xtpDelete(this)">x</a>
                        </div>
                    </div>
                </div>
                <div id="addLinkPannel" class="easyui-panel" style="width:100px;padding:5px">
                    <a id="addLinkBtn" href="javascript:void(0)" class="easyui-linkbutton" onclick="xtpAdd()">+增加一块</a></div>
            </div>
            <div class="lcy-window-item-header" style="padding-top:20px;">数据盘</div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                <ul id="network">
                    <li class="active" value="10001">政务外网</li>
                    <li value="10002">互联网</li>
                </ul>
            </div>
            <div class="lcy-window-item-header">区域</div>
        
        </div>
           <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                 <input id="resourceapp" style="width: 320px;height: 30px; "><span style="position: relative; top: 4px;left: 8px" onclick="addApp('resourceapp','1')" ><img src="${ctx}/easyui-1.4/themes/icons/edit_add.png"></span>
            </div>
            <div class="lcy-window-item-header">应用名称</div>
        </div>
        
        <div class="lcy-window-item">
            <div class="lcy-window-item-body">
                <div class="add-sub">
                    <a class="subbtn" id="subBtn" href="javascript:void(0)">-</a>
                    <input class="input-num" type="text" value="1">
                    <a class="addbtn" id="addBtn" href="javascript:void(0)">+</a>
                </div>
            </div>
            <div class="lcy-window-item-header">数量</div>
        </div>
        <!-- 占位 -->
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 280px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
      
    </div>
    <!-- 弹层结束 -->
    <!-- 其他弹出层1 -->
    <div id="serviceWindow_other">

    	<!-- 占位 -->
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 10px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    	<div class="lcy-window-item">
            <div class="lcy-window-item-body">
                  <textarea id="config" style="width: 500px;height: 220px; font-size:14px; border:1px solid #CCCCCC;"></textarea>
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
                    <li class="active" value="10001">政务外网</li>
                    <li value="10002">互联网</li>
                </ul>
            </div>
            <div class="lcy-window-item-header">区域</div>
        
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 5px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
        <div class="lcy-window-item">
            <div class="lcy-window-item-body j-item-body">
                 <input id="resourceapp_other" style="width: 320px;height: 30px; "><span style="position: relative; top: 4px;left: 8px" onclick="addApp('resourceapp_other','2')"><img src="${ctx}/easyui-1.4/themes/icons/edit_add.png"></span>
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
                    <a class="subbtn" id="subBtn_other" href="javascript:void(0)">-</a>
                    	<input class="input-num" id="inptNum" type="text" value="1">
                    <a class="addbtn" id="addBtn_other" href="javascript:void(0)">+</a>&nbsp;<span id="productunit"></span>
                </div>
            </div>
            <div class="lcy-window-item-header">数量</div>
        </div>
       <div class="lcy-window-item">
            <div class="lcy-window-item-body" style=" height: 23px; ">
            </div>
            <div class="lcy-window-item-header"></div>
        </div>
    
    </div>
    <!-- 其他弹出层 结束 -->
    
     <!--其他弹出层弹层2 -->
     <div id="serviceWindow_app">
   
	     <form id="serviceWindow_app_form">
	     
	    	<div class="order_appname" style="margin: 15px 25px 15px 25px">
	           <label for="appname">应用名称:</label>   
	           <input id="appname" type="text" name="appname"  style="height: 30px;width:222px" />  
	        </div>
            <div class="order_appshort" style="margin: 15px 25px 15px 25px">
	           <label for="appshort">应用简称:</label>   
	           <input   id="appshort" type="text" name="appshort"  style="height: 30px;width:222px" />  
	        </div>
	    	<div class="order_note"  style="margin: 5px 25px 5px 25px">
	    	  <label for="appnote" style="position: relative; top: -30px;">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</label>  
	          <textarea rows="5"  id="appnote" name="appnote" style="width:222px;border:1px solid #ccc"></textarea>
	        </div>
	     </form>
    
     
    </div>
     <!-- 其他弹出层弹层结束-->
     
      <!-- 弹层2 互联网-->
      <div id="serviceWindow_ip" style="padding:3px 0px;">
         
           <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">IP基本信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                        
                       
                        <tr>
                            <td align="right"> <span class="must-star">*</span>运营商：</td>
                            <td align="left">
                                <input id="yys" type="text" class="ty-top-input" style="width: 170px;">
                            </td>
                            <td align="right"> <span class="must-star">*</span>带宽（M）：</td>
                            <td align="left">
                                 <input id="dk" type="text" class="ty-top-input" style="width: 170px;">
                            </td>
                        </tr>
                          <tr>
                            <td align="right">域名备案：</td>
                            <td align="left">
                              <input id="ymba" type="text" class="ty-top-input" style="width: 158px;">
                            </td>
                             
                            <td align="right"> <span class="must-star">*</span>注：</td>
                            <td align="left">
                                此表为单个IP申请
                            </td>
                        </tr>
                     
                     
                    </table>
                </div>
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">端口映射</div>
                    <div style="height: 320px; overflow:auto;">
                        <table id="internetWindowtt" style="width:675px;height:auto" data-options="fitColumns:true,rownumbers:true,border: false,singleSelect:true,url:'',scrollbarSize:0">
                            <thead>
                                <tr>
                                   <th data-options="field:'application',width:100,formatter:appFormatters,
	                           
                           editor:{
                           type: 'combobox',
                           options:{
                           valueField:'appid',
                           textField:'appname',
                           method:'post',
                           required:true,
                           validType: 'isBlankorchoose',
                           url:'${pageContext.request.contextPath}/ordermg/getapps.do?unitid='+ $('#userunit').combobox('getValue'),
                           loadFilter:function(data){
					         data.push({appid:'btn',appname:'添加应用'});
					        return data;
	                     },
	                         onLoadSuccess:function(data){
							        $(this).combobox('select',data[0].appid);
							        },
							      formatter:function(dec){
						            if (dec.appid == 'btn') {
						            var str1='<div class=combobox-wrap>';
						            var str2='<span class=combobox-icon>+</span><span>' ;
						            var str3='</span></div>'
						          
						            var s =str1+str2 + dec.appname +str3 ;
						               
						                return s;
						            } else {
						                var opts = $(this).combobox('options');
						                return dec[opts.textField];
						
						            }
						        },
				                 required:true,
                                 onSelect: function(rec){
                                 if(rec.appid=='btn')  {
					                   var tr = $(this).closest('tr.datagrid-row');
					                  addApp('internetWindowtt',tr);
					              }  
					        }
                          }
                        }"><span class="must-star">*</span>应用</th>
                                    <th data-options="field:'usefor',width:100,editor:{type:'textbox', options:{required:true,validType:'isBlank',prompt:'如:web应用服务器',missingMessage:'该输入项为必填项'}}"> <span class="must-star">*</span>用途</th>
                                    <th data-options="field:'networkport',width:100,formatter:productFormatters,
                        editor:{
                            type:'validatebox',
                            options:{
                              required:true,
                              validType:'length[1,100]' 
                            }
                        
                        }"> <span class="must-star">*</span>公网端口</th>
                                    <th data-options="field:'reflectport',width:100,editor:{type:'validatebox', options:{required:true,validType:'length[1,100]'}}"><span class="must-star">*</span>映射端口</th>
                                    </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
      </div>
    <!--1专享弹出层弹层 -->
	   <!-- 专享云服务 -->
    <div id="ServiceVipWindow" style="padding:3px 0px;">
        <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">设备配置信息</div>
                    <div style="height: 426px; overflow:auto;">
                        <table id="serviceVipGrid" style="width:980px;height:410px" data-options="fitColumns:true, rownumbers: true,border: false,singleSelect:true,url:'',scrollbarSize:0">
                            <thead>
                                <tr>
                                    <th data-options="field:'equipmentname',width:100, editor:{type: 'validatebox',options:{required:true}}">
                        			<span class="must-star">*</span>设备名称</th>
                                    <th data-options="field:'equipmentbrand',width:80,editor:{type:'validatebox', options:{required:true}}"> 
                                    <span class="must-star">*</span>品牌型号</th>
                                    <th data-options="field:'equipmentstyle',width:100,formatter:productFormatters,
				                        editor:{
				                            type:'combobox',
				                            options:{
				                            	editable:false,
				                                valueField:'productid',
				                                textField:'name',
				                                data:optionTypes,
				                                required:true
				                            }
				                        }"> 
                        			<span class="must-star">*</span> 类型</th>
                                 	<th data-options="field:'equiparameters',width:100, formatter:formatCellTooltip,editor:{type:'viptext',options:{ required:true}}">
                                 	规格参数</th>
                                    <th data-options="field:'measureunit',width:60,align:'center',editor:{type: 'validatebox',options:{required:true}}">
                                    <span class="must-star">*</span>单位</th>
                                    <th data-options="field:'equipnums',width:60,align:'center',editor:{type:'numberbox',options:{required:true}}">
                                    <span class="must-star">*</span>数量</th>
                                    
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <!-- 专享弹出层弹层结束-->
    
    
       <!-- 整机柜托管 -->
    <div id="boxManagedWindow" style="padding:3px 0px;">
        <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">客户及业务信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                        <tr>
<!--                             <td align="right" width="16%"> <span class="must-star">*</span>业务应用系统：</td>
                            <td align="left" width="34%">
                                 <input id="ywyyxt" type="text" class="ty-top-input" style="width: 180px;"><span style="position: relative; top: 4px;left: 8px" onclick="addApp('ywyyxt','3')"><img src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
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
                                <input class="j-datetimebox" name=""  style="width:181px" id="zjtg_sjsj">
                            </td>
<!--                             <td align="right">域名备案：</td> -->
<!--                             <td align="left"> -->
<!--                                 <ul class="ty-tabscon-item-ul j-item-ul"> -->
<!--                                     <li class="active">是</li> -->
<!--                                     <li>否</li> -->
<!--                                 </ul> -->
<!--                             </td> -->
   <td align="right"> <span class="must-star">*</span>网络设备：</td>
                            <td align="left">
                                <ul class="ty-tabscon-item-ul j-item-ul">
                                    <li class="active">共享云中心</li>
                                    <li>自有设备连接</li>
                                </ul>
                            </td>

                        </tr>
                        <tr>
                         <!--    <td align="right"> <span class="must-star">*</span>网络设备：</td>
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
                              <td align="right">机柜功率：</td>
                            <td align="left">
                                <input id="jg_power" type="text" class="ty-top-input" style="width: 181px;">&nbsp;(W)
                            </td>
                        </tr>
                        <tr>
                          <!--   <td align="right">机柜功率：</td>
                            <td align="left">
                                <input id="jg_power" type="text" class="ty-top-input" style="width: 181px;">&nbsp;(W)
                            </td>
                             -->
                            <td align="right"><span class="must-star">*</span>申请机柜个数：</td>
                            <td align="left">
                                <input id="jg_num" type="text" class="ty-top-input" style="width: 181px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">设备配置信息</div>
                    <div style="height: 310px; overflow:auto;">
                        <table id="boxManagedWindowtt" style="width:714px;height:auto" data-options="fitColumns:true,rownumbers: true,border: false,singleSelect:true,url:'',scrollbarSize:0">
                            <thead>
                                <tr>
                                    <th data-options="field:'equipmentname',width:100, editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>设备名称</th>
                                    <th data-options="field:'equipmentpro',width:100,editor:{type:'validatebox'}">品牌型号</th>
                                    <th data-options="field:'equipmentstyle',width:100,formatter:productFormatters,
                        editor:{
                            type:'combobox',
                            options:{
                            editable:false,
                                valueField:'productid',
                                textField:'name',
                                data:optionTypes,
                                required:true
                            }
                        
                        }"> <span class="must-star">*</span> 类型</th>
                                    <th data-options="field:'equipmentcode',width:100,editor:{type:'validatebox'}">序列号</th>
                                    <th data-options="field:'equipmentpower',width:120,editor:{type:'numberbox'}">额定功率（W）</th>
                                    <th data-options="field:'equipmentheight',width:120,editor:{type:'numberbox',options:{required:true  }}"><span class="must-star">*</span>设备高度（U）</th>
                                    <th data-options="field:'equipmentapp',width:120,formatter:appFormatters,
                        editor:{
                            type:'combobox',
                            options:{
                                editable:false,
                                valueField:'appid',
                                textField:'appname',
                                url:'${ctx}/ordermg/getapps.do?unitid='+$('#userunit').combobox('getValue'),
                                 loadFilter:function(data){
							      
							        data.push({appid:'btn',appname:'添加应用'});
							        return data;
							        },
							       onLoadSuccess:function(data){
							        $(this).combobox('select',data[0].appid);
							        },
							      formatter:function(dec){
						            if (dec.appid == 'btn') {
						            var str1='<div class=combobox-wrap>';
						            var str2='<span class=combobox-icon>+</span><span>' ;
						            var str3='</span></div>'
						          
						            var s =str1+str2 + dec.appname +str3 ;
						               
						                return s;
						            } else {
						                var opts = $(this).combobox('options');
						                return dec[opts.textField];
						
						            }
						        },
				                 required:true,
                                 onSelect: function(rec){
                                 if(rec.appid=='btn')  {
					                   var tr = $(this).closest('tr.datagrid-row');
					                  addApp('boxManagedWindowtt',tr);
					              }  
					        }
                            }
                        
                        }"> <span class="must-star">*</span> 应用</th>
                                    <th data-options="field:'equipmentregion',width:100,formatter:productFormatter,
                        editor:{
                            type:'combobox',
                            options:{
                                editable:false,
                                valueField:'productid',
                                textField:'name',
                                data:optionNetwork,
                                required:true
                            }
                        }"> <span class="must-star">*</span> 区域</th>
                                    <th data-options="field:'snote',width:100, editor:{
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
    
   <!-- 机位托管 -->
    <div id="positionManagedWindow" style="padding:3px 0px;">
        <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">客户及业务信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                        <tr>
                           <!--  <td align="right" width="16%"> <span class="must-star">*</span>业务应用系统：</td>
                            <td align="left" width="34%">
                                  <input id="u_ywyyxt" type="text" class="ty-top-input" style="width: 180px;"><span style="position: relative; top: 4px;left: 8px" onclick="addApp('u_ywyyxt','4')"><img src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
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
                                <input class="j-datetimebox" name=""  style="width:181px" id="u_putime">
                            </td>
                          <!--   <td align="right">域名备案：</td>
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
                         <!--    <td align="right"> <span class="must-star">*</span>网络设备：</td>
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
                                <input id="u_num" type="text" class="ty-top-input" style="width: 180px;">
                            </td>
                        </tr>
                     <!--    <tr>
                            <td align="right">申请U位个数</td>
                            <td align="left">
                                <input id="u_num" type="text" class="ty-top-input" style="width: 180px;">
                            </td>
                            <td align="right"></td>
                            <td align="left">
                            </td>
                        </tr> -->
                    </table>
                </div>
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">设备配置信息</div>
                    <div style="height: 310px; overflow:auto;">
                        <table id="positionManagedtt" style="width:714px;height:auto" data-options="fitColumns:true,rownumbers: true,border: false,singleSelect:true,url:'datagrid_data2.json',scrollbarSize:0">
                         <thead>
                                <tr>
                                    <th data-options="field:'equipmentname',width:100, editor:{
                           type: 'validatebox',
                            options:{required:true  }
                            
                        }"><span class="must-star">*</span>设备名称</th>
                                    <th data-options="field:'equipmentpro',width:100,editor:{type:'validatebox'}"> 品牌型号</th>
                                    <th data-options="field:'equipmentstyle',width:100,formatter:productFormatters,
                        editor:{
                            type:'combobox',
                            options:{
                                editable:false,
                                valueField:'productid',
                                textField:'name',
                                data:optionTypes,
                                required:true
                            }
                        }"> <span class="must-star">*</span> 类型</th>
                                    <th data-options="field:'equipmentcode',width:100,editor:{type:'validatebox'}">序列号</th>
                                    <th data-options="field:'equipmentpower',width:120,editor:{type:'numberbox'}">额定功率（W）</th>
                                    <th data-options="field:'equipmentheight',width:120,editor:{type:'numberbox',options:{required:true  }}"><span class="must-star">*</span>设备高度（U）</th>
                              <th data-options="field:'equipmentapp',width:120,formatter:appFormatters,
                        editor:{
                            type:'combobox',
                            options:{
                                editable:false,
                                valueField:'appid',
                                textField:'appname',
                                url:'${ctx}/ordermg/getapps.do?unitid='+$('#userunit').combobox('getValue'),
                                 loadFilter:function(data){
							        
							        data.push({appid:'btn',appname:'添加应用'});
							        return data;
							        },
							          onLoadSuccess:function(data){
							        $(this).combobox('select',data[0].appid);
							        },
							      formatter:function(dec){
						            if (dec.appid == 'btn') {
						            var str1='<div class=combobox-wrap>';
						            var str2='<span class=combobox-icon>+</span><span>' ;
						            var str3='</span></div>'
						          
						            var s =str1+str2 + dec.appname +str3 ;
						               
						                return s;
						            } else {
						                var opts = $(this).combobox('options');
						                return dec[opts.textField];
						
						            }
						        },
                                required:true,
                                 onSelect: function(rec){
                                 if(rec.appid=='btn')  {
                   var tr = $(this).closest('tr.datagrid-row');
                  addApp('positionManagedtt',tr);
              }  
        }
                            }
                        
                        }"> <span class="must-star">*</span> 应用</th>
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
                                    <th data-options="field:'snote',width:100, editor:{
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
 
    <!-- 防火墙 -->
       <div id="fhqsqWindow" class="pop easyui-window">
        <div style="padding:20px 0">
            <form id="">
                <div class="item3">
                    <div class="item-wrap">
                        <table width="100%" border="0" class="table-layout">
                            <tr>
                                <td align="right" width="30%"><span class="must-star">*</span>防护类型：</td>
                                <td style="padding:6px 3px;">
                                    <ul class="item-ul j-toggle">
                                        <li text='snfw' class="active" onclick="nTabs(this, 'active');$('#wbFh').show();$('#allFh').hide();">外部防护</li>
                                        <li text='ewfw' onclick="nTabs(this, 'active');$('#allFh').show();$('#wbFh').hide();">全防护</li>
                                    </ul>
                                    <a href="javascript:void(0)" class="tip-why-box " id="fhqsq01" title="">？</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                  <div class="item3" id="wbFh">
                    <div class="item-wrap">
                        <table width="100%" border="0" class="table-layout">
                            <tr>
                                <td align="right"  width="30%"><span class="must-star">*</span>吞吐量：</td>
                                <td style="padding:6px 3px;">
                                    <ul class="item-ul j-toggle">
                                        <li class="active" onclick="nTabs(this, 'active')">2G</li>
                                        <li onclick="nTabs(this, 'active')">4G</li>
                                    </ul><a href="javascript:void(0)" class="tip-why-box fhqsq02"  title="">？</a>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><span class="must-star">*</span>使用区域：</td>
                                <td align="left" style="padding:6px 3px;">
                                    <ul class="item-ul j-toggle">
                                        <li value="10001" class="active" onclick="nTabs(this, 'active')">政务外网</li>
                                        <li value="10002" onclick="nTabs(this, 'active')">互联网</li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><span class="must-star">*</span>数量：</td>
                                <td style="padding:6px 3px;">
                                    <div class="add-sub">
                                        <a class="subbtn j-subtn" href="javascript:void(0)">-</a>
                                        <input class="input-num"  id ="snfwnum"  onkeydown="onlyNum()"  type="text" value="1" style="width: 121px;">
                                        <a class="addbtn j-addbtn" href="javascript:void(0)">+</a>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="item3" id="allFh" style="display:none">
                    <div class="item-wrap">
                        <table width="100%" border="0" class="table-layout">
                            <tr>
                                <td align="right"  width="30%"><span class="must-star">*</span>吞吐量：</td>
                                <td style="padding:6px 3px;">
                                    <ul class="item-ul j-toggle">
                                        <li class="active" onclick="nTabs(this, 'active')">5G</li>
                                       
                                    </ul><a href="javascript:void(0)" class="tip-why-box fhqsq02"  title="">？</a>
                                </td>
                            </tr>
                           
                            <tr>
                                <td align="right"><span class="must-star">*</span>数量：</td>
                                <td style="padding:6px 3px;">
                                    <div class="add-sub">
                                        <a class="subbtn j-subtn" href="javascript:void(0)">-</a>
                                        <input class="input-num "  id="ewfwnum" onkeydown="onlyNum()" type="text" value="1" style="width: 121px;">
                                        <a class="addbtn j-addbtn" href="javascript:void(0)">+</a>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- 结束 -->

    <%-- 负载均衡 start --%>
      <div id="serviceWindow_fzjh"  class="pop easyui-window">
	      <div style="padding:20px 0">
	            <form id="myForm">
	                <div class="item3">
	                    <div class="item-wrap">
	                        <table width="100%" border="0" class="table-layout">
	                            <tr>
	                                <td align="right"><span class="must-star">*</span>区域：</td>
	                                <td style="padding:6px 3px;">
	                                    <ul class="item-ul j-toggle" id="fzjhNetWork">
	                                        <li class="active"   value="10001" onclick="nTabs(this, 'active')">政务外网</li>
	                                        <li  value="10002" onclick="nTabs(this, 'active')">互联网</li>
	                                    </ul>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td align="right"><span class="must-star">*</span>最大连接数：</td>
	                                <td align="left" style="padding:6px 3px;">
	                                    <ul class="item-ul j-toggle" id="fzjhMaxConn">
	                                        <li class="active" onclick="nTabs(this, 'active')">5000</li>
	                                        <li onclick="nTabs(this, 'active')">10000</li>
	                                        <li onclick="nTabs(this, 'active')">20000</li>
	                                    </ul><a href="javascript:void(0)" class="tip-why-box " id="fzjhTips" title="">？</a>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td align="right"><span class="must-star">*</span>数量：</td>
	                                <td style="padding:6px 3px;">
	                                    <div class="add-sub">
	                                        <a class="subbtn j-subtn" href="javascript:void(0)">-</a>
	                                        <input class="input-num" onkeydown="onlyNum()" id="fzjhNum" type="text" value="1" style="width: 121px;">
	                                        <a class="addbtn j-addbtn" href="javascript:void(0)">+</a>
	                                    </div>
	                                </td>
	                            </tr>
	                        </table>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
    <%--  负载均衡 end  --%>
    
    <!-- 云硬盘start -->
    <div id="storageWindow" style="padding:3px 0px;">
        <div class="j-tabs-con">
            <div class="ty-tabscon-main">
                <div class="ty-tabscon-item">
                    <div class="ty-tabscon-item-title">配置信息</div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout" style="table-layout:fixed">
                        <tr>
                        	<td align="right" style="width:10% ; "> <span class="must-star">*</span>容量：</td>
                            <td align="left" colspan="3" style="width:40%;height:70px" class="j-xtp-item"> 
                            <div class="j-silde"></div> 
                            <div class="item-right" style="position: static;margin-left: 392px;margin-top: -25px;">
				            	<input type="text" value="10" class="j-indisk"><span>GB</span>
				            </div>
                        </tr>
                        <tr >
                        	<td align="right" width="13%" style=""> <span class="must-star">*</span>数量：</td>
                            <td align="left">
					               <div class="add-sub" style="overflow: hidden;margin-top:30px; margin-bottom:20px;">
					                   <a class="subbtn" id="subBtn" href="javascript:void(0)" style=" font-size: 20px; line-height: 30px; border-width: 1px; border-style: solid; border-color: #ddd;float:left; width: 30px; text-align: center; text-decoration: none">-</a>
					                   <input class="input-num" type="text" value="1" style="line-height: 30px; height: 30px; border-width: 1px 0 1px 0; border-style: solid; border-color: #ddd; vertical-align: top;float:left; width: 60px; text-align: center;">
					                   <a class="addbtn" id="addBtn" href="javascript:void(0)" style="font-size: 20px; line-height: 30px; border-width: 1px; border-style: solid; border-color: #ddd;float:left; width: 30px;text-align: center; text-decoration: none">+</a>
					               </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
	<!-- 云硬盘end -->
	
	
    <div id="dd" class="easyui-dialog" title="规格" style="width:420px;height:220px;padding:10px;"   
        data-options="iconCls:'icon-edit',modal:true,closed:true">   
        <textarea  id="addtext" style="width:380px;height:120px;margin-left:8px;font-size:14px;border:1px solid #ccc;overFlow-y:scroll;" onkeyup="charleft()"></textarea>
     	<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
     		<span style="color:red; float:left">&nbsp;&nbsp;(*不得超过500个字符)</span>
     		<span style="float:left;margin-left: 10px;" id="charleft">500</span>
			<a id="savebtn" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="confirmVip()" style="width:60px">保存</a>
			<a id="btn" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="cancelVip()" style="width:60px">取消</a>
		</div>
	</div>  
    <script type="text/javascript">
    $.extend($.fn.combobox.methods, {
    selectedIndex: function (jq, index) {
        if (!index)
            index = 0;
        var data = $(jq).combobox('options').data;
        var vf = $(jq).combobox('options').valueField;
        $(jq).combobox('setValue', eval('data[index].' + vf));
    }
});
		    var i = 0;
		    var yy = '';
    		$.extend($.fn.datagrid.defaults.editors, {    
            viptext: {    
                init: function(container, options){ 
                    var input = $('<input type="viptext"  id="_'+i+'" class="datagrid-editable-input" > ').appendTo(container);    
    				$("#_"+i).click(function(){
    					var val = $(this).attr("id");
    					yy=val;
    					 $("#charleft").html(500-$("#"+val).val().length);
    					$('#dd').window('open');
    					$('#addtext').val($("#"+val ).val());
    				});          
     				i++;
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
       	
       	function charleft(){
       	  
       	 var num = 500-$("#addtext").val().length;
       	 if(num>0||num==0){
       	  $("#charleft").html("剩余字数  "+'<font face="微软雅黑" size="12px"color="#666">'+num+"</font>");  
       	 }else {
       	  $("#charleft").html('<font color="red">超过限制字数  </font>'+ '<font face="微软雅黑" size="12px">'+(0-num)+"</font>"); 
       	 }
       	}

    var  appDiloagid = '';
    var  datagridtr = '';
    function getFormattime () {
       var date = new Date();
       return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
     }
  
     
      
    $(".fqdate").html("发起时间："+getFormattime());
    $("#giveUp").hide();
 
    $(".j-toggle-z").click(function() {
        $(".j-select").height("auto");
        $(this).hide().siblings().show();

    })
    $(".j-toggle-s").click(function() {
        $(".j-select").height("36px");
        $(this).hide().siblings().show();

    })

    loadDataGrid();


    $('#userunit').combobox({
        
        valueField: 'unitId',
        textField: 'unitName',
        
        url: '${ctx}/project/getUnits.do',
        onSelect: function(rec){    
               var url = '${ctx}/project/getProjects.do?unitid='+rec.unitId;    
                 
                 $('#projectName').combobox({    
                    url:url,    
                    valueField:'proid',    
                    textField:'proname',  
                    onLoadSuccess: function () { //加载完成后,设置选中第一项
                    var data = $('#proid').combobox('getData');
                    if (data.length > 0) {
                    $('#projectName').combobox('select', data[0].proid);
                  } 
                 }   
               });
              },
               onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#userunit').combobox('getData');
             if (data.length > 0) {
                 $('#userunit').combobox('select', data[0].unitId);
             } 
            }  
        });
        
    $('#projectName').combobox({
      
        valueField: 'proid',
        textField: 'proname',
     
        
    });
  
    // 表格数据加载
    function loadDataGrid() {
        var str;
        for(var i=0,len=$(".t-wrap-iaas").length;i<len;i++){
        
		       $('#iaas'+i).datagrid({
		           title:  $("#hidden"+i).val(),
		           rownumbers: false,
		           scrollbarSize: 0,
		           border: false,
		           method: 'post',
		           loadMsg: '数据装载中......',
		           fitColumns: true,
		           nowrap: false,
		           url: '',
		           columns: [
		               [{
		                   field: 'serviceid',
		                   title: '服务编码 ',
		                   width: 80,
		                   align: 'center'
		               }, {
		                   field: 'itemname',
		                   title: '产品名称',
		                   width: 80,
		                   align: 'center'
		               }, {
		                   field: 'format',
		                   title: '规格',
		                   width: 150,
		                   align: 'center'
		               },
		               {
		                   field: 'appid',
		                   title: '单位ID',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		               {
		                   field: 'platformid',
		                   title: '平台ID',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		               {
		                   field: 'ipaddress',
		                   title: 'IP',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		               {
		                   field: 'typeid',
		                   title: '单位ID',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		                 {
		                   field: 'appname',
		                   title: '单位ID',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		               {
		                   field: 'pshopid',
		                   title: '单位ID',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		                   {
		                   field: 'pshopname',
		                   title: '单位ID',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		                {
		                   field: 'unitid',
		                   title: '单位ID',
		                   width: 80,
		                    hidden:true,
		                   align: 'center'
		               },
		                 {
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
		               },
		               {
		                   field: 'network',
		                   title: '项目名称',
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		            
		              {
		                   field: 'networkid',
		                   title: '网络类型id',
		                   hidden:true,
		                   width: 80,
		                   hidden:true,
		                   align: 'center'
		               },
		                {
		                   field: 'unit',
		                   title: '使用单位',
		                   hidden:true,
		                   width: 80,
		                   align: 'center'
		               }, 
		               {
		                   field: 'unitnum',
		                   title: '单位',
		                   width: 60,
		                   align: 'center'
		               },{
		                   field: 'counter',
		                   title: '数量',
		                   width: 60,
		                   align: 'center'
		               }, {
		                   field: 'operate',
		                   title: '操作',
		                   width: 60,
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
       for(var i=0,len=$(".t-wrap-iaas").length;i<len;i++){
        $("#iaas"+i).datagrid('resize', {
            width: $(".t-wrap-iaas").width //收缩引起window resize,重新计算值，并调用resize方法。
        });
      
        }
    });

    //删除行操作  
    function del(index, obj) {
      
        id=$(obj).parents(".datagrid-view2").next("table").attr("id");
         index=$(obj).parents("tr").index();
        $.messager.confirm('确认', '确认删除?', function(row) {
            if (row) {
                var selectedRow = $("#" +id).datagrid('getSelected'); //获取选中行  
                
                $("#" +id).datagrid('deleteRow', index);
            }
        })

    }
    $(".j-yes").click(function() {
        $('#orderWrap').panel({
            href: ''
        });

    })
    $(".j-cancle").click(function() {
        $('#orderWrap').panel({
            href: ''
        });


    })


   
    var selectFlag = "";
    var unitNum = "";
    var typeid = "";
    var productid = "";
    var pproductid = "";
    var pproductname = "";
    var idname;
    var objdata = new Object();
    var windowHtml = $('#serviceWindow').html();
   	
 
    $('#serviceWindow').html("");
    
    var innethtml = $('#boxManagedWindow').html();//整机托管
    var innethtml2 = $('#positionManagedWindow').html();//机位托管
    var innethtml3 = $('#serviceWindow_ip').html();
 
    //var  firewalls = $('#FirewallsWindow').html();//防火墙
 
    var innerhtml_fzjh = $('#serviceWindow_fzjh').html();//负载均衡
 	var storage = $('#storageWindow').html();//云硬盘
    // 弹层展开以及配置 大于0咯 
    $(".j-select li span:gt(0) a").click(function() {
    
        objdata.proname = $("#projectName").textbox('getValue');
        var obj=$(this).parent();
    	if(objdata.proname){ 
        selectFlag = $(this).parent().text();
        idname = $(obj).parent().attr('id');
        pproductname = $(obj).parent().prev().prev().text();
        pproductid = $(obj).parent().prev().val();
    
    
        var uid =  $("#userunit").combobox('getValue');
	    $("#resourceapp_other").combobox({
	        url:'${ctx}/ordermg/getapps.do?unitid='+uid,
	        valueField: 'appid',
	        textField: 'appname',
	        loadFilter:function(data){
	        data.unshift({appid:'',appname:"---请选择---"});
	        return data;
	        }
	    })
        var temp = $(obj).next().val().split(",");
        productid = temp[0];
        temp[1]=='null'?temp[1]='个':temp[1];
       
        unitNum =temp[1];
        typeid = temp[2];
        $("#config").val('');
        $("#inptNum").val('1');
        $("#productunit").text(unitNum);
        if(typeid=="HLW"){
	   
	        
	     $('#serviceWindow_ip').dialog({
            closed: false,
            title: selectFlag
          });
     
          //初始化
         $('#serviceWindow_ip').html(innethtml3);
        
	  
          $("#yys").combobox({
	        url:'${ctx}/ordermg/getDataConfig.do?dataType=corporation',
	        valueField: 'dcid',
	        textField: 'dcname',
	        loadFilter:function(data){
	        data.unshift({dcid:'',dcname:"请选择"});
	        return data;
	        }
	    })
	     //获取应用数据
	    $('#dk').numberbox({    
            min:0   
        });  
	    
         var lastIndex;
        $('#internetWindowtt').datagrid({
            toolbar: [{
                text: '增加',
                iconCls: 'icon-add',
                handler: function() {
                    $('#internetWindowtt').datagrid('endEdit', lastIndex);
                    $('#internetWindowtt').datagrid('appendRow', {
                        application: '',
                        usefor:'',
                        networkport: '',
                        reflectport: ''      
                    });
                    lastIndex = $('#internetWindowtt').datagrid('getRows').length - 1;
                    $('#internetWindowtt').datagrid('selectRow', lastIndex);
                    $('#internetWindowtt').datagrid('beginEdit', lastIndex);
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
            }, '-', {
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
            }
					
        });
        
        
     
        }else if(typeid=="JGTG"){
        
            
           $('#boxManagedWindow').dialog({
            closed: false,
            title:selectFlag
        });
        
        $('#boxManagedWindow').html(innethtml);

        // 弹层内容easyui初始化
        var  datestr = getFormattime();
        $('.j-datetimebox').datebox({
            showSeconds: false,
            value:datestr,
            required: true
        });
        var myDate = new Date()	;
	    var myMonth = new Date();
	    var myYear = new Date();
        var d = $('.j-datetimebox').datebox('calendar');
        d.calendar({
	      firstDay: 1,
	      	validator:function  (date){
					var day =date.getDate();
					var month=date.getMonth();
					var year=date.getYear();
					if(year>myYear.getYear())
							return true;
					   else if (year==myYear.getYear())
					 	{
							if(month>myMonth.getMonth())
							return true ;
							else if (month==myMonth.getMonth())
							{
								if(day >=myDate.getDate() )
								return true;
								else 
								return false;
							}
								else 
								return false ;
					    }
						else 
						return false ;
				
				}
        });
        
        $('#jg_power').numberbox({    
          min:1,       
         }); 
         
        $('#jg_num').numberbox({    
         min:1, 
         value:1      
        });
      
      /*       var tguid =  $("#userunit").combobox('getValue');
            $("#ywyyxt").combobox({
	        url:'${ctx}/ordermg/getapps.do?unitid='+tguid,
	        valueField: 'appid',
	        textField: 'appname',
	        loadFilter:function(data){
	        data.unshift({appid:'',appname:"请选择"});
	        return data;
	        }
	    }) */
        // 初始化
        var lastIndex;
        
      $('#boxManagedWindowtt').datagrid({
            toolbar: [{
                text: '增加',
                iconCls: 'icon-add',
                handler: function() {
                    $('#boxManagedWindowtt').datagrid('endEdit', lastIndex);
                    
                    $('#boxManagedWindowtt').datagrid('appendRow', {
                         equipmentname: '',
                        equipmentpro:'',
                        equipmentstyle: '',
                        equipmentcode: '',
                        equipmentpower: '',
                        equipmentheight: '',
                        equipmentapp:'',
                        equipmentregion: '',
                        snote: ''
                    });
                    lastIndex = $('#boxManagedWindowtt').datagrid('getRows').length - 1;
                    $('#boxManagedWindowtt').datagrid('selectRow', lastIndex);
                    $('#boxManagedWindowtt').datagrid('beginEdit', lastIndex);
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function() {
                    var row = $('#boxManagedWindowtt').datagrid('getSelected');
                    if (row) {
                        var index = $('#boxManagedWindowtt').datagrid('getRowIndex', row);
                        $('#boxManagedWindowtt').datagrid('deleteRow', index);
                    }
                }
            }, '-', {
                text: '保存',
                iconCls: 'icon-save',
                handler: function() {
                    $('#boxManagedWindowtt').datagrid('acceptChanges');
                }
            }],
            onBeforeLoad: function() {
                $(this).datagrid('rejectChanges');
            },
            onClickRow: function(rowIndex) {
                if (lastIndex != rowIndex) {
                    $('#boxManagedWindowtt').datagrid('endEdit', lastIndex);
                }
                    $('#boxManagedWindowtt').datagrid('beginEdit', rowIndex);
                lastIndex = rowIndex;
            }
        });
	       
 
        }else if(typeid=="VIP"){
        //2专享服务
        $('#ServiceVipWindow').dialog({
            closed: false,
            title:selectFlag
        });
        $('#ServiceVipWindow').html(innerviphtml);

        // 弹层内容easyui初始化
        $('.j-datetimebox').datetimebox({
            showSeconds: true,
            required: true
        });
        // 初始化
        var lastIndex;
    	$('#dd').window('close');
        $('#serviceVipGrid').datagrid({
            toolbar: [{
                text: '增加',
                iconCls: 'icon-add',
                handler: function() {
                    $('#serviceVipGrid').datagrid('endEdit', lastIndex);
                    $('#serviceVipGrid').datagrid('appendRow', {
                        equipmentname: '',
                        equipmentbrand: '',
                        equipmentstyle: '',
                        equiparameters: '',
                        measureunit: '',
                        equipnums: '1'
                       
                    });
                    lastIndex = $('#serviceVipGrid').datagrid('getRows').length - 1;
                    $('#serviceVipGrid').datagrid('selectRow', lastIndex);
                    $('#serviceVipGrid').datagrid('beginEdit', lastIndex);
                }
            }, '-', {
                text: '删除',
                iconCls: 'icon-remove',
                handler: function() {
                    var row = $('#serviceVipGrid').datagrid('getSelected');
                    if (row) {
                        var index = $('#serviceVipGrid').datagrid('getRowIndex', row);
                        $('#serviceVipGrid').datagrid('deleteRow', index);
                    }
                }
            }, '-', {
                text: '保存',
                iconCls: 'icon-save',
                handler: function() {
            	var eqipmentsvips= $("#serviceVipGrid").datagrid('getRows'); 
 		 //验证
 		 if(eqipmentsvips.length==0){
                $.messager.alert('消息',"请输入设备配置信息","info");
	              return;
              }
             if(isendEdit("serviceVipGrid",eqipmentsvips)){
             
                endEdit("serviceVipGrid",eqipmentsvips);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
                    //$('#serviceVipGrid').datagrid('acceptChanges');
                }
            }],
            onBeforeLoad: function() {
                $(this).datagrid('rejectChanges');
            },
            onClickRow: function(rowIndex) {
                if (lastIndex != rowIndex) {
                    $('#serviceVipGrid').datagrid('endEdit', lastIndex);
                }
                    $('#serviceVipGrid').datagrid('beginEdit', rowIndex);
                lastIndex = rowIndex;
            }
        });
        
        }
       else if(typeid=="JWTG"){
	    
	       $('#positionManagedWindow').dialog({
            closed: false,
            title:selectFlag
        });
        $('#positionManagedWindow').html(innethtml2);
         // 弹层内容easyui初始化
          var  datestr2 = getFormattime();
        $('.j-datetimebox').datebox({
            showSeconds: false,
            value :datestr2,
            required: true
        });
    
        var myDate = new Date();
	   
        var d = $('#u_putime').datebox('calendar');
        d.calendar({
	      firstDay: 1,
	      	validator:function(date){
					var day =date.getDate();
					var month=date.getMonth();
					var year=date.getYear();
					if(year>myDate.getYear())
							return true;
					   else if (year==myDate.getYear())
					 	{
							if(month>myDate.getMonth())
							return true ;
							else if (month==myDate.getMonth())
							{
								if(day >=myDate.getDate() )
								return true;
								else 
								return false;
							}
								else 
								return false ;
					    }
						else 
						return false ;
				
				}
        });
         $('#u_num').numberbox({    
         min:1, 
         value:1      
        });
          /*  var u_tguid =  $("#userunit").combobox('getValue');
            $("#u_ywyyxt").combobox({
	        url:'${ctx}/ordermg/getapps.do?unitid='+u_tguid,
	        valueField: 'appid',
	        textField: 'appname',
	        loadFilter:function(data){
	        data.unshift({appid:'',appname:"请选择"});
	        return data;
	        } 
	    }) */
        // 初始化
        var lastIndex;
        $('#positionManagedtt').datagrid({
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
                        equipmentapp:'',
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
            }
        });
	    
	    }else if(typeid==='FW'){
	    
	  // 弹层展示
        $('#fhqsqWindow').dialog({
            closed: false,
            title:selectFlag
        });
        var fwtype = ""; 
        var inout = ""; 
	     $.ajaxSettings.async = false; //全局设置同步
	  	 $.getJSON('${ctx}/tips.json', function(data) {
	  	     var fwobj=data.fw;//获取指定对象（数组形式）
             fwtype  = fwobj[0].type;//如果只有一个（即一个{}）选择第一个即可，如果多个，按需选择或遍历
              inout = fwobj[0].inout;
        });
	  	$.ajaxSettings.async = true;//全局设置异步（改为默认方式）
        //内容填充初始化
        for (var i = 0; i < $('#fhqsqWindow .j-toggle ').length; i++) {
            $('#fhqsqWindow .j-toggle').eq(i).find("li:eq(0)").addClass('active').siblings().removeClass('active');
        }
        $('#wbFh').show();
        $('#allFh').hide();
        $('#fhqsqWindow .input-num').val(1);
        $('#fhqsq01').tooltip({
            position: 'right',
            content:fwtype ,
            onShow: function() {
                $(this).tooltip('tip').css({
                    backgroundColor: '#f7f7f7',
                    borderColor: '#ddd'
                });
            }
        })
        $('.fhqsq02').tooltip({
            position: 'right',
            content: inout,
            onShow: function() {
                $(this).tooltip('tip').css({
                    backgroundColor: '#f7f7f7',
                    borderColor: '#ddd'
                });
            }
        })

	    }
	    
       else if(typeid == "InSLB"){//负载均衡
    	   $("#serviceWindow_fzjh").html(innerhtml_fzjh);
    	   $("#serviceWindow_fzjh").dialog({
    		   closed:false,
    	   	   title: selectFlag
    	   });
    	 
    	 var inout = ""; //帮助提示
  	     $.ajaxSettings.async = false; //全局设置同步
  	  	 $.getJSON('${ctx}/tips.json', function(data) {
  	  	       var fwobj=data.InSLB_SQ;//获取指定对象（数组形式）
  	  	  	   inout  = fwobj[0].connnum;//如果只有一个（即一个{}）选择第一个即可，如果多个，按需选择或遍历
          });
  	  	 $.ajaxSettings.async = true;//全局设置异步（改为默认方式）
    	 //内容填充初始化
           for (var i = 0; i < $('#appFzjhWindow .j-toggle ').length; i++) {
               $('#appFzjhWindow .j-toggle').eq(i).find("li:eq(0)").addClass('active').siblings().removeClass('active');
           }
           $('#fzjhNum').val(1);

           $('#fzjhTips').tooltip({
               position: 'right',
               content: inout,
               onShow: function() {
                   $(this).tooltip('tip').css({
                       backgroundColor: '#f7f7f7',
                       borderColor: '#ddd'
                   });
               }
           })
       }else if(typeid == "InDisk"){
    	   $('#storageWindow').dialog({
               closed: false,
               title:selectFlag
           });
           $('#storageWindow').html(storage);
           
           // 云硬盘滑块初始
           $('.j-silde').slider({
               width: 350,
               showTip: true,
               value: 10,
               min: 0,
               max: 2000,
               step: 1,
               disabled: false,
               rule: [0,'|',1000,'|', 2000],
               tipFormatter: function(value) {
                   return value + 'GB';
               },
               onChange: function(value) {
                   $(this).parent("td").find('.j-indisk').val(value);
               }
           });
       }
        
	    else{
	    
	          $('#serviceWindow_other').dialog({
	            closed: false,
	            title: selectFlag,
	        });
	    }
        
        
       }else{
    		$.messager.alert('提示',"请选择项目名称！",'info');
    		return false;
    	}

     })
     
    $(".j-select li span:eq(0)  a").click(function() {
    	objdata.proname = $("#projectName").textbox('getValue');
    	if(""==objdata.proname||null==objdata.proname){
    		$.messager.alert('提示',"请选择项目名称！",'info');
    		return false;
    	}
    	var obj=$(this).parent();
        selectFlag = $(this).text();
        idname = $(obj).parent().attr('id');
        pproductname = $(obj).parent().prev().prev().text();
        pproductid = $(obj).parent().prev().val();
        var temp = $(obj).next().val().split(",");
        productid = temp[0];
        unitNum = temp[1];
        typeid = temp[2];
         //初始化cpu
	    initCpu();
	    $("#cpuchoose").children().remove();
	    //初始化內存
	    initMem();
	    $("#memchoose").children().remove();
   
        $('#serviceWindow').html(windowHtml);
        
         var auid =$("#userunit").combobox('getValue');
	    $("#resourceapp").combobox({
	        url:'${ctx}/ordermg/getapps.do?unitid='+auid,
	        valueField: 'appid',
	        textField: 'appname',
	        loadFilter:function(data){
	        data.unshift({appid:'',appname:"---请选择---"});
	        return data;
	        }
	    })
    
        $('#serviceWindow').dialog({
            closed: false,
            title: selectFlag,
        });
            // 滑块1初始
        $('.j-silde').slider({
            width: 450,
            showTip: true,
            value: 10,
            min: 0,
            max: 2000,
            step: 10,
            disabled: false,
            rule: [0, '|', 2000],
            tipFormatter: function(value) {
                return value + 'GB';
            },
            onChange: function(value) {
                $(this).parents(".j-xtp-item").find('.j-value').val(value);
            }
        });
        $('#addLinkBtn').linkbutton({
           
        });
        $('#addLinkPannel').tooltip({
            position: 'right',
            content: '<span style="color:#666">最多可增加两块盘</span>',
            onShow: function() {
                $(this).tooltip('tip').css({
                    backgroundColor: '#afe8ff',
                    borderColor: '#afe8ff'
                });
            }
        });
        $('#sss').spinner({
            required:true,
            increment:10
            /* showTip:true,
			rule: [0,'|',25,'|',50,'|',75,'|',100] */
        });  
        $("#template").combobox({
            url:'${pageContext.request.contextPath}/vmconfig/queryTemplates.do',    
	        valueField:'templateid',    
	        textField:'templatename',
	        loadFilter:function(data){
	        data.unshift({templateid:'',templatename:"---请选择---"});
	        return data;
	    },
	    onSelect: function(data){ 
	      $(this).combobox('setText', data.templatename.substring(data.templatename.indexOf(">")+1));
	      if(data.templateid.toLowerCase().indexOf('win')!=-1){
	        $("#sysdisk").html("注：系统盘60G");
	      }else if(''===data.templateid||"其它"===data.templateid){
	        $("#sysdisk").html("");
	      }else{
	        $("#sysdisk").html("注：系统盘40G");
	      }
	    },
	    onLoadSuccess: function () { //加载完成后,设置选中第一项
	       var data = $('#instancestemplate').combobox('getData');
           if (data.length > 0) {
                 $('#instancestemplate').combobox('select', data[0].templateid);
             
                 $('#instancestemplate').combobox('select', data[0].templatename.substring(data[0].templatename.indexOf(">")+1));
            
           } 
	             
	    }   
        })

    })

 

    // 弹层配置
    
    $('#serviceWindow').dialog({
        width: 820,
        height: 600,
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
                objdata.image = $("#template").combobox('getText');
                objdata.appid = $("#resourceapp").combobox('getValue');
                objdata.appname = $("#resourceapp").combobox('getText');
                if("---请选择---"==objdata.image){
                	$.messager.alert('提示',"请选择操作系统！",'info'); 
	                return false;
                }
                 if(''==objdata.appid){
                	$.messager.alert('提示',"请选择应用！",'info'); 
	                return false;
                }
             
                var len = $("#serviceWindow .j-xtp .j-xtp-item").length;
                objdata.disk =  '';
                 
                if(len==0){objdata.disk = '0,0'}
                if(len==1){
                 var disk1 = $("#serviceWindow .j-silde:first").slider('getValue');
                 objdata.disk=disk1+',0'
                }
                if(len==2){
	                var disk1 = $("#serviceWindow .j-silde:first").slider('getValue');
	                var disk2 = $("#serviceWindow .j-silde:last").slider('getValue');
                    objdata.disk=disk1+','+disk2
                }
                objdata.unit = $("#userunit").combobox('getText');
                objdata.unitid = $("#userunit").combobox('getValue');
                objdata.proid = $("#projectName").combobox('getValue');
                objdata.proname = $("#projectName").combobox('getText');
                objdata.num = $(".lcy-window-item .input-num").val();
                $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                        serviceid: productid,
                        pshopid:pproductid,
                        pshopname:pproductname,
                        itemname: $('#serviceWindow').panel('options').title,
                        unitid: objdata.unitid,
                        format: "CPU:"+objdata.cpu+";内存:"+objdata.rom+";操作系统:"+ objdata.image+";磁盘(G):"+objdata.disk+";磁盘类型:"+objdata.disktype,
                        network:objdata.network,
                        networkid:objdata.networkid,
                        unit: objdata.unit,
                        unitnum: unitNum,
                        typeid:typeid,
                        proid: objdata.proid,
                        appid:objdata.appid,
                        appname:objdata.appname,
                        proname:  objdata.proname,
                        counter:objdata.num
                    }
                });
                $('#serviceWindow').dialog('close');
                $(".j-toggle-s").click(); 
                isGiveUp();
                
                $('#serviceWindow').html("");
           
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#serviceWindow').dialog('close');
            }
        }]
    });
   
     $('#serviceWindow_other').dialog({
    	   width: 820,
           height: 552,
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
                  var unit = $("#userunit").combobox('getText');
                  var appid = $("#resourceapp_other").combobox('getValue');
                  var appname = $("#resourceapp_other").combobox('getText');
                  objdata.network = $("#network_other").find("li.active").text();
                  objdata.networkid = $("#network_other").find("li.active").val().toString().substring(1);
            	   if(""==config||null==config){
            		   $.messager.alert('提示',"规格配置不能为空!",'info');
            		   return false;
            	   }
            	   if(''==appid){
            		   $.messager.alert('提示',"应用不能为空!",'info');
            		   return false;
            	   }
   
	               var unitid = $("#userunit").combobox('getValue');
	               var proid = $("#projectName").combobox('getValue');
	               var proname = $("#projectName").combobox('getText'); 
                   $('#iaas'+idname).datagrid('insertRow', {
                       index: 0, // index start with 0
                       row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#serviceWindow_other').panel('options').title,
                           format: config,
                           network:objdata.network,
                           networkid:objdata.networkid,
                           unit: unit,
                           unitnum:unitNum,
                           counter:num,
                           unitid: unitid,
                           proid:  proid,
                           appid:appid,
                           typeid:typeid,
                           appname:appname,
                           proname: proname
                       }  
                   });
                   $('#serviceWindow_other').dialog('close');
                   $(".j-toggle-s").click(); 
                   isGiveUp();
                 
               }
           }, {
               text: '取消',
               iconCls: 'icon-cancel',
               handler: function() {
                   $('#serviceWindow_other').dialog('close');
               }
           }]
       });
       
           $('#serviceWindow_app').dialog({
    	   width: 380,
           height: 260,
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
                $.messager.progress();
                $("#serviceWindow_app_form").form('submit',{
	    
	               url:'${ctx}/ordermg/addapp.do',
	               async:false,
	               onSubmit: function(){    
				     
				       var isValid = $("#serviceWindow_app_form").form('validate');
						if (!isValid){
							$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
						}else{
						
				         $('#serviceWindow_app').dialog('close');
						}
						return isValid;  
				    },    
				    queryParams:{unitid: $("#userunit").combobox('getValue'),unitname:$("#userunit").combobox('getText')},
				    
				    success:function(data){
				      $.messager.progress('close');
				      var data =  JSON.parse(data);  
				      $.messager.alert('消息',data.msg,"info"); 
				      
				      if(data.success){ 
				       if(appDiloagid=="boxManagedWindowtt"||appDiloagid=='positionManagedtt'){
				            
                                                 var idx = parseInt(datagridtr.attr('datagrid-row-index'));
                                                 var ed = $('#'+appDiloagid).datagrid('getEditor', {index:idx,field:'equipmentapp'});
                                                
                                                 $(ed.target).combobox('reload');
                                                
				       }
				       else if(appDiloagid=='internetWindowtt')
				       {
				           var idx = parseInt(datagridtr.attr('datagrid-row-index'));
                           var ed = $('#'+appDiloagid).datagrid('getEditor', {index:idx,field:'application'});
                          
                           $(ed.target).combobox('reload');
				       }
				       else{
				       $('#'+appDiloagid).combobox('reload');
				         
				       }
				      }    
				    }    

	    	    }); 
                 
               }
           }, {
               text: '取消',
               iconCls: 'icon-cancel',
               handler: function() {
                   $('#serviceWindow_app').dialog('close');
               }
           }]
       });
      
 
/*       
    var windowHtml2 = $('#serviceWindow2').html();
    $('#serviceWindow2').dialog({
        title: "互联网线路",
        width: 650,
        height: 130,
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
                var len = $(".j-com").length;
                if(len>0){
                var iptype = "";var ipnumber = "";var bandwidth = "";
                var configure="";
                var tnum=0;
                   for(var i=0;i<len;i++){
                     iptype=$(".j-com").eq(i).find("select option:selected").text();
                     ipnumber= $(".j-com").eq(i).find(".lcy-com .input-num").val();
                     tnum+=parseInt(ipnumber);
                     bandwidth= $(".j-com").eq(i).find(".lcy-com .j-numberbox").val();
                     configure +="类型:"+iptype+",数量:"+ipnumber+",带宽:"+bandwidth+";";
                   }
                 configure = configure.substring(0,configure.length-1);
                objdata.unit = $("#userunit").combobox('getText');
                objdata.unitid = $("#userunit").combobox('getValue');
                objdata.proid = $("#projectName").combobox('getValue');
                objdata.proname = $("#projectName").combobox('getText');
                 
                }
                $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#serviceWindow2').panel('options').title,
                           format: configure,
                           unit: objdata.unit,
                           unitnum:unitNum,
                           counter:tnum,
                           unitid: objdata.unitid,
                           proid:  objdata.proid,
                           appid:"",
                           network:"互联网",
                           networkid:"0002",
                           typeid:typeid,
                           appname:"",
                           proname: objdata.proname
                    }
                });

                $('#serviceWindow2').dialog('close');
                $('#serviceWindow2').html("");
               
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#serviceWindow2').dialog('close');
            }
        }]
    }); */
      
/*        $("#tc2").click(function(event) {
        $('#serviceWindow2').dialog({
            closed: false
        });
        $('#serviceWindow2').html(windowHtml2);
        $('.j-numberbox').numberbox({
            min: 0,
            max: 20,
            precision: 0
        });
    }); */


    
    // 弹层内容样式配置
    $(document).on("click", ".j-item-body li", function() {
        $(this).addClass("active").siblings().removeClass("active");
    })

    // 数据盘增加一块
    function xtpAdd() {
        var addhtml = ' <div class="j-xtp-item item-sildebox"><div class="j-silde"></div><div class="item-right"><input id="nn" type="text" value="10" class="j-value"><span>GB</span> <a href="javascript:void(0)" class="lcy-window-item-body-delete" onclick="xtpDelete(this)">×</a></div></div>'

        var len = $("#serviceWindow .j-xtp .j-xtp-item").length;

        if (len < 2) {
            $("#serviceWindow .j-xtp .j-xtp-item").show();
            $("#serviceWindow .j-xtp").append(addhtml);
            $('#serviceWindow .j-silde:last').slider({
                width: 450,
                value: 10,
                showTip: true,
                min: 0,
                max: 2000,
                step: 10,
                rule: [0, 2000],
                tipFormatter: function(value) {
                    return value + 'GB';
                },
                onChange: function(value) {
                    $(this).parents("#serviceWindow .j-xtp-item").find('.j-value').val(value);
                    // $('.j-value').val(value);
                }
            });
            
        } else {

        }
            isBtnMove();
    }
    // 删除滑块
    function xtpDelete(obj) {
     
        $(obj).parents(".j-xtp-item").remove();
        isBtnMove();
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
    
   
    //提交订单
    function orderSubmit(){
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
      var snote = $("#order_note").val();
      if(!flag){
        $.messager.alert('消息',"您还没有选择任何商品","info");
        $('#submitBtn').linkbutton('enable');
        return;
      }
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
  				saveOrder(jsonArr,snote,fileName,fileUrl);
  		    }
  		});
      }else{//没有附件
    	  saveOrder(jsonArr,snote,fileName,fileUrl);
      }
    }
    
    //订单保存
    function saveOrder(jsonArr,snote,fileName,fileUrl){
    	$.ajax({
	  		type : 'post',
	  		url:'${pageContext.request.contextPath}/ordermg/saveOrders.do',
	  		data:{json1:jsonArr[0],json2:jsonArr[1],json3:jsonArr[2],json4:jsonArr[3],json5:jsonArr[4],snote:snote,fileName:fileName,fileUrl:fileUrl},
	  		beforeSend: function(){
             load("正在提交，请稍待。。。");
            },
	  		success:function(retr){
	  		   	disLoad("操作完成");
	  			var data =  JSON.parse(retr); 
	  			if(data.success){
	  				$.messager.alert('消息',data.msg,"info");
	  				$('#centerTab').panel({
						href:'/icpmg/web/ordersMg/orderLists.jsp'
					});
		    		/* for(var i=0,len=$(".t-wrap-iaas").length;i<len;i++){
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
	    	        $('#submitBtn').linkbutton('enable');
		    	   //恢复可读
		    	   $('#userunit').textbox('readonly',false);
		           $('#projectName').textbox('readonly',false);
		           $("#giveUp").hide(); */
		    	 } 
		  		}
		  	}); 
     }
    
     function initCpu() {
        
         	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/vmconfig/queryCpu.do',
   				  		asyn:false,
   				  		dataType:'json',
   				  		success:function(data){
   				  		  if($("#cpuchoose").children().length==0){
   				  	       $.each(data,function(index,value){
   				  	         if(index=='1'){   				  	         
   				  	             $("#cpuchoose").append("<li class=\"active\" onclick=\"choosecpu("+value+")\" value="+value+"><a href=\"javascript:void(0)\" >"+value+"核 </a></li>");
   				  	         }else{
   				  	            $("#cpuchoose").append("<li onclick=\"choosecpu("+value+")\"  value="+value+"><a href=\"javascript:void(0)\">"+value+"核</a></li>");
   				  	         }
  			              
   				  	       })
   				  	      }
		  	        	   var obj_2=$("#cpuchoose").children('li');
		 	               obj_2.click(function(){
	   			           $(this).addClass('active').siblings('li').removeClass('active');
	   			            var _value = $(this).attr("value");
	                        $("#cpuNum").val(_value);
	                      })
   				  		}
   				 })
       }
       
       function initMem() {
        
         	$.ajax({
			  		type : 'post',
			  		url:'${pageContext.request.contextPath}/vmconfig/queryMem.do',
			  		asyn:false,
			  		dataType:'json',
			  		cache: true,
			  		success:function(data){
			  	      if($("#memchoose").children().length==0){
			  	       $.each(data,function(index,value){
			  	         if(index=='0'){   				  	         
			  	             $("#memchoose").append("<li class=\"active\" onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	         }else{
			  	            $("#memchoose").append("<li onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
			  	         }
			          
			            
			  	       })
			      	   } 
			             var obj_2=$("#memchoose").children('li');
			             obj_2.click(function(){
			             $(this).addClass('active').siblings('li').removeClass('active');
			           
			            })
			  		}
			 })
       }  
       
       
      function choosecpu(value){
       
        $("#memchoose").children().remove();
         	$.ajax({
   				  		type : 'post',
   				  		url:'${pageContext.request.contextPath}/vmconfig/queryMem.do',
   				  		data:{cpunum:value},
   				  		asyn:false,
   				  		dataType:'json',
   				  		success:function(data){
   				  	       $.each(data,function(index,value){
   				  	         if(index=='0'){   				  	         
   				  	          $("#memchoose").append("<li class=\"active\" onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
   				  	          $('#stroeSize').val(value);
   				  	         }else{
   				  	           $("#memchoose").append("<li onclick=\"choosemem("+value+")\"><a href=\"javascript:void(0)\" >"+value+"G </a></li>");
   				  	         }
   				  	         
   				  	         var obj_2=$("#memchoose").children('li');
		 	                 obj_2.click(function(){
	   		             	 $(this).addClass('on').siblings('li').removeClass('on');
  			                 })
  			                
   				  	       })
   				  		}
   				 })
   			
     }
      
       function choosemem(value){
           $('#stroeSize').val(value);
       }
       
       //放弃
       $("#giveUp").click(function() {
    	   //删除列表信息
    	     $.messager.confirm('确认', '确认放弃?', function(row) {
    	     if(row){
    	     for(var i=0,len=$(".t-wrap-iaas").length;i<len;i++){
    	        var rows = $('#iaas'+i).datagrid('getRows');
    	        var rowlen = rows.length;
    	      
    	        if(rowlen>0){
    	          for(var j=rowlen;j>0;j--){
    	          $('#iaas'+i).datagrid('deleteRow', 0);
    	          }
    	        }
    	     }
    	   //恢复可读
    	   $('#userunit').textbox('readonly',false);
           $('#projectName').textbox('readonly',false);
            $("#giveUp").hide();
           }
           })
       });
       
   //弹出框app 
   function addApp(obj,tr){
   
        $('#appname').textbox({    
	     iconCls:'icon-apps', 
         iconAlign:'left' ,
         required:true,
         missingMessage: '应用名称必填'            
	   })
	   
	    $('#appshort').textbox({    
	 
         required:true,
         validType:['englishOrNum','length[1,10]'],
         missingMessage: '应用简称必填(英文或数字)'            
	   })
	   
       appDiloagid = obj;
       datagridtr = tr;
       $("#appname").textbox('setValue','');
       $("#appshort").textbox('setValue','');
        $("#appnote").val('');
         $('#serviceWindow_app').dialog({
            closed: false,
            title: "添加应用",
        });
        return false;
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
 
 $(document).on("click", ".j-tosub", function() {
        $.messager.confirm('提示', '确定要删除吗?', function(r) {
            if (r) {
                $(this).parents('.j-com').remove();
                $(".window-shadow").css({
                    height: 'auto'
                });
            }
        });
        $(this).parents('.j-com').remove();
    })
//tan2

/* $('#tcPop').click(function(event) {
        $('#serviceWindow_ip').dialog({
            closed: false,
            increment: 1
        });

    }); */

  /*   $('.j-tabs li').click(function(event) {
        var index = $(this).index();
        var nowActiveIndex = $('.j-tabs li.active').index();
        var flag = 0;
        if (nowActiveIndex == 0) {
           
            if ($('#yys').combobox('getText')!== "请选择" || $('#gwdk').val() !== "" || $('#ysdk').val() !== "" || $('#jrms').combobox('getText')!== "请选择" || $('#kd').val() !== "" || $('#yy').combobox('getText')!== "请选择" || !$('#num').numberbox('getValue') == 1) {
                flag = 1;
            }
        } else {
            if ($('#zwGwdk').val() !== "" || $('#zwYsdk').val() !== "" || $('#zwKd').val() !== "" || $('#zwYy').val() !== "" || !$('#zwNum').numberbox('getValue') == 1) {
                flag = 1;
            }
        }
       

        if (!index == nowActiveIndex && flag == 1) {
            $.messager.confirm('提示', '您确定要放弃当前的设置吗?', function(r) {
                if (r) {
                    $('.j-tabs li').eq(index).addClass('active').siblings().removeClass('active');
                    $('.j-tabs-con').eq(index).show().siblings().hide();
                    clear();
                }
            });
        } else {
            $('.j-tabs li').eq(index).addClass('active').siblings().removeClass('active');
            $('.j-tabs-con').eq(index).show().siblings().hide();
        }


    }); */
  
      /* $("#yys").combobox({
	        url:'${ctx}/ordermg/getDataConfig.do?dataType=corporation',
	        valueField: 'dcid',
	        textField: 'dcname',
	        loadFilter:function(data){
	        data.unshift({dcid:'',dcname:"请选择"});
	        return data;
	        }
	    }) */
	    
	 /*     $("#jrms").combobox({
	        url:'${ctx}/ordermg/getDataConfig.do?dataType=model',
	        valueField: 'dcid',
	        textField: 'dcname',
	        loadFilter:function(data){
	        data.unshift({dcid:'',dcname:"请选择"});
	        return data;
	        }
	    })
	     */
	    
	
    // 初始化
    $('#serviceWindow_ip').dialog({
      
        width: 720,
        height: 555,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '提交',
            iconCls: 'icon-ok',
            handler: function() {
              
              var corpertionid = $('#yys').combobox('getValue');
              var bandth = $('#dk').val();
              var domainfo = $('#ymba').val();
              if(corpertionid==''){
                $.messager.alert('消息',"请选择运营商","info");
	              return;
              }
              if(bandth==''){
                $.messager.alert('消息',"请填写带宽","info");
	              return;
              }
              if(domainfo==''){
                domainfo=' ';
              }
              var eqipments= $("#internetWindowtt").datagrid('getRows');
              if(eqipments.length==0){
                $.messager.alert('消息',"请输入设备配置信息","info");
	              return;
              }
              
             if(isendEdit("internetWindowtt",eqipments)){
             
                endEdit("internetWindowtt",eqipments);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
              var eqipmentstr =  JSON.stringify(eqipments);
              var configure = ''; var corpertion = $('#yys').combobox('getText');
              
               configure ="运营商:"+corpertion+";带宽:"+bandth+";域名备案信息:"+domainfo;
               objdata.unit = $("#userunit").combobox('getText');
                objdata.unitid = $("#userunit").combobox('getValue');
                objdata.proid = $("#projectName").combobox('getValue');
                objdata.proname = $("#projectName").combobox('getText');
                
	              $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#serviceWindow_ip').panel('options').title,
                           format: configure,
                           unit: objdata.unit,
                           unitnum:unitNum,
                           counter:'1',
                           unitid: objdata.unitid,
                           proid:  objdata.proid,
                           appid:eqipmentstr,
                           network:'互联网',
                           networkid:'0002',
                           typeid:typeid,
                           appname:'',
                           proname: objdata.proname
                    }
                });
                 /* clear(); */

	            $('#serviceWindow_ip').dialog('close');
	            $(".j-toggle-s").click(); 
	            isGiveUp();
            } 
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
               
                $('#serviceWindow_ip').dialog('close');
            }
        }]
    });
    
    $('.j-numberspinner').numberspinner({
        editable: false
    });
   
  /*   function clear() {
    
         $('#gwdk').numberbox('setValue','');  
         $('#kd').numberbox('setValue','');
         $('#ysdk').numberbox('setValue','');
         $('#zwGwdk').numberbox('setValue','');  
         $('#zwKd').numberbox('setValue','');
         $('#zwYsdk').numberbox('setValue','');   
         $("#yys").combobox('select','');
         $("#jrms").combobox('select','');
         $("#yy").combobox('select',''); 
         $("#zwYy").combobox('select',''); 
        $('.j-numberspinner').numberspinner({
            editable: false,
            val: 1
        });

    } */
    
    // 专享云服务初始化
    var innerviphtml = $('#ServiceVipWindow').html();//专享服务
    $('#ServiceVipWindow').dialog({
        closed: true,
       
        width: 1024,
        height: 560,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
           
 		 var eqipmentsvip= $("#serviceVipGrid").datagrid('getRows'); 
 		 //验证
 		 if(eqipmentsvip.length==0){
                $.messager.alert('消息',"请输入设备配置信息","info");
	              return;
              }
             if(isendEdit("serviceVipGrid",eqipmentsvip)){
             
                endEdit("serviceVipGrid",eqipmentsvip);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
         var configure="";
         var eqipmentvipstr ="";
         var eqipmentviptempstr ="";
         var rowlen = eqipmentsvip.length;
               if(rowlen>0){
                eqipmentvipstr =  JSON.stringify(eqipmentsvip);
               
                objdata.network = eqipmentvipstr;
                eqipmentviptempstr=JSON.parse(eqipmentvipstr);
    	         for(var i=0;i<rowlen;i++){
    	         
    	         configure +="名称:"+eqipmentviptempstr[i].equipmentname+";品牌:"+eqipmentviptempstr[i].equipmentbrand+";单位:"+eqipmentviptempstr[i].measureunit+";数量:"+eqipmentviptempstr[i].equipnums+"<br/>";  
    	          
    	          }
    	        }
                       
	            
               //objdata.networkid = $("#network_ip").find("li.active").val().toString().substring(1); 
                objdata.unit = $("#userunit").combobox('getText');
                objdata.unitid = $("#userunit").combobox('getValue');
                objdata.proid = $("#projectName").combobox('getValue');
                objdata.proname = $("#projectName").combobox('getText');
               
	            
	              $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#ServiceVipWindow').panel('options').title,
                           format: configure,
                           unit: objdata.unit,
                           unitnum:'专享',
                           counter:'1',
                           unitid: objdata.unitid,
                           proid:  objdata.proid,
                           appid:'',
                           network:eqipmentvipstr,
                           networkid:'',
                           typeid:typeid,
                           appname:'',
                           proname: objdata.proname
                    }
                });
                $('#ServiceVipWindow').dialog('close');
                $(".j-toggle-s").click(); 
                isGiveUp();
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#ServiceVipWindow').dialog('close');

            }
        }]
    });
    
        // 弹层表格
    var optionNetwork = [{
        productid: '0001',
        name: '政务外网区'
    }, {
        productid: '0002',
        name: '互联网区'
    }
    , {
        productid: '0003',
        name: '其他'
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
    }];
        
           //格式化单元格提示信息  
   function formatCellTooltip(value){  
            return "<span title='" + value + "'>" + value + "</span>";  
        }  

    function productFormatters(value) {
     
         //return row.name;
           for (var i = 0; i < optionTypes.length; i++) {
            if (optionTypes[i].productid == value) return optionTypes[i].name;
        }
        return value;
       
    }
     
    //托管开始
      $(document).on('click', '.j-item-ul li', function(event) {
     
        $(this).addClass('active').siblings().removeClass('active');
      
    });
    
     /*  //切换防火墙
      $(document).on('click', '#snfwpic,#ewfwpic', function(event) {
     
        $(this).addClass('active').siblings().removeClass('active');
        var fwtype = $(this).find('p').attr('text');
        
        if('snfw'==fwtype){
        
          $(this).find('img').attr('src','${ctx}/images/snfwselect.png');
          $(this).siblings().find('img').attr('src','${ctx}/images/ewfwunselect.png'); 
          $("#snfw").show();
          $("#ewfw").hide();
        }
        if('ewfw'==fwtype){
        
          $(this).find('img').attr('src','${ctx}/images/ewfwselect.png');
          $(this).siblings().find('img').attr('src','${ctx}/images/snfwunselect.png');
          $("#snfw").hide();
          $("#ewfw").show(); 
        }
    }); 
     //$('#fwzzfw a').off('click');
      $(document).off('click','#fwzzfw a');
     $(document).on('click','#fwzzfw a',function(){
    
            $(this).toggleClass('active');
          })*/
      // 初始化（整机托管）
    $('#boxManagedWindow').dialog({
        
         width: 760,
        height: 610,
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
            
              var eqipments= $("#boxManagedWindowtt").datagrid('getRows');
              if(eqipments.length==0){
                $.messager.alert('消息',"请输入设备配置信息","info");
	              return;
              }
             if(isendEdit("boxManagedWindowtt",eqipments)){
             
                endEdit("boxManagedWindowtt",eqipments);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
              var eqipmentstr =  JSON.stringify(eqipments);
             
               objdata.network = eqipmentstr;
               //objdata.networkid = $("#network_ip").find("li.active").val().toString().substring(1); 
               var configure="";/* var appid_zjtg="";var appname_zjtg=""; */ var jg_num=""; var putaway="";
               var putawaytime=""; var domainrecord=""; var safety=""; var netmachine="";var power="";
               
                                
	           /* appid_zjtg = $("#ywyyxt").combobox('getValue');
	           appname_zjtg = $("#ywyyxt").combobox('getText'); */
               jg_num=$("#jg_num").val();
               putaway = $("#boxManagedWindow .ty-tabscon-item-ul").eq(0).find("li.active").text();
               
              
               putawaytime=$("#zjtg_sjsj").datebox('getValue');
            
               domainrecord =  $("#boxManagedWindow .ty-tabscon-item-ul").eq(1).find("li.active").text();
               safety =  $("#boxManagedWindow .ty-tabscon-item-ul").eq(3).find("li.active").text();
               netmachine =  $("#boxManagedWindow .ty-tabscon-item-ul").eq(2).find("li.active").text();
               power = $("#jg_power").val();
               if(''==power){
                  power =' ';
               }
               configure ="上架方式:"+putaway+";上架时间:"+putawaytime+";域名备案:"+domainrecord+";网络设备:"+netmachine+
                   ";安全设备:"+safety+";机柜功率:"+power;
                
                objdata.unit = $("#userunit").combobox('getText');
                objdata.unitid = $("#userunit").combobox('getValue');
                objdata.proid = $("#projectName").combobox('getValue');
                objdata.proname = $("#projectName").combobox('getText');
	           
	           /*  if(appid_zjtg==''){
	             $.messager.alert('消息',"请选择业务应用系统","info");
	              return;
	            } */
	           
	              $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#boxManagedWindow').panel('options').title,
                           format: configure,
                           unit: objdata.unit,
                           unitnum:unitNum,
                           counter:jg_num,
                           unitid: objdata.unitid,
                           proid:  objdata.proid,
                           appid:'',
                           network:eqipmentstr,
                           networkid:'',
                           typeid:typeid,
                           appname:'',
                           proname: objdata.proname
                    }
                });
                $('#boxManagedWindow').dialog('close');
                $(".j-toggle-s").click(); 
				isGiveUp();
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#boxManagedWindow').dialog('close');

            }
        }]
    });
    
//接入防火墙界面开始
  $('#fhqsqWindow').dialog({
        width:460, 
        shadow: false,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
            text: '提交',
            iconCls: 'icon-ok',
            handler: function() {
                var fwtype = $('#fhqsqWindow .item-ul').eq(0).find('li.active').attr('text');
          
                var quyu="";var quyuid="";var guige='';var fwnum=1;var configure='';
                 if('snfw'==fwtype){
                  
                   guige = $("#fhqsqWindow  .item-ul").eq(1).find("li.active").text();
                   quyu = $("#fhqsqWindow  .item-ul").eq(2).find("li.active").text();
                   quyuid = $("#fhqsqWindow .item-ul").eq(2).find("li.active").val().toString().substring(1);            
                   fwnum = $('#snfwnum').val();
                   configure ='类型:'+"外部防护"+';吞吐量:'+guige+";区域:"+quyu;
                }
                else if('ewfw'==fwtype){
         
                   guige = $("#allFh .item-wrap .item-ul").eq(1).find("li.active").text();
                   fwnum = $("#ewfwnum").val();
                   configure ='类型:'+"全防护"+';吞吐量:'+guige;
                   
                }  
              
                objdata.unit = $('#userunit').combobox('getText');
                objdata.unitid = $('#userunit').combobox('getValue');
                objdata.proid = $('#projectName').combobox('getValue');
                objdata.proname = $('#projectName').combobox('getText');
                
                 $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#fhqsqWindow').panel('options').title,
                           format: configure,
                           unit: objdata.unit,
                           unitnum:unitNum,
                           counter:fwnum,
                           unitid: objdata.unitid,
                           proid:  objdata.proid,
                           appid:'',
                           network:quyu,
                           networkid:quyuid,
                           typeid:typeid,
                           appname:fwtype,
                           proname: objdata.proname
                    }
                });

	          
                $('#fhqsqWindow').dialog('close');
	            $('.j-toggle-s').click(); 
	            isGiveUp(); 
            }  
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#fhqsqWindow').dialog('close');
            }
        }]
    });  

    //初始化防火墙界面结束
    function productFormatter(value) {
        for (var i = 0; i < optionNetwork.length; i++) {
            if (optionNetwork[i].productid == value) return optionNetwork[i].name;
        }
        return value;
    }
  
    function isBtnMove(){
       var len= $('#serviceWindow .j-silde').length;
       if(len>1) $('#addLinkPannel').hide();
       else {
       $('#addLinkPannel').show();
       }
    }
     
      
     function appFormatters(value) {
        
           var appname = value;
         	$.ajax({
			  		type : 'post',
			  		url:'${pageContext.request.contextPath}/ordermg/getapps.do?unitid='+ $('#userunit').combobox('getValue'),
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
     
    //云硬盘
     $('#storageWindow').dialog({
         width: 700,
         height: 300,
         closed: true,
         modal: true,
         collapsible: false,
         minimizable: false,
         maximizable: false,
         resizable: false,
         buttons: [{
             text: '提交',
             iconCls: 'icon-ok',
             handler: function() {
                 var storenum = $(".j-silde").slider('getValue');//硬盘容量
                 var configure ="容量(G):"+storenum;
                 objdata.num = $("#storageWindow .input-num").val();
                 objdata.unit = $("#userunit").combobox('getText');
                 objdata.unitid = $("#userunit").combobox('getValue');
                 objdata.proid = $("#projectName").combobox('getValue');
                 objdata.proname = $("#projectName").combobox('getText');
                 $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#storageWindow').panel('options').title,
                           format: configure,
                           unit: objdata.unit,
                           unitnum:unitNum,
                           counter:objdata.num,
                           unitid: objdata.unitid,
                           proid:  objdata.proid,
                           network:'',
                           networkid:'',
                           typeid:typeid,
                           appname:'',
                           proname: objdata.proname,
                    }
                });
 	            $('#storageWindow').dialog('close');
 	            $(".j-toggle-s").click(); 
 	            isGiveUp();
             } 
         }, {
             text: '取消',
             iconCls: 'icon-cancel',
             handler: function() {
                 $('#storageWindow').dialog('close');
             }
         }]
     });
     
    // 机位托管
    // 整托管交互
    
    // 初始化
 
    $('#positionManagedWindow').dialog({
      
        width: 780,
        height: 610,
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
              
              var eqipments= $("#positionManagedtt").datagrid('getRows');
              if(eqipments.length==0){
                $.messager.alert('消息',"请输入设备配置设备配置信息","info");
	              return;
              }
             if(isendEdit("positionManagedtt",eqipments)){
             
                endEdit("positionManagedtt",eqipments);
             }else{
               $.messager.alert('消息',"请输入设备配置必填信息","info");
               return;
             }
              var eqipmentstr =  JSON.stringify(eqipments);
                
               objdata.network = eqipmentstr;
               //objdata.networkid = $("#network_ip").find("li.active").val().toString().substring(1); 
               var configure="";/* var appid_u="";var appname_u=""; */ var u_num=""; var putaway="";
               var putawaytime=""; var domainrecord=""; var safety=""; var netmachine="";var power="";
               
                                
	          /*  appid_u = $("#u_ywyyxt").combobox('getValue');
	           appname_u = $("#u_ywyyxt").combobox('getText'); */
               u_num=$("#u_num").val();
               putaway = $("#positionManagedWindow .ty-tabscon-item-ul").eq(0).find("li.active").text();
               
              
               putawaytime=$("#u_putime").datetimebox('getValue');
               domainrecord =  $("#positionManagedWindow .ty-tabscon-item-ul").eq(1).find("li.active").text();
               safety =  $("#positionManagedWindow .ty-tabscon-item-ul").eq(3).find("li.active").text();
               netmachine =  $("#positionManagedWindow .ty-tabscon-item-ul").eq(2).find("li.active").text();
               /* power = $("#jg_power").val(); */
               configure ="上架方式:"+putaway+";上架时间:"+putawaytime+";域名备案:"+domainrecord+";网络设备:"+netmachine+
                   ";安全设备:"+safety;
                
                 
                objdata.unit = $("#userunit").combobox('getText');
                objdata.unitid = $("#userunit").combobox('getValue');
                objdata.proid = $("#projectName").combobox('getValue');
                objdata.proname = $("#projectName").combobox('getText');
	           
	            /* if(appid_u==''){
	              $.messager.alert('消息',"请选择业务应用系统","info");
	              return;
	            } */
	              $('#iaas'+idname).datagrid('insertRow', {
                    index: 0, // index start with 0
                    row: {
                           serviceid: productid,
                           pshopid:pproductid,
                           pshopname:pproductname,
                           itemname: $('#positionManagedWindow').panel('options').title,
                           format: configure,
                           unit: objdata.unit,
                           unitnum:unitNum,
                           counter:u_num,
                           unitid: objdata.unitid,
                           proid:  objdata.proid,
                           appid:'',
                           network:eqipmentstr,
                           networkid:'',
                           typeid:typeid,
                           appname:'',
                           proname: objdata.proname
                    }
                });
                $('#positionManagedWindow').dialog('close');
                $(".j-toggle-s").click(); 
                isGiveUp();
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#positionManagedWindow').dialog('close');

            }
        }]
    });
    
    

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
  
  //放弃功能
  function isGiveUp(){
     
     if($("#giveUp").is(':hidden')){
     
       $('#userunit').textbox('readonly');
       $('#projectName').textbox('readonly');
       $("#giveUp").show();
     }
  }

	  //负载均衡初始化
	  $('#serviceWindow_fzjh').dialog({
	      width: 500,
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
	            var network = $("#fzjhNetWork").find("li.active").text();//区域
                var networkid = $("#fzjhNetWork").find("li.active").val().toString().substring(1);
                var fzjhMaxConn = $("#fzjhMaxConn").find("li.active").text();//最大连接数
                var fzjhNum = $("#fzjhNum").val();//数量
	            var configure = "区域:"+network+";最大连接数:"+fzjhMaxConn+";数量:"+fzjhNum;//区域:互联网;最大连接数:5000;数量:2
                objdata.unit = $("#userunit").combobox('getText');
                objdata.unitid = $("#userunit").combobox('getValue');
                objdata.proid = $("#projectName").combobox('getValue');
                objdata.proname = $("#projectName").combobox('getText');
                $('#iaas'+idname).datagrid('insertRow', {
                	 index: 0, // index start with 0
                 	 row: {
                        serviceid: productid,
                        pshopid:pproductid,
                        pshopname:pproductname,
                        itemname: $('#serviceWindow_fzjh').panel('options').title,
                        format: configure,
                        unit: objdata.unit,
                        unitnum:unitNum,
                        counter: fzjhNum,
                        unitid: objdata.unitid,
                        proid:  objdata.proid,
                        appid:"",
                        appname:'',
                        network: network,
                        networkid: networkid,
                        typeid:typeid,
                        proname: objdata.proname
                  }
              });
               /* clear(); */

	            $('#serviceWindow_fzjh').dialog('close');
	            $(".j-toggle-s").click(); 
	            isGiveUp();
	          } 
	      }, {
	          text: '取消',
	          iconCls: 'icon-cancel',
	          handler: function() {
	              $('#serviceWindow_fzjh').dialog('close');
	          }
	      }]
	  });

	  //弹层表格-是否是https服务
	  var fzjhIsHttps = [{
	        xyid: '1',
	        name: '是'
	    }, {
	    	xyid: '0',
	        name: '否'
	    }];

	    
	    
    </script>
  </body>
</html>
