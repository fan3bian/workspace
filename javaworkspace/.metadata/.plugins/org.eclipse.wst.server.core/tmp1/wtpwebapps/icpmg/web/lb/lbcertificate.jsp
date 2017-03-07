<%@ page contentType="text/html; charset=utf-8" import="java.util.*" language="java"%>	
<body>
<style type="text/css">
.FieldInput2 {
	width: 75%;
	height: 25px;
	background-color: #FFFFFF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	border: #BCD2EE 1px solid !important;
}
.FieldLabel2 {
	width: 25%;
	height: 25px;
	background-color: #F0F8FF;
	font: normal 12px tahoma, arial, helvetica, sans-serif;
	text-align: left;
	word-wrap: break-word;
	padding-top: 0px !important;
	padding-bottom: 0px !important;
	padding-right: 10px !important;
	border: #BCD2EE 1px solid !important;
}
</style>	
<script type="text/javascript">
var certgrid;//服务器证书数据网格
var certtoolbar = [{
					text:'新增服务器证书',
					iconCls:'icon-add',
					handler:function(){ 
						$('#certAddForm').form('clear');
						$('#wAddCert').attr('style','visibility:visible');
						$('#wAddCert').window('open');
					}
				}
                     ];
$(document).ready(function() {
	loadDataGrid();
	});

//新增证书
function addLbCert(){
	var certificatename = $("#certificatename").val();
	if(null == certificatename || "" == certificatename){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var content = $("#content").val();
	if(null == content || "" == content){
		$.messager.alert('提示信息','请填写证书内容！', 'info');
		return;
	}
	var privatekey = $("#privatekey").val();
	if(null == privatekey || "" == privatekey){
		$.messager.alert('提示信息','请填写私钥！', 'info');
		return;
	}
	if(!checkContent(content)){
		$.messager.alert('提示信息','证书内容格式不正确！', 'info');
		return;
	}
	if(!checkPrivatekey(privatekey)){
		$.messager.alert('提示信息','私钥格式不正确！', 'info');
		return;
	}
	
	$('#certAddForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/saveLbCert.do', 
	    onSubmit : function(param) {
	    	param.certificatename= certificatename;
			param.content=content;
			param.privatekey=privatekey;
			param.lbid= $("#tabs_lbid").val();
			param.cuserid= $("#cuserid").val();
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.flag) {
				$.messager.alert('提示信息','保存成功！', 'info'); 
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#wAddCert').window('close');
	    }
	});
	
} 
function CertModify(){
	var certificatename = $("#ecertificatename").val();
	if(null == certificatename || "" == certificatename){
		$.messager.alert('提示信息','请填写名称！', 'info');
		return;
	}
	var content = $("#econtent").val();
	if(null == content || "" == content){
		$.messager.alert('提示信息','请填写证书内容！', 'info');
		return;
	}
	var privatekey = $("#eprivatekey").val();
	if(null == privatekey || "" == privatekey){
		$.messager.alert('提示信息','请填写私钥！', 'info');
		return;
	}
	if(!checkContent(content)){
		$.messager.alert('提示信息','证书内容格式不正确！', 'info');
		return;
	}
	if(!checkPrivatekey(privatekey)){
		$.messager.alert('提示信息','私钥格式不正确！', 'info');
		return;
	}
	var certificateid= $('#certificateid').val();
	var lbid = $('#elbid').val();
	$('#certModForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/lbCertModify.do', 
	    onSubmit : function(param) {
	    	param.certificatename=certificatename;
			param.content=content;
			param.privatekey=privatekey;
			param.certificateid=certificateid;
			param.lbid=lbid;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
			if (_data.flag) {
				$.messager.alert('提示信息','保存成功！', 'info'); 
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','保存发生错误，请重试！', 'error'); 
			}
			$('#wModCert').window('close');
	    }
	});
	
}	

//证书内容格式校验
function checkContent(content){
	var patrnBegin=/^\s*-----BEGIN CERTIFICATE-----/;
	var patrnEnd=/-----END CERTIFICATE-----\s*$/;
	if(patrnBegin.test(content) && patrnEnd.test(content)){
		return true;
	}
	return false;
}

