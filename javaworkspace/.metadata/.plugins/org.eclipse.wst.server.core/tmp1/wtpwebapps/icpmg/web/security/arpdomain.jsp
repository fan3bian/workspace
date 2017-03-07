<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
.FieldInput3 {
	width:12%;
	height: 30px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}
.FieldLabel3 {
	width:8%;
	height: 30px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align:left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>	
<script type="text/javascript">

$(document).ready(function() {
		$('#addOrEdit').val("");
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
	    $('#allaction1').combobox({
            onSelect: function (rec) {
                if (null != rec.value && "" != rec.value) {
                    for (var i = 0; i < 14; i++) {
                        $('#_r' + i).combobox('setValue', rec.value);
                    }
                }
            }
        });
		arploadDataGrid();
	
		// 新增防护配置
		$('.j-yesno').unbind("click");
    
		$('.j-yesno').click(function(event){
	
			 $(this).toggleClass('active');
			 event.stopPropagation();
        
           	 
	  	});
	   	$('.j-btn-toggle').unbind("click");
	    $('.j-btn-toggle').click(function() {
            liindex = $(this).parents('.item3').parent().index();
			
			if($('#addOrEdit').val()=='edit'){
				liindex1 = liindex+'_';	
				
				$(this).toggleClass('active');
	            if ($(this).hasClass('active')) {
	                $('#arpw1 .j-tree-tab ul li').eq(liindex).find('input:checkbox').prop({
	                    checked: 'checked'
	                });
	                $(this).parents('table').removeClass('make-gray');
	            } else {
	                $(this).parents('table').addClass('make-gray');
					
	                if (!$('#arpw1 .tabcon').eq(liindex).find('.j-btn-toggle').hasClass('active'))
	                    $('#arpw1 .j-tree-tab ul li').eq(liindex).find('input:checkbox').removeAttr('checked');
	            }
	            isAbled($(this).parents('.item3'));
			}else{
				liindex1 = liindex;
				
				$(this).toggleClass('active');
	            if ($(this).hasClass('active')) {
	                $('#arpw .j-tree-tab ul li').eq(liindex).find('input:checkbox').prop({
	                    checked: 'checked'
	                });
	                $(this).parents('table').removeClass('make-gray');
	            } else {
	                $(this).parents('table').addClass('make-gray');
					
	                if (!$('#arpw .tabcon').eq(liindex).find('.j-btn-toggle').hasClass('active'))
	                    $('#arpw .j-tree-tab ul li').eq(liindex).find('input:checkbox').removeAttr('checked');
	            }
	            isAbled($(this).parents('.item3'));
			}
			
           
        });
        // 二级选择
        $('.j-tree-tab ul li').unbind("click");
        $('.j-tree-tab ul li').click(function(event) {
            $(this).addClass('active').siblings().removeClass('active');
            var liIndex = $(this).index() + 1;
            var liindex1;
            if($('#addOrEdit').val()=='edit'){
				liindex1 = liIndex+'_';	
			}else{
				liindex1 = liIndex;
			}
            $('#tabcon' + liindex1).show().siblings().hide();
            isAbled($('#tabcon' + liindex1));
        });
        $('.j-tree-tab ul li input:checkbox').change(function(event) {
            liindex = $(this).parents("li").index() + 1;
            if($('#addOrEdit').val()=='edit'){
				liindex1 = liindex+'_';	
			}else{
				liindex1 = liindex;
			}
            if ($(this).prop('checked')) {
                $('#tabcon' + liindex1).find("table").removeClass('make-gray');
                $('#tabcon' + liindex1).find(".j-btn-toggle").addClass('active');
            } else {
                $('#tabcon' + liindex1).find("table").addClass('make-gray');
                $('#tabcon' + liindex1).find(".j-btn-toggle").removeClass('active');
            }
            
            isAbled($('#tabcon' + liindex1));
        });
        
        //新增页面 全选按钮
        $('#allStart').click(function(event) {
            $(this).toggleClass('active');
           
            if ($(this).hasClass('active')) {
                $('.j-tree-tab ul li input:checkbox').attr('checked', 'checked');
                $('.j-btn-toggle').addClass('active');
                $("#arpreverseq").addClass("active");
            } else {
                $('.j-tree-tab ul li input:checkbox').removeAttr('checked');
                $('.j-btn-toggle').removeClass('active');
            }
            for (var i = 0; i < $('.j-tree-tab ul li').length; i++) {
                var liindex = i + 1;
                var obj = $('.j-tree-tab ul li').eq(i).find('input:checkbox');
                if ($(obj).prop('checked')) {
                    $('#tabcon' + liindex).find("table").removeClass('make-gray');
                } else {
                    $('#tabcon' + liindex).find("table").addClass('make-gray');
                }

            }
            isAbled($('.tabcon'));
        });
		//修改页面 全选按钮
		$('#allStart1').click(function(event) {
            $(this).toggleClass('active');
           
            if ($(this).hasClass('active')) {
                $('.j-tree-tab ul li input:checkbox').attr('checked', 'checked');
                $('.j-btn-toggle').addClass('active');
                $("#arpreverseq").addClass("active");
            } else {
                $('.j-tree-tab ul li input:checkbox').removeAttr('checked');
                $('.j-btn-toggle').removeClass('active');
            }
            for (var i = 0; i < $('.j-tree-tab ul li').length; i++) {
                var liindex = i + 1+'_';
                var obj = $('.j-tree-tab ul li').eq(i).find('input:checkbox');
                if ($(obj).prop('checked')) {
                    $('#tabcon' + liindex).find("table").removeClass('make-gray');
                } else {
                    $('#tabcon' + liindex).find("table").addClass('make-gray');
                }

            }
            isAbled($('.tabcon'));
        });
    
        function isAbled(obj) {
            for (var i = 0; i <$(obj).find('table').length; i++) {
                if ($(obj).find('table').eq(i).hasClass('make-gray')) {
                  	$(obj).find('table').eq(i).find("input,select,button").attr('disabled', 'disabled');
                   	$(obj).find('table').eq(i).find('.j-yesno').removeClass('active');
                } else {
                    $(obj).find('table').eq(i).find("input,select,button").removeAttr('disabled');
                }
            }
        }
});

//查询结果
function arploadDataGrid(){
	grid = $('#arp_grid').datagrid({
		singleSelect:true,
		rownumbers : false,
		border : false,
		striped : true,
		scrollbarSize : 0,
		method : 'post',
		loadMsg : '数据装载中......',
		fitColumns : true,
		pagination : true,
		pageSize:10,
		pageList:[5,10,20,30,40,50],
		toolbar: [{
            id: 'btnadd',
            text: '新增防护配置',
            iconCls: 'icon-add',
            handler: function() {
                newArpw();
            }

        }],    
	    url:'${pageContext.request.contextPath}/security/arpDomainList.do?securityid=' + $("#tabs_security_id").val(),
	    onLoadSuccess : function(data) {
			var pageopt = $('#arp_grid').datagrid('getPager').data("pagination").options;
			var _pageSize = pageopt.pageSize;
			var _rows = $('#arp_grid').datagrid("getRows").length;
			var total = pageopt.total;
			if (_pageSize >= 10) {
				for (i = 10; i > _rows; i--) {
					$(this).datagrid('appendRow', {operation : ''});
				}
				$('#arp_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
					total: total,
			});	
			} else {
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
			
			 // 弹层
            $('#arpw').dialog({
                title: "新增防护配置",
                width: 900,
                height: 530,
                closed: true,
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                buttons: [{
                    text: '提交',
                    iconCls: 'icon-ok',
                    id:'addarp',
                    handler: function() {
                        adddomainarp();
                    }
                }, {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#arpw').dialog('close');

                    }
                }]
            });
             // 弹层
            $('#arpw1').dialog({
                title: "修改防护配置",
                width: 900,
                height: 530,
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
                        editdomainarp();
                    }
                }, {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#arpw1').dialog('close');

                    }
                }]
            });
            //初始 不选
             $('#allStart').addClass("active");
             if($('#allStart').hasClass("active")){
 				$('#allStart').click();
       		 	 }
       		
            // 弹层选择地址
	        $('#wlistConfig').dialog({
	            title: "选择地址",
	            width: 500,
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
	                	wilisttj();//内容回填
	                    $('#wlistConfig').dialog('close');
	                }
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function() {
	                    $('#wlistConfig').dialog('close');
	
	                }
	            }]
	        });
	        
	        $('.j-open').linkbutton({
                iconCls: 'icon-open',
                plain: true
   		    });
			$('.j-close').linkbutton({
                iconCls: 'icon-close',
                plain: true
   		    });
			$('.j-modify').linkbutton({
                iconCls: 'icon-modify',
                plain: true
   		    });
		}
	 }); 
}
//状态属性格式化
function arpusestatformatter(value, row, index) {
	var str = "";
	if(value == '1'){
		str = "在用";
	}else if(value == '0'){
		str = "停用";
	}
	return str;
} 

