<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>ICP后台管理</title>
</head>
<body>
    <link href="/icpmg/css/rmdobject-pop.css" rel="stylesheet" type="text/css">
    <div id="serviceWindow" style="padding:3px 0px;">
        <form id="tableform">
        <div class="ty-tabs">
            <ul class="j-tabs ty-tabs-title">
                <li class="active">基本信息</li>
                <li>维保信息</li>
                <li>统计信息</li>
                <li>使用信息</li>
                <li>配置信息</li>
            </ul>
            <div class="ty-tabs-content ">
                <!-- 选项卡1 -->
                <div class="j-tabs-con">
                    <div class="ty-tabscon-top">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IP：
                        <input type="text" class="ty-top-input"><a href="javascript:void(0)" class="ty-top-button">自动采集</a>
                    </div>
                    <div class="ty-tabscon-main">
                        <div class="ty-tabscon-item">
                            <div class="ty-tabscon-item-title">设备基本属性</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">设备编码：</td>
                                    <td align="left" width="35%">
                                        <input type="text"  id="neid" name="neid" class="ty-top-input required"  style="width: 170px;"    >
                                        <span class="must-star">*</span>
                                    </td>
                                    <td align="right" width="15%">设备名称：</td>
                                    <td align="left" width="35%">
                                        <input type="text"  id="nename" name="nename" class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">域名：</td>
                                    <td align="left">
                                        <input type="text" id="ipname" name="ipname" class="ty-top-input" style="width: 170px;">
                                    </td>
                                    <td align="right">MAC：</td>
                                    <td align="left">
                                        <input type="text" id="macaddr" name="macaddr"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">IP地址：</td>
                                    <td align="left">
                                        <input type="text" id="ipaddr" name="ipaddr"  class="ty-top-input required" style="width: 170px;"> <span class="must-star">*</span>
                                    </td>
                                    <td align="right">业务IP：</td>
                                    <td align="left">
                                        <input type="text"  id="sip" name="sip" class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">资源位置：</td>
                                    <td align="left">
                                        <input type="text"   id="slocation" name="slocation" class="ty-top-input" style="width: 170px;">
                                    </td>
                                    <td align="right">资源用途：</td>
                                    <td align="left">
                                        <input type="text"  id="useinfo" name="useinfo"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">设备等级：</td>
                                    <td colspan="3" align="left">
                                        <input type="text"  name="nelevel" id="nelevel" class="ty-top-input" style="width: 540px;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="ty-tabscon-item">
                            <div class="ty-tabscon-item-title">设备规格属性</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">设备类型：</td>
                                    <td align="left" width="35%" class="selectPropertyTd">
                                      <input type="text"   id="typeid" name="typeid" class="ty-top-input "  style="width: 182px;">
                                      <input type="hidden" id="typename" name="typename" />
                                      <input type="hidden" id="cfgtable" name="cfgtable" />
                                    </td>
                                    <td align="right" width="15%">厂商编码：</td>
                                    <td align="left" width="35%"  class="selectPropertyTd">
                                        <input type="text"   id="vendorid" name="vendorid" class="ty-top-input"  style="width: 182px;">
                                        <input type="hidden" id="vendorname" name="vendorname" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">设备型号：</td>
                                    <td colspan="3" align="left">
                                        <input type="text"  id="omodel" name="omodel"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="ty-tabscon-item">
                            <div class="ty-tabscon-item-title">设备状态属性</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">管理状态：</td>
                                    <td align="left" width="35%" class="radioPropertyTd">
										<input type="hidden" id="adstat" name="adstat" value="1">
                                        <ul class="ty-tabscon-item-ul j-item-toggle">
                                            <li class="active li1">可管理</li>
                                            <li class="li0">不可管理</li>
                                        </ul>
                                    </td>
                                    <td align="right" width="15%">操作状态：</td>
                                    <td align="left" width="35%" class="radioPropertyTd">
										<input type="hidden" id="opstat" name="opstat" value="1">
                                        <ul class="ty-tabscon-item-ul j-item-toggle">
                                            <li  class="active li1">可操作</li>
                                            <li class="li0">不可操作</li>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">费用状态：</td>
                                    <td align="left">
                                        <input type="text"  id="feestat" name="feestat"  class="ty-top-input"  style="width: 182px;">
                                    </td>
                                    
                                    <td align="right">运行状态：</td>
                                    <td align="left">
                                       <input type="text"  id="curstat" name="curstat"  class="ty-top-input"  style="width: 182px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">删除标志：</td>
                                    <td colspan="3" align="left" class="radioPropertyTd" id="deleteflagTd">
										<input type="hidden" id="deleteflag" name="deleteflag" value="1">
                                        <ul class="ty-tabscon-item-ul j-item-toggle">
                                            <li class="active li1">否</li>
                                            <li class="li0">是  </li>  
                                        </ul>
                                        
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <!-- 备注 -->
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout" style="margin-top: 5px;">
                            <tr>
                                <td align="right" width="17%">备注：</td>
                                <td colspan="3" align="left" width="85%">
                                    <input type="text" id="remark" name="remark" class="ty-top-input" style="width:510px;">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!-- 选项卡2 -->
                <div class="j-tabs-con"   style="display:none">
                    <div class="ty-tabscon-main">
                        <div class="ty-tabscon-item" style="padding:25px 0;">
                            <div class="ty-tabscon-item-title">设备生命周期</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout2">
                                <tr>
                                    <td align="center" width="25%">创建时间</td>
                                    <td align="center" width="25%">
                                        试运行时间：
                                    </td>
                                    <td align="center" width="25%">入网时间：</td>
                                    <td align="center" width="25%">
                                        退网时间：
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4"><img src="../../images/rmdobject-timeline.jpg" alt="">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <input id="buytime" name="buytime" class="j-datetime" style="width:150px">
                                    </td>
                                    <td align="center">
                                        <input id="testtime" name="testtime" class="j-datetime" style="width:150px">
                                    </td>
                                    <td align="center">
                                        <input id="usetime" name="usetime"  class="j-datetime" style="width:150px">
                                    </td>
                                    <td align="center">
                                        <input id="useendtime" name="useendtime"  class="j-datetime" style="width:150px">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="ty-tabscon-item" style="padding:25px 0;">
                            <div class="ty-tabscon-item-title">设备维护信息</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">维护人：</td>
                                    <td align="left" width="26%">
                                        <input type="text"  id="opuser" name="opuser" class="ty-top-input" style="width: 120px;">
                                        <a href="javascript:void(0)" class="j-search" id="search" iconCls="icon-search" onclick="openOpuserWindow()"></a>
                                    </td>
                                    <td align="right" width="15%">维护开始时间：</td>
                                    <td align="left" width="25%">
                                        <input id="sbegin" name="sbegin" class="j-datetime" style="width:150px">
                                    </td>
                                    <td rowspan="4" style="border-left: 1px solid #ddd">
                                        <div align="left"><a href="javascript:void(0)" class="ty-icon ty-icon-warning">预警配置</a></div>
                                    </td>
                                </tr>
                                </tr>
                                <tr>
                                    <td align="right">软件版本：</td>
                                    <td align="left">
                                        <input type="text"  id="softver" name="softver"  class="ty-top-input" style="width: 120px;">
                                    </td>
                                    <td align="right">维护结束时间：</td>
                                    <td align="left">
                                        <input  id="send" name="send"  class="j-datetime" style="width:150px;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="ty-tabscon-item" style="padding:25px 0;">
                            <div class="ty-tabscon-item-title">设备数据更新</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="24%">配置更新时间：</td>
                                    <td align="left" width="26%">
                                         <input  id="ctime" name="ctime" class="fillcurtime" readonly="readonly"  style="width:150px;border:none;" >
                                    </td>
                                    <td align="right" width="24%">性能更新时间：</td>
                                    <td align="left" width="26%">
                                        <input  id="ptime" name="ptime"  class="fillcurtime" readonly="readonly"  style="width:150px;border:none;" >
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="25%">告警更新时间：</td>
                                    <td align="left">
                                       <input  id="ftime" name="ftime" class="fillcurtime"  readonly="readonly"  style="width:150px;border:none;" >
                                    </td>
                                </tr>
                            </table>
                            <div style="border-top:1px solid #eee; margin-top: 15px;padding-top:15px;">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                    <tr>
                                        <td align="right" width="24%">录入人：</td>
                                        <td align="left" width="26%">
                                        	<input  id="insertman" name="insertman" readonly="readonly"  style="width:150px;border:none;" value="${sessionUser.email}">
                                        </td>
                                        <td align="right" width="24%">最后更新时间：</td>
                                        <td align="left" width="26%">
                                            <input  id="infotime" name="infotime" class="fillcurtime"  readonly="readonly"  style="width:150px;border:none;" >
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 选项卡2中弹层 -->
                    <div id="serviceWindow2-1" style="padding:3px 0px;">
                        <table class="ty-tabcon-table-layout" width="100%">
                            <tr>
                                <td align="right" width="20%">维护人姓名：</td>
                                <td align="left" width="80%">
                                    <input type="text" id="searchOpuser" class="ty-top-input" style="width: 120px;">
                                    <a href="javascript:void(0)" class="j-search" id="search" iconCls="icon-search" onclick="freshOpuser()"></a>
                                </td>
                            </tr>
                        </table>
                        <div style=" overflow-y: auto;">
                            <table  id="opuserSearch" width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-data j-name" >
								<thead>
									<tr>
										<th data-options="field:'uname',align:'center',width:'100px'">用户名称</th>
										<th data-options="field:'usertype',align:'center',formatter:formatUsertype,width:'100px'">用户类型</th>
										<th data-options="field:'email',align:'center',width:'100px'">邮箱</th>
										<th data-options="field:'mobile',align:'center',width:'100px'">手机</th>
									</tr>
								</thead>
							</table>
                        </div>
                    </div>
                </div>
                <!-- 选项卡3 -->
                <div class="j-tabs-con"  style="display:none">
                    <div class="ty-tabscon-main">
                        <div style="padding:25px 0;">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout3">
                                <tr>
                                    <td align="right" width="30%">所属资源池：</td>
                                    <td align="left" width="70%"  class="selectPropertyTd">
                                        <input type="text" id="poolid" name="poolid" class="ty-top-input" style="width: 182px;">
                                        <a href="javascript:void(0)" class="j-search" id="searchPool" iconCls="icon-search" onclick="openPoolWindow()"></a>
                                        <input type="hidden" id="poolname" name="poolname">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">所属机房：</td>
                                    <td align="left" class="selectPropertyTd">
                                        <input type="text" id="roomid" name="roomid" class="ty-top-input" style="width: 182px;">
                                        <input type="hidden" id="roomname" name="bidname">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">所在城市：</td>
                                    <td align="left"  class="selectPropertyTd">
                                        <input type="text" id="cityid" name="cityid" class="ty-top-input" style="width: 182px;">
                                        <input type="hidden" id="cityname" name="cityname">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">所在省：</td>
                                    <td align="left" class="selectPropertyTd">
                                       <input type="text" id="provid" name="provid" class="ty-top-input" style="width: 182px;">
                                       <input type="hidden" id="provname" name="provname">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">所在区域：</td>
                                    <td align="left" class="selectPropertyTd">
                                       <input type="text" id="nodeid" name="nodeid" class="ty-top-input" style="width: 182px;">
                                       <input type="hidden" id="nodename" name="nodename">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- 选择资源池弹层 -->
                    <div id="serviceWindow3-1" style="padding:3px 0px;">
                        <table class="ty-tabcon-table-layout" width="100%" style="margin-top:5px; margin-bottom: 7px;">
                            <tr>
                            <!-- 
                                <td align="right" width="18%" >城市：</td>
                                <td align="left" width="30%">
                                    <select name="" id="" class="ty-select" style="width:120px;">
                                        <option value="">城市1</option>
                                    </select>
                                </td>
                             -->
                                <td align="right" width="30%">资源池：</td>
                                <td align="left" width="50%">
                                    <input type="text" id="poolSearch" class="ty-top-input" style="width: 120px;">
                                    <a href="javascript:void(0)" class="j-search" id="search" iconCls="icon-search" onclick="freshPoolList()"></a>
                                </td>
                            </tr>
                        </table>
                        <ul id="poolListUl" class="ty-pool-con j-item-toggle ">
                        </ul>
                        <div id="page" style="background:#fafafa;border:1px solid #e5e5e5; margin:0 15px;"></div>
                    </div>
                </div>
                <!-- 选项卡4 -->
                <div class="j-tabs-con"  style="display:none">
                    <div class="ty-tabscon-main">
                        <div class="ty-tabscon-item">
                            <div class="ty-tabscon-item-title">租户基本属性</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">归属单位：</td>
                                    <td align="left" width="35%" class="selectPropertyTd">
                                       <input type="text" id="unitid" name="unitid" class="ty-top-input" style="width: 182px;">
                                       <input type="hidden" id="unitname" name="unitname">
                                    </td>
                                    <td align="right" width="15%">项目名称：</td>
                                    <td align="left" width="35%" class="selectPropertyTd">
                                       <input type="text" id="projectid" name="projectid" class="ty-top-input" style="width: 182px;">
                                       <input type="hidden" id="projectname" name="projectname">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">应用名称：</td>
                                    <td align="left" class="selectPropertyTd">
                                      <input type="text" id="appid" name="appid" class="ty-top-input" style="width: 182px;">
                                       <input type="hidden" id="appname" name="appname">
                                    </td>
                                    <td align="right">应用类型：</td>
                                    <td align="left">
                                        <input type="text" id="appmodel" name="appmodel" class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">展示名称：</td>
                                    <td align="left">
                                        <input type="text" id="displayname" name="displayname"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                    <td align="right">应用链接：</td>
                                    <td align="left">
                                        <input type="text"  id="appurl" name="appurl"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="ty-tabscon-item">
                            <div class="ty-tabscon-item-title">设备申请属性</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">申请人：</td>
                                    <td align="left" colspan="3">
                                        <input type="text" id="suserid" name="suserid"  class="ty-top-input" style="width: 528px;">
                                        <a href="javascript:void(0)" class="j-search " iconcls="icon-search" onclick="openApplicant()"></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">一级属性：</td>
                                    <td align="left" width="35%">
                                        <input type="text" id="groupid" name="groupid"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                    <td align="right" width="15%">二级属性：</td>
                                    <td align="left" width="35%">
                                        <input type="text" id="puserid" name="puserid"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">订单编码：</td>
                                    <td align="left" width="35%">
                                        <input type="text" id="orderid" name="orderid"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                    <td align="right" width="15%">订单详细编码：</td>
                                    <td align="left" width="35%">
                                        <input type="text" id="detailid" name="detailid"  class="ty-top-input" style="width: 170px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="15%">工单编码：</td>
                                    <td align="left" colspan="3">
                                        <input type="text" id="flowid" name="flowid"  class="ty-top-input" style="width: 528px;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="ty-tabscon-item">
                            <div class="ty-tabscon-item-title">服务信息属性</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">一级服务类型：</td>
                                    <td align="left" width="35%" class="selectPropertyTd">
                                        <input id="severtypeidlevelfirstid"  name="severtypeidlevelfirst" class="ty-top-input" style="width: 182px;">
                                        <input type="hidden" id="severtypeidlevelfirstname" name="servertypenamelevelfirst">
                                    </td>
                                    <td align="right" width="15%">二级服务类型：</td>
                                    <td align="left" width="35%" class="selectPropertyTd">
                                        <input id="servertypeidlevelsecondid" name="servertypeidlevelsecond" class="ty-top-input" style="width: 182px;">
                                        <input type="hidden" id="servertypeidlevelsecondname" name="servertypenamesecond">
                                    </td>
                                </tr>
                                <tr style="display:none">
                                    <td align="right" width="15%">服务开始时间：</td>
                                    <td align="left" width="35%">
                                        <input class="j-datetime " style="width: 182px">
                                    </td>
                                    <td align="right" width="15%">服务结束时间：</td>
                                    <td align="left" width="35%">
                                        <input class="j-datetime " style="width: 182px">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="15%">价格：</td>
                                    <td align="left" colspan="3">
                                        <input type="text" id="perprice" name="perprice"  class="ty-top-input" style="width: 528px;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="ty-tabscon-item">
                            <div class="ty-tabscon-item-title">网络信息属性</div>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout">
                                <tr>
                                    <td align="right" width="15%">网络类型：</td>
                                    <td align="left" width="35%" class="selectPropertyTd">
                                        <input name="networktypeid" id="networktypeid" class="ty-top-input" style="width: 182px;">
                                        <input type="hidden" id="networktypename" name="networktypename">
                                    </td>
                                    <td align="right" width="15%">vlan编码：</td>
                                    <td align="left" width="35%">
                                        <input name="vlanid" id="vlanid" class="ty-top-input" style="width: 182px;">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- 选项卡4中弹层 -->
                    <div id="serviceWindow4-1" style="padding:3px 0px;">
                        <table class="ty-tabcon-table-layout" width="100%">
                            <tr>
                                <td align="right" width="20%">申请人姓名：</td>
                                <td align="left" width="80%">
                                    <input type="text"  id="searchSuser" name="searchSuser" class="ty-top-input" style="width: 120px;">
                                    <a href="#" class="j-search" id="search" iconCls="icon-search" onclick="freshSuser()"></a>
                                </td>
                            </tr>
                        </table>
                        <div style=" overflow-y: !important;;">
                        	<table  id="userPopSearch" width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-data j-name" >
								<thead>
									<tr>
										<th data-options="field:'uname',align:'center',width:'100px'">用户名称</th>
										<th data-options="field:'usertype',align:'center',formatter:formatUsertype,width:'100px'">用户类型</th>
										<th data-options="field:'email',align:'center',width:'100px'">邮箱</th>
										<th data-options="field:'mobile',align:'center',width:'100px'">手机</th>
									</tr>
								</thead>
							</table>
                          
                        </div>
                    </div>
                </div>
                <!-- 选项卡5 -->
                <div class="j-tabs-con"  style="display:none">
                    <div class="ty-tabscon-main">
                        <div class="ty-tabscon-item" style="padding:25px 0;">
                            <div class="ty-tabscon-item-title">配置属性</div>
                            <table id="customPropertyTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="ty-tabcon-table-layout" >
                               
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    	</form>
    </div>
    
</body>

</html>
