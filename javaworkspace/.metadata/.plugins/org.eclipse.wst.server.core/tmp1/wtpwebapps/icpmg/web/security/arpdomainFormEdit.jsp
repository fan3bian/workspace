<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<body>
<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();%>
<%String contextPath = request.getContextPath();%>
<%--<div id="arpw1" class="easyui-window" title="修改防护配置" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save'" style="width:800px;height:500px;padding:5px;top:127px;">--%>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'center'" style="padding:10px;border:0">
            <form id="arpCreateForm1" method="post" data-options="novalidate:true">
                <h2>选择安全域</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">安全域：</span>
					<span style="margin-left:15px;">
						<input type="hidden" id="domainid1"/>
						<select id="domain1" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',editable:false,disabled:true">
                        </select>
					</span>
                </div>
                <h2>白名单</h2>
                <div style="margin-bottom:5px;">
					<input type="hidden" id="wlist1" name="wlist1"/>
					<a class="easyui-linkbutton" style="margin-left:30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="choosewlist('edit', 'd');">配置</a>
				</div>
                <h2>全选</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">全部启用</span>
                    <span style="margin-left:15px;" ><input type="checkbox" id="alluser1"/></span>
					<span style="margin-left:15px;">
						<span style="display:inline-block;width: 120px;">行为：</span>
						<select id="allaction1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="">--</option>
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
					</span>
                </div>
                <h2>Flood防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">ICMP洪水攻击防护</span>
                    <span style="margin-left:15px;" ><input type="checkbox" id="icmp1" name="chk1"/></span>
					<span style="margin-left:15px;" id="icmp1_">
						<span style="display:inline-block;width: 120px;">警戒值：</span>
						<input id="icmpalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-50,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="_r0" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">UDP洪水攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="udp1" name="chk1"/></span>
					<span style="margin-left:15px;" id="udp1_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="udpsalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="_r1" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<input id="udpdalert1" class="easyui-textbox" style="width:70px;height:22px;"/>(0-300,000)
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">ARP欺骗攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="arp1" name="chk1"/></span>
					<span style="margin-left:15px;" id="arp1_">
						<span style="display:inline-block;width: 120px;">每个MAC最大IP数：</span>
						<input id="arpipnumofmac1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-1,024)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="_r2" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">免费ARP包发送速率：</span>
						<input id="arppsendrate1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-10)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">反向查询</span>
						<input type="checkbox" id="arpreverseq1"/>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">SYN洪水攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="syn1" name="chk1"/></span>
					<span style="margin-left:15px;" id="syn1_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="synsalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-50,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="_r3" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<select id="syndalerttype1" class="easyui-combobox" style="width:80px;" data-options="panelHeight:'auto',editable:false">
                            <option value="1">基于IP</option>
                            <option value="2">基于端口</option>
                        </select>
						<input id="syndalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-50,000)</span>
					</span>
                </div>
                <h2>MS-Windows防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">WinNuke攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="winnuke1" name="chk1"/></span>
                </div>
                <h2>扫描/欺骗防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP地址欺骗攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipcheat1" name="chk1"/></span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP地址扫描攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipscanning1" name="chk1"/></span>
					<span style="margin-left:15px;" id="ipscanning1_">
					<span style="display:inline-block;width: 120px;">警戒值：</span>
					<input id="ipscanningalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-5,000)</span>
					<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
					<select id="_r4" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">端口扫描防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="portscanning1" name="chk1"/></span>
					<span style="margin-left:15px;" id="portscanning1_">
					<span style="display:inline-block;width: 120px;">警戒值：</span>
					<input id="portscanningalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-5,000)</span>
					<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
					<select id="_r5" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <h2>拒绝服务防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Ping of Death攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="pingofdeath1" name="chk1"/></span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Teardrop攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="treadrop1" name="chk1"/></span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP分片防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipshard1" name="chk1"/></span>
					<span style="margin-left:15px;" id="ipshard1_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="_r6" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">IP选项</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="ipoption1" name="chk1"/></span>
					<span style="margin-left:15px;" id="ipoption1_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="_r7" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Smurf或者Fraggle攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="sf1" name="chk1"/></span>
					<span style="margin-left:15px;" id="sf1_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="_r8" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">Land攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="land1" name="chk1"/></span>
					<span style="margin-left:15px;" id="land1_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="_r9" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">ICMP大包攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="icmpbp1" name="chk1"/></span>
					<span style="margin-left:15px;" id="icmpbp1_">
					<span style="display:inline-block;width: 120px;">源警戒值：</span>
					<input id="icmpbpalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-50,000)</span>
					<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
					<select id="_r10" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <h2>代理</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">SYN代理</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="synagent1" name="chk1"/></span>
					<span style="margin-left:15px;" id="synagent1_">
						<span style="display:inline-block;width: 120px;">最小代理速率：</span>
						<input id="synagentminrate1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-50,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">cookie</span>
						<input type="checkbox" id="syncookie1"/>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">最大代理速率：</span>
						<input id="synagentmaxrate1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 60px;margin-left:25px;">代理超时：</span>
						<input id="syntimeout1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(1-180)秒</span>
					</span>
                </div>
                <h2>协议异常报告</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">TCP异常</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="tcp1" name="chk1"/></span>
					<span style="margin-left:15px;" id="tcp1_">
					<span style="display:inline-block;width: 120px;">行为：</span>
					<select id="_r11" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                        <option value="0">丢弃</option>
                        <option value="1">告警</option>
                    </select>
					</span>
                </div>
                <h2>DNS查询洪水防护</h2>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">DNS查询洪水防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="dns1" name="chk1"/></span>
					<span style="margin-left:15px;" id="dns1_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="dnssalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="_r12" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<input id="dnsdalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
					</span>
                </div>
                <div style="margin-bottom:5px;">
                    <span style="display:inline-block;width: 145px;margin-left:30px;">DNS递归查询洪水攻击防护</span>
                    <span style="margin-left:15px;width: 25px;" ><input type="checkbox" id="dnsr1" name="chk1"/></span>
					<span style="margin-left:15px;" id="dnsr1_">
						<span style="display:inline-block;width: 120px;">源警戒值：</span>
						<input id="dnsrsalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
						<span style="display:inline-block;width: 55px;margin-left:30px;">行为：</span>
						<select id="_r13" class="easyui-combobox" style="width:70px;" data-options="panelHeight:'auto',editable:false">
                            <option value="0">丢弃</option>
                            <option value="1">告警</option>
                        </select>
						<br>
						<span style="display:inline-block;width: 120px;margin-left:225px;margin-top: 5px;">目的警戒值：</span>
						<input id="dnsrdalert1" class="easyui-textbox" style="width:70px;height:22px;"/><span  style="display:inline-block;width: 75px;">(0-300,000)</span>
					</span>
                </div>
            </form>
        </div>
        <div data-options="region:'south',border:false" style="text-align:center;padding:5px 0 0;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="editdomainarp();" id="addarp" style="width:80px">提交</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#editDialog').dialog('destroy');" style="width:80px">取消</a>
        </div>
    </div>