//操作列格式化
function arpfwoptionformater(value, row, index) {
	if(!value){
		return "";
	}	
	var str = "";
	if(row.usestat == "0"){
		str = "<a href=\"javascript:void(0);\" onclick=\"arpeditstatus(\'1\',\'" + row.domainid + "\');\" class=\"j-open\" title=\"启用\"></a>";
	}else{
		str = "<a href=\"javascript:void(0);\" onclick=\"arpeditstatus(\'0\',\'" + row.domainid + "\');\" class=\"j-close\" title=\"停用\"></a>";
	}
	str += "&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"getdomainarp(\'" + row.domainid + "\', \'"
			+ row.alluser + "\', \'" + row.allaction + "\', \'" + row.icmp  + "\', \'" + row.icmpalert + "\', \'"
			+ row.icmpaction + "\', \'" + row.udp + "\', \'" + row.udpsalert  + "\', \'" + row.udpdalert + "\', \'" 
			+ row.udpaction + "\', \'" + row.arp + "\', \'" + row.arpaction + "\', \'" + row.arpipnumofmac  + "\', \'"
			+ row.arppsendrate + "\', \'" + row.arpreverseq + "\', \'" + row.syn + "\', \'" + row.synsalert + "\', \'"
			+ row.syndalert  + "\', \'" + row.synaction + "\', \'" + row.syndalerttype + "\', \'"+row.syndalertdatype+"\', \'"+row.syndalertdavalue+"\', \'" + row.winnuke + "\', \'"
			+ row.ipcheat  + "\', \'" + row.ipscanning + "\', \'" + row.ipscanningalert + "\', \'" + row.ipscanningaction + "\', \'" 
			+ row.portscanning  + "\', \'" + row.portscanningalert + "\', \'" + row.portscanningaction + "\', \'"
			+ row.pingofdeath + "\', \'" + row.treadrop + "\', \'" + row.ipshard  + "\', \'" + row.ipshardaction + "\', \'"
			+ row.ipoption + "\', \'" + row.ipoptionaction + "\', \'" + row.sf  + "\', \'" + row.sfaction + "\', \'"
			+ row.land + "\', \'" + row.landaction + "\', \'" + row.icmpbp + "\', \'" + row.icmpbpalert  + "\', \'"
			+ row.icmpbpaction + "\', \'" + row.synagent + "\', \'" + row.synagentminrate + "\', \'" + row.synagentmaxrate + "\', \'" 
			+ row.syncookie+ "\', \'" + row.syntimeout + "\', \'" + row.tcp + "\', \'" + row.tcpaction + "\', \'"
			+ row.dns + "\', \'" + row.dnssalert + "\', \'" + row.dnsdalert + "\', \'" + row.dnsaction  + "\', \'" 
			+ row.dnsr + "\', \'" + row.dnsrsalert  + "\', \'" + row.dnsrdalert + "\', \'" + row.dnsraction + "\', \'" +row.whilststr+ "\', \'" + row.whilststrv + "\');\"  class=\"j-modify\"  title=\"修改\"></a>"; 
	return str;
} 
//单记录获取信息
function getdomainarp(domainid, alluser, allaction, icmp, icmpalert, icmpaction, udp, udpsalert, udpdalert, udpaction,
		arp, arpaction, arpipnumofmac, arppsendrate, arpreverseq, syn, synsalert, syndalert, synaction, syndalerttype,syndalertdatype,syndalertdavalue,
		winnuke, ipcheat, ipscanning, ipscanningalert, ipscanningaction, portscanning, portscanningalert, portscanningaction,
		pingofdeath, treadrop, ipshard, ipshardaction, ipoption, ipoptionaction, sf, sfaction, land, landaction, icmpbp,
		icmpbpalert, icmpbpaction, synagent, synagentminrate, synagentmaxrate, syncookie, syntimeout, tcp, tcpaction, 
		dns, dnssalert, dnsdalert ,dnsaction, dnsr, dnsrsalert, dnsrdalert, dnsraction,whilststr,whilststrv){
	    
	
	
		$('#arpCreateForm1').form('clear');
		$('#addOrEdit').val("edit");
		$("#wlist1").val(whilststrv);
		$('#wilist_display1').textbox('setValue', whilststr).textbox('setText', whilststr);
		$('#allStart1').addClass("active");
        if($('#allStart1').hasClass("active")){
 			$('#allStart1').click();
       	}
		$('#arpCreateForm1  #domainid1').val(domainid);
		$('#arpCreateForm1  #domain1').combobox('setValue', domainid);
		if(alluser == 1){
			$('#allStart1').addClass("active");
		}
		$('#arpCreateForm1 #allaction1').combobox('setValue', '');
		/*
		if(null === allaction || "null" === allaction){
			$('#arpCreateForm1 #allaction1').combobox('setValue', '');
		}else{
			$('#arpCreateForm1 #allaction1').combobox('setValue', allaction);
		}
		*/
		if(icmp == 1){
			$('#arpCreateForm1  #icmp1').click();
			$('#arpCreateForm1 #icmpalert1').textbox('setValue', icmpalert).textbox('setText', icmpalert);
			$('#arpCreateForm1 #_r0').combobox('setValue', icmpaction);
		}else{
			$('#arpCreateForm1  #icmp1').removeClass("active");
			$('#arpCreateForm1 #icmpalert1').textbox('setValue', '1500')
			$('#arpCreateForm1 #_r0').combobox('setValue','0');
		}
		
		
		if(udp == 1){
			$('#arpCreateForm1  #udp1').click();
			$('#arpCreateForm1 #udpsalert1').textbox('setValue', udpsalert).textbox('setText', udpsalert);
			$('#arpCreateForm1 #udpdalert1').textbox('setValue', udpdalert).textbox('setText', udpdalert);
			$('#arpCreateForm1 #_r1').combobox('setValue', udpaction);
		}else{
			$('#arpCreateForm1  #udp1').removeClass("active");
			$('#arpCreateForm1 #udpsalert1').textbox('setValue', '1500');
			$('#arpCreateForm1 #udpdalert1').textbox('setValue', '1500');
			$('#arpCreateForm1 #_r1').combobox('setValue', '0');
		}
		
		
		if(arp == 1){
			$('#arpCreateForm1 #arp1').click();
			$('#arpCreateForm1 #arpipnumofmac1').textbox('setValue', arpipnumofmac).textbox('setText', arpipnumofmac);
			$('#arpCreateForm1 #arppsendrate1').textbox('setValue', arppsendrate).textbox('setText', arppsendrate);
		}else{
			$('#arpCreateForm1 #arp1').removeClass("active");
			$('#arpipnumofmac1').textbox('setValue', '0');
			$('#arppsendrate1').textbox('setValue', '0');
		}
		if(arpreverseq==1){
			$('#arpCreateForm1 #arpreverseq1').addClass("active");
		}else{
			$('#arpCreateForm1 #arpreverseq1').removeClass("active");
		}
		
		
		$('#arpCreateForm1 #_r2').combobox('setValue', arpaction);
		
		if(syn == 1){
			$('#arpCreateForm1 #syn1').click();
			$('#arpCreateForm1 #synsalert1').textbox('setValue', synsalert).textbox('setText', synsalert);
			$('#arpCreateForm1 #syndalert1').textbox('setValue', syndalert).textbox('setText', syndalert);    
			$('#arpCreateForm1 #_r3').combobox('setValue', synaction);
			$('#arpCreateForm1 #syndalerttype1').combobox('setValue', syndalerttype);
			if(syndalerttype == 2){
				document.getElementById('portmodify').style.display='';
				$('#arpCreateForm1 #syndalertdatypemodify').combobox('setValue', syndalertdatype);
				if(syndalertdatype == 1){
					document.getElementById('ipaddressmodify1').style.display='';
		            document.getElementById('ipaddressmodify2').style.display='';
					var arr=syndalertdavalue.split('/'); 
					$('#arpCreateForm1 #syndalertdavaluemodify0').textbox('setValue', arr[0]).textbox('setText', arr[0]);
					$('#arpCreateForm1 #syndalertdavaluemodify1').textbox('setValue', arr[1]).textbox('setText', arr[1]);
				}else{
					document.getElementById('addressentrymodify').style.display='';
					$('#arpCreateForm1 #syndalertdavaluemodify2').combobox('setValue', syndalertdavalue);
				}
			}else{
				$('#arpCreateForm1 #syndalertdatypemodify').combobox('setValue', 1);
				document.getElementById('ipaddressmodify1').style.display='';
	            document.getElementById('ipaddressmodify2').style.display='';
	            document.getElementById('portmodify').style.display='none';
			}
		}else{
			$('#arpCreateForm1 #syn1').removeClass("active");
			$('#arpCreateForm1 #synsalert1').textbox('setValue', '1500');
			$('#arpCreateForm1 #syndalert1').textbox('setValue', '1500');
			$('#arpCreateForm1 #_r3').combobox('setValue', '0');
			$('#arpCreateForm1 #syndalerttype1').combobox('setValue', '1');
			$('#arpCreateForm1 #syndalertdatypemodify').combobox('setValue', 1);
			document.getElementById('ipaddressmodify1').style.display='';
            document.getElementById('ipaddressmodify2').style.display='';
            document.getElementById('portmodify').style.display='none';
		}
								   
		
		
		if(winnuke == 1){
			$('#arpCreateForm1 #winnuke1').click();
		}else{
			$('#arpCreateForm1 #winnuke1').removeClass("active");
		}
		if(ipcheat == 1){
			$('#arpCreateForm1 #ipcheat1').click();
		}else{
			$('#arpCreateForm1 #ipcheat1').removeClass("active");
		}
		
		if(ipscanning == 1){
			$('#arpCreateForm1 #ipscanning1').click();
			$('#arpCreateForm1 #ipscanningalert1').textbox('setValue', ipscanningalert).textbox('setText', ipscanningalert);
			$('#arpCreateForm1 #_r4').combobox('setValue', ipscanningaction);
		}else{
			$('#arpCreateForm1 #ipscanning1').removeClass("active");
			$('#arpCreateForm1 #ipscanningalert1').textbox('setValue', '1');
			$('#arpCreateForm1 #_r4').combobox('setValue', '0');
		}
		
		if(portscanning == 1){
			$('#arpCreateForm1 #portscanning1').click();
			$('#arpCreateForm1 #portscanningalert1').textbox('setValue', portscanningalert).textbox('setText', portscanningalert);
			$('#arpCreateForm1 #_r5').combobox('setValue', portscanningaction);
		}else{
			$('#arpCreateForm1 #portscanning1').removeClass("active");
			$('#arpCreateForm1 #portscanningalert1').textbox('setValue', '1');
			$('#arpCreateForm1 #_r5').combobox('setValue', '0');
		}
		
		
		if(pingofdeath == 1){
			$('#arpCreateForm1 #pingofdeath1').click();
		}else{
			$('#arpCreateForm1 #pingofdeath1').removeClass("active");
		}
		if(treadrop == 1){
			$('#arpCreateForm1 #treadrop1').click();
		}else{
			$('#arpCreateForm1 #treadrop1').removeClass("active");
		}
		if(ipshard == 1){
			$('#arpCreateForm1 #ipshard1').click();
			$('#arpCreateForm1 #_r6').combobox('setValue', ipshardaction);
		}else{
			$('#arpCreateForm1 #ipshard1').removeClass("active");
			$('#arpCreateForm1 #_r6').combobox('setValue', '0');
		}
		
		if(ipoption == 1){
			$('#arpCreateForm1 #ipoption1').click();
			$('#arpCreateForm1 #_r7').combobox('setValue', ipoptionaction);
		}else{
			$('#arpCreateForm1 #ipoption1').removeClass("active");
			$('#arpCreateForm1 #_r7').combobox('setValue', '0');
		}
		
		if(sf == 1){
			$('#arpCreateForm1 #sf1').click();
			$('#arpCreateForm1 #_r8').combobox('setValue', sfaction);
		}else{
			$('#arpCreateForm1 #sf1').removeClass("active");
			$('#arpCreateForm1 #_r8').combobox('setValue', '0');
		}
		
		if(land == 1){
			$('#arpCreateForm1 #land1').click();
			$('#arpCreateForm1 #_r9').combobox('setValue', landaction);
		}else{
			$('#arpCreateForm1 #land1').removeClass("active");
			$('#arpCreateForm1 #_r9').combobox('setValue', '0');
		}
		
		if(icmpbp == 1){
			$('#arpCreateForm1 #icmpbp1').click();
			$('#arpCreateForm1 #icmpbpalert1').textbox('setValue', icmpbpalert).textbox('setText', icmpbpalert);
			$('#arpCreateForm1 #_r10').combobox('setValue', icmpbpaction);
		}else{
			$('#arpCreateForm1 #icmpbp1').removeClass("active");
			$('#arpCreateForm1 #icmpbpalert1').textbox('setValue', '1024');
			$('#arpCreateForm1 #_r10').combobox('setValue', '0');
		}
		
		if(synagent == 1){
			$('#arpCreateForm1 #synagent1').click();
			$('#arpCreateForm1 #synagentminrate1').textbox('setValue', synagentminrate).textbox('setText', synagentminrate);
			$('#arpCreateForm1 #synagentmaxrate1').textbox('setValue', synagentmaxrate).textbox('setText', synagentmaxrate);
		}else{
			$('#arpCreateForm1 #synagent1').removeClass("active");
			$('#arpCreateForm1 #synagentminrate1').textbox('setValue', '1000');
			$('#arpCreateForm1 #synagentmaxrate1').textbox('setValue', '3000');
		}
		
		if(syncookie == 1){
			$('#arpCreateForm1 #syncookie1').addClass("active");
		}else{
			$('#arpCreateForm1 #syncookie1').removeClass("active");
		}
		$('#arpCreateForm1 #syntimeout1').textbox('setValue', syntimeout).textbox('setText', syntimeout);
		if(tcp == 1){
			$('#arpCreateForm1 #tcp1').click();
			$('#arpCreateForm1 #_r11').combobox('setValue', tcpaction);
		}else{
			$('#arpCreateForm1 #tcp1').removeClass("active");
			$('#arpCreateForm1 #_r11').combobox('setValue', '0');
		}
		
		if(dns == 1){
			$('#arpCreateForm1 #dns1').click();
			$('#arpCreateForm1 #dnssalert1').textbox('setValue', dnssalert).textbox('setText', dnssalert);
			$('#arpCreateForm1 #dnsdalert1').textbox('setValue', dnsdalert).textbox('setText', dnsdalert);
			$('#arpCreateForm1 #_r12').combobox('setValue', dnsaction);
		}else{
			$('#arpCreateForm1 #dns1').removeClass("active");
			$('#arpCreateForm1 #dnssalert1').textbox('setValue', '1500');
			$('#arpCreateForm1 #dnsdalert1').textbox('setValue', '1500');
			$('#arpCreateForm1 #_r12').combobox('setValue', 0);
		}
		
		if(dnsr == 1){
			$('#arpCreateForm1 #dnsr1').click();
			$('#arpCreateForm1 #dnsrsalert1').textbox('setValue', dnsrsalert).textbox('setText', dnsrsalert);
			$('#arpCreateForm1 #dnsrdalert1').textbox('setValue', dnsrdalert).textbox('setText', dnsrdalert);
		}else{
			$('#arpCreateForm1 #dnsr1').removeClass("active");
			$('#arpCreateForm1 #dnsrsalert1').textbox('setValue', '1000');
			$('#arpCreateForm1 #dnsrdalert1').textbox('setValue', '1000');
		}
		$('#arpCreateForm1 #_r13').combobox('setValue', dnsraction);
		$('#arpw1').attr('style','visibility:visible');
		$('#arpw1').window('open');
}
//单记录修改状态
function arpeditstatus(status, domainid){
	$("#manForm").form('submit', {
		url:"${pageContext.request.contextPath}/security/updateArpDomainStat.do", 
	    onSubmit : function(param) {
	    	param.securityid = $("#tabs_security_id").val(); 
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val(); 
			param.domainid=domainid;
			param.usestat=status;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				arploadDataGrid();
			} else {
				$.messager.alert('提示', "状态修改失败，请重试！", 'error');
			}
	    }
	}); 
}


