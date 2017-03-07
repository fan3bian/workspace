<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
select{
	width:10.5%;
	height:30px;
}
.FieldInput3 {
	width:18%;
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
	width:15%;
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js">
</script>
<script type="text/javascript">
var grid;
var listentoolbar = [
						{
							text:'新增应用服务配置',
							iconCls:'icon-add',
							handler:showListenWin
						}
                       ];
$(document).ready(function() {
	loadDataGrid();
	$('#listen_grid').show();
	$('#win_out').show();
});
function showListenWin(){
	$('#wCreateForm').form('clear');
	getCert();
	$('#certname').combobox('setValue','请选择');
	$('#listtype').combobox('setValue','1');
	$('#forwardrule').combobox('setValue','1');
	$('#respovtime').textbox('setValue','5');
	$('#checkinterval').textbox('setValue','2');
	$('#health').textbox('setValue','3');
	$('#nohealth').textbox('setValue','3');
	document.getElementById('v1').style.display='';
	document.getElementById('v2').style.display='none';
	$('#cookie').combobox('setValue','1');
	selectTab();          // 根据协议类型对应内容显示
	$('#listen_add_win').attr('style','visibility:visible');
	
	$('#listen_add_win .j-toggle li').bind('click', function(event) {
	    $(this).addClass('active').siblings().removeClass('active');
	    if($("#check_tcp").hasClass("active")){
	    	$('#check_div').attr('style','visibility:hidden');
	    }else if($("#check_http").hasClass("active") && $("#listtype").textbox('getValue') != '2'){
	    	$('#check_div').attr('style','visibility:visible');
	    }
	});
	$('#check_tcp').addClass('active').siblings().removeClass('active');
	$('#check_div').attr('style','visibility:hidden');
	$('#listen_add_win').window('open');
}
//查询结果
function loadDataGrid(){
	grid = $('#listen_grid').datagrid({
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
		toolbar:listentoolbar,    
	    url:'${pageContext.request.contextPath}/lb/queryLbListens.do?lbparam=lbid&lbvalue=' + $("#tabs_lbid").val(),
	    onLoadSuccess: function (data) {
		      var pageopt = $('#listen_grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#listen_grid').datagrid("getRows").length;
		      var total = pageopt.total;
		        
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {lbid :''  });
		         }
		         $('#listen_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
		       
		      }else{
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		      var rows = data.rows;
		      if (rows.length) {
					 $.each(rows, function (idx, val) {
						if   (val.lbid ==''){ 
							$('#listen_grid_div input:checkbox').eq(idx+1).css("display","none");
						}
					}); 
		      }
		      
      		  //列表icon
		      $('.j-edit').linkbutton({
                  iconCls: 'icon-edit',
                  plain: true
     		  });
    		  $('.j-delete').linkbutton({
                  iconCls: 'icon-delete',
                  plain: true
              });
              $('.j-set').linkbutton({
                  iconCls: 'icon-config',
                  plain: true
              });
              $('.j-load').linkbutton({
                  iconCls: 'icon-insiderelease',
                  plain: true
              });
              $('.j-reload').linkbutton({
                  iconCls: 'icon-outsiderelease',
                  plain: true
              });
              
              // 新增监听服务器弹层
           	  $('#listen_add_win').dialog({
                title: "新增应用服务配置",
                width: 815,
                closed: true,
                modal: true,
                shadow: false,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                buttons: [{
                    text: '提交',
                    iconCls: 'icon-ok',
                    handler: function() {
                    	addLbListen();
                    }
                }, {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#listen_add_win').window('close');

                    }
                }]
              });
              // 修改监听服务器弹层
              $('#listen_edit_win').dialog({
                title: "修改应用服务配置",
                width: 815,
                //height: 460,
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
                    	editLbListen();
                    }
                }, {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#listen_edit_win').window('close');
                    }
                }]
            });
            // 弹层
            $('#windowBackedConfig').dialog({
                title: "后端服务器配置",
                width: 850,
                height: 500,
                closed: true,
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                resizable: false,
                closable:false,
                buttons: [
                	{
                    text: '关闭',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#windowBackedConfig').dialog('close');
                        loadDataGrid();
                    }
                }]
            });
            $('#windowBackedConfigAdd').dialog({
                title: "新增后端服务器配置",
                width: 480,
                //height: 411,
                shadow: false,//取消固定高度限制，自适应高度，去除阴影  zhanghl 2016.08.22
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
                        //str = '<tr><td>' + $('#name').val() + '</td>' + '<td>' + $('#jtdk').val() + '</td>' + '<td>' +  $('#zjip').val() + '</td>' + '<td>' + $('#hdxydk').val() + '</td>' + '<td>' + $('#qz').val() + '</td>' + '<td>' + $('#aclcl').val() + '</td>' + '<td><a href="#" onclick="edit()" class="j-edit" title="修改" ></a><span class="gproducts-partingline">|</span><a href="#" onclick="deleteC()" class="j-delete" title="删除"></a></td></tr>';
                       	//$('#BackedConfigTable').append(str);
                      

                        //$('#windowBackedConfigAdd').dialog('close');
                        $('.j-edit').linkbutton({
                            iconCls: 'icon-edit',
                            plain: true
                        });
                        $('.j-delete').linkbutton({
                            iconCls: 'icon-delete',
                            plain: true
                        });
						
						addLbServer();
                    }
                }, {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#windowBackedConfigAdd').dialog('close');

                    }
                }]
            });
           
             $('#windowBackedConfigModify').dialog({
                title: "修改后端服务器配置",
                width: 480,
                //height: 411,
                shadow: false,//取消固定高度限制，自适应高度，去除阴影  zhanghl 2016.08.22
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
                        //str = '<tr><td>' + $('#name').val() + '</td>' + '<td>' + $('#jtdk').val() + '</td>' + '<td>' +  $('#zjip').val() + '</td>' + '<td>' + $('#hdxydk').val() + '</td>' + '<td>' + $('#qz').val() + '</td>' + '<td>' + $('#aclcl').val() + '</td>' + '<td><a href="#" onclick="edit()" class="j-edit" title="修改" ></a><span class="gproducts-partingline">|</span><a href="#" onclick="deleteC()" class="j-delete" title="删除"></a></td></tr>';
                       	//$('#BackedConfigTable').append(str);
                      


                        $('#windowBackedConfigModify').dialog('close');
                        $('.j-edit').linkbutton({
                            iconCls: 'icon-edit',
                            plain: true
                        });
                        $('.j-delete').linkbutton({
                            iconCls: 'icon-delete',
                            plain: true
                        });
						
						lbServerModify();
                    }
                }, {
                    text: '取消',
                    iconCls: 'icon-cancel',
                    handler: function() {
                        $('#windowBackedConfigModify').dialog('close');
                    }
                }]
            });
		 }
	    
	 }); 		
}
function reset(){
	$('#listen_grid').datagrid('load',{});
}
function listtypeformater(value, row, index) {
	if(value == '1'){
		return "HTTP协议";
	}else if(value == '2'){
		return "TCP协议";
	}else if(value == '3'){
		return "HTTPS协议";
	}
}
function forwardruleformater(value, row, index) {
	if(value == '1'){
		return "轮询模式";
	}else if(value == '2'){
		return "最小连接数";
	}else if(value == '3'){
		return "源IP";
	}
}
function isreadipformater(value, row, index) {
	if(value == '0'){
		return "是";
	}else if(value == '1'){
		return "否";
	}
}
function issessionformater(value, row, index) {
	if(value == '1'){
		return "是";
	}else if(value == '0' || row.listtype == '2'){
		return "否";
	}
}
function ischeckformater(value, row, index) {
	if(value == '1'){
		return "是";
	}else if(value == '0'){
		return "否";
	}
}
function listenoptionformater(value, row, index) {
	if(!value){
		return "";
	}
	var str = "<div style=\"height:30px;overflow:hidden;\"><a href=\"javascript:void(0);\" onclick=\"editlisten(\'" 
				+ row.listname + "\', \'" + row.listtype + "\', \'" + row.forwardrule + "\', \'" + row.isreadip 
				 + "\', \'" + row.issession + "\', \'" + row.cookie + "\', \'" + row.timesum + "\', \'" + row.ischeck 
				 + "\', \'" + row.domain + "\', \'" + row.checkpath + "\', \'" + row.respovtime + "\', \'" + row.checkinterval
				 + "\', \'" + row.nohealth + "\', \'" + row.health + "\', \'" + row.certificateid + "\', \'" + row.certificatename + "\', \'"
				 + row.iscompression + "\', \'" + row.istcppass + "\', \'" 
				+ row.listport + "\', \'" + row.checktype + "\');\" tittle=\"编辑\" class=\"j-edit\"></a><span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"delbefore(\'" 
	 			+ row.listport + "\', \'" + row.listtype + "\', \'" + row.appname + "\', \'" + row.certificateid +"\');\" tittle=\"删除\" class=\"j-delete\"></a>";
	var str0 = "<span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\"onclick=\"initLbServer(\'" 
				 +  row.listport  + "\', \'" + row.listtype+"\');\" class=\"j-set\" title=\"后端服务器配置\"></a>";
	var str1 = "<span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"lbappnettype0(\'" 
				+ row.lbid + "\', \'" + row.listname + "\', \'" + row.funip + "\', \'" + row.listport   + "\', \'" + row.listtype +"\');\" class=\"j-reload\" title=\"外网发布\"></a><span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"appnettype1(\'" 
	 			+ row.funip + "\', \'" + row.listport +"\');\" class=\"j-load\" title=\"内网发布\"></a>";
	var str2 = "<span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"outRelease(\'" + index + "\');\" class=\"j-reload\" title=\"政务外网发布\"></a></div>";
	return str+str0+str2;//目前版本隐藏互联网发布及内网发布 （str1）
}

//政务外网发布  zhanghl 2016.08.18
function outRelease(index) {
    $('#applicationZwww').dialog({
        closed: false
    });
    $('#applicationZwwwText').html('为保证应用正常访问，请使用负载均衡<br /><br />地址：<span style="color:#5099fd">' + $("#funip").val() + '</span>');
    event.stopPropagation();
}

function appnameformater(value, row, index){
	if(!value && row.ischeck=='1'){
		return "未绑定";
	}else{
		return value;
	}
}

function appnettypeformater(value, row, index) {
	if(!value && row.ischeck=='1'){
		return "未发布";
	}
	if(row.appnettype=='0'){
		var str = "未发布";
	}else if(row.appnettpye=='1'){
		var str = "互联网";
	}else if(row.appnettype=='2'){
		var str = "政务外网";
	}
	return str;
}
//外网发布
function lbappnettype0(lbid,listname,funip,listport,listtype) {
	$('#lbappnettype0').form('clear');
	debugger;
	$.ajax({  
		url:'${pageContext.request.contextPath}/lb/querydaddr.do',
			  	type:'post',  
			    async: false,
			    data: {listport:listport,lbid:lbid},    
			    dataType:'json',  
			    success:function(data){ 
			   		if(data.daddr !=null && data.daddr != ''){
			   			$('#lb_daddr').textbox('setValue', data.daddr);
						$('#lb_dport').textbox('setValue', data.dport);
						$('#lb_daddr').textbox({disabled:true});
						$('#lb_dport').textbox({disabled:true});
						$('#save_type').val('modify'); //修改
						$('#nat_manip').val(data.manip); 
						
						$('#serverip').val(data.serverip); 
						$('#backport').val(data.backport); 
						
			   		}else{
			   			$('#lb_daddr').textbox({disabled:false,value:""});
			   			$('#lb_dport').textbox({disabled:false,value:""});
			   			$('#save_type').val('add'); //新增
			   		}
			    }	    
			});
	$("#lb_saddr").combobox("setValue","Any");
	$('#listname3').textbox('setValue', listname);
	$('#lb_transferaddr').textbox('setValue', funip);
	$('#lb_transferport').textbox('setValue', listport);
	
	if(listtype == '1'){
		$('#lb_listtype').combobox('setValue', "HTTP");
	}else if(listtype == '2'){
		$('#lb_listtype').combobox('setValue', "TCP");
	}else if(listtype == '3'){
		$('#lb_listtype').combobox('setValue', "HTTPS");
	}
	debugger;
	$('#lbappnettype0').window('open');
}
//内网发布
function appnettype1(funip,listport) {
	var mg = funip+":"+listport;
	$.messager.alert('提示', "已经发布的应用需要重新公布访问地址为"+mg, 'info');
}
function editlisten(listname,listtype,forwardrule,isreadip,issession,cookie,timesum,ischeck,domain,checkpath,respovtime,checkinterval,nohealth,health,certificateid,certificatename,iscompression,istcppass,listport,checktype){
	$('#w1CreateForm').form('clear');
	$('#listen_edit_win .j-toggle li').bind('click', function(event) {
	    $(this).addClass('active').siblings().removeClass('active');
	    if($("#check_tcp1").hasClass("active")){
	    	$('#check_div1').attr('style','visibility:hidden');
	    }else if($("#check_http1").hasClass("active") && listtype != '2'){
	    	$('#check_div1').attr('style','visibility:visible');
	    }else if($("#check_http1").hasClass("active") && listtype == '2'){
	    	$('#check_div1').attr('style','visibility:hidden');
	    }
	});
	if(checktype == '1'){
		$("#check_http1").click(); //健康检查方式为http
	}else{
		$("#check_tcp1").click(); //健康检查方式为tcp
	}

	$('#listname1').textbox('setValue', listname);
	$('#listport1').textbox('setValue', listport);
	$('#listtype1').combobox('setValue', listtype);
	$('#forwardrule1').combobox('setValue', forwardrule);
	if(listtype == '3'){//HTTPS协议需展示证书内容
		getCert1();
		$('#certname1').combobox('setValue',certificatename);
		//$('#oldCertid').val(certificateid);
	}
	if('1' == isreadip){//获取真实ip
		if('2' == listtype){
			$('#isreadip1_tcp').addClass('active').siblings().removeClass('active');
		}else{
			$('#isreadip1_').addClass('active').siblings().removeClass('active');
		}
	}else{
		if('2' == listtype){
			$('#isreadip1_tcp').removeClass('active').siblings().addClass('active');
		}else{
			$('#isreadip1_').removeClass('active').siblings().addClass('active');
		}
	}
	if('1' == iscompression){//是否压缩
		$('#iscompression1_').addClass('active').siblings().removeClass('active');
	}else{
		$('#iscompression1_').removeClass('active').siblings().addClass('active');
	}
	
	if('1' == istcppass){//TCP透传
		if('2' == listtype){
			$('#istcppass1_tcp').addClass('active').siblings().removeClass('active');
		}else{
			$('#istcppass1_').addClass('active').siblings().removeClass('active');
		}
	}else{
		if('2' == listtype){
			$('#istcppass1_tcp').removeClass('active').siblings().addClass('active');
		}else{
			$('#istcppass1_').removeClass('active').siblings().addClass('active');
		}
		
	}
	if(issession == '1'){
		if(null != cookie && "" != cookie && "undefined" != cookie){
			$('#cookie1').combobox('setValue', cookie);
		}
		
		for(var i=1; i<3; i++){
			document.getElementById('v_' + i).style.display='none';
		}
		document.getElementById('v_' + cookie).style.display=''; 
		
		if(null != timesum && "" != timesum && "undefined" != timesum){
			$('#timesum1').textbox('setValue', timesum);
		}
		$('#issession1_').addClass('active');
		$('#isession_div1   .j-http').removeClass('http-tcp-gray');
	}
	else{
		$('#cookie1').combobox('setValue','1');
		$('#issession1_').removeClass('active');
		$('#isession_div1   .j-http').addClass('http-tcp-gray');
		
		document.getElementById('v_1').style.display='';
		document.getElementById('v_2').style.display='none';
	}
	if(ischeck == '1'){
		$('#ischeck1_').addClass('active');
	}else{
		$('#ischeck1_').removeClass('active');
	}

	if(null != domain && "" != domain && "undefined" != domain){
		$('#domain1').textbox('setValue', domain);
		$('#check_http1').click();
	}
	if(null != checkpath && "" != checkpath && "undefined" != checkpath){
		$('#checkpath1').textbox('setValue', checkpath);
		$('#check_http1').click();
	}
	if(null != respovtime && "" != respovtime && "undefined" != respovtime){
		$('#respovtime1').textbox('setValue', respovtime);
	}
	if(null != checkinterval && "" != checkinterval && "undefined" != checkinterval){
		$('#checkinterval1').textbox('setValue', checkinterval);
	}
	if(null != nohealth && "" != nohealth && "undefined" != nohealth){
		$('#nohealth1').textbox('setValue', nohealth);
	}
	if(null != health && "" != health && "undefined" != health){
		$('#health1').textbox('setValue', health);
	}
	if(listtype == '2'){
		$('#isession_div1').hide();
		$('#httpsHttp1').hide();
		$('#tcp1').show();
		$('#certificate1').hide();
	}else if(listtype == '1'){
		$('#isession_div1').show();
		$('#httpsHttp1').show();
		$('#tcp1').hide();
		$('#certificate1').hide();
	}else if(listtype == '3'){
		$('#isession_div1').show();
		$('#httpsHttp1').show();
		$('#tcp1').hide();
		$('#certificate1').show();
	}
	
	$('#listen_edit_win').attr('style','visibility:visible');
	$('#listen_edit_win').window('open');
}

//////// 删除服务配置  zhanghl 2016.08.23 ////////
function delbefore(listport,listtype,appname,certificateid){
	$('#delLblisten').dialog({
		closed:false
	});
	if(null != appname && "" != appname && "undefined" != appname){
		$('#delLblistenText').text('此应用服务已经关联主机，执行删除后原来提供的负载服务将停止，但不对关联主机造成影响，您确定要执行此操作吗？');
	}else{
		$('#delLblistenText').text('此应用服务未关联主机，执行删除后无影响，您确定要执行此操作吗？');
	}
	
	$('#delLblisten').dialog({
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		buttons : [ {
			text : '确定',
			iconCls : 'icon-ok',
			handler : function() {
				delListenMethod(listport,listtype,certificateid);
				$('#delLblisten').dialog('close');
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$('#delLblisten').dialog('close');
			}
		} ]
	});
}

function delListenMethod(listport,listtype,certificateid){
	$('#listenManForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/dellbListen.do', 
	    onSubmit : function(param) {
	    	param.lbid= $("#tabs_lbid").val();
			param.listport=listport;
			param.listtype=listtype;
			param.certificateid=certificateid;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				$.messager.alert('提示信息','删除成功！', 'info');
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','删除发生错误，请重试！', 'error');
			}
	    }
	});
}
////////删除服务配置  ////////



//协议类型对应内容显示
function selectTab() {
    if ($('#listtype').combobox('getValue') == "2") {
    	$('#certificate').hide();
        $('#isession_div').hide();
        $('#httpsHttp').hide();
        $('#tcp').show();
        $('#ischeck_').addClass('active');
        $('#isreadip_tcp').addClass('active').siblings().removeClass('active');
        $('#istcppass_tcp').addClass('active').siblings().removeClass('active');
    } else if($('#listtype').combobox('getValue') == "1"){
    	$('#certificate').hide();
    	$('#isession_div').show();
        $('#httpsHttp').show();
        $('#tcp').hide();
        $('#isession_div .j-http').removeClass('http-tcp-gray');
        $('#issession_').css({
            cursor: 'pointer'
        });
		$('#issession_').addClass('active');
		$('#isession_div').removeClass('http-tcp-gray');
		$('#ischeck_').addClass('active');
		$('#isreadip_').addClass('active').siblings().removeClass('active');
        $('#istcppass_').addClass('active').siblings().removeClass('active');
        $('#iscompression_').addClass('active').siblings().removeClass('active');
    }else{
    	$('#certificate').show();
    	$('#isession_div').show();
        $('#httpsHttp').show();
        $('#tcp').hide();
        $('#isession_div .j-http').removeClass('http-tcp-gray');
        $('#issession_').css({
            cursor: 'pointer'
        });
		$('#issession_').addClass('active');
		$('#isession_div').removeClass('http-tcp-gray');
		$('#ischeck_').addClass('active');
		$('#isreadip_').addClass('active').siblings().removeClass('active');
        $('#istcppass_').addClass('active').siblings().removeClass('active');
        $('#iscompression_').addClass('active').siblings().removeClass('active');
    }
}



  // 后端服务配置
function initLbServer(listport,listtype) {
	$('#windowBackedConfig').attr('style','visibility:visible');
    $('#windowBackedConfig').dialog({
        closed: false
    });
    $('.j-windowBackedConfig-add').linkbutton({
        iconCls: 'icon-add',
        plain: true
    });
    $('#listen_port').val(listport);
    $('#listen_listtype').val(listtype);
    loadDataGrid1();
    event.stopPropagation();
}
// 新增后端服务器配置
$(".j-windowBackedConfig-add").click(function(event) {
	 $('#vms_sev').combobox('loadData', {}); //清空主机数据  
	
	$('#windowBackedConfigAdd').attr('style','visibility:visible');
    $('#windowBackedConfigAdd').dialog({
        closed: false
    });
     $('#windowBackedConfigModify').dialog({
        closed: true
    });
    $('#w2CreateForm').form('clear');
    $('#lbname_sev').textbox('setValue',$('#listen_port').val());
    $('#listport_v_sev').textbox('setValue', $('#listen_port').val());
    initacl($('#listen_listtype').val());
    getvms($('#listen_port').val());
    
});

function loadDataGrid1(){
	$("#BackedConfigTable  tr:not(:first)").remove();
	$.ajax({ 
		url:'${pageContext.request.contextPath}/lb/queryLbServers.do', 
			    type:'post',  
			    async: false,
			    data: {lbparam:"lbid",lbvalue:$("#tabs_lbid").val(),lbparam1:"listport",lbvalue1:$("#listen_port").val()},    
			    dataType:'json',  
			    success:function(data){ 
			    	for(var i=0;i<data.length;i++){
			    		var obj = data[i];
			    		var str = "<a href=\"javascript:void(0);\" onclick=\"editlbserver(\'" 
					 + obj.lbname + "\', \'" + obj.listport + "\', \'" 
					 + obj.serverid + "\', \'" + obj.serverip + "\', \'" 
					 + obj.backport + "\', \'" + obj.weight + "\', \'" + obj.acl +"\');\" tittle=\"编辑\" class=\"j-edit\"></a><span class=\"gproducts-partingline\">|</span><a href=\"javascript:void(0);\" onclick=\"delbefore1(\'" 
	 					+obj.serverid + "\', \'" +obj.backport + "\', \'" +obj.listport+ "\', \'"+obj.serverip+ "\', \'"+ obj.acl + "\');\" tittle=\"删除\" class=\"j-delete\"></a>";
			    	
			    		switch (obj.lsstatus) {
							case "UP":
								var lsstatus = "运行中";
								break;
							case "DOWN":
								var lsstatus = "停止";
						}
						var trHtml = "<tr><td >" + obj.lbname + "</td><td >" +obj.listport + "</td><td >" +obj.serverid + "</td><td >" + obj.serverip 
						+ "</td><td >" + obj.backport + "</td><td >" + lsstatus + "</td><td >" + obj.weight + "</td><td >" + str + "</td></tr>";
						var $tr=$("#BackedConfigTable tr:last"); 
						$tr.after(trHtml);
						$('.j-edit').linkbutton({
		                  iconCls: 'icon-edit',
		                  plain: true
			     		    });
			    		 $('.j-delete').linkbutton({
			                  iconCls: 'icon-delete',
			                  plain: true
			                });
					    }
					   }	    
				});
}

//获取lbid对应的服务器证书 zhanghl 2016.08.11
function getCert(){
	$('#certname').combobox({    
	    url:'${pageContext.request.contextPath}/lb/getCertname.do?lbid=' + $("#tabs_lbid").val(),    
	    valueField:'certificatename',    
	    textField:'certificatename',
    	onSelect: function(rec){  
    		$('#certname').val(rec.certificatename);
    		$('#certid').val(rec.certificateid);
        }
	});
}
function getCert1(){
	$('#certname1').combobox({    
	    url:'${pageContext.request.contextPath}/lb/getCertname.do?lbid=' + $("#tabs_lbid").val(),    
	    valueField:'certificatename',    
	    textField:'certificatename',
    	onSelect: function(rec){  
    		$('#certname1').val(rec.certificatename);
    		$('#certid1').val(rec.certificateid);
        }
	});
}

//根据listport和lbid查询主机  zhanghl 2016.08.19
function getvms(listport){
	$('#vms_sev').combobox({    
	    url:'${pageContext.request.contextPath}/lb/queryExitOwnVMs.do?lbid=' + $("#tabs_lbid").val() + '&listport=' + listport,     
	    valueField:'serverid',    
	    textField:'serverid',
    	onSelect: function(rec){  
    		$('#servername').val(rec.servername);
    		$('#vm_ip_sev').combobox('setValue',rec.sip);
        }
	});
}

function editlbserver(lbname,listport,serverid,serverip,backport,weight,aclid) {
		jQuery.ajax( {
		url : "${pageContext.request.contextPath}/lb/queryBackVmName.do",
		data : {'serverid' :serverid ,
				'lbid':$("#tabs_lbid").val(),
				'listport':listport,
				'aclid':aclid},
		type : "post",
		cache : false,
		dataType : "json",
		success : function(result) {
			$('#evms').combobox('setValue', serverid).textbox('setText', serverid);
			$('#w2CreateForm').form('clear');
			$('#elbname').textbox('setValue', lbname).textbox('setText', lbname);
			$('#elistport_v').textbox('setValue', listport).textbox('setText', listport);
			$('#oldbackport').val(backport);
			$('#oldacl').val(aclid);
			$('#ebackport').textbox('setValue', backport).textbox('setText', backport);
			$('#oldip').val(serverip);
			$('#eweight').textbox('setValue', weight).textbox('setText', weight);
		//	getvmipCombobox2(serverid);
			$('#evm_ip').combobox('select', serverip);
			einitacl(result.listtype,aclid);
			//$('#eappname').combobox('select', result.appname);
			$('#windowBackedConfigAdd').dialog({
		        closed: true
		    });
			$('#windowBackedConfigModify').attr('style','visibility:visible');
		    $('#windowBackedConfigModify').dialog({
		        closed: false
		    });
		}
	}); 
}
//后端服务器修改
function lbServerModify(){
	var lbname = $('#elbname').textbox('getValue');
	if(null == lbname || "" == lbname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var listport = $('#elistport_v').textbox('getValue');
	if(null == listport || "" == listport){
		$.messager.alert('提示信息','请选择端口！', 'info');
		return;
	}
	var serverid = $('#evms').combobox('getValue');
	if(null == serverid || "" == serverid){
		$.messager.alert('提示信息','请选择主机！', 'info');
		return;
	}
	var serverip = $('#evm_ip').combobox('getValue');
	if(null == serverip || "" == serverip){
		$.messager.alert('提示信息','请选择主机IP！', 'info');
		return;
	}
	var backport = $('#ebackport').textbox('getValue');
	if(null == backport || "" == backport){
		$.messager.alert('提示信息','请填写后端协议端口！', 'info');
		return;
	}
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(backport)){
		$.messager.alert('提示信息','后端协议端口请填写数字！', 'info');  
		return;
	}else if(backport<1 || backport>65535){
		$.messager.alert('提示信息','后端协议端口范围为1-65535！', 'info'); 
		return;
	}else if(backport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
	var weight = $('#eweight').textbox('getValue');
	if(null == weight || "" == weight){
		$.messager.alert('提示信息','请输入权重！', 'info');
		return;
	}
	if(isNaN(weight)){
		$.messager.alert('提示信息','权重要求填写数字！', 'info');
		return;
	}
	if(weight > 100 || weight < 0){
		$.messager.alert('提示信息','权重填写范围为0-100！', 'info');
		return;
	}
	if ($('#ew2CreateForm').form('validate')) {
		$('#ew2CreateForm').form('submit',{
				url : '${pageContext.request.contextPath}/lb/lbServerModify.do',
				onSubmit : function(param) {
					param.lbname = $('#elbname').textbox('getValue');
					param.listport = $('#elistport_v').textbox('getValue');
					param.serverid = $('#evms').combobox('getValue');
					param.serverip = $('#evm_ip').combobox('getValue');
					param.backport = $('#ebackport').textbox('getValue');
					param.weight = $('#eweight').textbox('getValue');
					param.lbid = $("#tabs_lbid").val();
					param.oldip=$("#oldip").val();
					param.oldbackport=$("#oldbackport").val();
					param.oldacl=$("#oldacl").val();
					param.acl=$('#eacl').combobox('getValue');
				},
				success : function(retr) {
					var _data = $.parseJSON(retr);
					if (_data.success) {
						$.messager.alert('提示','操作成功！','info');
						loadDataGrid1();
					} else {
						$.messager.alert('提示','操作失败！','error');
					}
					$('#w3').window('close');
					
				}
			});
	}
	
}

function initacl(listtype){
	$('#acl_sev').combobox({    
		url:'${pageContext.request.contextPath}/lb/lbBvmAclInit.do?lbid=' + $("#tabs_lbid").val(),    
		valueField:'aclid',    
		textField:'aclname',
		onSelect: function(rec){
	    }
	});
	if(listtype=='1' || listtype=='3'){
		$('#acltr').show();
		$('#acl_sev').combobox('select','default');
	}else{
		$('#acltr').hide();
	}
}

function einitacl(listtype,aclid){
	$('#eacl').combobox({    
		url:'${pageContext.request.contextPath}/lb/lbBvmAclInit.do?lbid=' + $("#tabs_lbid").val(),    
		valueField:'aclid',    
		textField:'aclname',
		onSelect: function(rec){
	    }
	});  
	if(listtype=='1' || listtype=='3'){
		$('#eacltr').show();
		$('#eacl').combobox('select',aclid);
	}else{
		$('#eacltr').hide();
	}
}
</script>
<form id="listenManForm"></form>
<div data-options="region:'center',border:false" id="listen_grid_div" >
	<table title="" style="width:100%;"  id="listen_grid" >
		<thead>
			<tr>
				<!-- <th data-options="field:'ck',checkbox:true"></th> -->
				<th data-options="field:'listname',width:50,align:'center'">名称</th>
				<th data-options="field:'listtype',width:50,align:'center',formatter:listtypeformater">监听协议</th>
				<th data-options="field:'listport',width:50,align:'center'">监听端口</th>
				<th data-options="field:'forwardrule',width:50,align:'center',formatter:forwardruleformater">负载方式</th>
				<th data-options="field:'isreadip',width:50,align:'center',formatter:isreadipformater">隐藏真实IP</th>
				<th data-options="field:'issession',width:50,align:'center',formatter:issessionformater">会话保持</th>
				<th data-options="field:'ischeck',width:50,align:'center',formatter:ischeckformater">健康检查</th>
				<th data-options="field:'appname',width:50,align:'center',formatter:appnameformater">应用名称</th>
				<th data-options="field:'appnettype',width:55,align:'center',formatter:appnettypeformater">应用网络类型</th>
				<th data-options="field:'lbid',width:120,align:'center',formatter:listenoptionformater">操作</th>
			</tr>
		</thead>
	</table>
</div>  
<div id="win_out" >
 	<!-- 弹层 -->
    <!-- 新增应用服务配置 -->
    <div id="listen_add_win" class="pop"  style="visibility: hidden;">
        <div style="padding:10px 0">
        	<form id="wCreateForm" method="post" data-options="novalidate:true">
            <table style="width:100%;border:0px;" class="table-layout">
                <tr>
                    <td width="20%" align="right">名称：</td>
                    <td width="35%" align="left">
                        <input type="text" class="easyui-textbox" style="width: 240px;" id="listname">
                        <span class="must-star">*</span>
                    </td>
                    <td width="18%" align="right">负载方式：</td>
                    <td width="27%">
                        <select class="easyui-combobox"  id="forwardrule" style="width: 157px;" data-options="editable:false,panelHeight:'auto'">
                        	<option value="1">轮询模式</option>
							<option value="2">最小连接数</option>
							<option value="3">源IP</option>
                        </select> 
                        <a href="javascript:void(0)" class="tip-why-box " id="forwardruletip1">？</a>
                    </td>
                </tr>
                <tr>
                    <td align="right">监听协议：</td>
                    <td align="left">
                        <select class="easyui-combobox" id="listtype" style="width: 240px;" data-options="editable:false,panelHeight:'auto'">
                            <option value="1">HTTP</option>
                            <option value="2">TCP</option>
                            <option value="3">HTTPS</option>
                        </select>
                        <a href="javascript:void(0)" class="tip-why-box " id="listtypetip1">？</a>
                    </td>
                    <td align="right">监听端口：</td>
                    <td >
                        <input type="text" class="easyui-textbox" style="width:157px;" id="listport">
                        <span class="must-star">*</span>
                    </td>
                </tr>
                <tr id="certificate">
                        <td align="right">服务器证书：</td>
                        <td colspan="3">
                        	<input type="hidden" id="certid">
                            <select class="easyui-combobox" id="certname" style="width: 240px;" data-options="editable:false,panelHeight:'auto'"></select>
                            <span class="must-star">*</span>
                        </td>
                </tr>
            </table>
            <p class="spanceline"></p>
            <div class="item1">
                <table style="width:100%;border:0px;" class="table-layout">
                    <tr class="j-tcp">
                        <td width="18%" rowspan="4" align="right">
                            <div class="item-title"> <a href="javascript:void(0)"  id="ischeck_" style="width: 90px;" class="default-btn-demo2">健康检查</a></div>
                        </td>
                        <td width="15%" align="right">健康检查方式：</td>
                        <td width="27%" colspan="3">
                            <ul class="item-ul j-toggle">
                                <li id="check_tcp" class="active" style="padding:0 5px">TCP</li>
                                <li id="check_http" style="padding:0 5px">HTTP</li>
                            </ul>
                        </td>
                    </tr>
                     <tr class="j-tcp">
                        <td width="15%" align="right">响应超时时间(s)：</td>
                        <td width="27%">
                            <input type="text" id="respovtime" class="easyui-textbox" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                            <span class="tip-info">（1-50）</span>
                        </td>
                        <td width="15%" align="right">健康检查间隔(s)：</td>
                        <td width="25%">
                            <input type="text" id="checkinterval" class="easyui-textbox" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        	<span class="tip-info">（1-5）</span>
                        </td>
                    </tr>
                    <tr class="j-tcp">
                        <td align="right">健康阀值(次)：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="health" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        	<span class="tip-info">（2-10）</span>
                        </td>
                        <td align="right">不健康阀值(次)：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="nohealth" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        	<span class="tip-info">（2-10）</span>
                        </td>
                    </tr>
                    <tr id="check_div" class="j-tcp " style="visibility: hidden;">
                        <td align="right">域名：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="domain" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        </td>
                        <td align="right">检查路径：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="checkpath" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        </td>
                    </tr>
                </table>
            </div>
            <div id="isession_div" class="item1">
                <table style="width:100%;border:0px;" class="table-layout">
                    <tr  class="j-http http-tcp-gray ">
                        <td width="18%" align="right">
                            <div class="item-title2"> <a href="javascript:void(0)"   style="width: 90px;" class="default-btn-demo2" id="issession_">会话保持</a></div>
                        </td>
                        <td width="15%" align="right">Cookie处理方式：</td>
                        <td width="27%">
                           <select class="easyui-combobox"  id="cookie" style="width: 150px;" data-options="editable:false,panelHeight:'auto',onSelect: 
								function(rec){
									for(var i=1; i<3; i++){
										document.getElementById('v' + i).style.display='none';
									}
									document.getElementById('v' + rec.value).style.display=''; 
						    	}">
								<option value="1">植入</option>
								<option value="2">重写</option>
							</select>
                        </td>
                        <td width="15%" align="right">
                        	<div id="v1" >超时时间（s）</div>
                        	<div id="v2" >Cookie值：</div>
                        </td>
                        <td width="25%">
                            <input type="text" class="easyui-textbox" id="timesum" style="width:150px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="item1" id="httpsHttp">
				<table style="width:100%;border:0px;" class="table-layout">
					<tr>
						<td width="10%" align="right">获取真实IP:</td>
							<td width="24%" align="left">
								<ul class="item-ul j-toggle">
									<li id="isreadip_" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
							<td width="10%" align="right">数据压缩：</td>
							<td width="24%" align="left">
								<ul class="item-ul j-toggle">
									<li id="iscompression_" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
							<td width="8%" align="right">TCP透传:</td>
							<td width="24%" align="left">
								<ul class="item-ul j-toggle">
									<li id="istcppass_" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
				<div class="item1" id="tcp">
				<table style="width:100%;border:0px;" class="table-layout">
					<tr>
						<td width="15%" align="right">获取真实IP:</td>
							<td width="35%" align="left">
								<ul class="item-ul j-toggle">
									<li id="isreadip_tcp" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
							<td width="15%" align="right">TCP透传:</td>
							<td width="35%" align="left">
								<ul class="item-ul j-toggle">
									<li id="istcppass_tcp" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
            </form>
        </div>
    </div>
</div>

	<!-- 弹层 -->
    <!-- 修改应用服务配置 -->
    <div id="listen_edit_win" class="pop" style="visibility: hidden;">
        <div style="padding:10px 0">
        	<form id="w1CreateForm" method="post" data-options="novalidate:true">
            <table style="width:100%;border:0px;" class="table-layout">
                <tr>
                    <td width="20%" align="right">名称：</td>
                    <td width="35%" align="left">
                        <input type="text" class="easyui-textbox" style="width: 240px;" id="listname1">
                        <span class="must-star">*</span>
                    </td>
                    <td width="18%" align="right">负载方式：</td>
                    <td width="27%">
                        <select class="easyui-combobox"  id="forwardrule1" style="width: 157px;" data-options="editable:false,panelHeight:'auto'">
                        	<option value="1">轮询模式</option>
							<option value="2">最小连接数</option>
							<option value="3">源IP</option>
                        </select> 
                        <a href="javascript:void(0)" class="tip-why-box " id="forwardruletip11">？</a>
                    </td>
                </tr>
                <tr>
                    <td align="right">监听协议：</td>
                    <td align="left">
                        <select class="easyui-combobox" id="listtype1" style="width: 240px;" data-options="editable:false,panelHeight:'auto'" disabled>
                            <option value="1">HTTP</option>
                            <option value="2">TCP</option>
                            <option value="3">HTTPS</option>
                        </select>
                        <a href="javascript:void(0)" class="tip-why-box " id="listtypetip11">？</a>
                    </td>
                    <td align="right">监听端口：</td>
                    <td>
                        <input type="text" class="easyui-textbox" style="width:157px;" id="listport1" disabled>
                        <span class="must-star">*</span>
                    </td>
                </tr>
                <tr id="certificate1">
                        <td align="right">服务器证书：</td>
                        <td colspan="3">
                        	<!-- <input type="hidden" id="oldCertid">  -->
                        	<input type="hidden" id="certid1">
                            <select class="easyui-combobox" id="certname1" style="width: 240px;" data-options="editable:false,panelHeight:'auto'"></select>
                            <span class="must-star">*</span>
                        </td>
                </tr>
            </table>
            <p class="spanceline"></p>
            <div class="item1">
                <table style="width:100%;border:0px;" class="table-layout">
                    <tr class="j-tcp">
                        <td width="18%" rowspan="4" align="right">
                            <div class="item-title"> <a href="javascript:void(0)"  id="ischeck1_" style="width: 90px;" class="default-btn-demo2">健康检查</a></div>
                        </td>
                        <td width="15%" align="right">健康检查方式：</td>
                        <td width="27%" colspan="3">
                            <ul class="item-ul j-toggle">
                                <li id="check_tcp1" class="active" style="padding:0 5px">TCP</li>
                                <li id="check_http1" style="padding:0 5px">HTTP</li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="j-tcp">
                        <td width="15%" align="right">响应超时时间(s)：</td>
                        <td width="27%">
                            <input type="text" id="respovtime1" class="easyui-textbox" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        	<span class="tip-info">（1-50）</span>
                        </td>
                        <td width="15%" align="right">健康检查间隔(s)：</td>
                        <td width="25%">
                            <input type="text" id="checkinterval1" class="easyui-textbox" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        	<span class="tip-info">（1-5）</span>
                        </td>
                    </tr>
                    <tr class="j-tcp">
                        <td align="right">健康阀值(次)：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="health1" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        	<span class="tip-info">（2-10）</span>
                        </td>
                        <td align="right">不健康阀值(次)：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="nohealth1" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        	<span class="tip-info">（2-10）</span>
                        </td>
                    </tr>
                    <tr class="j-tcp" id="check_div1" style="visibility: hidden;">
                        <td align="right">域名：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="domain1" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        </td>
                        <td align="right">检查路径：</td>
                        <td>
                            <input type="text" class="easyui-textbox" id="checkpath1" style="width:120px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        </td>
                    </tr>
                </table>
            </div>
            <div  id="isession_div1" class="item1">
                <table style="width:100%;border:0px;" class="table-layout">
                    <tr class="j-http http-tcp-gray ">
                        <td width="18%" align="right">
                            <div class="item-title2"> <a href="javascript:void(0)"   style="width: 90px;" class="default-btn-demo2" id="issession1_">会话保持</a></div>
                        </td>
                        <td width="15%" align="right">Cookie处理方式：</td>
                        <td width="27%">
                           <select class="easyui-combobox"  id="cookie1" style="width: 150px;" data-options="editable:false,panelHeight:'auto',onSelect: 
								function(rec){
									for(var i=1; i<3; i++){
										document.getElementById('v_' + i).style.display='none';
									}
									document.getElementById('v_' + rec.value).style.display=''; 
						    	}">
								<option value="1">植入</option>
								<option value="2">重写</option>
							</select>
                        </td>
                        <td width="15%" align="right">
         					<div id="v_1" style="display:none;">超时时间（s）</div>
                        	<div id="v_2" style="display:none;">Cookie值：</div>               
                        </td>
                        <td width="25%">
                            <input type="text" class="easyui-textbox" id="timesum1" style="width:150px;" onblur="if(!this.value)this.value =this.defaultValue;" onfocus="if(this.value==this.defaultValue)this.value ='';">
                        </td>
                    </tr>
                </table>
            </div>
            <div class="item1" id="httpsHttp1">
				<table style="width:100%;border:0px;" class="table-layout">
					<tr>
						<td width="10%" align="right">获取真实IP:</td>
							<td width="24%" align="left">
								<ul class="item-ul j-toggle">
									<li id="isreadip1_" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
							<td width="10%" align="right">数据压缩：</td>
							<td width="24%" align="left">
								<ul class="item-ul j-toggle">
									<li id="iscompression1_" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
							<td width="8%" align="right">TCP透传:</td>
							<td width="24%" align="left">
								<ul class="item-ul j-toggle">
									<li id="istcppass1_" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
				<div class="item1" id="tcp1">
				<table style="width:100%;border:0px;" class="table-layout">
					<tr>
						<td width="15%" align="right">获取真实IP:</td>
							<td width="35%" align="left">
								<ul class="item-ul j-toggle">
									<li id="isreadip1_tcp" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
							<td width="15%" align="right">TCP透传:</td>
							<td width="35%" align="left">
								<ul class="item-ul j-toggle">
									<li id="istcppass1_tcp" class="active" style="padding:0 5px">是</li>
									<li style="padding:0 5px">否</li>
								</ul>
							</td>
						</tr>
					</table>
				</div>
            </form>
        </div>
    </div>

<div id="lbappnettype0" class="easyui-window" title="互联网发布" data-options="closed:true,minimizable:false,maximizable:false,closable:false,iconCls:'icon-save',singleSelect:true" 
style="width:480px;height:350px;padding:5px;top:57px;display:none">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center'" style="padding:10px;border:false">
			<form id="appnetForm" method="post" data-options="novalidate:true">
			<input type="hidden" id="save_type" name="save_type">
			<input type="hidden" id="nat_manip" name="nat_manip"> 
			<input type="hidden" id="serverip" name="serverip">
			<input type="hidden" id="backport" name="backport">
			<table style="width:100%;align:center;">
				<tr> 
					<td class="FieldLabel2">名称：</td>
					<td class="FieldInput2">
						<input id="listname3" class="easyui-textbox" data-options="required:true,missingMessage:'此处为必填项'" style="height:30px;width:160px;" disabled/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">源地址：</td>
					<td class="FieldInput2">	
						<select id="lb_saddr" class="easyui-combobox" style="height:30px;width:160px;" data-options="editable:false,panelHeight:'auto'"></select>
						<font color="red">*</font>
					</td> 
				</tr>
				<tr>
					<td class="FieldLabel2">目的地址：</td>
					<td class="FieldInput2"> 
						<input id="lb_daddr" class="easyui-textbox"	 style="height:30px;width:160px;"  />
						<font color="red">*</font>
					</td>
				</tr>                
				<tr>
					<td class="FieldLabel2">目的端口：</td>
					<td class="FieldInput2">
						<input id="lb_dport" class="easyui-textbox"	 style="height:30px;width:160px;"  />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">协议名称：</td>
					<td class="FieldInput2">
						<select id="lb_listtype" class="easyui-combobox"  style="height:30px;width:160px;" disabled>   
						    <option value="HTTP">HTTP</option>   
						    <option value="TCP">TCP</option>   
						    <option value="HTTPS">HTTPS</option>   
						</select>  
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">转换地址：</td>
					<td class="FieldInput2">
						<input id="lb_transferaddr" class="easyui-textbox"	 style="height:30px;width:160px;" disabled />
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel2">转换端口：</td>
					<td class="FieldInput2">
						<input id="lb_transferport" class="easyui-textbox"  style="height:30px;width:160px;" disabled/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr >
					<td class="FieldLabel2">描述信息：</td>
					<td class="FieldInput2">
						<input id="lb_description" name="description" class="easyui-textbox" style="width:160px;height:22px;"/>
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="saveAppnettype();" style="width:80px">提交</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#lbappnettype0').window('close');" style="width:80px">取消</a>
		</div>
	</div>
</div>

<!-- 后端服务器配置     -->
<form id="vmManForm"></form>
<div id="windowBackedConfig" class="pop" style="visibility: hidden;">
	<input type="hidden" id="listen_port" name="listen_port">
	<input type="hidden" id="listen_listtype" name="listen_listtype">
    <a href="javascript:void(0)" class="j-windowBackedConfig-add" style="margin:5px;">新增后端服务器配置</a>
    <style>.table-data td{text-align: center;}</style>
    <table style="width:100%;border:0px;" class="table-data" id="BackedConfigTable">
        <tr>
            <th scope="col" style="text-align:center;">名称</th>
            <th scope="col" style="text-align:center;">监听端口</th>
            <th scope="col" style="text-align:center;">主机</th>
            <th scope="col" style="text-align:center;">主机IP</th>
            <th scope="col" style="text-align:center;">主机协议端口</th>
            <th scope="col" style="text-align:center;">状态</th>
            <th scope="col" style="text-align:center;">权重</th>
            <th scope="col" style="text-align:center;">操作</th>
        </tr>
      
    </table>
</div>
<div id="windowBackedConfigAdd" class="pop" style="visibility: hidden；">
    <div class="j-tabs-con">
    <form id="w2CreateForm" method="post" data-options="novalidate:true">
        <div class="item3">
            <div class="item-wrap">
                <table style="width:100%;border:0px;cellpadding:0px;cellspacing:0px" class="table-layout">
                    <tr>
                        <td align="right" width="30%">名称：</td>
                        <td align="left" width="70%">
                            <input id="lbname_sev" type="text" class="easyui-textbox" style="width: 218px;">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">监听端口：</td>
                        <td align="left" width="70%">
                            <input id="listport_v_sev" type="text" class="easyui-textbox" style="width: 218px;" data-options="editable:false,panelHeight:'auto'">
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <!-- 
                    <tr>
                        <td align="right" width="30%">应用：</td>
                        <td align="left" width="70%">
							<select id="appname_sev" class="easyui-combobox" style="width: 218px;" data-options="editable:false,panelHeight:'auto'">
							</select>
                        </td>
                    </tr>
                     -->
                </table>
            </div>
        </div>
        <div class="item3">
            <div class="item-wrap">
                <input type="hidden" id="servername" name="servername">
                <input type="hidden" id="appname_sev" name="appname_sev">
                <table style="width:100%;border:0px;cellpadding:0px;cellspacing:0px" class="table-layout">
                    <tr>
                        <td align="right" width="30%">主机：</td>
                        <td align="left" width="70%">
                            <select  id="vms_sev" class="easyui-combobox" data-options="editable:false,panelHeight:150"  style="width: 218px;">
                            </select>
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">主机IP：</td>
                        <td align="left" width="70%">
                            <select  id="vm_ip_sev" class="easyui-combobox"  data-options="editable:false,panelHeight:'auto'" style="width: 218px;">
                            </select>
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">后端协议端口：</td>
                        <td align="left" width="70%">
                            <input id="vm_backport_sev" type="text" class="easyui-textbox" style="width: 218px;">
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">权重：</td>
                        <td align="left" width="70%">
                            <input id="weight_sev" type="text" class="easyui-textbox" style="width: 218px;">
                        </td>
                    </tr>
                    <tr id ="acltr">
                        <td align="right" width="30%">转发策略：</td>
                        <td align="left" width="70%">
                            <select id="acl_sev" class="easyui-combobox" data-options="editable:false,panelHeight:'auto'" style="width: 218px;">
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        </form>
    </div>
</div>
    
    
<div id="windowBackedConfigModify" class="pop" style="visibility: hidden;">
    <div class="j-tabs-con">
   	<form id="ew2CreateForm" method="post" data-options="novalidate:true">
   		<input type="hidden" id ="oldip"/>
		<input type="hidden" id ="oldbackport"/>
		<input type="hidden" id ="oldacl"/>
		<input type="hidden" id="elisttpye">
        <div class="item3">
            <div class="item-wrap">
                <table style="width:100%;border:0px;cellpadding:0px;cellspacing:0px" class="table-layout">
                    <tr>
                        <td align="right" width="30%">名称：</td>
                        <td align="left" width="70%">
                            <input id="elbname" type="text" class="easyui-textbox" style="width: 218px;">
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">监听端口：</td>
                        <td align="left" width="70%">
                            <input id="elistport_v" type="text" class="easyui-textbox" style="width: 218px;" data-options="editable:false,panelHeight:'auto',disabled:true">
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <!-- 
                    <tr>
                        <td align="right" width="30%">应用：</td>
                        <td align="left" width="70%">
                        	<select id="eappname" class="easyui-combobox" style="width: 218px;" data-options="editable:false,panelHeight:'auto',disabled:true">
							</select>
                        </td>
                    </tr>
                     -->
                </table>
            </div>
        </div>
        <div class="item3">
            <div class="item-wrap">
                <table style="width:100%;border:0px;cellpadding:0px;cellspacing:0px" class="table-layout">
                    <tr>
                        <td align="right" width="30%">主机：</td>
                        <td align="left" width="70%">
                            <select  id="evms" class="easyui-combobox" style="width: 218px;" data-options="editable:false,panelHeight:'auto',disabled:true">
                                <option value="">请选择</option>
                            </select>
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">主机IP：</td>
                        <td align="left" width="70%">
                            <select  id="evm_ip" class="easyui-combobox" style="width: 218px;" data-options="editable:false,panelHeight:'auto',disabled:true">
                                <option value="">请选择</option>
                            </select>
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">后端协议端口：</td>
                        <td align="left" width="70%">
                            <input id="ebackport" type="text" class="easyui-textbox" style="width: 218px;">
                            <span class="must-star">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="30%">权重：</td>
                        <td align="left" width="70%">
                            <input id="eweight" type="text" class="easyui-textbox" style="width: 218px;">
                        </td>
                    </tr>
                    <tr id="eacltr">
                        <td align="right" width="30%">转发策略：</td>
                        <td align="left" width="70%">
                            <select id="eacl" class="easyui-combobox"  data-options="editable:false,panelHeight:'auto'" style="width: 218px;">
                                <option value="">请选择</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    </div>
</div>
<!-- 政务外网发布 -->
<div id="applicationZwww"  class="easyui-dialog"  data-options=" modal:true,closed: true,title:'提示', buttons: [{
            text: '知道了',
            handler: function() {
                $('#applicationZwww').dialog('close');
            }
        }]" style="padding:20px 20px 30px;width:350px">
    <p align="center"><span class="ytip"></span><span align="left" class="ytip-text" id="applicationZwwwText"></span></p>
</div>
<!-- 删除后端服务器配置 -->
<div id="delLblisten"  class="easyui-dialog"  data-options=" modal:true,closed: true,title:'提示', buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function() {
            	$('#delLblisten').dialog('close');
            }
            }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#delLblisten').dialog('close');
            }
        }]" style="padding:20px 20px 30px;width:450px;">
    <p><span class="ytip"></span><span class="ytip-text" id="delLblistenText"></span></p>