<%--</div>--%>
<%--</div>--%>


<script type="text/javascript">

    $().ready(function () {
        var _form = $("#arpCreateForm1");
        $(_form).children("h2").eq(0).before(
                '<div id="editTabs" class="easyui-tabs" style="height:375px" data-options="tabPosition:\'left\',headerWidth:100,fit:true" ></div>'
        );
        
       
       
         var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "Flood防护").attr("id", "step" + 0).appendTo($("#arpCreateForm1 .easyui-tabs"));
         var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "服务防护").attr("id", "step" + 1).appendTo($("#arpCreateForm1 .easyui-tabs"));
         var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "异常报告").attr("id", "step" + 2).appendTo($("#arpCreateForm1 .easyui-tabs"));
        /* 
        for (var i = 0; i < 3; i++) {
            var div0 = $('<div style=\'height: 375px;\'></div>').attr("title", "步骤" + (i + 1)).attr("id", "step" + i).appendTo($("#arpCreateForm1 .easyui-tabs"));
        }
        */
        
//        alert('$("#arpCreateForm1 #editTabs #step0")  ' + $("#arpCreateForm1 #editTabs #step0").length);
        $(_form).children("h2").slice(0, 4).each(function () {
            $("#arpCreateForm1 #editTabs #step0").append($(this).nextUntil("h2").andSelf());
        });
        $(_form).children("h2").slice(0, 3).each(function () {
            $("#arpCreateForm1 #editTabs  #step1").append($(this).nextUntil("h2").andSelf());
        });
        $(_form).children("h2").slice(0, 4).each(function () {
            $("#arpCreateForm1 #editTabs #step2").append($(this).nextUntil("h2").andSelf());
        });
        $("#arpCreateForm1 #editTabs").tabs();



    });

    $.parser.onComplete = function () {
//        console.log("abc");

        //修改，全部行为
        $('#allaction1').combobox({
            onSelect: function (rec) {
                if (null != rec.value && "" != rec.value) {
                    for (var i = 0; i < 14; i++) {
                        $('#_r' + i).combobox('setValue', rec.value);
                    }
                }
            }
        });


//修改，全部选中
        $("#alluser1").change(function(){
            if(this.checked){
                var r=document.getElementsByName("chk1");
                for(var i=0;i<r.length;i++){
                    r[i].checked = true;
                }
                $("#arpCreateForm1  #icmp1_").show();
                $("#arpCreateForm1  #udp1_").show();
                $("#arpCreateForm1  #arp1_").show();
                $("#arpCreateForm1  #syn1_").show();
                $("#arpCreateForm1  #ipscanning1_").show();
                $("#arpCreateForm1  #portscanning1_").show();
                $("#arpCreateForm1  #ipshard1_").show();
                $("#arpCreateForm1  #ipoption1_").show();
                $("#arpCreateForm1  #sf1_").show();
                $("#arpCreateForm1  #land1_").show();
                $("#arpCreateForm1  #icmpbp1_").show();
                $("#arpCreateForm1  #synagent1_").show();
                $("#arpCreateForm1  #tcp1_").show();
                $("#arpCreateForm1  #dns1_").show();
                $("#arpCreateForm1  #dnsr1_").show();
            }else{
                var r=document.getElementsByName("chk1");
                for(var i=0;i<r.length;i++){
                    r[i].checked = false;
                }
                $("#arpCreateForm1  #icmp1_").hide();
                $("#arpCreateForm1  #udp1_").hide();
                $("#arpCreateForm1  #arp1_").hide();
                $("#arpCreateForm1  #syn1_").hide();
                $("#arpCreateForm1  #ipscanning1_").hide();
                $("#arpCreateForm1  #portscanning1_").hide();
                $("#arpCreateForm1  #ipshard1_").hide();
                $("#arpCreateForm1  #ipoption1_").hide();
                $("#arpCreateForm1  #sf1_").hide();
                $("#arpCreateForm1  #land1_").hide();
                $("#arpCreateForm1  #icmpbp1_").hide();
                $("#arpCreateForm1  #synagent1_").hide();
                $("#arpCreateForm1  #tcp1_").hide();
                $("#arpCreateForm1  #dns1_").hide();
                $("#arpCreateForm1  #dnsr1_").hide();
            }
        });

//修改页面效果：隐现
        $("#icmp1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #icmp1_").show();
            } else {
                $("#arpCreateForm1 #icmp1_").hide();
            }
        });
        $("#udp1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #udp1_").show();
            } else {
                $("#arpCreateForm1 #udp1_").hide();
            }
        });
        $("#arp1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #arp1_").show();
            } else {
                $("#arpCreateForm1 #arp1_").hide();
            }
        });
        $("#syn1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #syn1_").show();
            } else {
                $("#arpCreateForm1 #syn1_").hide();
            }
        });
        $("#ipscanning1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #ipscanning1_").show();
            } else {
                $("#arpCreateForm1 #ipscanning1_").hide();
            }
        });
        $("#portscanning1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #portscanning1_").show();
            } else {
                $("#arpCreateForm1 #portscanning1_").hide();
            }
        });
        $("#ipshard1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #ipshard1_").show();
            } else {
                $("#arpCreateForm1 #ipshard1_").hide();
            }
        });
        $("#ipoption1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #ipoption1_").show();
            } else {
                $("#arpCreateForm1 #ipoption1_").hide();
            }
        });
        $("#sf1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #sf1_").show();
            } else {
                $("#arpCreateForm1 #sf1_").hide();
            }
        });
        $("#land1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #land1_").show();
            } else {
                $("#arpCreateForm1 #land1_").hide();
            }
        });
        $("#icmpbp1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #icmpbp1_").show();
            } else {
                $("#arpCreateForm1 #icmpbp1_").hide();
            }
        });
        $("#synagent1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #synagent1_").show();
            } else {
                $("#arpCreateForm1 #synagent1_").hide();
            }
        });
        $("#tcp1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #tcp1_").show();
            } else {
                $("#arpCreateForm1 #tcp1_").hide();
            }
        });
        $("#dns1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #dns1_").show();
            } else {
                $("#arpCreateForm1 #dns1_").hide();
            }
        });
        $("#dnsr1").click(function () {
            var data = $(this).attr("checked");
            if (data) {
                $("#arpCreateForm1 #dnsr1_").show();
            } else {
                $("#arpCreateForm1 #dnsr1_").hide();
            }
        });
    }


</script>
</body>
</html>