//单记录添加保存信息
function adddomainarp(){
	var domainid = $('#domainid').val();//安全域
	if(null == domainid || "" == domainid){
		$.messager.alert('提示信息','请选择安全域！', 'info'); 
		return;
	} 
	var icmpalert = $('#icmpalert').textbox('getValue');
	var udpsalert = $('#udpsalert').textbox('getValue');
	var udpdalert = $('#udpdalert').textbox('getValue');
	var arpipnumofmac = $('#arpipnumofmac').textbox('getValue');
	var arppsendrate = $('#arppsendrate').textbox('getValue');
	var arpreverseq = 0;
	var ipscanningalert = $('#ipscanningalert').textbox('getValue');
	var portscanningalert = $('#portscanningalert').textbox('getValue');
	var synsalert = $('#synsalert').textbox('getValue');
	var syndalert = $('#syndalert').textbox('getValue');
	var syndalerttype = $('#syndalerttype').combobox('getValue');
	var syndalertdatype = "";
	var syndalertdavalue = "";
	var icmpbpalert = $('#icmpbpalert').textbox('getValue');
	var synagentminrate = $('#synagentminrate').textbox('getValue');
	var synagentmaxrate = $('#synagentmaxrate').textbox('getValue');
	var syntimeout = $('#syntimeout').textbox('getValue');
	var syncookie = 0;
	var dnssalert = $('#dnssalert').textbox('getValue');
	var dnsdalert = $('#dnsdalert').textbox('getValue');
	var dnsrsalert = $('#dnsrsalert').textbox('getValue');
	var dnsrdalert = $('#dnsrdalert').textbox('getValue');

	var wlist = $("#wlist").val(); 
	var alluser = 0;//全部启用
	var icmp = 0;//ICMP洪水攻击防护
	var udp = 0;//UDP洪水攻击防护
	var arp = 0;//ARP欺骗攻击防护
	var syn = 0;//SYN洪水攻击防护
	var ipscanning = 0;//IP地址扫描攻击防护
	var portscanning = 0;//端口扫描防护
	var ipshard = 0;//IP分片防护
	var ipoption = 0;//IP选项
	var sf = 0;//Smurf或者Fraggle攻击防护
	var land = 0;//Land攻击防护
	var icmpbp = 0;//ICMP大包攻击防护
	var tcp = 0;//TCP异常
	var dns = 0;//DNS查询洪水防护
	var dnsr = 0;//DNS递归查询洪水攻击防护
	var winnuke = 0;//winnuke攻击防护
	var ipcheat = 0;//ip地址欺骗攻击防护
	var pingofdeath = 0;//pingofdeath攻击防护
	var treadrop = 0;//Treadrop攻击防护
	var synagent = 0;//syn代理
	var state = 0;  
	if($("#icmp").hasClass("active")){
		icmp = 1;
		if(null == icmpalert || "" == icmpalert || icmpalert>50000 || icmpalert<1){
			$.messager.alert('提示信息','ICMP洪水攻击防护警戒值(1~50000)', 'info');
			return;
		}
		state++;
	}else{
		icmpalert = 1500;
	}
	if($("#udp").hasClass("active")){
		udp = 1;
		if(null == udpsalert || "" == udpsalert || udpsalert>300000 || udpsalert<0 ){
			$.messager.alert('提示信息','UDP洪水攻击防护源警戒值(0~300000)', 'info');
			return;
		}
		if(null == udpdalert || "" == udpdalert || udpdalert>300000 || udpdalert<0 ){
			$.messager.alert('提示信息','UDP洪水攻击防护目的警戒值(0~300000)', 'info');
			return;
		}
		state++;
	}else{
		udpsalert = 1500;
		udpdalert = 1500;
	}
	if($("#arp").hasClass("active")){
		arp = 1;
		if(null == arpipnumofmac || "" == arpipnumofmac || arpipnumofmac>1024 || arpipnumofmac<0 ){
			$.messager.alert('提示信息','每个MAC最大IP数(0~1024)', 'info');
			return;
		}
		if(null == arppsendrate || "" == arppsendrate || arppsendrate>1024 || arppsendrate<0 ){
			$.messager.alert('提示信息','免费ARP包发送速率(0~10)', 'info');
			return;
		}
		if($("#arpreverseq").hasClass("active")){
			arpreverseq = 1;
		}
		state++;
	}else{
		arpipnumofmac = "0";
		arppsendrate = "0";
	}
	if($("#syn").hasClass("active")){
		syn = 1;
		if(null == synsalert || "" == synsalert || synsalert>50000 || synsalert<0 ){
			$.messager.alert('提示信息','SYN洪水攻击防护源警戒值(0~50000)', 'info');
			return;
		}
		if(null == syndalert || "" == syndalert || syndalert>50000 || syndalert<0 ){
			$.messager.alert('提示信息','syn洪水攻击防护目的警戒值(0~50000)', 'info');
			return;
		}
		//目标地址
		if(syndalerttype==2){
			syndalertdatype = $('#syndalertdatype').combobox('getValue');
			if(syndalertdatype==1){
				
				syndalertdavalue = $('#0syndalertdavalue0').textbox('getValue') + '/' + transInt($('#0syndalertdavalue1').textbox('getValue'));
				if($('#0syndalertdavalue0').textbox('getValue')==""){
					$.messager.alert('提示信息','IP地址内容不允许为空！', 'info');
					return;
				}else if(!(checkIP($('#0syndalertdavalue0').textbox('getValue')))){
					$.messager.alert('提示信息','IPv4地址格式不正确！', 'info');
					return;
				}else if($('#0syndalertdavalue1').textbox('getValue')==""){
					$.messager.alert('提示信息','掩码内容不允许为空！', 'info');
					return;
				}else if($('#0syndalertdavalue1').textbox('getValue')!=0&&(!((24<=$('#0syndalertdavalue1').textbox('getValue'))&&($('#0syndalertdavalue1').textbox('getValue')<=32)))){
					$.messager.alert('提示信息','掩码数据范围：0或者24-32！', 'info');
					return;
				}
				
				
			}else{
				syndalertdavalue=$('#0syndalertdavalue2').textbox('getValue');
				if(syndalertdavalue==""){
					$.messager.alert('提示信息','地址条目内容不允许为空！', 'info');
					return;
				}
			}
		}
		/*
		if(null == syndalert || "" == syndalert || syndalert>50000 || syndalert<0 ){
			$.messager.alert('提示信息','SYN洪水攻击防护目的警戒值(0~50000)', 'info');
			return;
		}
		*/
		syndalert = 1500; //临时（由于界面效果缺失，暂时处理，以后删除）
		state++;
	}else{
		syndalerttype = 1;
		synsalert = 1500;
		syndalert = 1500;
	}
	if($("#ipscanning").hasClass("active")){
		ipscanning = 1;
		if(null == ipscanningalert || "" == ipscanningalert || ipscanningalert>5000 || ipscanningalert<0 ){
			$.messager.alert('提示信息','IP地址扫描攻击防护警戒值(0~5000)', 'info');
			return;
		}
		state++;
	}else{
		ipscanningalert = 1;
	}
	if($("#portscanning").hasClass("active")){
		portscanning = 1;
		if(null == portscanningalert || "" == portscanningalert || portscanningalert>5000 || portscanningalert<0 ){
			$.messager.alert('提示信息','端口扫描防护警戒值(0~5000)', 'info');
			return;
		}
		state++;
	}else{
		portscanningalert = 1;
	}
	if($("#ipshard").hasClass("active")){
		ipshard = 1;
		state++;
	}
	if($("#ipoption").hasClass("active")){
		ipoption = 1;
		state++;
	}
	if($("#sf").hasClass("active")){
		sf = 1;
		state++;
	}
	if($("#land").hasClass("active")){
		land = 1;
		state++;
	}
	if($("#icmpbp").hasClass("active")){
		icmpbp = 1;
		if(null == icmpbpalert || "" == icmpbpalert || icmpbpalert>50000 || icmpbpalert<1 ){
			$.messager.alert('提示信息','ICMP大包攻击防护源警戒值(1~50000)', 'info');
			return;
		}
		state++;
	}else{
		icmpbpalert = 1024;
	}
	if($("#synagent").hasClass("active")){
		synagent = 1;
		if(null == synagentminrate || "" == synagentminrate || synagentminrate>50000 || synagentminrate<0 ){
			$.messager.alert('提示信息','SYN代理最小代理速率(0~50000)', 'info');
			return;
		}
		if(null == synagentmaxrate || "" == synagentmaxrate || synagentmaxrate>300000 || synagentmaxrate<0 ){
			$.messager.alert('提示信息','SYN代理最大代理速率(0~300000)', 'info');
			return;
		}
		if(synagentminrate > synagentmaxrate){
			$.messager.alert('提示信息','SYN代理最小代理速率不可以大于最大代理速率', 'info');
			return;			
		}
		if(null == syntimeout || "" == syntimeout || syntimeout>180 || syntimeout<1 ){
			$.messager.alert('提示信息','SYN代理超时范围(1~180)', 'info');
			return;
		}
		if($("#syncookie").hasClass("active")){
			syncookie = 1;
		}
		state++;
	}else{
		synagentminrate = 1000;
		synagentmaxrate = 3000;
		syntimeout = 30;
		
	}
	if($("#tcp").hasClass("active")){
		tcp = 1;
		state++;
	}
	if($("#dns").hasClass("active")){
		dns = 1;
		if(null == dnssalert || "" == dnssalert || dnssalert>300000 || dnssalert<0 ){
			$.messager.alert('提示信息','DNS查询洪水防护源警戒值(0~300000)', 'info');
			return;
		}
		if(null == dnsdalert || "" == dnsdalert || dnsdalert>300000 || dnsdalert<0 ){
			$.messager.alert('提示信息','DNS查询洪水防护源目的警戒值(0~300000)', 'info');
			return;
		}
		state++;
	}else{
		dnssalert = 1500;
		dnsdalert = 1500;
	}
	if($("#dnsr").hasClass("active")){
		dnsr = 1;
		if(null == dnsrsalert || "" == dnsrsalert || dnsrsalert>300000 || dnsrsalert<0 ){
			$.messager.alert('提示信息','DNS递归查询洪水攻击防护警戒值(0~300000)', 'info');
			return;
		}
		if(null == dnsrdalert || "" == dnsrdalert || dnsrdalert>300000 || dnsrdalert<0 ){
			$.messager.alert('提示信息','DNS递归查询洪水攻击防护警戒值(0~300000)', 'info');
			return;
		}
		state++;
	}else{
		dnsrsalert = 1000;
		dnsrdalert = 1000;
	}
	if($("#winnuke").hasClass("active")){
		winnuke = 1;
		state++;
	}
	if($("#ipcheat").hasClass("active")){
		ipcheat = 1;
		state++;
	}
	if($("#pingofdeath").hasClass("active")){
		pingofdeath = 1;
		state++;
	}
	if($("#treadrop").hasClass("active")){
		treadrop = 1;
		state++;
	}
	if(state==19){
		alluser = 1;
	}
	var allaction = $('#allaction').combobox('getValue');//全部行为
	if(null != allaction && "" != allaction){
		var icmpaction = allaction, udpaction = allaction, arpaction = allaction;
		var synaction = allaction, ipscanningaction = allaction;
		var portscanningaction = allaction, ipshardaction = allaction, ipoptionaction = allaction;
		var sfaction = allaction, landaction = allaction, icmpbpaction = allaction;
		var tcpaction = allaction, dnsaction = allaction, dnsraction = allaction;
	}else{
		var icmpaction = $('#r0').combobox('getValue');//ICMP洪水攻击防护行为
		var udpaction = $('#r1').combobox('getValue');//UDP洪水攻击防护行为
		var arpaction = $('#r2').combobox('getValue');//ARP欺骗攻击防护行为
		var synaction = $('#r3').combobox('getValue');//SYN洪水攻击防护行为
		var ipscanningaction = $('#r4').combobox('getValue');//IP地址扫描攻击防护行为
		var portscanningaction = $('#r5').combobox('getValue');//端口扫描防护行为
		var ipshardaction = $('#r6').combobox('getValue');//IP分片防护行为
		var ipoptionaction = $('#r7').combobox('getValue');//IP选项行为
		var sfaction = $('#r8').combobox('getValue');//Smurf或者Fraggle攻击防护行为
		var landaction = $('#r9').combobox('getValue');//Land攻击防护行为
		var icmpbpaction = $('#r10').combobox('getValue');//ICMP大包攻击防护行为
		var tcpaction = $('#r11').combobox('getValue');//TCP异常行为
		var dnsaction = $('#r12').combobox('getValue');//DNS查询洪水防护行为
		var dnsraction = $('#r13').combobox('getValue');//DNS递归查询洪水攻击防护行为
	}
	
	$('#arpCreateForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/saveArpDomain.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val(); 
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.domainid = domainid;  
	        param.alluser = alluser;
	        param.allaction = allaction;
	        param.icmp = icmp; 
	        param.icmpalert = icmpalert;    
	        param.icmpaction = icmpaction;
	        param.udp = udp;    
	        param.udpsalert = udpsalert; 
	        param.udpdalert = udpdalert;    
	        param.udpaction = udpaction;
	        param.arp = arp;    
	        param.arpaction = arpaction; 
	        param.arpipnumofmac = arpipnumofmac;    
	        param.arppsendrate = arppsendrate;
	        param.arpreverseq = arpreverseq;    
	        param.syn = syn; 
	        param.synsalert = synsalert;    
	        param.synaction = synaction;
	        param.syndalert = syndalert;    
	        param.syndalerttype = syndalerttype; 
	        param.syndalertdatype = syndalertdatype;    
	        param.syndalertdavalue = syndalertdavalue;
	        param.winnuke = winnuke; 
	        param.ipcheat = ipcheat;    
	        param.ipscanning = ipscanning;
	        param.ipscanningalert = ipscanningalert;    
	        param.ipscanningaction = ipscanningaction; 
	        param.portscanning = portscanning;    
	        param.portscanningalert = portscanningalert;
	        param.portscanningaction = portscanningaction;    
	        param.pingofdeath = pingofdeath; 
	        param.treadrop = treadrop;    
	        param.ipshard = ipshard;
	        param.ipshardaction = ipshardaction; 
	        param.ipoption = ipoption;    
	        param.ipoptionaction = ipoptionaction;
	        param.sf = sf;    
	        param.sfaction = sfaction; 
	        param.land = land;    
	        param.landaction = landaction;
	        param.icmpbp = icmpbp;    
	        param.icmpbpalert = icmpbpalert; 
	        param.icmpbpaction = icmpbpaction;    
	        param.synagent = synagent;
	        param.synagentminrate = synagentminrate;    
	        param.synagentmaxrate = synagentmaxrate; 
	        param.syncookie = syncookie;    
	        param.syntimeout = syntimeout;
	        param.tcp = tcp;    
	        param.tcpaction = tcpaction; 
	        param.dns = dns;    
	        param.dnssalert = dnssalert;
	        param.dnsdalert = dnsdalert;    
	        param.dnsaction = dnsaction;
	        param.dnsr = dnsr;    
	        param.dnsrsalert = dnsrsalert; 
	        param.dnsrdalert = dnsrdalert;    
	        param.dnsraction = dnsraction;
	        param.wlist = wlist;  
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){ 
	        	$.messager.alert('提示信息','保存成功！', 'info');    
	        	arploadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        } 
	       $("#editDialog").dialog('destroy');
	    }    

	});  
}
//单记录编辑保存信息
function editdomainarp(){
	var domainid = $('#domainid1').val();//安全域
	var icmpalert = $('#icmpalert1').textbox('getValue');
	var udpsalert = $('#udpsalert1').textbox('getValue');
	var udpdalert = $('#udpdalert1').textbox('getValue');
	var arpipnumofmac = $('#arpipnumofmac1').textbox('getValue');
	var arppsendrate = $('#arppsendrate1').textbox('getValue');
	var arpreverseq = 0;
	var ipscanningalert = $('#ipscanningalert1').textbox('getValue');
	var portscanningalert = $('#portscanningalert1').textbox('getValue');
	var synsalert = $('#synsalert1').textbox('getValue');
	var syndalert = $('#syndalert1').textbox('getValue');
	var syndalerttype = $('#syndalerttype1').combobox('getValue');
	var syndalertdatype = "";
	var syndalertdavalue = "";
	var icmpbpalert = $('#icmpbpalert1').textbox('getValue');
	var synagentminrate = $('#synagentminrate1').textbox('getValue');
	var synagentmaxrate = $('#synagentmaxrate1').textbox('getValue');
	var syntimeout = $('#syntimeout1').textbox('getValue');
	var syncookie = 0;
	var dnssalert = $('#dnssalert1').textbox('getValue');
	var dnsdalert = $('#dnsdalert1').textbox('getValue');
	var dnsrsalert = $('#dnsrsalert1').textbox('getValue');
	var dnsrdalert = $('#dnsrdalert1').textbox('getValue');
	
	var wlist = $("#wlist1").val(); //白名单

	var alluser = 0;//全部启用
	var icmp = 0;//ICMP洪水攻击防护
	var udp = 0;//UDP洪水攻击防护
	var arp = 0;//ARP欺骗攻击防护
	var syn = 0;//SYN洪水攻击防护
	var ipscanning = 0;//IP地址扫描攻击防护
	var portscanning = 0;//端口扫描防护
	var ipshard = 0;//IP分片防护
	var ipoption = 0;//IP选项
	var sf = 0;//Smurf或者Fraggle攻击防护
	var land = 0;//Land攻击防护
	var icmpbp = 0;//ICMP大包攻击防护
	var tcp = 0;//TCP异常
	var dns = 0;//DNS查询洪水防护
	var dnsr = 0;//DNS递归查询洪水攻击防护
	var winnuke = 0;//winnuke攻击防护
	var ipcheat = 0;//ip地址欺骗攻击防护
	var pingofdeath = 0;//pingofdeath攻击防护
	var treadrop = 0;//Treadrop攻击防护
	var synagent = 0;//syn代理

	var state = 0;
	
	if($("#icmp1").hasClass("active")){
		icmp = 1;
		if(null == icmpalert || "" == icmpalert || icmpalert>50000 || icmpalert<1){
			$.messager.alert('提示信息','ICMP洪水攻击防护警戒值(1~50000)', 'info');
			return;
		}
		state++;
	}else{
		icmpalert = 1500;
	}
	if($("#udp1").hasClass("active")){
		udp = 1;
		if(null == udpsalert || "" == udpsalert || udpsalert>300000 || udpsalert<0 ){
			$.messager.alert('提示信息','UDP洪水攻击防护源警戒值(0~300000)', 'info');
			return;
		}
		if(null == udpdalert || "" == udpdalert || udpdalert>300000 || udpdalert<0 ){
			$.messager.alert('提示信息','UDP洪水攻击防护目的警戒值(0~300000)', 'info');
			return;
		}
		state++;
	}else{
		udpsalert = 1500;
		udpdalert = 1500;
	}
	if($("#arp1").hasClass("active")){
		arp = 1;
		if(null == arpipnumofmac || "" == arpipnumofmac || arpipnumofmac>1024 || arpipnumofmac<0 ){
			$.messager.alert('提示信息','每个MAC最大IP数(0~1024)', 'info');
			return;
		}
		if(null == arppsendrate || "" == arppsendrate || arppsendrate>1024 || arppsendrate<0 ){
			$.messager.alert('提示信息','免费ARP包发送速率(0~10)', 'info');
			return;
		}
		if($("#arpreverseq1").hasClass("active")){
			arpreverseq = 1;
		}
		state++;
	}else{
		arpipnumofmac = "0";
		arppsendrate = "0";
	}
	if($("#syn1").hasClass("active")){
		syn = 1;
		if(null == synsalert || "" == synsalert || synsalert>50000 || synsalert<0 ){
			$.messager.alert('提示信息','SYN洪水攻击防护源警戒值(0~50000)', 'info');
			return;
		}
		if(null == syndalert1 || "" == syndalert1 || syndalert1>50000 || syndalert1<0 ){
			$.messager.alert('提示信息','syn洪水攻击防护目的警戒值(0~50000)', 'info');
			return;
		}
		if(syndalerttype==2){
			syndalertdatype = $('#syndalertdatypemodify').combobox('getValue');
			if(syndalertdatype==1){
				/* var syndalertdavaluemodify0 = $('#syndalertdavaluemodify0').textbox('getValue');
				var syndalertdavaluemodify1 = $('#syndalertdavaluemodify1').textbox('getValue');
				syndalertdavalue = syndalertdavaluemodify0+'/'+syndalertdavaluemodify1; */
				
				
				syndalertdavalue = $('#syndalertdavaluemodify0').textbox('getValue') + '/' + transInt($('#syndalertdavaluemodify1').textbox('getValue'));
				if($('#syndalertdavaluemodify0').textbox('getValue')==""){
					$.messager.alert('提示信息','IP地址内容不允许为空！', 'info');
					return;
				}else if(!(checkIP($('#syndalertdavaluemodify0').textbox('getValue')))){
					$.messager.alert('提示信息','IPv4地址格式不正确！', 'info');
					return;
				}else if($('#syndalertdavaluemodify1').textbox('getValue')==""){
					$.messager.alert('提示信息','掩码内容不允许为空！', 'info');
					return;
				}else if($('#syndalertdavaluemodify1').textbox('getValue')!=0&&(!((24<=$('#syndalertdavaluemodify1').textbox('getValue'))&&($('#syndalertdavaluemodify1').textbox('getValue')<=32)))){
					$.messager.alert('提示信息','掩码数据范围：0或者24-32！', 'info');
					return;
				}
			}else{
				syndalertdavalue = $('#syndalertdavaluemodify2').textbox('getValue');
				if(syndalertdavalue==""){
					$.messager.alert('提示信息','地址条目内容不允许为空！', 'info');
					return;
				}
			}
		}
		/*
		if(null == syndalert || "" == syndalert || syndalert>50000 || syndalert<0 ){
			$.messager.alert('提示信息','SYN洪水攻击防护目的警戒值(0~50000)', 'info');
			return;
		}
		*/
		syndalert = 1500; //临时（由于界面效果缺失，暂时处理，以后删除）
		state++;
	}else{
		syndalerttype = 1;
		synsalert = 1500;
		syndalert = 1500;
	}
	if($("#ipscanning1").hasClass("active")){
		ipscanning = 1;
		if(null == ipscanningalert || "" == ipscanningalert || ipscanningalert>5000 || ipscanningalert<0 ){
			$.messager.alert('提示信息','IP地址扫描攻击防护警戒值(0~5000)', 'info');
			return;
		}
		state++;
	}else{
		ipscanningalert = 1;
	}
	if($("#portscanning1").hasClass("active")){
		portscanning = 1;
		if(null == portscanningalert || "" == portscanningalert || portscanningalert>5000 || portscanningalert<0 ){
			$.messager.alert('提示信息','端口扫描防护警戒值(0~5000)', 'info');
			return;
		}
		state++;
	}else{
		portscanningalert = 1;
	}
	if($("#ipshard1").hasClass("active")){
		ipshard = 1;
		state++;
	}
	if($("#ipoption1").hasClass("active")){
		ipoption = 1;
		state++;
	}
	if($("#sf1").hasClass("active")){
		sf = 1;
		state++;
	}
	if($("#land1").hasClass("active")){
		land = 1;
		state++;
	}
	if($("#icmpbp1").hasClass("active")){
		icmpbp = 1;
		if(null == icmpbpalert || "" == icmpbpalert || icmpbpalert>50000 || icmpbpalert<1 ){
			$.messager.alert('提示信息','ICMP大包攻击防护源警戒值(1~50000)', 'info');
			return;
		}
		state++;
	}else{
		icmpbpalert = 1024;
	}
	if($("#synagent1").hasClass("active")){
		synagent = 1;
		if(null == synagentminrate || "" == synagentminrate || synagentminrate>50000 || synagentminrate<0 ){
			$.messager.alert('提示信息','SYN代理最小代理速率(0~50000)', 'info');
			return;
		}
		if(null == synagentmaxrate || "" == synagentmaxrate || synagentmaxrate>300000 || synagentmaxrate<0 ){
			$.messager.alert('提示信息','SYN代理最大代理速率(0~300000)', 'info');
			return;
		}
		if(synagentminrate > synagentmaxrate){
			$.messager.alert('提示信息','SYN代理最小代理速率不可以大于最大代理速率', 'info');
			return;			
		}
		if(null == syntimeout || "" == syntimeout || syntimeout>180 || syntimeout<1 ){
			$.messager.alert('提示信息','SYN代理超时范围(1~180)', 'info');
			return;
		}
		if($("#syncookie1").hasClass("active")){
			syncookie = 1;
		}
		state++;
	}else{
		synagentminrate = 1000;
		synagentmaxrate = 3000;
		syntimeout = 30;
		
	}
	if($("#tcp1").hasClass("active")){
		tcp = 1;
		state++;
	}
	if($("#dns1").hasClass("active")){
		dns = 1;
		if(null == dnssalert || "" == dnssalert || dnssalert>300000 || dnssalert<0 ){
			$.messager.alert('提示信息','DNS查询洪水防护源警戒值(0~300000)', 'info');
			return;
		}
		if(null == dnsdalert || "" == dnsdalert || dnsdalert>300000 || dnsdalert<0 ){
			$.messager.alert('提示信息','DNS查询洪水防护源目的警戒值(0~300000)', 'info');
			return;
		}
		state++;
	}else{
		dnssalert = 1500;
		dnsdalert = 1500;
	}
	if($("#dnsr1").hasClass("active")){
		dnsr = 1;
		if(null == dnsrsalert || "" == dnsrsalert || dnsrsalert>300000 || dnsrsalert<0 ){
			$.messager.alert('提示信息','DNS递归查询洪水攻击防护警戒值(0~300000)', 'info');
			return;
		}
		if(null == dnsrdalert || "" == dnsrdalert || dnsrdalert>300000 || dnsrdalert<0 ){
			$.messager.alert('提示信息','DNS递归查询洪水攻击防护警戒值(0~300000)', 'info');
			return;
		}
		state++;
	}else{
		dnsrsalert = 1000;
		dnsrdalert = 1000;
	}
	if($("#winnuke1").hasClass("active")){
		winnuke = 1;
		state++;
	}
	if($("#ipcheat1").hasClass("active")){
		ipcheat = 1;
		state++;
	}
	if($("#pingofdeath1").hasClass("active")){
		pingofdeath = 1;
		state++;
	}
	if($("#treadrop1").hasClass("active")){
		treadrop = 1;
		state++;
	}
	if(state==19){
		alluser = 1;
	}

	var allaction = $('#allaction1').combobox('getValue');//全部行为
	if(null != allaction && "" != allaction){
		var icmpaction = allaction, udpaction = allaction, arpaction = allaction;
		var synaction = allaction, ipscanningaction = allaction;
		var portscanningaction = allaction, ipshardaction = allaction, ipoptionaction = allaction;
		var sfaction = allaction, landaction = allaction, icmpbpaction = allaction;
		var tcpaction = allaction, dnsaction = allaction, dnsraction = allaction;
	}else{
		var icmpaction = $('#_r0').combobox('getValue');//ICMP洪水攻击防护行为
		var udpaction = $('#_r1').combobox('getValue');//UDP洪水攻击防护行为
		var arpaction = $('#_r2').combobox('getValue');//ARP欺骗攻击防护行为
		var synaction = $('#_r3').combobox('getValue');//SYN洪水攻击防护行为
		var ipscanningaction = $('#_r4').combobox('getValue');//IP地址扫描攻击防护行为
		var portscanningaction = $('#_r5').combobox('getValue');//端口扫描防护行为
		var ipshardaction = $('#_r6').combobox('getValue');//IP分片防护行为
		var ipoptionaction = $('#_r7').combobox('getValue');//IP选项行为
		var sfaction = $('#_r8').combobox('getValue');//Smurf或者Fraggle攻击防护行为
		var landaction = $('#_r9').combobox('getValue');//Land攻击防护行为
		var icmpbpaction = $('#_r10').combobox('getValue');//ICMP大包攻击防护行为
		var tcpaction = $('#_r11').combobox('getValue');//TCP异常行为
		var dnsaction = $('#_r12').combobox('getValue');//DNS查询洪水防护行为
		var dnsraction = $('#_r13').combobox('getValue');//DNS递归查询洪水攻击防护行为
	}
	
	$('#arpCreateForm1').form('submit', {    
	    url:"${pageContext.request.contextPath}/security/arpUpdate.do",    
	    onSubmit: function(param){ 
	     	param.securityid = $("#tabs_security_id").val();
	    	param.objectid = $("#tabs_service_id").val();
	    	param.displayname = $("#tabs_displayname").val();
	    	param.manip = $("#tabs_manip").val();
	        param.domainid = domainid;  
	        param.alluser = alluser;
	        param.allaction = allaction;
	        param.icmp = icmp; 
	        param.icmpalert = icmpalert;    
	        param.icmpaction = icmpaction;
	        param.udp = udp;    
	        param.udpsalert = udpsalert; 
	        param.udpdalert = udpdalert;    
	        param.udpaction = udpaction;
	        param.arp = arp;    
	        param.arpaction = arpaction; 
	        param.arpipnumofmac = arpipnumofmac;    
	        param.arppsendrate = arppsendrate;
	        param.arpreverseq = arpreverseq;    
	        param.syn = syn; 
	        param.synsalert = synsalert;    
	        param.synaction = synaction;
	        param.syndalert = syndalert;    
	        param.syndalerttype = syndalerttype; 
	        param.syndalertdatype = syndalertdatype;    
	        param.syndalertdavalue = syndalertdavalue;
	        param.winnuke = winnuke; 
	        param.ipcheat = ipcheat;    
	        param.ipscanning = ipscanning;
	        param.ipscanningalert = ipscanningalert;    
	        param.ipscanningaction = ipscanningaction; 
	        param.portscanning = portscanning;    
	        param.portscanningalert = portscanningalert;
	        param.portscanningaction = portscanningaction;    
	        param.pingofdeath = pingofdeath; 
	        param.treadrop = treadrop;    
	        param.ipshard = ipshard;
	        param.ipshardaction = ipshardaction; 
	        param.ipoption = ipoption;    
	        param.ipoptionaction = ipoptionaction;
	        param.sf = sf;    
	        param.sfaction = sfaction; 
	        param.land = land;    
	        param.landaction = landaction;
	        param.icmpbp = icmpbp;    
	        param.icmpbpalert = icmpbpalert; 
	        param.icmpbpaction = icmpbpaction;    
	        param.synagent = synagent;
	        param.synagentminrate = synagentminrate;    
	        param.synagentmaxrate = synagentmaxrate; 
	        param.syncookie = syncookie;    
	        param.syntimeout = syntimeout;
	        param.tcp = tcp;    
	        param.tcpaction = tcpaction; 
	        param.dns = dns;    
	        param.dnssalert = dnssalert;
	        param.dnsdalert = dnsdalert;    
	        param.dnsaction = dnsaction;
	        param.dnsr = dnsr;    
	        param.dnsrsalert = dnsrsalert; 
	        param.dnsrdalert = dnsrdalert;    
	        param.dnsraction = dnsraction;
	        param.wlist = wlist;  //白名单
	    },  
		success: function(retr){    
			var data = $.parseJSON(retr);   
	        if (data.success){
	        	$.messager.alert('提示信息','保存成功！', 'info');    
	        	arploadDataGrid();   
	        } else{
	        	$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
	        }  
			$("#editDialog").dialog('destroy');
	    }    

	});  
}