</div>
<script type="text/javascript">
function checkPort1(listport){
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(listport)){
		$.messager.alert('提示信息','端口请填写数字！', 'info');  
		return;
	}else if(listport<1 || listport>65535){
		$.messager.alert('提示信息','端口范围为1-65535！', 'info'); 
		return;
	}else if(listport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
}
function checkPort(listport){
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(listport)){
		$.messager.alert('提示信息','端口请填写数字！', 'info');  
		return;
	}else if(listport<1 || listport>65535){
		$.messager.alert('提示信息','端口范围为1-65535！', 'info'); 
		return;
	}else if(listport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
	
	$.ajax({  
		url:'${pageContext.request.contextPath}/lb/getLbListen.do',
		type:'post',  
		async: false,
		data: {lbid:$("#tabs_lbid").val(),listport:listport},    
		dataType:'json',  
		success:function(data){ 
			if (data.success) {
				$.messager.alert('提示信息','该端口已经存在配置数据!', 'info'); 
				document.getElementById("addLbListen_button").style.display="none";
			} else {
				document.getElementById("addLbListen_button").style.display="";
			}
		}	    
	});
}
function editLbListen(){
	var listname = $('#listname1').textbox('getValue');
	if(null == listname || "" == listname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var listport = $('#listport1').textbox('getValue');
	
	var listtype = $('#listtype1').combobox('getValue');
	var forwardrule = $('#forwardrule1').combobox('getValue');
	var certificateid = "";
	var certificatename = "";
	if("3" == listtype){
		certificateid = $('#certid1').val();
		certificatename = $('#certname1').combobox('getValue');
	}
	
	var ischeck = '1';//始终为1  zhanghl 2016.08.23
	var respovtime = "5";
	var checkinterval = "2";
	var health = "3";
	var nohealth = "3";
	var domain = "";
	var checkpath = "";
	var checktype = "";
	if($("#check_http1").hasClass("active")){
		checktype = '1';
	}else{
		checktype = '2';
	}
	////////不再检查ischeck的值  zhanghl 2016.08.23////////
	respovtime = $('#respovtime1').textbox('getValue');
	if(isNaN(respovtime)){
		$.messager.alert('提示信息','响应超时时间请填写数字！', 'info');  
		return;
	}else if(respovtime<1 || respovtime>50){
		$.messager.alert('提示信息','响应超时时间范围为1-50秒！', 'info');
		return;
	}
	checkinterval = $('#checkinterval1').textbox('getValue');
	if(isNaN(checkinterval)){
		$.messager.alert('提示信息','健康检查间隔请填写数字！', 'info');  
		return;
	}else if(checkinterval<1 || checkinterval>5){
		$.messager.alert('提示信息','健康检查间隔范围为1-5秒！', 'info');
		return;
	}
	health = $('#health1').textbox('getValue');
	if(isNaN(health)){
		$.messager.alert('提示信息','健康阈值请填写数字！', 'info');  
		return;
	}else if(health<2 || health>10){
		$.messager.alert('提示信息','健康阈值范围为2-10次！', 'info');
		return;
	}
	nohealth = $('#nohealth1').textbox('getValue');
	if(isNaN(nohealth)){
		$.messager.alert('提示信息','不健康阈值请填写数字！', 'info');  
		return;
	}else if(nohealth<2 || nohealth>10){
		$.messager.alert('提示信息','不健康阈值范围为2-10次！', 'info');
		return;
	}
	if("1" == checktype && "2" != listtype){  //检查健康方式选择http，才传递域名与路径
		domain = $('#domain1').textbox('getValue');
		checkpath = $('#checkpath1').textbox('getValue');
	}
	////////不再检查ischeck的值////////
	
	//是否获取真实IP zhanghl 2016.08.23
	var isreadip = 0;
	if('2' == listtype){
		var isreadip_flag = $("#isreadip1_tcp").hasClass("active");
	}else{
		var isreadip_flag = $("#isreadip1_").hasClass("active");
	}
	if(isreadip_flag){
		isreadip = 1;
	}
	//是否数据压缩  zhanghl 2016.08.23
	var iscompression = 0;
	if("2" != listtype){
		var iscompression_flag = $("#iscompression1_").hasClass("active");
		if(iscompression_flag ){
			iscompression = 1;
		}
	}
	//TCP透传  zhanghl 2016.08.23
	var istcppass = 0;
	if('2' == listtype){
		var istcppass_flag = $("#istcppass1_tcp").hasClass("active");
	}else{
		var istcppass_flag = $("#istcppass1_").hasClass("active");
	}
	if(istcppass_flag){
		istcppass = 1;
	}
	var issession = 0;
	if("2" != listtype){
		var issession_flag = $("#issession1_").hasClass("active");
		if(issession_flag){
			issession = 1;
		}
	}
	var cookie = "";
	var timesum = "";
	if("2" != listtype && "1" == issession){//http和https
		cookie = $('#cookie1').combobox('getValue');
		timesum = $('#timesum1').textbox('getValue');
		if(null == timesum || "" == timesum){
			$.messager.alert('提示信息','请填写超时时间（s）/Cookie值！', 'info');
			return;
		}
		if(cookie==1 && isNaN(timesum)){
			$.messager.alert('提示信息','超时时间请填写数字！', 'info');
			return;
		}
	}
	
	$('#w1CreateForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/editLbListen.do', 
	    onSubmit : function(param) {
	    	param.lbid= $("#tabs_lbid").val();
			param.listport=listport;
			param.listname=listname;
			param.listtype=listtype;
			param.forwardrule=forwardrule;
			param.ischeck=ischeck;
			param.isreadip=isreadip;
			param.issession=issession;
			param.respovtime=respovtime;
			param.checkinterval=checkinterval;
			param.health=health;
			param.nohealth=nohealth;
			param.cookie=cookie;
			param.timesum=timesum;
			param.domain=domain;
			param.checkpath=checkpath;
			param.checktype=checktype;
			param.certificateid=certificateid;
			param.certificatename=certificatename;
			param.iscompression=iscompression;
			param.istcppass=istcppass;
			//param.oldCertid=$("#oldCertid").val();//传递原先的证书编号以对证书状态进行相应修改
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				$.messager.alert('提示信息','保存成功！', 'info');
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#listen_edit_win').window('close');
	    }
	});
	
}
function addLbListen(){
	var listname = $('#listname').textbox('getValue');
	if(null == listname || "" == listname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var listport = $('#listport').textbox('getValue');
	if(null == listport || "" == listport){
		$.messager.alert('提示信息','请填写端口！', 'info');
		return;
	}
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(listport)){
		$.messager.alert('提示信息','端口请填写数字！', 'info');  
		return;
	}else if(listport<1 || listport>65535){
		$.messager.alert('提示信息','端口范围为1-65535！', 'info'); 
		return;
	}else if(listport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
	var listtype = $('#listtype').combobox('getValue');
	var forwardrule = $('#forwardrule').combobox('getValue');
	var ischeck = '1';//健康检查必须选中，此处写死为1  zhanghl 2016.08.23
	var respovtime = "5";
	var checkinterval = "2";
	var health = "3";
	var nohealth = "3";
	var domain = "";
	var checkpath = "";
	var checktype = "";
	var certificateid = "";//https协议需传服务器证书，tcp和http协议时证书传空 zhanghl 2016.08.17
	var certificatename = "";
	if("3" == listtype){// https协议时需传递证书
		certificateid = $('#certid').val();
		certificatename = $('#certname').combobox('getValue');
		if('请选择' == certificatename){
			$.messager.alert('提示信息','请选择服务器证书','info');
			return;
		}
	}
	if($("#check_http").hasClass("active")){ 
		checktype = '1';
	}else{
		checktype = '2';
	}
	//////////健康检查必须选中，此处不再判断是否进行健康检查    zhanghl 2016.08.23//////////
	respovtime = $('#respovtime').textbox('getValue');
	if(isNaN(respovtime)){
		$.messager.alert('提示信息','响应超时时间请填写数字！', 'info');  
		return;
	}else if(respovtime<1 || respovtime>50){
		$.messager.alert('提示信息','响应超时时间范围为1-50秒！', 'info');
		return;
	}
	checkinterval = $('#checkinterval').textbox('getValue');
	if(isNaN(checkinterval)){
		$.messager.alert('提示信息','健康检查间隔请填写数字！', 'info');  
		return;
	}else if(checkinterval<1 || checkinterval>5){
		$.messager.alert('提示信息','健康检查间隔范围为1-5秒！', 'info');
		return;
	}
	health = $('#health').textbox('getValue');
	if(isNaN(health)){
		$.messager.alert('提示信息','健康阈值请填写数字！', 'info');  
		return;
	}else if(health<2 || health>10){
		$.messager.alert('提示信息','健康阈值范围为2-10次！', 'info');
		return;
	}
	nohealth = $('#nohealth').textbox('getValue');
	if(isNaN(nohealth)){
		$.messager.alert('提示信息','不健康阈值请填写数字！', 'info');  
		return;
	}else if(nohealth<2 || nohealth>10){
		$.messager.alert('提示信息','不健康阈值范围为2-10次！', 'info');
		return;
	}
	if("1" == checktype && "2" != listtype){  //协议类型为HTTP或者HTTPS且检查健康方式选择HTTP，才传递域名与路径
		domain = $('#domain').textbox('getValue');
		checkpath = $('#checkpath').textbox('getValue');
	}
	//////////健康检查必须选中，此处不再判断是否进行健康检查//////////
	
	var isreadip = 0;
	if("2" == listtype){
		var isreadip_flag = $('#isreadip_tcp').hasClass("active");
	}else{
		var isreadip_flag = $('#isreadip_').hasClass("active");
	}	
	if(isreadip_flag){
		isreadip = 1;
	}
	
	//新增TCP透传参数 By:zhanghl Date:2016.08.11
	var istcppass = 0;
	if("2" == listtype){
		var istcppass_flag = $('#istcppass_tcp').hasClass("active");
	}else{
		var istcppass_flag = $('#istcppass_').hasClass("active");
	}	
	if(istcppass_flag){
		istcppass = 1;
	}
	//新增数据压缩参数   zhanghl Date:2016.08.11
	var iscompression = 0;
	if("2" != listtype){
		var iscompression_flag = $("#iscompression_").hasClass("active");
		if(iscompression_flag){
			iscompression = 1;
		}
	}
	
	var issession = 0;
	if("2" != listtype){
		var issession_flag = $("#issession_").hasClass("active");
		if(issession_flag){
			issession = 1;
		}
	}
	var cookie = "";
	var timesum = "";
	if("2" != listtype && "1" == issession){//http和https协议使用
		cookie = $('#cookie').combobox('getValue');
		timesum = $('#timesum').textbox('getValue');
		if(null == timesum || "" == timesum){
			$.messager.alert('提示信息','请填写超时时间（s）/Cookie值！', 'info');
			return;
		}
		if(cookie==1 && isNaN(timesum )){
			$.messager.alert('提示信息','超时时间请填写数字！', 'info');
			return;
		}
	}
	
	$('#wCreateForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/saveLbListen.do', 
	    onSubmit : function(param) {
	    	param.lbid= $("#tabs_lbid").val();
			param.listport=listport;
			param.listname=listname;
			param.listtype=listtype;
			param.forwardrule=forwardrule;
			param.ischeck=ischeck;
			param.isreadip=isreadip;
			param.issession=issession;
			param.respovtime=respovtime;
			param.checkinterval=checkinterval;
			param.health=health;
			param.nohealth=nohealth;
			param.cookie=cookie;
			param.timesum=timesum;
			param.domain=domain;
			param.checkpath=checkpath;
			param.checktype=checktype;
			//传递证书、tcp透传、数据压缩属性
			param.istcppass=istcppass;
			param.iscompression=iscompression;
			param.certificateid=certificateid;
			param.certificatename=certificatename;
			param.cuserid=$("#cuserid").val();
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				$.messager.alert('提示信息','保存成功！', 'info');
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#listen_add_win').window('close');
	    }
	});
}