//私钥格式校验
function checkPrivatekey(privatekey){
	var patrnBegin=/^\s*-----BEGIN RSA PRIVATE KEY-----/;
	var patrnEnd=/-----END RSA PRIVATE KEY-----\s*$/;
	if(patrnBegin.test(privatekey) && patrnEnd.test(privatekey)){
		return true;
	}
	return false;
}


//查询结果
function loadDataGrid(){
	certgrid = $('#cert_grid').datagrid({
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
		toolbar:certtoolbar,
		//将Action修改为服务器证书对应的Action
	    url:'${pageContext.request.contextPath}/lb/queryLbCert.do?lbid=' + $("#tabs_lbid").val(),
	    onLoadSuccess: function (data) {
		      var pageopt = $('#cert_grid').datagrid('getPager').data("pagination").options;
		      var  _pageSize = pageopt.pageSize;
		      var  _rows = $('#cert_grid').datagrid("getRows").length;
		      var total = pageopt.total;
		        
		      if (_pageSize >= 10) {
		         for(var i=10;i>_rows;i--){
		            $(this).datagrid('appendRow', {lbid :''  });
		         }
		         $('#cert_grid').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
			    		total: total,
			     });
		       
		      }else{
		         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
		      }
		      var rows = data.rows;
		      if (rows.length) {
					 $.each(rows, function (idx, val) {
						if   (val.lbid ==''){ 
							$('#cert_grid_div input:checkbox').eq(idx+1).css("display","none");
						}
					}); 
		      }
		      
		      for(var i = 0; i < data.rows.length; i++){//增加提示  zhanghl 20160902
		    	  addTooltip('<div><p>相关应用服务：' + data.rows[i].listens + '</div>', 'certUsestat-' + i);
		      }
		      
		      $('.j-edit-forward').linkbutton({
                    iconCls: 'icon-edit',
                   plain: true
              });
              $('.j-delete-forward').linkbutton({
                   iconCls: 'icon-delete',
                   plain: true
              });
              
              $('#wAddCert').dialog({
		            title: "新增服务器证书",
		            width: 500,
		            height: 215,
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
		                	addLbCert();
		                }
		            }, {
		                text: '取消',
		                iconCls: 'icon-cancel',
		                handler: function() {
		                    $('#wAddCert').dialog('close');

                }
          	  }]
      		 });
         	$('#wModCert').dialog({
		            title: "修改服务器证书",
		            width: 500,
		            height: 215,
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
		                	CertModify();
		                }
		            }, {
		                text: '取消',
		                iconCls: 'icon-cancel',
		                handler: function() {
		                    $('#wModCert').dialog('close');

                }
            }]
        	});
		 }
	 }); 
}
function reset(){
	$('#cert_grid').datagrid('load',{});
} 

function addTooltip(tooltipContentStr,tootipId){   
	  $('#'+tootipId).tooltip({  
	     position: 'right',  
	     content: tooltipContentStr,
	     deltaX: -110,
	     onShow: function(){  
	     	$(this).tooltip('tip').css({
	     		backgroundColor: '#ecf5fd',
	      		borderColor: '#bbd2ea'  
			});
	     }     
	  }); 
}

function typeformatter(value,row,index){
	switch(value){
		case "0":
			return '<span>未使用</span>';
		case "1":
			return '<div id="certUsestat-' + index + '" style="width:auto;">' + '<span style="color:#2b9af0"">已使用</span>' + '</div>';
	}
}


function editCertMethod(certificateid,certificatename,content,privatekey,lbid){
	$('#ecertificatename').val(certificatename);
	$('#econtent').val(content);
	$('#eprivatekey').val(privatekey)
	$('#elbid').val(lbid);
	$('#certificateid').val(certificateid);
	$('#wModCert').attr('style','visibility:visible');
	$('#wModCert').window('open');
}


function optionformatter(value, row, index) {
	if(!value){
		return "";
	}
	return '<a href="#" onclick="editcertificate('+ index + ')" class="j-edit-forward" title="修改" ></a><span class="gproducts-partingline">|</span><a href="#" onclick="deletecertificate('+ index + ')" class="j-delete-forward" title="删除"></a>';
}

