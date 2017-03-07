<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<body>
<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();%>
<%String contextPath = request.getContextPath();%>
<%--<div id="arpw" class="easyui-window" title="新增防护配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:1000px;height:350px;padding:5px;top:127px;">--%>
    <%--<div class="easyui-layout" data-options="fit:true">--%>
        <%--<div data-options="region:'center'" style="padding:10px;border:0">--%>
            <%--<form id="arpCreateForm" method="post" data-options="novalidate:true">--%>
                <%--<h2>选择安全域</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="margin-left:30px;">安全域：--%>
                        <%--<input type="hidden" id="domainid"/>--%>
                        <%--<select id="domain" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="">请选择</option>--%>
                            <%--<option value="trust">trust</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<h2>白名单</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<a class="easyui-linkbutton" style="margin-left:30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="">配置</a>--%>
                <%--</div>--%>
                <%--<h2>全选</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">全部启用&nbsp;<input type="checkbox" id="alluser"/></p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="allaction" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="">--</option>--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<h2>Flood防护</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">ICMP洪水攻击防护&nbsp;<input type="checkbox" id="icmp" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">警戒值：<input id="icmpalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-50,000)</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r0" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">UDP洪水攻击防护&nbsp;<input type="checkbox" id="udp" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">源警戒值：<input id="udpsalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">目的警戒值：<input id="udpdalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">ARP欺骗攻击防护&nbsp;<input type="checkbox" id="arp" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">每个MAC最大IP数：<input id="arpipnumofmac" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-1,024)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">免费ARP包发送速率：<input id="arppsendrate" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-10)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">反向查询&nbsp;<input type="checkbox" id="arpreverseq"/></p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r2" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">SYN洪水攻击防护&nbsp;<input type="checkbox" id="syn" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">源警戒值：<input id="synsalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">目的警戒值：--%>
                        <%--<select id="syndalerttype" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="1">基于IP</option>--%>
                            <%--<option value="2">基于端口</option>--%>
                        <%--</select>--%>
                        <%--<input id="syndalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)--%>
                    <%--</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r3" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<h2>MS-Windows防护</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="margin-left:30px;">WinNuke攻击防护&nbsp;<input type="checkbox" id="winnuke" name="chk"/></p>--%>
                <%--</div>--%>
                <%--<h2>扫描/欺骗防护</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="margin-left:30px;">IP地址欺骗攻击防护&nbsp;<input type="checkbox" id="ipcheat" name="chk"/></p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">IP地址扫描攻击防护&nbsp;<input type="checkbox" id="ipscanning" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">警戒值：<input id="ipscanningalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-5,000)</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r4" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">端口扫描防护&nbsp;<input type="checkbox" id="portscanning" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">警戒值：<input id="portscanningalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-5,000)</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r5" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<h2>拒绝服务防护</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="margin-left:30px;">Ping of Death攻击防护&nbsp;<input type="checkbox" id="pingofdeath" name="chk"/></p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="margin-left:30px;">Teardrop攻击防护&nbsp;<input type="checkbox" id="treadrop" name="chk"/></p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">IP分片防护&nbsp;<input type="checkbox" id="ipshard" name="chk"/></p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r6" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">IP选项&nbsp;<input type="checkbox" id="ipoption" name="chk"/></p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r7" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">Smurf或者Fraggle攻击防护&nbsp;<input type="checkbox" id="sf" name="chk"/></p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r8" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">Land攻击防护&nbsp;<input type="checkbox" id="land" name="chk"/></p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r9" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">ICMP大包攻击防护&nbsp;<input type="checkbox" id="icmpbp" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">源警戒值：<input id="icmpbpalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-50,000)</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r10" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<h2>代理</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">SYN代理&nbsp;<input type="checkbox" id="synagent" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">最小代理速率：<input id="synagentminrate" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-50,000)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">最大代理速率：<input id="synagentmaxrate" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-1,500,000)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">代理超时：<input id="syntimeout" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(1-180)秒</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;cookie&nbsp;<input type="checkbox" id="syncookie"/></p>--%>
                <%--</div>--%>
                <%--<h2>协议异常报告</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">TCP异常&nbsp;<input type="checkbox" id="tcp" name="chk"/></p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r11" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<h2>DNS查询洪水防护</h2>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">DNS查询洪水防护&nbsp;<input type="checkbox" id="dns" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">源警戒值：<input id="dnssalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">目的警戒值：<input id="dnsdalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r12" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
                <%--<div style="margin-bottom:5px;">--%>
                    <%--<p style="float:left;margin-left:30px;">DNS递归查询洪水攻击防护&nbsp;<input type="checkbox" id="dnsr" name="chk"/></p>--%>
                    <%--<p style="float:left;margin-left:30px;">源警戒值：<input id="dnsrsalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>--%>
                    <%--<p style="float:left;margin-left:30px;">目的警戒值：<input id="dnsrdalert" class="easyui-textbox" style="width:70px;height:22px;"/>&nbsp;(0-300,000)</p>--%>
                    <%--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行为：--%>
                        <%--<select id="r13" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">--%>
                            <%--<option value="0">丢弃</option>--%>
                            <%--<option value="1">告警</option>--%>
                        <%--</select>--%>
                    <%--</p>--%>
                <%--</div>--%>
            <%--</form>--%>
        <%--</div>--%>
        <%--<div data-options="region:'south',border:false" style="text-align:center;padding:5px 0 0;">--%>
            <%--<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="adddomainarp();" id="addarp"  style="width:80px">提交</a>--%>
            <%--<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#arpw').window('close');" style="width:80px">取消</a>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<%--<div id="arpw" class="easyui-window" title="新增防护配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:1000px;height:350px;padding:5px;top:127px;">--%>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'center'" style="padding:10px;border:0">
            <form id="arpCreateForm" method="post" data-options="novalidate:true">
                <h2>选择安全域</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">安全域：</span>
					<span style="margin-left:15px;">
						<input type="hidden" id="domainid"/>
						<select id="domainMy" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false">
                            <option value="">请选择</option>
                            <option value="trust">trust</option>
                        </select>
					</span>
                </div>
                <h2>白名单</h2>
                <div style="margin-bottom:5px;">
					<input type="hidden" id="wlist" name="wlist"/>
					<a class="easyui-linkbutton" style="margin-left:30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="choosewlist('add', 'd');">配置</a>
				</div>
                <h2>全选</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">全部启用</span>
                    <span style="margin-left:15px;" ><input type="checkbox" id="alluser"/></span>
					<span style="margin-left:15px;">
						<span style="display:inline-block;width: 120px;">行为：</span>
						<select id="allaction" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="">--</option>
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
					</span>
                </div>
                <h2>Flood防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">ICMP洪水攻击防护</span>
                    <span style="margin-left:15px;" ><input type="checkbox" id="icmp" name="chk"/></span>
					<span style="margin-left:15px;" id="icmp_">
						<span style="display:inline-block;width: 120px;">警戒值：</span>
						<input id="icmpalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-50,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="r0" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">UDP洪水攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="udp" name="chk"/></span>
					<span style="margin-left:15px;" id="udp_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="udpsalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="r1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<input id="udpdalert" class="easyui-textbox" style="width:70px;height:22px;"/>(0-300,000)
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">ARP欺骗攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="arp" name="chk"/></span>
					<span style="margin-left:15px;" id="arp_">
						<span style="display:inline-block;width: 120px;">每个MAC最大IP数：</span>
						<input id="arpipnumofmac" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-1,024)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="r2" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">免费ARP包发送速率：</span>
						<input id="arppsendrate" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-10)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">反向查询</span>
						<input type="checkbox" id="arpreverseq"/>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">SYN洪水攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="syn" name="chk"/></span>
					<span style="margin-left:15px;" id="syn_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="synsalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-50,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="r3" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<select id="syndalerttype" class="easyui-combobox" style="width:80px;" data-options="panelHeight:'auto',editable:false">
                            <option value="1">基于IP</option>
                            <option value="2">基于端口</option>
                        </select>
						<input id="syndalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-50,000)</span>
					</span>
                </div>
                <h2>MS-Windows防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">WinNuke攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="winnuke" name="chk"/></span>
                </div>
                <h2>扫描/欺骗防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP地址欺骗攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipcheat" name="chk"/></span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP地址扫描攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipscanning" name="chk"/></span>
					<span style="margin-left:15px;" id="ipscanning_">
					<span style="display:inline-block;width: 120px;">警戒值：</span>
					<input id="ipscanningalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-5,000)</span>
					<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
					<select id="r4" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">端口扫描防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="portscanning" name="chk"/></span>
					<span style="margin-left:15px;" id="portscanning_">
					<span style="display:inline-block;width: 120px;">警戒值：</span>
					<input id="portscanningalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-5,000)</span>
					<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
					<select id="r5" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <h2>拒绝服务防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Ping of Death攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="pingofdeath" name="chk"/></span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Teardrop攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="treadrop" name="chk"/></span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP分片防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipshard" name="chk"/></span>
					<span style="margin-left:15px;" id="ipshard_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="r6" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP选项</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipoption" name="chk"/></span>
					<span style="margin-left:15px;" id="ipoption_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="r7" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Smurf或者Fraggle攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="sf" name="chk"/></span>
					<span style="margin-left:15px;" id="sf_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="r8" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Land攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="land" name="chk"/></span>
					<span style="margin-left:15px;" id="land_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="r9" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">ICMP大包攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="icmpbp" name="chk"/></span>
					<span style="margin-left:15px;" id="icmpbp_">
					<span style="display:inline-block;width: 120px;">源警戒值：</span>
					<input id="icmpbpalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-50,000)</span>
					<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
					<select id="r10" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <h2>代理</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">SYN代理</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="synagent" name="chk"/></span>
					<span style="margin-left:15px;" id="synagent_">
						<span style="display:inline-block;width: 120px;">最小代理速率：</span>
						<input id="synagentminrate" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-50,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">cookie</span>
						<input type="checkbox" id="syncookie"/>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">最大代理速率：</span>
						<input id="synagentmaxrate" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 60px;margin-left:25px;">代理超时：</span>
						<input id="syntimeout" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-180)秒</span>
					</span>
                </div>
                <h2>协议异常报告</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">TCP异常</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="tcp" name="chk"/></span>
					<span style="margin-left:15px;" id="tcp_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="r11" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>

                </div>
                <h2>DNS查询洪水防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">DNS查询洪水防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="dns" name="chk"/></span>
					<span style="margin-left:15px;" id="dns_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="dnssalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="r12" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<input id="dnsdalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">DNS递归查询洪水攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="dnsr" name="chk"/></span>
					<span style="margin-left:15px;" id="dnsr_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="dnsrsalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="r13" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<input id="dnsrdalert" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
					</span>
                </div>
            </form>
        </div>
        <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="adddomainarp();" id="addarp" style="width:80px">提交</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#addDialog').dialog('destroy')" style="width:80px">取消</a>
        </div>
    </div>