//打开白名单设置窗口
function choosewlist(oper, type){
	//先清空
	$('#wlistForm').form('clear');
	$("#data_wlist  tr:not(:first)").remove();
	
	//再赋值
	var temp = "";
	if(oper == 'edit'){
		temp = "1";
 	}
	var str = $("#wlist" + temp).val();
	var strArr = str.split(";");
	for(var i=0;i<strArr.length-1;i++){
		var sArr = strArr[i].split(",");
		var contypeid = sArr[1];
		var contypename = "";
		if("1" == contypeid){
			contypename = "IP/掩码";
		}else if("2" == contypeid){
			contypename = "地址条目";
		}
		var val = sArr[0];
		var trHtml = "<tr class='tr'><td  style='display:none;'>" + contypeid + "</td><td  style='text-align:center;width:5%;'>" + contypename + "</td><td  style='text-align:center;width:15%;'>" + val + "</td><td  style='text-align:center;width:5%;'><a class='j-delete'  style='cursor: pointer;' onclick='delwilist(this.parentElement.parentElement.rowIndex)'></a></td></tr>";
		var $tr=$("#data_wlist tr:last"); 
		$tr.after(trHtml);
	}
	
	$('#oper_wlist').val(oper);//操作，add/edit
	$('#type_wlist').val(type);//地址类型，s/d
	$('.j-delete').linkbutton({
		 iconCls: 'icon-delete',
	     plain: true
	});
	$('#wlistConfig').window('open');
}