$(function() {
	$('#listport').textbox({//端口校验
		onChange: function(param){
			checkPort(param);
		}
	});
	$('#listport1').textbox({//端口校验
		onChange: function(param){
			checkPort1(param);
		}
	});

  	// 新增界面提示
    $('#tipIp').tooltip({
         position: 'right',
         content: '<span style="color:#333">获取真实ip，XXXXXXXXXX</span>',
         onShow: function() {
             $(this).tooltip('tip').css({
                 backgroundColor: '#f7f7f7',
                 borderColor: '#ddd'
             });
         }
     });
     $('#forwardruletip1').tooltip({
               position: 'bottom',
               content: '<span style="color:#333">负载方式：轮询模式、最小连接数、源IP</span>',
               onShow: function() {
                   $(this).tooltip('tip').css({
                       backgroundColor: '#f7f7f7',
                       borderColor: '#ddd'
                   });
               }
     });
     //增加监听类型提示  zhanghl 2016.08.22     
     $('#listtypetip1').tooltip({
         position: 'bottom',
         content: '<span style="color:#333">监听协议：HTTP、TCP、HTTPS</span>',
         onShow: function() {
             $(this).tooltip('tip').css({
                 backgroundColor: '#f7f7f7',
                 borderColor: '#ddd'
             });
         }
     });
	// 修改界面提示
    $('#tipIp1').tooltip({
         position: 'right',
         content: '<span style="color:#333">获取真实ip，XXXXXXXXXX</span>',
         onShow: function() {
             $(this).tooltip('tip').css({
                 backgroundColor: '#f7f7f7',
                 borderColor: '#ddd'
             });
         }
     });
     $('#forwardruletip11').tooltip({
               position: 'bottom',
               content: '<span style="color:#333">负载方式：轮询模式、最小连接数、源IP</span>',
               onShow: function() {
                   $(this).tooltip('tip').css({
                       backgroundColor: '#f7f7f7',
                       borderColor: '#ddd'
                   });
               }
     });
   //增加监听类型提示  zhanghl 2016.08.22     
     $('#listtypetip11').tooltip({
         position: 'bottom',
         content: '<span style="color:#333">监听协议：HTTP、TCP、HTTPS</span>',
         onShow: function() {
             $(this).tooltip('tip').css({
                 backgroundColor: '#f7f7f7',
                 borderColor: '#ddd'
             });
         }
     });
	
	// 新增界面-tcp http选择改变
    $('#listtype').combobox({//监听协议类型
		onSelect: function(param){
			 selectTab();
		}
	});

	$('#issession_').bind("click", function() {
			   var listtype = $('#listtype').combobox('getValue');
			   if(listtype=='1' || listtype=='3'){
			   		$(this).toggleClass('active');
			   }
			   if($(this).hasClass("active") && (listtype=='1' || listtype=='3')){
					$('#isession_div').removeClass('http-tcp-gray');
			   }else if(!$(this).hasClass("active")  && (listtype=='1' || listtype=='3')){
					$('#isession_div').addClass('http-tcp-gray');
			   }
	});
	$('#issession1_').bind("click", function() {
			   var listtype = $('#listtype1').combobox('getValue');
			   if(listtype=='1' || listtype=='3'){
			   		$(this).toggleClass('active');
			   }
			   if($(this).hasClass("active") && (listtype=='1' || listtype=='3') ){
					$('#isession_div1   .j-http').removeClass('http-tcp-gray');
			   }else if(!$(this).hasClass("active")  && (listtype=='1' || listtype=='3') ){
					$('#isession_div1   .j-http').addClass('http-tcp-gray');
			   }
	});
	
	//后端服务器端口校验
	$('#vm_backport_sev').textbox({//端口
		onChange: function(param){
			checkPort1(param);
		}
	});
	$('#ebackport_sev').textbox({//端口
		onChange: function(param){
			checkPort1(param);
		}
	});
});
function saveAppnettype(){ 
	var listname = $('#listname3').textbox('getValue');
	var daddr = $('#lb_daddr').textbox('getValue');
	if(null == daddr || "" == daddr){
		$.messager.alert('提示信息','请填写目的地址！', 'info');
		return;
	}
	var dport = $('#lb_dport').textbox('getValue');
	if(null == dport || "" == dport){
		$.messager.alert('提示信息','请填写目的端口！', 'info');
		return;
	}
	var transferaddr = $('#lb_transferaddr').textbox('getValue');
	var transferport = $('#lb_transferport').textbox('getValue');
	var description = $('#lb_description').textbox('getValue');
	
	var listtype = $('#lb_listtype').combobox('getValue');
	var saddr = $('#lb_saddr').combobox('getValue');
	if(null == saddr || "" == saddr){
		$.messager.alert('提示信息','请填写源地址！', 'info');
		return;
	}
	var optype = $('#save_type').val();
	var nat_manip = $('#nat_manip').val();
	
	var serverip = $('#serverip').val();
	var backport = $('#backport').val();
	$('#appnetForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/saveInternetPub.do', 
	    onSubmit : function(param) {
	    	param.lbid= $("#tabs_lbid").val();
			param.listport=transferport;
			param.listname=listname;
			param.daddr=daddr;
			param.dport=dport;
			param.transferaddr=transferaddr;
			param.transferport=transferport;
			param.description=listtype;
			param.listtype=listtype;
			param.saddr=saddr;
			param.optype=optype;
			param.optype=optype;
			param.description=description;
			param.manip=nat_manip;
			
			param.serverip=serverip; //后端服务器ip
			param.backport=backport; //后端服务器端口
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				$.messager.alert('提示信息','保存成功！', 'info'); 
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#lbappnettype0').window('close');
	    }
	});
}