function editcertificate(index){
	var row = $('#cert_grid').datagrid('getData').rows[index];
	var usestat = row.usestat;
	certificateid = row.certificateid;
	certificatename = row.certificatename;
	content = row.content;
	privatekey = row.privatekey;
	lbid = row.lbid;
	if(usestat == "0"){
		editCertMethod(certificateid,certificatename,content,privatekey,lbid);
	}else{
		$('#certificateModTip').dialog({
			closed : false
		});
		$('#certificateModTipText').html('此证书已被使用，修改会对使用该证书的应用服务产生影响，<br />您确定要对其进行修改吗？');
		$('#certificateModTip').dialog({
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				handler : function() {
					editCertMethod(certificateid,certificatename,content,privatekey,lbid);
					$('#certificateModTip').dialog('close');
				}
			}, {
				text : '取消',
				iconCls : 'icon-cancel',
				handler : function() {
					$('#certificateModTip').dialog('close');
				}
			} ]
		});
	}
}

function deletecertificate(index) {
	var row = $('#cert_grid').datagrid('getData').rows[index];
	var usestat = row.usestat;
	var certificateid = row.certificateid;
	var lbid = row.lbid;
	if (usestat == "1") {
		$('#certificateDelTip').dialog({
			closed : false
		});
		$('#certificateDelTipText').html('此证书已被使用，删除会对使用该证书的应用服务产生影响。<br /><br />    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如果您确定要删除此证书，请返回<span style="color:#5099fd">应用服务列表</span>找到使<br />用此证书的应用服务解除该证书和应用服务的关联关系。');
		} else {
			$('#certificateDelTip2').dialog({
				closed : false
			});
			$('#certificateDelTip2Text').html('证书信息一经删除将不可恢复，您确定要执行此操作吗？');
			$('#certificateDelTip2').dialog({
				collapsible : false,
				minimizable : false,
				maximizable : false,
				resizable : false,
				buttons : [ {
					text : '确定',
					iconCls : 'icon-ok',
					handler : function() {
						delCertMethod(certificateid,lbid);
						$('#certificateDelTip2').dialog('close');
					}
				}, {
					text : '取消',
					iconCls : 'icon-cancel',
					handler : function() {
						$('#certificateDelTip2').dialog('close');
					}
				} ]
			});
		}
		event.stopPropagation();
}

function delCertMethod(certificateid,lbid){
	$('#certQueryForm').form('submit',{
	    url:'${pageContext.request.contextPath}/lb/deleteCert.do', 
	    onSubmit : function(param) {
	    	param.certificateid= certificateid;
	    	param.lbid = lbid;
		},
	    success:function(retr){
	    	var _data = $.parseJSON(retr);
	    	if (_data.flag) {
				$.messager.alert('提示信息','删除成功！', 'info');
				loadDataGrid();
			} else {
				$.messager.alert('提示信息','删除发生错误，请重试！', 'error'); 
			}
	    }
	});
}
//样例内容
$('#certificateTipyl1').linkbutton({
	iconCls : 'icon-html'
	});
$('#certificateTipyl2').linkbutton({
	iconCls : 'icon-html'
	});
$('#certificateTipyl3').linkbutton({
	iconCls : 'icon-html'
	});
$('#certificateTipyl4').linkbutton({
	iconCls : 'icon-html'
	});

$('#certificateTipyl1').click(
		function(event) {
			var str = '-----BEGIN CERTIFICATE----- MIIFRzCCBC+gAwIBAgIHSyW9yrLTdzANBgkqhkiG9w0BAQUFADCByjELMAkGA1UEBhMCVVMxEDAOBgNVBAgTB0FyaXpvbmExEzARBgNVBAcTClNjb3R0c2RhbGUxGjAYBgNVBAoTEUdvRGFkZHkuY29tLCBJbmMuMTMwMQYDVQQLEypodHRwOi8vY2VydGlmaWNhdGVzLmdvZGFkZHkuY29tL3JlcG9zaXRvcnkxMDAuBgNVBAMTJ0dvIERhZGR5......\r\n 0jFV1vvczYwIQaEr+1iZXxgZC2itR4hbX3D3JN7WnPWJp+8LJpwkZeCXDL4t2GK8G4/6MpCRBK936qU=\r\n-----END CERTIFICATE-----';
			$(this).prev('textarea').html(str);
			$(this).prev('textarea').val(str);
	});