//所有白名单设置回填
 function wilisttj(){
	var addrstr = '';
	var addrstrv = '';
	var i =0;
	$("#data_wlist .tr").each(function(){
		addrstr += $(this).children().eq(2).text() + ",";
		addrstrv += $(this).children().eq(2).text() + "," + $(this).children().eq(0).text() + ";"; 
		i++;
	});
	addrstr = addrstr.substring(0, addrstr.length-1);
	var temp = "";
	if($('#oper_wlist').val() == 'edit'){
		temp = "1";
	}
	$("#wlist" + temp).val(addrstrv);
	$("#wilist_display" + temp).textbox('setValue', addrstr).textbox('setText', addrstr);
	$('#wlistConfig').window('close');
}

//白名单添加
function addwlist(contypeid, contypename){
	var flag =0;
	var val = "";
	if('2' == contypeid && contypename!=""){
		val = $('#0wlisttype0').textbox('getValue'); 
		if(val==""){
			$.messager.alert('提示信息','内容不允许为空！', 'info');
			return;
		}
	}else if('1' == contypeid && contypename!=""){
		val = $('#0wlisttype1').textbox('getValue') + '/' + transInt($('#1wlisttype1').textbox('getValue'));
		if($('#0wlisttype1').textbox('getValue')=="" || $('#1wlisttype1').textbox('getValue')==""){
			$.messager.alert('提示信息','内容不允许为空！', 'info');
			return;
		}
	}
	//校验
	$("#data_wlist .tr").each(function(){
		if(contypeid==2 && val==$(this).children().eq(2).text()){//校验地址条目
			flag = 1;  
		}
		if(contypeid==1){   //校验ip掩码
			var str = $(this).children().eq(2).text().split("/");
			if(str[0]==$('#0wlisttype1').textbox('getValue') || str[1] == transInt($('#1wlisttype1').textbox('getValue'))){  
				flag = 2;
			}
			else if(!(checkIP($('#0wlisttype1').textbox('getValue')) && checkMask($('#1wlisttype1').textbox('getValue')))){
				flag = 3;
			}
		}
	});
	if(flag==0){
		var trHtml = "<tr class='tr'><td  style='display:none;'>" + contypeid + "</td><td  style='text-align:center;width:5%;'>" + contypename + "</td><td style='text-align:center;width:15%;'>" + val + "</td><td  style='text-align:center;width:5%;'><a class='j-delete'  style='cursor: pointer;' onclick='delwilist(this.parentElement.parentElement.rowIndex)'></a></td></tr>";
		var $tr=$("#data_wlist tr:last"); 
		$tr.after(trHtml);
		$('#0wlisttype1').textbox('setValue',""); 
		$('#1wlisttype1').textbox('setValue',"");
		$('#0wlisttype0').textbox('setValue',null);
	}else{
		if(flag==1){
			$.messager.alert('提示信息','与'+val+'重复！', 'info');
			return;
		}else if(flag==2){
			$.messager.alert('提示信息','存在相同的防护规则！', 'info');
			return;
		}else if(flag==3){
			$.messager.alert('提示信息','ip或掩码不符合格式要求！', 'info');
			return;
		}
	}
	$('.j-delete').linkbutton({
		 iconCls: 'icon-delete',
	     plain: true
	});
}