<%--</div>--%>


<script type="text/javascript">

    $().ready(function(){

        formTabFormatter("arpw", "arpCreateForm", 'addTabs');

        function formTabFormatter(windowId, formId, tabsid) {
            var _form = $("#" + formId);
            $(_form).children("h2").eq(0).before(
                    '<div id="' + tabsid + '" class="easyui-tabs" style="height:375px" data-options="tabPosition:\'left\',headerWidth:100,fit:true" ></div>'
            );
             var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "Flood防护").attr("id", "step" + 0).appendTo($(".easyui-tabs"));
             var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "服务防护").attr("id", "step" + 1).appendTo($(".easyui-tabs"));
             var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "异常报告").attr("id", "step" + 2).appendTo($(".easyui-tabs"));
            /*
            for (var i = 0; i < 3; i++) {
                var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "步骤" + (i + 1)).attr("id", "step" + i).appendTo($(".easyui-tabs"));
            }
            */
            $(_form).children("h2").slice(0, 4).each(function () {
                $("#" + formId + " .easyui-tabs #step0").append($(this).nextUntil("h2").andSelf());
            });
            $(_form).children("h2").slice(0, 3).each(function () {
                $("#" + formId + " .easyui-tabs #step1").append($(this).nextUntil("h2").andSelf());
            });
            $(_form).children("h2").slice(0, 4).each(function () {
                $("#" + formId + " .easyui-tabs #step2").append($(this).nextUntil("h2").andSelf());
            });
            var _win = $("#" + windowId);
            $("#" + tabsid).tabs().tabs("select", 0);