$('#certificateTipyl2').click(
		function(event) {
			$(this).prev('textarea').val('');
			var str = '-----BEGIN RSA PRIVATE KEY-----MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8GJMCnGlRJP/yw0cjaDmVDSW0hUZrWmvoFWyrtZxh4YZpsimk6Fep98gFGOLLYfo7NNxQEXFe9oZBYQeD8GRMlych5LprSbtJkFg86PlNp6o0CRaRG1sjwvx/ilv/FyVZgWYrn1uknXu/sqYjoD8L/AoeO7YGaP+2e2qR1/VM2bfDvDJefMUphLnGcyscutEivoY7bhR1i+U/1swUJ4QfoHivTkgr+VqIv4S70Glmp/cVhdTUI8/ZOTs23AdOEjYUZZuWPMt8qR8Y\r\n ......\r\n 7LZIJjTM48Zqpjz20wFp/oyJXVnrnELVi1qQdG0UmRuMdnJwRec7hMN/qJg4UL6EQgMEkOOZKQ+0axw8B7td1y1Kk9H3yctm0dhkUUKtF9RSbJFH1zW2lCPw3O1YZTTXwp6Bjckfsi4SndD7h+punihjgctBO+CVu7r2ZHIhAoGAJsjvpWECOV/1n9SlsSS3hZFSOg2SojJX2aeu3LvWw318fuzmQH6L6PHWuIJDSGx5gJlT6WfHMwmTnTo7X0k1otCp5JUB5a/GqAzvcja9Y/XARViFRvmPs1trGSRwzxQr4Hj8HWAyvyx3m8hT3VinQRE08NOYtlxbCE/Iymu+BtU=\r\n-----END RSA PRIVATE KEY-----'
			$(this).prev('textarea').html(str);
			$(this).prev('textarea').val(str);
	});
$('#certificateTipyl3').click(
		function(event) {
			var str = '-----BEGIN CERTIFICATE----- MIIFRzCCBC+gAwIBAgIHSyW9yrLTdzANBgkqhkiG9w0BAQUFADCByjELMAkGA1UEBhMCVVMxEDAOBgNVBAgTB0FyaXpvbmExEzARBgNVBAcTClNjb3R0c2RhbGUxGjAYBgNVBAoTEUdvRGFkZHkuY29tLCBJbmMuMTMwMQYDVQQLEypodHRwOi8vY2VydGlmaWNhdGVzLmdvZGFkZHkuY29tL3JlcG9zaXRvcnkxMDAuBgNVBAMTJ0dvIERhZGR5......\r\n 0jFV1vvczYwIQaEr+1iZXxgZC2itR4hbX3D3JN7WnPWJp+8LJpwkZeCXDL4t2GK8G4/6MpCRBK936qU=\r\n-----END CERTIFICATE-----';
			$(this).prev('textarea').html(str);
			$(this).prev('textarea').val(str);
	});
$('#certificateTipyl4').click(
		function(event) {
			$(this).prev('textarea').val('');
			var str = '-----BEGIN RSA PRIVATE KEY-----MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8GJMCnGlRJP/yw0cjaDmVDSW0hUZrWmvoFWyrtZxh4YZpsimk6Fep98gFGOLLYfo7NNxQEXFe9oZBYQeD8GRMlych5LprSbtJkFg86PlNp6o0CRaRG1sjwvx/ilv/FyVZgWYrn1uknXu/sqYjoD8L/AoeO7YGaP+2e2qR1/VM2bfDvDJefMUphLnGcyscutEivoY7bhR1i+U/1swUJ4QfoHivTkgr+VqIv4S70Glmp/cVhdTUI8/ZOTs23AdOEjYUZZuWPMt8qR8Y\r\n ......\r\n 7LZIJjTM48Zqpjz20wFp/oyJXVnrnELVi1qQdG0UmRuMdnJwRec7hMN/qJg4UL6EQgMEkOOZKQ+0axw8B7td1y1Kk9H3yctm0dhkUUKtF9RSbJFH1zW2lCPw3O1YZTTXwp6Bjckfsi4SndD7h+punihjgctBO+CVu7r2ZHIhAoGAJsjvpWECOV/1n9SlsSS3hZFSOg2SojJX2aeu3LvWw318fuzmQH6L6PHWuIJDSGx5gJlT6WfHMwmTnTo7X0k1otCp5JUB5a/GqAzvcja9Y/XARViFRvmPs1trGSRwzxQr4Hj8HWAyvyx3m8hT3VinQRE08NOYtlxbCE/Iymu+BtU=\r\n-----END RSA PRIVATE KEY-----'
			$(this).prev('textarea').html(str);
			$(this).prev('textarea').val(str);
	});