function addLbServer(){
	debugger;
	var lbname = $('#lbname_sev').textbox('getValue');
	if(null == lbname || "" == lbname){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var listport = $('#listport_v_sev').textbox('getValue');
	if(null == listport || "" == listport){
		$.messager.alert('提示信息','请选择端口！', 'info');
		return;
	}
	var appname = $('#appname_sev').val();
	var serverid = $('#vms_sev').combobox('getValue');
	if(null == serverid || "" == serverid){
		$.messager.alert('提示信息','请选择主机！', 'info');
		return;
	}
	var serverip = $('#vm_ip_sev').combobox('getValue');
	if(null == serverip || "" == serverip){
		$.messager.alert('提示信息','请选择主机IP！', 'info');
		return;
	}
	var backport = $('#vm_backport_sev').textbox('getValue');
	var type="^[0-9]*[1-9][0-9]*$"; 
	var re = new RegExp(type); 
	if(isNaN(backport)){
		$.messager.alert('提示信息','后端协议端口请填写数字！', 'info');  
		return;
	}else if(backport<1 || backport>65535){
		$.messager.alert('提示信息','后端协议端口范围为1-65535！', 'info'); 
		return;
	}else if(backport.match(re)==null){
		$.messager.alert('提示信息','请输入正整数！', 'info'); 
		return;
	}
	var weight = $('#weight_sev').textbox('getValue');
	if(null == weight || "" == weight){
		$.messager.alert('提示信息','请输入权重！', 'info');
		return;
	}
	if(isNaN(weight)){
		$.messager.alert('提示信息','权重要求填写数字！', 'info');
		return;
	}
	if(weight > 100 || weight < 0){
		$.messager.alert('提示信息','权重填写范围为0-100！', 'info');
		return;
	}
	var servername = $('#servername').val();
	//$('#windowBackedConfigAdd').dialog('close');
	var acl= $('#acl_sev').combobox('getValue');
	$('#w2CreateForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/saveLbServer.do', 
	    onSubmit : function(param) {
	    	param.lbid= $("#tabs_lbid").val();
			param.lbname=lbname;
			param.listport=listport;
			param.serverid=serverid;
			param.serverip=serverip;
			param.backport=backport;
			param.weight=weight;
			param.acl=acl;
			//param.appname=appname;
			param.servername=servername;
			param.cuserid= $("#cuserid").val();
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.success) {
				$.messager.alert('提示信息','保存成功！', ''); 
				loadDataGrid1();
				$('#windowBackedConfigAdd').window('close');
			} else {
				if(_data.msg=='该服务器配置信息已存在，请更改！'){
					$.messager.alert('提示信息','该服务器配置信息已存在，请更改！', 'error'); 
				}else{
					$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
					$('#windowBackedConfigAdd').window('close');
				}
			}
			
	    }
	});
}
function delbefore1(serverid,backport,listport,serverip,acl){
	$.messager.confirm('系统提示信息', '当前配置删除后无法恢复，请谨慎操作，确定删除吗？', function(r){
		if (r){
			$('#vmManForm').form('submit',{
			    url:'${pageContext.request.contextPath}/lb/deleteLbServer.do', 
			    onSubmit : function(param) {
			    	param.lbid= $("#tabs_lbid").val();
					param.serverid=serverid;
					param.backport=backport;
					param.serverip=serverip;
					param.listport=listport;
					param.acl=acl;
				},
			    success:function(retr){
			    	var _data = $.parseJSON(retr);
					if (_data.success) {
						$.messager.alert('提示', _data.msg, 'info');
						loadDataGrid1();
					} else {
						$.messager.alert('提示', _data.msg, 'error');
					}
			    }
			});
		}
	});
}

</script>
</body>