//            $.parser.parse("#domain");
        }

    });

    $.parser.onComplete = function(){
        console.log("abc");
        //新增，全部行为
        $('#allaction').combobox({
            onSelect: function (rec) {
                if (null != rec.value && "" != rec.value) {
                    for (var i = 0; i < 14; i++) {
                        $('#r' + i).combobox('setValue', rec.value);
                    }
                }
            }
        });

        //安全域选择校验
        $('#arpCreateForm #domainMy').combobox({
            onSelect: function (rec) {
                $('#domainid').val(rec.value);
                if (null != rec.value && "" != rec.value) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/security/chkArpByDomain.do',
                        type: 'post',
                        async: false,
                        data: {domainid: rec.value, securityid: $("#tabs_security_id").val()},
                        dataType: 'json',
                        success: function (data) {
                            if (data.success) {
                                $.messager.alert('提示信息', '当前安全域下已经配置了攻击防护信息,不允许重复配置！', 'info');
                                $('#addarp').linkbutton("disable", true);
                            } else {
                                $('#addarp').linkbutton("enable");
                            }
                        }
                    })
                } else {
                    $('#addarp').linkbutton("enable");
                }
            }
        });

        $("#alluser").change(function () {
            if (this.checked) {
                var r = document.getElementsByName("chk");
                for (var i = 0; i < r.length; i++) {
                    r[i].checked = true;
                }
                $("#arpCreateForm  #icmp_").show();
                $("#arpCreateForm  #udp_").show();
                $("#arpCreateForm  #arp_").show();
                $("#arpCreateForm  #syn_").show();
                $("#arpCreateForm  #ipscanning_").show();
                $("#arpCreateForm  #portscanning_").show();
                $("#arpCreateForm  #ipshard_").show();
                $("#arpCreateForm  #ipoption_").show();
                $("#arpCreateForm  #sf_").show();
                $("#arpCreateForm  #land_").show();
                $("#arpCreateForm  #icmpbp_").show();
                $("#arpCreateForm  #synagent_").show();
                $("#arpCreateForm  #tcp_").show();
                $("#arpCreateForm  #dns_").show();
                $("#arpCreateForm  #dnsr_").show();
            } else {
                var r = document.getElementsByName("chk");
                for (var i = 0; i < r.length; i++) {
                    r[i].checked = false;
                }
                $("#arpCreateForm  #icmp_").hide();
                $("#arpCreateForm  #udp_").hide();
                $("#arpCreateForm  #arp_").hide();
                $("#arpCreateForm  #syn_").hide();
                $("#arpCreateForm  #ipscanning_").hide();
                $("#arpCreateForm  #portscanning_").hide();
                $("#arpCreateForm  #ipshard_").hide();
                $("#arpCreateForm  #ipoption_").hide();
                $("#arpCreateForm  #sf_").hide();
                $("#arpCreateForm  #land_").hide();
                $("#arpCreateForm  #icmpbp_").hide();
                $("#arpCreateForm  #synagent_").hide();
                $("#arpCreateForm  #tcp_").hide();
                $("#arpCreateForm  #dns_").hide();
                $("#arpCreateForm  #dnsr_").hide();
            }
        });

        //新增页面效果：隐现
        $("#icmp").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #icmp_").show();
            } else {
                $("#arpCreateForm  #icmp_").hide();
            }
        });
        $("#udp").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #udp_").show();
            } else {
                $("#arpCreateForm  #udp_").hide();
            }
        });
        $("#arp").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #arp_").show();
            } else {
                $("#arpCreateForm  #arp_").hide();
            }
        });
        $("#syn").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #syn_").show();
            } else {
                $("#arpCreateForm  #syn_").hide();
            }
        });
        $("#ipscanning").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #ipscanning_").show();
            } else {
                $("#arpCreateForm  #ipscanning_").hide();
            }
        });
        $("#portscanning").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #portscanning_").show();
            } else {
                $("#arpCreateForm  #portscanning_").hide();
            }
        });
        $("#ipshard").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #ipshard_").show();
            } else {
                $("#arpCreateForm  #ipshard_").hide();
            }
        });
        $("#ipoption").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #ipoption_").show();
            } else {
                $("#arpCreateForm  #ipoption_").hide();
            }
        });
        $("#sf").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #sf_").show();
            } else {
                $("#arpCreateForm  #sf_").hide();
            }
        });
        $("#land").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #land_").show();
            } else {
                $("#arpCreateForm  #land_").hide();
            }
        });
        $("#icmpbp").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #icmpbp_").show();
            } else {
                $("#arpCreateForm  #icmpbp_").hide();
            }
        });
        $("#synagent").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #synagent_").show();
            } else {
                $("#arpCreateForm  #synagent_").hide();
            }
        });
        $("#tcp").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #tcp_").show();
            } else {
                $("#arpCreateForm  #tcp_").hide();
            }
        });
        $("#dns").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #dns_").show();
            } else {
                $("#arpCreateForm  #dns_").hide();
            }
        });
        $("#dnsr").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm  #dnsr_").show();
            } else {
                $("#arpCreateForm  #dnsr_").hide();
            }
        });

    }
</script>
</body>
</html>