function delwilist(rowIndex){
	document.getElementById("data_wlist").deleteRow(rowIndex); 
}

function checkIP(ip) 
{ 
	if(ip==null || ip ==""){
		return false;
	}
	var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/; 
	if(!exp.exec(ip)) 
	{ 
		return false;//不合法 
	} 
	else 
	{ 
		return true; //合法 
	} 
} 

function checkMask(mask) 
{ 
	var flag = true;
	if(mask==null || mask ==""){
		flag = false ;
	}
	if(mask.indexOf(".")==-1 ){
		if(mask<0 || mask >32){
			flag = false ;
		}
	}else{
		var exp=/^(254|252|248|240|224|192|128|0)\.0\.0\.0|255\.(254|252|248|240|224|192|128|0)\.0\.0|255\.255\.(254|252|248|240|224|192|128|0)\.0|255\.255\.255\.(254|252|248|240|224|192|128|0)$/; 
		if(!exp.exec(mask)){
			flag = false;
		}
	}
	return flag;
} 

//掩码转换整数
function transInt(IP){
	if(IP.indexOf(".")==-1&&Number(IP)){
			return Number(IP);
	}
	return 1 * (1 + IP.replace(/\d+\.?/ig, function(a) {
			a = parseInt(a).toString(2);
			return a;
		}).lastIndexOf('1'));
}

//安全域选择校验
$('#domainMy').combobox({
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
            });
        } else {
            $('#addarp').linkbutton("enable");
        }
    }
});


      
   //新增攻击防护
   function newArpw() {
   	$('#arpCreateForm').form('clear');
   	//默认值
   	$('#allStart').addClass("active");
    if($('#allStart').hasClass("active")){
		$('#allStart').click();
    }
   	$('#icmp').click();
   	$('#icmpalert').textbox('setValue', '1500');
   	$('#udp').click();
   	$('#udpsalert').textbox('setValue', '1500');
   	$('#udpdalert').textbox('setValue', '1500');
   	$('#arpipnumofmac').textbox('setValue', '0');
   	$('#arppsendrate').textbox('setValue', '0');
   	$('#syn').click();
   	$('#synsalert').textbox('setValue', '1500');
   	$('#syndalert').textbox('setValue', '1500');
   	$('#winnuke').click();
   	$('#ipcheat').click();
   	$('#ipscanning').click();
   	$('#ipscanningalert').textbox('setValue', '1');
   	$('#portscanning').click();
   	$('#portscanningalert').textbox('setValue', '1');
   	$('#pingofdeath').click();
   	$('#treadrop').click();
   	$('#ipshard').click();
   	$('#ipoption').click();
   	$('#sf').click();
   	$('#land').click();
   	$('#icmpbpalert').textbox('setValue', '1024');
   	$('#synagentminrate').textbox('setValue', '1000');
   	$('#synagentmaxrate').textbox('setValue', '3000');
   	$('#dnssalert').textbox('setValue', '1500');
   	$('#dnsdalert').textbox('setValue', '1500');
   	$('#dnsrsalert').textbox('setValue', '1000');
   	$('#dnsrdalert').textbox('setValue', '1000');
   	$('#syntimeout').textbox('setValue', '30');
   	document.getElementById('port').style.display='none';
   	
   	
   	$('#domainid').val('');
   	$('#domainMy').combobox('setValue', "");
	$('#allaction').combobox('setValue', '');
   	$('#syndalerttype').combobox('setValue', 1);
   	$('#syndalertdatype').combobox('setValue', 1);
   	$("#arpCreateForm  select[id^='r']").each(function () {
		$(this).combobox('setValue', '0');
	});
   	$('#addOrEdit').val("add");
    	$('#arpw').attr('style','visibility:visible');
       	$('#arpw').dialog({
           closed: false
     });
   }


</script>
<form id="manForm"></form>
<div data-options="region:'center',border:false">
	<table title="" style="width:100%;"  id="arp_grid">
		<thead>
			<tr>
				<th data-options="field:'domainname',width:10,align:'center'">防护安全域</th>
				<th data-options="field:'usestat',width:10,align:'center',formatter:arpusestatformatter">攻击防护状态</th>
				<th data-options="field:'etime',width:10,align:'center'">修改时间</th>
				<th data-options="field:'ctime',width:10,align:'center'">创建时间</th>
				<th data-options="field:'domainid',width:10,align:'center',formatter:arpfwoptionformater">操作</th>
			</tr>
		</thead>
	</table>
