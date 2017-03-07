<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="/icp/include/taglib.jsp"%>
<head></head>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <body>
  <style>
    #dd td .h19{ height:19px; overflow:hidden; display:block }
   </style>
    <div id="dd" class="pop" style="padding-bottom:32px;" >
        <div class="item-wrap">
            <div class="item2">
                <div class="item-title">基本信息</div>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td align="right" width="15%"> 单位：</td>
                            <td align="left" width="20%" class="c999">
                              <span id ="unitname" class="h19"></span>
                            </td>
                            <td align="right" width="12%"> 项目：</td>
                            <td align="left" width="20%" class="c999">
                               <span id="projectname" class="h19"></span>
                            </td>
                            <td align="right" width="15%"> 一类分级：</td>
                            <td align="left" class="c999">
                                 <span id="servertypenamelevelfirst"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">二级分类：</td>
                            <td align="left" class="c999">
                                <span id="servertypenamesecond"></span>
                            </td>
                            <td align="right"> 名称：</td>
                            <td align="left" class="c999">
                                <span id="objectid" class="h19"></span>
                            </td>
                            <td align="right">应用：</td>
                            <td align="left" class="c999">
                                 <span id="appname" class="h19"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">UUID名称：</td>
                            <td align="left" colspan="5" class="c999">
                                <span id="objectname"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="item2">
                <div class="item-title">基础配置</div>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td align="right" width="15%"> CPU（核）：</td>
                            <td align="left" width="20%" class="c999">
                                 <span id="cpunum"></span>
                            </td>
                            <td align="right" width="12%"> 内存（G）：</td>
                            <td align="left" width="20%" class="c999">
                                <span id="memnum"></span>
                            </td>
                            <td align="right" width="15%">云硬盘（G）：</td>
                            <td align="left" class="c999">
                                <span id="disknum"></span>
                              
                            </td>
                        </tr>
                        <tr>
                            <td align="right">操作系统：</td>
                            <td align="left" class="c999">
                               <span id="osname" class="h19"></span>
                            </td>
                            <td align="right"> 主机IP：</td>
                            <td align="left" colspan="3" class="c999">
                                 <span id="hostid"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="item2">
                <div class="item-title">网络信息</div>
                
                 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout" id="zwww-wrap" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td align="right" width="15%">区域：</td>
                            <td align="left" width="20%" class="c999">
                              <span id="networktype_zw"></span>
                            </td>
                            <td align="right" width="12%"> 内网IP：</td>
                            <td align="left" class="c999">
                                  <span id="interaip_zw"></span>
                            </td>
                            <td align="right" width="17%"> 内网端口：</td>
                            <td align="left" class="c999">
                                 <span id="interaport_zw"></span>
                            </td>
                        </tr>
                            <tr>
                            <td align="right" width="15%">外网IP：</td>
                            <td align="left" width="20%" class="c999">
                              <span id="interipgov"></span>
                            </td>
                            <td align="right" width="12%"> 外网端口：</td>
                            <td align="left" class="c999">
                                  <span id="interport_zw" data-toggle="tooltip"></span>
                            </td>
                            <td align="right" width="17%"> 带宽(M)：</td>
                            <td align="left" class="c999">
                                 <span id="bandwidth_zw"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" id="hlw-table" class="table-layout" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td align="right" width="15%">区域：</td>
                            <td align="left" width="20%" class="c999">
                              <span id="networktype"></span>
                            </td>
                            <td align="right" width="12%"> 内网IP：</td>
                            <td align="left" class="c999">
                                  <span id="interaip"></span>
                            </td>
                            <td align="right" width="17%"> 域名：</td>
                            <td align="left" class="c999">
                                 <span id="domainname"></span>
                            </td>
                        </tr>
                      
                    </tbody>
                </table>
           
                <div class="wlxx-wrap" id="wlxx-wrap">
                    <dl id="unicom">
                        <dt>联通</dt>
                        <dd>联通IP：<span id="interipunincom"></span></dd>
                        <dd>公网端口： <span id="interport"></span></dd>
                        <dd>映射端口： <span id="interaport"></span></dd>
                        <dd style="width: 10%">带宽： <span id="bandwidth"></span></dd>
                    </dl>
                    <dl id="mobile">
                        <dt class="cyd">移动</dt>
                        <dd>移动IP：<span id="interipmobile"></span></dd>
                        <dd>公网端口： <span id="mobileport"></span></dd>
                        <dd>映射端口： <span id="mobileaport"></span></dd>
                        <dd style="width: 10%">带宽： <span id="mobilebwidth"></span></dd>
                    </dl>
                    <dl id="telecom">
                        <dt class="cdx">电信</dt>
                        <dd>电信IP：<span id="interiptelecom"></span></dd>
                        <dd>公网端口： <span id="telecomport"></span></dd>
                        <dd>映射端口： <span id="telecomaport"></span></dd>
                        <dd style="width: 10%" >带宽： <span id="telecombwidth"></span></dd>
                    </dl>
                </div>
            </div>
        </div>
    </div>
     
    </body>
</html>