</script>
<form id="certQueryForm"></form>
	<div data-options="region:'center',border:false" id="cert_grid_div">
		<table title="" style="width:100%;"  id="cert_grid">
			<thead>
				<tr>
					<th data-options="field:'certificatename',width:60,align:'center'">名称</th>
					<th data-options="field:'usestat',width:60,align:'center',formatter:typeformatter">使用状态</th>
					<th data-options="field:'ctime',width:60,align:'center'">创建时间</th> 
					<th data-options="field:'lbid',width:50,align:'center',formatter:optionformatter">操作</th>
				</tr>
			</thead>
		</table>
	</div>  
	
<!-- 新增服务器证书     -->
    <div id="wAddCert" class="pop" style="visibility: hidden;">
        <div class="j-tabs-con">
       		<form action="" id="certAddForm">
            	<div class="item3">
                	<div class="item-wrap">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
                        <tr>
                            <td align="right" width="20%">名称：</td>
                            <td align="left">
                                <input id="certificatename" type="text" class="shadow-input" style="width: 265px;">
                                <span class="must-star">*</span>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">证书内容：</td>
                            <td align="left">
                                <textarea id="content" class="shadow-input" style="width: 265px; height: 90px;vertical-align: top; overflow-y:auto;" rows="10"></textarea>
                                <a href="#" id="certificateTipyl1">样例</a>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">私钥：</td>
                            <td align="left">
                                <textarea id="privatekey" class="shadow-input" style="width: 265px;height: 90px;vertical-align: top;overflow-y:auto;" rows="10"></textarea>
                                <a href="#" id="certificateTipyl2">样例</a>
                            </td>
                        </tr>
                     </table>
                	</div>
            	</div>
            </form>
        </div>
    </div>

	<div id="wModCert" class="pop" style="visibility: hidden;">
		<div class="j-tabs-con">
			<form id="certModForm" method="post" data-options="novalidate:true">
				<div class="item3">
					<div class="item-wrap">
						<input type="hidden" id="elbid" />
						<input type="hidden"id="certificateid" />
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-layout">
							<tr>
								<td align="right" width="20%">名称：</td>
								<td align="left">
								    <input id="ecertificatename"type="text" class="shadow-input" style="width: 265px;">
									<span class="must-star">*</span>
								</td>
							</tr>
							<tr>
                                <td align="right">证书内容：</td>
                                <td align="left">
                                    <textarea id="econtent" class="shadow-input" style="width: 265px; height: 90px;vertical-align: top; overflow-y:auto;" rows="10"></textarea>
                                    <a href="#" id="certificateTipyl3">样例</a>
                                </td>
                            </tr>
							<tr>
                                <td align="right">私钥：</td>
                                <td align="left">
                                    <textarea id="eprivatekey" class="shadow-input" style="width: 265px;height: 90px;vertical-align: top;overflow-y:auto;" rows="10"></textarea>
                                    <a href="#" id="certificateTipyl4">样例</a>
                                </td>
                            </tr>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<!-- 提示弹层 -->
	<!-- 证书已使用，删除提示 -->
    <div id="certificateDelTip" class="easyui-dialog" data-options=" modal:true,closed: true,title:'提示', buttons: [{
                text: '知道了',
                iconCls: 'icon-ok',
                handler: function() {
                    $('#certificateDelTip').dialog('close');
                }
            }]" style="padding:20px 20px 30px;width:450px;">
        <p><span class="ytip"></span><span class="ytip-text" id="certificateDelTipText"></span></p>
    </div>
    <!-- 证书未使用，删除提示 -->
    <div id="certificateDelTip2" class="easyui-dialog" data-options=" modal:true,closed: true,title:'提示'" style="padding:20px 20px 30px;width:450px;">
        <p><span class="ywarning"></span><span class="ytip-text" id="certificateDelTip2Text"></span></p>
    </div>
    <!-- 证书已使用，修改提示 -->
    <div id="certificateModTip" class="easyui-dialog" data-options=" modal:true,closed: true,title:'提示'" style="padding:20px 20px 30px;width:450px;">
        <p><span class="ywarning"></span><span class="ytip-text" id="certificateModTipText"></span></p>
    </div>

</body>