</div>  
<input type="hidden" id="addOrEdit"/>
<!-- 弹层 -->
<!-- 新增防护配置 -->
<div id="arpw" class="pop"   style="visibility: hidden;">
    <div style="padding:10px  0">
    	<form id="arpCreateForm" method="post" data-options="novalidate:true">
        <table width="100%" border="0" class="table-layout">
            <tr>
                <td width="12%" align="right">安全域：</td>
                <td width="20%" align="left">
                	<input type="hidden" id="domainid"/>
                    <select class="easyui-combobox"  id="domainMy" style="width: 170px;" data-options="panelHeight:'auto',editable:false">
                    	<option value="">请选择</option>
                        <option value="trust">trust</option>
                        <option value="untrust">untrust</option>
                    </select>
                </td>
                <td width="12%" align="right">白名单：</td>
                <td>
                	<input type="hidden" id="wlist" name="wlist"/>
                	<input id="wilist_display" class="easyui-textbox" style="width:174px;"  data-options="editable:false">
                    <span style="position: relative; top: 4px;left: 8px; cursor: pointer;" onclick="choosewlist('add', 'd');"><img src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
                </td>
            </tr>
        </table>
        <p class="spanceline"></p>
        <div class="tree-tab-box">
            <div class="title">
                <a href="javascript:void(0)" style="width: 160px;" class=" default-btn-demo2  " id="allStart">全部启用</a> &nbsp;&nbsp;&nbsp;&nbsp;行为：
                <select class="easyui-combobox" id="allaction" style="width: 170px;" data-options="panelHeight:'auto',editable:false">
                	 <option value="">--</option>
                     <option value="0">丢弃</option>
                     <option value="1">告警</option>
                </select>
            </div>
            <div class="content">
                <div class="tree-tab j-tree-tab">
                    <ul>
                        <li class="active">
                            <input type="checkbox">
                            <label for="">Flood防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">MS-Windows防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">扫描/欺骗防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">拒绝服务防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">代理</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">协议异常报告</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">DNS查询洪水防护</label>
                        </li>
                    </ul>
                </div>
                <div class="tabcon">
                    <div id="tabcon1">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" id="icmp" style="width: 150px;" class="default-btn-demo2 j-btn-toggle  ">ICMP洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">警戒值：</td>
                                    <td width="23%">
                                        <input   id="icmpalert" style="width:120px;"  prompt="1-50,000" class="easyui-textbox" data-options="min:1,precision:0">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select class="easyui-combobox"  id="r0" style="width: 120px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" rowspan="2" align="right">
                                        <a href="javascript:void(0)" id="udp" style="width: 150px;" class="default-btn-demo2 j-btn-toggle  ">UDP洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="udpsalert"  class="easyui-textbox"  prompt="0-300,000" style="width:120px;" >
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select class="easyui-combobox" id="r1" style="width: 120px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr class=" ">
                                    <td align="right">目的警戒值：</td>
                                    <td>
                                        <input id="udpdalert"  class="easyui-textbox" prompt="0-300,000"  style="width:120px;"  >
                                    </td>
                                    <td></td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" rowspan="2" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="arp" class="default-btn-demo2 j-btn-toggle  ">ARP欺骗攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">每个MAC最大IP数：</td>
                                    <td width="23%">
                                        <input id="arpipnumofmac" class="easyui-textbox" prompt="0-1024"  style="width:120px;">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="r2" class="easyui-combobox" style="width: 120px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr >
                                    <td align="right">免费ARP包发送速率：</td>
                                    <td>
                                        <input id="arppsendrate" class="easyui-textbox" style="width:120px;" prompt="0-10"  >
                                    </td>
                                    <td> </td>
                                    <td>    
										<input id="arpreverseq" class="default-btn-demo2  j-yesno" style="width: 120px;" disabled type="button"  value="反向查询" />                                                           
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3" style="border-bottom:none;">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" rowspan="2" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="syn"  class="default-btn-demo2 j-btn-toggle  ">SYN洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="synsalert" class="easyui-textbox" style="width:120px;" prompt="0-50,000">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="r3" class="easyui-combobox" style="width: 120px" data-options="panelHeight:'auto',editable:false">
				                            <option value="0">丢弃</option>
				                            <option value="1">告警</option>
				                        </select>
                                    </td>
                                </tr>
                                  
                                <tr class=" ">
                                    <td align="right">目的警戒值：</td>
                                    <td>
                                        <select id="syndalerttype" class="easyui-combobox" style="width:120px;" data-options="panelHeight:'auto',editable:false,onSelect: 
										function(rec){
												if(rec.value==1){
												    document.getElementById('port').style.display='none';
												}else{
												    document.getElementById('port').style.display=''; 
												}
									    }">
				                            <option value="1">基于IP</option>
				                            <option value="2">基于端口</option>
				                        </select>
                                    </td>
                                    <td></td>
                                    <td>
                                        <input  id="syndalert" class="easyui-textbox" prompt="0-50,000" style="width: 120px">
                                    </td>
                                </tr>
                                <tr id="port" style="display:none;">
                                   <td style="width: 150px;"></td>
                                   <td style="" align="right">目的地址：</td>
                                   <td>
								    <select id="syndalertdatype" class="easyui-combobox" style="width:120px;" data-options="panelHeight:'auto',editable:false,onSelect: 
										function(rec){
												
									            document.getElementById('ipaddress1').style.display='none';
									            document.getElementById('ipaddress2').style.display='none';
							                    document.getElementById('addressentry').style.display='none';
							                    if(rec.value==1){
							                       document.getElementById('ipaddress1').style.display='';
									               document.getElementById('ipaddress2').style.display='';
							                    }else{
							                       document.getElementById('addressentry').style.display='';
							                    }
								                
									    }">
				                            <option value="1">IP地址</option>
				                            <!-- <option value="2">地址条目</option> -->        <!-- 临时隐藏 -->
				                        </select>
							       </td> 
							       <td><div id="ipaddress1"><input  id="0syndalertdavalue0" class="easyui-textbox" prompt="IPv4地址" style="width:100px;height:22px;"/></div></td>
							       <td>
									  <div id="ipaddress2">
									     /&nbsp;&nbsp;<input id="0syndalertdavalue1" class="easyui-textbox" prompt="0或者24-32" style="width:106px;height:22px;"/>
									  </div>
									  <div id="addressentry" style="display:none;">
											<select id="0syndalertdavalue2" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#0wlisttype0').val(rec.value);}">
												<option value="Any">Any</option>
												<option value="monitor_address">monitor_address</option>
												<option value="private_network">private_network</option>
											</select>
									  </div>
							       </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon2" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="winnuke" class="default-btn-demo2 j-btn-toggle  ">WinNuke攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon3" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="ipcheat" class="default-btn-demo2 j-btn-toggle  ">ip地址欺骗攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;"  id="ipscanning" class="default-btn-demo2 j-btn-toggle  ">ip地址扫描攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">警戒值：</td>
                                    <td width="23%">
                                        <input id="ipscanningalert" class="easyui-textbox" prompt="0-5,000" style="width:120px;" >
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="r4" class="easyui-combobox"  style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="portscanning" class="default-btn-demo2 j-btn-toggle  ">端口扫描防护</a>
                                    </td>
                                    <td width="22%" align="right">警戒值：：</td>
                                    <td width="23%">
                                        <input id="portscanningalert" class="easyui-textbox" prompt="0-5,000" style="width:120px;" >
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="r5" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon4" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="pingofdeath" class="default-btn-demo2 j-btn-toggle  ">Ping of Death攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="treadrop" class="default-btn-demo2 j-btn-toggle  "> Teardrop攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="ipshard" class="default-btn-demo2 j-btn-toggle  ">ip分片防护</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="r6" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	 <option value="0">丢弃</option>
                        					 <option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="ipoption" class="default-btn-demo2 j-btn-toggle  ">ip选项</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="r7" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="sf" class="default-btn-demo2 j-btn-toggle  ">Smurf或者Fraggle攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="r8" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="land" class="default-btn-demo2 j-btn-toggle  ">Land攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="r9" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3" style="border-bottom: none;">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="icmpbp" class="default-btn-demo2 j-btn-toggle  ">ICMP大包攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="icmpbpalert" class="easyui-textbox"  style="width:120px;" prompt="0-50,000">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="r10" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon5" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right" rowspan="2">
                                        <a href="javascript:void(0)" style="width: 150px;" id="synagent" class="default-btn-demo2 j-btn-toggle  ">SYN代理</a>
                                    </td>
                                    <td width="22%" align="right">最小代理速率：</td>
                                    <td width="23%">
                                        <input id="synagentminrate" class="easyui-textbox" style="width:120px;" prompt="0-50,000">
                                    </td>
                                    <td width="12%" align="right"></td>
                                    <td>
                                    <input type="button" style="width: 130px;" id="syncookie" class="default-btn-demo2  active j-yesno" value="cookie">
                                      
                                    </td>
                                </tr>
                                <tr>
                                    <td width="22%" align="right">最大代理速率：</td>
                                    <td width="23%">
                                        <input id="synagentmaxrate" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td width="12%" align="right">代理超时：</td>
                                    <td>
                                        <input id="syntimeout" class="easyui-textbox" style="width:120px;" prompt="1-180">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon6" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="tcp" class="default-btn-demo2 j-btn-toggle  ">TCP异常</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td>
                                        <select id="r11" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon7" style="display: none">
                        <div class="item3" style="">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right" rowspan="2">
                                        <a href="javascript:void(0)" style="width: 150px;" id="dns" class="default-btn-demo2 j-btn-toggle  ">DNS查询洪水防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="dnssalert" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td>
                                        <select id="r12" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="22%" align="right">目的警戒值：</td>
                                    <td width="23%">
                                        <input id="dnsdalert" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right" rowspan="2">
                                        <a href="javascript:void(0)" style="width: 150px;" id="dnsr" class="default-btn-demo2 j-btn-toggle  ">DNS递归查询洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="dnsrsalert" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td>
                                        <select id="r13" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="22%" align="right">目的警戒值：</td>
                                    <td width="23%">
                                        <input id="dnsrdalert" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>
<!-- 修改防护配置 -->
<div id="arpw1" class="pop"   style="visibility: hidden;">
    <div style="padding:10px  0">
    	<form id="arpCreateForm1" method="post" data-options="novalidate:true">
        <table width="100%" border="0" class="table-layout">
            <tr>
                <td width="12%" align="right">安全域：</td>
                <td width="20%" align="left">
                	<input type="hidden" id="domainid1"/>
                    <select class="easyui-combobox"  id="domain1" style="width: 170px;" data-options="panelHeight:'auto',editable:false,disabled:true">
                    	<option value="">请选择</option>
                        <option value="trust">trust</option>
                        <option value="untrust">untrust</option>
                    </select>
                </td>
                <td width="12%" align="right">白名单：</td>
                <td>
                	<input type="hidden" id="wlist1" name="wlist1"/>
                	<input id="wilist_display1" class="easyui-textbox" style="width:174px;"  data-options="editable:false">
                    <span style="position: relative; top: 4px;left: 8px; cursor: pointer;" onclick="choosewlist('edit', 'd');"><img src="/icpmg/easyui-1.4/themes/icons/edit_add.png"></span>
                </td>
            </tr>
        </table>
        <p class="spanceline"></p>
        <div class="tree-tab-box">
            <div class="title">
                <a href="javascript:void(0)" style="width: 160px;" class=" default-btn-demo2  " id="allStart1">全部启用</a> &nbsp;&nbsp;&nbsp;&nbsp;行为：
                <select class="easyui-combobox" id="allaction1" style="width: 170px;" data-options="panelHeight:'auto',editable:false">
                	 <option value="">--</option>
                     <option value="0">丢弃</option>
                     <option value="1">告警</option>
                </select>
            </div>
            <div class="content">
                <div class="tree-tab j-tree-tab">
                    <ul>
                        <li class="active">
                            <input type="checkbox">
                            <label for="">Flood防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">MS-Windows防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">扫描/欺骗防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">拒绝服务防护</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">代理</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">协议异常报告</label>
                        </li>
                        <li>
                            <input type="checkbox">
                            <label for="">DNS查询洪水防护</label>
                        </li>
                    </ul>
                </div>
                <div class="tabcon">
                    <div id="tabcon1_">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" id="icmp1" style="width: 150px;" class="default-btn-demo2 j-btn-toggle  ">ICMP洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">警戒值：</td>
                                    <td width="23%">
                                        <input   id="icmpalert1" style="width:120px;"  prompt="1-50,000" class="easyui-textbox" data-options="min:1,precision:0">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select class="easyui-combobox"  id="_r0" style="width: 120px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" rowspan="2" align="right">
                                        <a href="javascript:void(0)" id="udp1" style="width: 150px;" class="default-btn-demo2 j-btn-toggle  ">UDP洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="udpsalert1"  class="easyui-textbox"  prompt="0-300,000" style="width:120px;" >
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select class="easyui-combobox" id="_r1" style="width: 120px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr class=" ">
                                    <td align="right">目的警戒值：</td>
                                    <td>
                                        <input id="udpdalert1"  class="easyui-textbox" prompt="0-300,000"  style="width:120px;"  >
                                    </td>
                                    <td></td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" rowspan="2" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="arp1" class="default-btn-demo2 j-btn-toggle  ">ARP欺骗攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">每个MAC最大IP数：</td>
                                    <td width="23%">
                                        <input id="arpipnumofmac1" class="easyui-textbox" prompt="0-1024"  style="width:120px;">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="_r2" class="easyui-combobox" style="width: 120px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr >
                                    <td align="right">免费ARP包发送速率：</td>
                                    <td>
                                        <input id="arppsendrate1" class="easyui-textbox" style="width:120px;" prompt="0-10"  >
                                    </td>
                                    <td> </td>
                                    <td>    
										<input id="arpreverseq1" class="default-btn-demo2  j-yesno" style="width: 120px;" disabled type="button"  value="反向查询" />                                                           
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3" style="border-bottom:none;">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" rowspan="2" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="syn1"  class="default-btn-demo2 j-btn-toggle  ">SYN洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="synsalert1" class="easyui-textbox" style="width:120px;" prompt="0-50,000">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="_r3" class="easyui-combobox" style="width: 120px" data-options="panelHeight:'auto',editable:false">
				                            <option value="0">丢弃</option>
				                            <option value="1">告警</option>
				                        </select>
                                    </td>
                                </tr>
                                <tr class=" ">
                                    <td align="right">目的警戒值：</td>
                                    <td>
                                        <select id="syndalerttype1" class="easyui-combobox" style="width:120px;" data-options="panelHeight:'auto',editable:false,onSelect: 
										function(rec){
												if(rec.value==1){
												    document.getElementById('portmodify').style.display='none';
												}else{
												    document.getElementById('portmodify').style.display=''; 
					
												}
									    }">
				                            <option value="1">基于IP</option>
				                            <option value="2">基于端口</option>
				                        </select>
                                    </td>
                                    <td></td>
                                    <td>
                                        <input  id="syndalert1" class="easyui-textbox" prompt="0-50,000" style="width:120px;">
                                    </td>
                                </tr>
                                <tr id="portmodify" style="display:none;">
                                   <td style="width: 150px;"></td>
                                   <td style="" align="right">目的地址：</td>
                                   <td>
								    <select id="syndalertdatypemodify" class="easyui-combobox" style="width:120px;" data-options="panelHeight:'auto',editable:false,onSelect: 
										function(rec){
												
									            document.getElementById('ipaddressmodify1').style.display='none';
									            document.getElementById('ipaddressmodify2').style.display='none';
							                    document.getElementById('addressentrymodify').style.display='none';
							                    if(rec.value==1){
							                       document.getElementById('ipaddressmodify1').style.display='';
									               document.getElementById('ipaddressmodify2').style.display='';
							                    }else{
							                       document.getElementById('addressentrymodify').style.display='';
							                    }
								                
									    }">
				                            <option value="1">IP地址</option>
				                            <!-- <option value="2">地址条目</option> -->        <!--临时隐藏  -->
				                        </select>
							       </td> 
							       <td><div id="ipaddressmodify1" style="display:none;"><input  id="syndalertdavaluemodify0" prompt="IPv4地址" class="easyui-textbox" style="width:100px;height:22px;"/></div></td>
							       <td>
									  <div id="ipaddressmodify2" style="display:none;">
									     /&nbsp;&nbsp;<input id="syndalertdavaluemodify1" prompt="0或者24-32" class="easyui-textbox" style="width:106px;height:22px;"/>
									  </div>
									  <div id="addressentrymodify" style="display:none;">
											<select id="syndalertdavaluemodify2" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#0wlisttype0').val(rec.value);}">
												<option value="Any">Any</option>
												<option value="monitor_address">monitor_address</option>
												<option value="private_network">private_network</option>
											</select>
									  </div>
							       </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon2_" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="winnuke1" class="default-btn-demo2 j-btn-toggle  ">WinNuke攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon3_" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="ipcheat1" class="default-btn-demo2 j-btn-toggle  ">ip地址欺骗攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;"  id="ipscanning1" class="default-btn-demo2 j-btn-toggle  ">ip地址扫描攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">警戒值：</td>
                                    <td width="23%">
                                        <input id="ipscanningalert1" class="easyui-textbox" prompt="0-5,000" style="width:120px;" >
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="_r4" class="easyui-combobox"  style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="portscanning1" class="default-btn-demo2 j-btn-toggle  ">端口扫描防护</a>
                                    </td>
                                    <td width="22%" align="right">警戒值：：</td>
                                    <td width="23%">
                                        <input id="portscanningalert1" class="easyui-textbox" prompt="0-5,000" style="width:120px;" >
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="_r5" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon4_" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="pingofdeath1" class="default-btn-demo2 j-btn-toggle  ">Ping of Death攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="treadrop1" class="default-btn-demo2 j-btn-toggle  "> Teardrop攻击防护</a>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="ipshard1" class="default-btn-demo2 j-btn-toggle  ">ip分片防护</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="_r6" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	 <option value="0">丢弃</option>
                        					 <option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="ipoption1" class="default-btn-demo2 j-btn-toggle  ">ip选项</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="_r7" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="sf1" class="default-btn-demo2 j-btn-toggle  ">Smurf或者Fraggle攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="_r8" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="land1" class="default-btn-demo2 j-btn-toggle  ">Land攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td width="23%">
                                        <select id="_r9" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3" style="border-bottom: none;">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="icmpbp1" class="default-btn-demo2 j-btn-toggle  ">ICMP大包攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="icmpbpalert1" class="easyui-textbox"  style="width:120px;" prompt="0-50,000">
                                    </td>
                                    <td width="12%" align="right">行为：</td>
                                    <td>
                                        <select id="_r10" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon5_" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right" rowspan="2">
                                        <a href="javascript:void(0)" style="width: 150px;" id="synagent1" class="default-btn-demo2 j-btn-toggle  ">SYN代理</a>
                                    </td>
                                    <td width="22%" align="right">最小代理速率：</td>
                                    <td width="23%">
                                        <input id="synagentminrate1" class="easyui-textbox" style="width:120px;" prompt="0-50,000">
                                    </td>
                                    <td width="12%" align="right"></td>
                                    <td>
                                    	<input type="button" style="width: 130px;" id="syncookie1" class="default-btn-demo2  active j-yesno" value="cookie">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="22%" align="right">最大代理速率：</td>
                                    <td width="23%">
                                        <input id="synagentmaxrate1" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td width="12%" align="right">代理超时：</td>
                                    <td>
                                        <input id="syntimeout1" class="easyui-textbox" style="width:120px;" prompt="1-180">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon6_" style="display: none">
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right">
                                        <a href="javascript:void(0)" style="width: 150px;" id="tcp1" class="default-btn-demo2 j-btn-toggle  ">TCP异常</a>
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td>
                                        <select id="_r11" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                        					<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="tabcon7_" style="display: none">
                        <div class="item3" style="">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right" rowspan="2">
                                        <a href="javascript:void(0)" style="width: 150px;" id="dns1" class="default-btn-demo2 j-btn-toggle  ">DNS查询洪水防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="dnssalert1" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td>
                                        <select id="_r12" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="22%" align="right">目的警戒值：</td>
                                    <td width="23%">
                                        <input id="dnsdalert1" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="item3">
                            <table width="100%" border="0" class="table-layout make-gray">
                                <tr>
                                    <td width="15%" align="right" rowspan="2">
                                        <a href="javascript:void(0)" style="width: 150px;" id="dnsr1" class="default-btn-demo2 j-btn-toggle  ">DNS递归查询洪水攻击防护</a>
                                    </td>
                                    <td width="22%" align="right">源警戒值：</td>
                                    <td width="23%">
                                        <input id="dnsrsalert1" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td width="22%" align="right">行为：</td>
                                    <td>
                                        <select id="_r13" class="easyui-combobox" style="width: 132px" data-options="panelHeight:'auto',editable:false">
                                        	<option value="0">丢弃</option>
                            				<option value="1">告警</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="22%" align="right">目的警戒值：</td>
                                    <td width="23%">
                                        <input id="dnsrdalert1" class="easyui-textbox" style="width:120px;" prompt="0-300,000">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>
<div id="wlistConfig" class="pop">
      <div class="item3">
      	<form id="wlistForm" method="post" data-options="novalidate:true">
		<input type="hidden" id="oper_wlist"/>
		<input type="hidden" id="type_wlist"/>
	          <table class="table-layout">
	              <tr>
	                  <td>配置类型：</td>
	                  <td>
	                    	<select id="wlistcontype" class="easyui-combobox"  value="0" data-options="panelHeight:'auto',width:80,editable:false,onSelect: 
							function(rec){
								for(var i=0; i<2; i++){
									document.getElementById('wlisttype' + i).style.display='none';
								}
								document.getElementById('wlisttype' + rec.value).style.display=''; 
						    }">
								<option value="0">地址条目</option>
								<option value="1">IP/掩码</option>
							</select>
		                </td>
		                <td>
	                    	<div id="wlisttype0" style="display:none;">
								<input type="hidden" id="1contype0"/>
								&nbsp;<select id="0wlisttype0" class="easyui-combobox"  data-options="panelHeight:'auto',width:140,editable:false,onSelect: function(rec){$('#0wlisttype0').val(rec.value);}">
									<option value="Any">Any</option>
									<option value="monitor_address">monitor_address</option>
									<option value="private_network">private_network</option>
								</select>
								&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addwlist('2', '地址条目');" style="width:50px">添加</a>
							</div>
							<div id="wlisttype1" style="display:none;">
								&nbsp;<input id="0wlisttype1" class="easyui-textbox" style="width:100px;height:22px;"/>
								&nbsp;/&nbsp;<input id="1wlisttype1" class="easyui-textbox" style="width:100px;height:22px;"/>
								&nbsp;<a class="easyui-linkbutton" href="javascript:void(0)" onclick="addwlist('1', 'IP/掩码');" style="width:50px">添加</a>
							</div>
	                </td>
	            </tr>
	        </table>
	        </form>
	    </div>
	    <div class="panle" data-options="fit:true">
	        <table id="data_wlist" class="table-data">
	        	<tbody id="tb_wlist">
					<tr>
						<th scope="col" style="text-align:center;display:none;">类型编码</th>
						<th scope="col" style="text-align:center;width:5%;">类型</th>
						<th scope="col" style="text-align:center;width:15%;">成员</th>
						<th scope="col" style="text-align:center;width:5%;">操作</th>
					</tr>
				</tbody>
	    	</table>
	</div>
</div>    
</body>
