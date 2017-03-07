<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>
<style type="text/css">
.dialogWrapper{background:#fff;width:750px;margin:0 auto;overflow:hidden;padding:30px 10px 20px 20px;}
.dialogWrapper .left{width:350px;float:left;margin-right:10px;overflow:hidden;}
.dialogWrapper .line{margin-bottom:5px;width:100%;overflow:hidden;float:left;}
.dialogWrapper .line label{display:inline-block;width:120px;text-align:right;}
.dialogWrapper .line label span{color:#ff3030;padding:0px 5px;}
.dialogWrapper .line input{width:200px;}
.dialogWrapper .line .location{width:100px;}
.dialogWrapper .line .trade{width:200px;}
.dialogWrapper .line .pwpp{width:200px;}
.dialogWrapper .line .khlx{width:200px;}
.dialogWrapper .line .ljtj{width:200px;}
fieldset{color:#333; border:#06c dashed 1px;}
</style>

<script type="text/javascript" charset="utf-8">
var reqestUrl;
$(function(){
	clearAddAllMsg();
	$('#acorpinfodiv').hide();
	$('#agovmtinfodiv').hide();
	//设置缺省的请求路径
	reqestUrl = '${pageContext.request.contextPath}/userMgr/saveGovmtInfo.do';
	
});

/* function onSelectChange(obj,toSelId){
	setSelect(obj.value,toSelId);
} */
/* function onTradeSelChange(obj,toSelId){
	if('twoid' == toSelId){
		var threeidobj = document.getElementById("threeid");
		threeidobj.options.length=0;
		var nullOp = document.createElement("option");
		nullOp.setAttribute("value","");
		nullOp.appendChild(document.createTextNode("请选择"));
		threeidobj.appendChild(nullOp);
	}
	setTradeSelect(obj.value,toSelId);
} */
function setSelect(fromSelVal,toSelId){
	document.getElementById(toSelId).innerHTML="";
	jQuery.ajax({
	  url:"${pageContext.request.contextPath}/userMgr/provcity.do",
	  cache: false,
	  data:"parentId="+fromSelVal,
	  success: function(data){
	  	createSelectObj(data,toSelId);
	  }
	});
} 
 function setTradeSelect(fromSelVal,toSelId){
	document.getElementById(toSelId).innerHTML="";
	jQuery.ajax({
	  url:"${pageContext.request.contextPath}/userMgr/trade.do",
	  cache: false,
	  data:"tradePrtId="+fromSelVal,
	  success: function(data){
	  	createSelectObj(data,toSelId);
	  }
	});
} 
/* function createSelectObj(data,toSelId){
	var arr = jsonParse(data);
	//var arr = $.parseJSON(data);	//将字符串转化为json对象
	
	if(arr != null && arr.length > 0){
		var obj = document.getElementById(toSelId);
		obj.innerHTML="";
		var nullOp = document.createElement("option");
		nullOp.setAttribute("value","");
		nullOp.appendChild(document.createTextNode("请选择"));
		obj.appendChild(nullOp);
		for(var o in arr){
			var op = document.createElement("option");
			op.setAttribute("value",arr[o].id);
			//op.text=arr[o].name;//这一句在ie下不起作用，用下面这一句或者innerHTML
			op.appendChild(document.createTextNode(arr[o].name));
			obj.appendChild(op);
		}
	}
} */
/* function getProvCityName(){
	var providobj = document.getElementById("aprovid");
	var cityidobj = document.getElementById("acityid");
	var provnameobj = document.getElementById("provname");
	var citynameobj = document.getElementById("cityname");
	provnameobj.setAttribute("value", providobj.options[providobj.selectedIndex].text);
	citynameobj.setAttribute("value", cityidobj.options[cityidobj.selectedIndex].text);
}
function getTradeName(){
	var oneidobj = document.getElementById("aoneid");
	var twoidobj = document.getElementById("atwoid");
	var threeidobj = document.getElementById("athreeid");
	
	var oneidnameobj = document.getElementById("oneidname");
	var twoidnameobj = document.getElementById("twoidname");
	var threeidnameobj = document.getElementById("threeidname");
	oneidnameobj.setAttribute("value", oneidobj.options[oneidobj.selectedIndex].text);
	twoidnameobj.setAttribute("value", twoidobj.options[twoidobj.selectedIndex].text);
	threeidnameobj.setAttribute("value", threeidobj.options[threeidobj.selectedIndex].text);
} */

//点击客户类型
function clickkhlx(){
	var khlx = $('.khlx').val();		//客户类型
	var yhdj = $('#aauserlevel').val();	//账号等级
	
	if(yhdj == 1 && khlx == 1){
		$('#acorpinfodiv input').val('');
		$('#acorpinfodiv').hide();
		$('#agovmtinfodiv').show();
		reqestUrl = '${pageContext.request.contextPath}/userMgr/saveGovmtInfo.do';
		comboxselect(); 
	}else if(yhdj == 1 && khlx == 2){
		$('#agovmtinfodiv input').val('');
		$('#agovmtinfodiv').hide();
		$('#acorpinfodiv').show();
		reqestUrl = '${pageContext.request.contextPath}/userMgr/saveCorpInfo.do';
	}else{
		$('#agovmtinfodiv input').val('');
		$('#acorpinfodiv input').val('');
		$('#acorpinfodiv').hide();
		$('#agovmtinfodiv').hide();
		reqestUrl = '${pageContext.request.contextPath}/authMgr/addUser.do';
	}
	
}
//添加子帐号，显示或隐藏父帐号字段
function add_showPemailDiv(obj){
	$('#apemail').val('');
	if (obj.checked) {
		$('#apemaildiv').show();
		$('#abiwaydiv').show();
		$('#acorpinfodiv').hide();
		$('#agovmtinfodiv').hide();
		$('#aauserlevel').val("2");
		//$('#auserlevel').val("2");
		$('#agovmtinfodiv input').val('');
		$('#acorpinfodiv input').val('');
	} else {
		$('#apemaildiv').hide();
		$('#abiwaydiv').hide();
		$('#aauserlevel').val("1");
		if($('.khlx').val() == 1){
			$('#agovmtinfodiv input').val('');
			$('#agovmtinfodiv').show();
			comboxselect();
		}else if($('.khlx').val() == 2){
			$('#acorpinfodiv input').val('');
			$('#acorpinfodiv').show();
		}else{
			$('#acorpinfodiv').hide();
			$('#agovmtinfodiv').hide();
			$('#agovmtinfodiv input').val('');
			$('#acorpinfodiv input').val('');
		}
	}
}
//下拉框显示
function comboxselect(){
		$('#oneunitid').combobox({    
   						valueField: 'unitId',    
                         textField: 'unitName',
                         editable:true,
                         loadFilter:function(data){
	                 data.unshift({unitId:'',unitName:'请选择'});
	                 return data;
	               },
                         url: '${pageContext.request.contextPath}/project/getUnitsForRegist.do',
                        onSelect: function(rec){    
                       var urlson = '${pageContext.request.contextPath}/project/getUnitsForRegistNext.do?unitid='+rec.unitId;    
                 	  
            	    $('#twounitid').combobox({    
                    url:urlson,    
                    valueField:'unitId',    
                    textField:'unitName',  
                    editable:true,
	             onLoadSuccess: function () { //加载完成后,设置选中第一项
              var data = $('#twounitid').combobox('getData');
             if (data.length > 0) {
                 $('#twounitid').combobox('select', data[0].unitId);
             } 
            }   
         }).combobox('clear');
                
          },
               onLoadSuccess: function () { //加载完成后,设置选中第一项
               jQuery('#twounitid').combobox('clear');
                var parentId= $('#oneunitid').combobox('getValue');  
                var url2='${pageContext.request.contextPath}/project/getUnitsForRegistNext.do?unitid='+parentId; 
                $('#twounitid').combobox('reload', url2);  
                
            }    
	}); 
}
function validEmail(email){
	var flag = true;
	if(email != ''){
		$.ajax({
			url:"${pageContext.request.contextPath}/userMgr/validEmail.do",
			cache: false,
		 	async: false,
		  	data:{
		  		email:email
		  	},
		  	success: function(b){
		  		var r = $.parseJSON(b);
				if(r.success){
					if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
						document.getElementById('aemailtips').textContent = r.msg;
					}else{
						document.getElementById('aemailtips').innerText = r.msg;
					}
		  			flag = false;
				}else{
					if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
						document.getElementById('aemailtips').textContent = r.msg;
					}else{
						document.getElementById('aemailtips').innerText = r.msg;
					}
					flag = true;
				}
		  	}
		});
	}
	return flag;
}

function validAlias(alias){
	var flag = true;
	if(alias != ''){
		$.ajax({
			url:"${pageContext.request.contextPath}/userMgr/validAlias.do",
			cache: false,
		 	async: false,
		  	data:{
		  		alias:alias
		  	},
		  	success: function(b){
		  		var r = $.parseJSON(b);
				if(r.success){
					if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
						document.getElementById('aaliastips').textContent = r.msg;
					}else{
						document.getElementById('aaliastips').innerText = r.msg;
					}
		  			flag = false;
				}else{
					if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
						document.getElementById('aaliastips').textContent = r.msg;
					}else{
						document.getElementById('aaliastips').innerText = r.msg;
					}
					flag = true;
				}
		  	}
		});
	}
	return flag;
}

//表单提交时验证
function addCheck(){
	var isValid = false;
	
	//动态设置 扣费方式--子账号时
	var userlevelobj = document.getElementById("auserlevel");	//获取复选框obj
	if(userlevelobj.checked){
		if(user_add_addForm.gdbiway[0].checked){
			$('#biway').val('0');	
		}
		if(user_add_addForm.gdbiway[1].checked){
			$('#biway').val('1');
		}
	}
	
	isValid = $('#user_add_addForm').form('validate');
	if(!isValid){
		return isValid;
	}
	isValid = validEmail($('#aemail').val());
	if(!isValid){
		return isValid;
	}
	//增加密码验证（大写、小写字母、数字和标点符号至少包含2种）
	//passwdCheck();
	
	isValid = validAlias($('#aalias').val());
	if(!isValid){
		return isValid;
	}
	
	var aptipsObj = document.getElementById('apemailtips');		
	
	if(userlevelobj.checked && $('#apemail').val() == ''){
		if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
			aptipsObj.textContent = '请输入父账号邮箱！';
		}else{
			aptipsObj.innerText = '请输入父账号邮箱！';
		}
		return false;
	}else{
		if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
			aptipsObj.textContent = '';
		}else{
			aptipsObj.innerText = '';
		}
	}
	
	//父帐号有效性验证
	if(userlevelobj.checked && $('#apemail').val() != ''){
		$.ajax({
		  url:"${pageContext.request.contextPath}/userMgr/validatePEmail.do",
		  cache: false,
		  async: false,
		  data:{
		  	pemail:$('#apemail').val(),
		  	userType:$('#ausertype').val()
		  },
		  success: function(b){
		  	var r = $.parseJSON(b);
			if(!r.success){
				if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
					aptipsObj.textContent = r.msg;
				}else{
					aptipsObj.innerText = r.msg;
				}
		  		isValid = false;
			}else{
				if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
					aptipsObj.textContent = '';
				}else{
					aptipsObj.innerText = '';
				}
				isValid = true;
			}
		  }
		});
	}
	
	//验证政府用户基本信息
	var auserType = $("#ausertype").val();
	var userlevelobj1 = document.getElementById("auserlevel");	//获取复选框obj
	if(auserType == "1" && !userlevelobj1.checked){
		var oneunitid = $("#oneunitid").combobox('getValue');//一级单位
		if(oneunitid == ""){
			$("#oneunitidSpan").text("请选择一级单位");
			return false;
		}else{
			$("#oneunitidSpan").text("");
		}
		var twounitid = $("#twounitid").combobox('getValue');;//二级单位
		if(twounitid == ""){
			$("#twounitidSpan").text("请选择二级单位");
			return false;
		}else{
			$("#twounitidSpan").text("");
		}
		if($("#officeloc").val()==""){
			$("#officelocSpan").text("请输入办公地点");
			return false;
		}else{
			$("#officelocSpan").text("");
		}
		if($("#contactpart").val()==""){
			$("#contactpartSpan").text("请输入联系人部门");
			return false;
		}else{
			$("#contactpartSpan").text("");
		}
		if($("#contact_person").val()==""){
			$("#contact_personSpan").text("请输入单位联系人");
			return false;
		}else{
			$("#contact_personSpan").text("");
		}
		if($("#contacttel").val()==""){
			$("#contacttelSpan").text("请输入联系人电话");
			return false;
		}else{
			$("#contacttelSpan").text("");
		}
	}
	return isValid;
}

function clearAddAllMsg(){
		$("#oneunitidSpan").empty();
		$("#twounitidSpan").empty();
		$("#officelocSpan").empty();
		$("#contactpartSpan").empty();
		$("#contact_personSpan").empty();
		$("#contacttelSpan").empty();
}
</script>

<div id="user_add_dialog" class="easyui-dialog" data-options="title:'增加新用户',modal:true,shadow:false,cache:false,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
				text:'取消',
				handler:function(){
					$('#user_add_addForm input').val('');
					$('#user_add_dialog').dialog('close');
				}
			},{
				text:'保存',
				handler:function(){
					if(addCheck()){
						$('#user_add_addForm').form('submit',{
							url:reqestUrl,
							queryParams:{unitid:$('#twounitid').combobox('getValue'),unitname:$('#twounitid').combobox('getText')},
							success:function(r){
								var obj = jQuery.parseJSON(r);
								if(obj.success){
									$('#user_add_dialog').dialog('close');
								}
								$.messager.show({
									title:'提示',
									msg:obj.msg
								});
								$('#agovmtinfodiv input').val('');
								$('#acorpinfodiv input').val('');
								datagrid.datagrid('load');
							}
						});		
					}
				}
			}]">
	<div class="dialogWrapper">
		<form id="user_add_addForm" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">用户帐号基本信息</span></legend>
				<div class="left">
					<div class="line">
						<label><span>*</span>电子邮箱：</label>
						<input type="text" class='easyui-textbox text' id="aemail" name="email" data-options="required:true,prompt:'电子邮箱',validType:['email','length[10,30]'],missingMessage:'请输入电子邮箱'" />
						<div><span id="aemailtips" style="color:#FF910C"></span></div>
					</div>
					<div class="line">
						<label><span>*</span>登录密码：</label>
						<input type="password" class='easyui-textbox text'  id="passwd" name="passwd" data-options="required:true,validType:['length[6,20]','passCheck'],missingMessage:'长度必须在6-20之间'"/>
						<div><span id="passwdtips" style="color:#FF910C"></span></div>
					</div>
					<div class="line">
						<label><span>*</span>确认登录密码：</label>
						<input type="password" class='easyui-textbox text' name="repasswd" data-options="required:true,validType:'equalTo[\'#user_add_addForm input[name=passwd]\']',missingMessage:'确认密码'"/>
					</div>
					<div class="line">
						<label><span>*</span>登录用户名：</label>
						<input type="text" class='easyui-textbox text' id="aalias" name="alias" data-options="required:true,prompt:'别名',validType:'length[4,20]',missingMessage:'有效长度4-20'" />
						<div><span id="aaliastips" style="color:#FF910C"></span></div>
					</div>
	 				<div class="line">
						<label><span>*</span>联系电话：</label>
						<input type="text" class='easyui-textbox text' id="amobile" name="mobile" data-options="required:true,prompt:'联系电话',validType:'mobileAndTel',missingMessage:'请输入联系电话'"/>
					</div>
					<div class="line">
						<label><span>*</span>真实姓名：</label>
						<input type="text" class='easyui-textbox text' id="auname" name="uname" data-options="required:true,prompt:'真实姓名',validType:'length[2,20]',missingMessage:'有效长度2-20'"/>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label>是否子账号：</label>
						<input type="checkbox" id="auserlevel" onclick="add_showPemailDiv(this);" style="width:20px;line-height:20px;" checked/>
						<input type="hidden" id="aauserlevel" name="userlevel" value="2" />
					</div>
					<div class="line" id="apemaildiv">
						<label><span>*</span>父账号：</label>
						<input id="apemail" name="pemail" type="text" class='easyui-textbox text' data-options="prompt:'父账户电子邮箱',validType:['email','length[4,30]'],missingMessage:'请输入电子邮箱'"/>
						<span id="apemailtips" style="color:#FF910C"></span>
					</div>
					<div class="line" id="abiwaydiv">
						<label><span>*</span>扣费方式：</label>
						<input type="radio" name="gdbiway" value="0" style="width:20px;line-height:20px;" checked/><span style="width:80px;">共享计费</span>
						<input type="radio" name="gdbiway" value="1" style="width:20px;line-height:20px;"/><span style="width:80px;">独立计费</span>
						<input type="hidden" id="biway" name="biway" />
					</div>
					<div class="line">
						<label>密保问题：</label>
						<select class="easyui-combobox pwpp" id="apwdpp" name="pwdpp" data-options="editable:false,required:true,panelHeight:100">
							<option value="我的名字叫什么？" selected="selected">我的名字叫什么？</option>
							<option value="我的家乡地址？">我的家乡地址？</option>
							<option value="我的手机号？">我的手机号？</option>
						</select>
					</div>
					<div class="line">
						<label>密保答案：</label>
						<input type="text" class="easyui-textbox text" id="apwdppanswer" name="pwdppanswer" data-options="prompt:'密保答案',validType:'length[2,30]',missingMessage:'密保答案'"/>
					</div>
					<div class="line">
						<label><span>*</span>客户类型：</label>
						<select class="khlx" id="ausertype" name="usertype" onchange="clickkhlx();">
							<option value="1">政府客户</option>
							<!--<option value="2">企业客户</option>-->
							<!-- <option value="3">公众客户</option> -->
							<option value="4" selected>管理员</option>
						</select>
					</div>
				</div>
			</fieldset>
			
		<!-- 企业基本信息  开始-->
		<div id="acorpinfodiv">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">企业客户基本信息</span></legend>	
				<div class="left">
					<div class="line">
						<label><span>*</span>公司全称：</label>
						<input type="text" class='easyui-textbox text' id="cmpyname" name="cmpyname" data-options="prompt:'公司全称',validType:'length[4,30]',missingMessage:'请输入公司全称'"/>
					</div>
					<div class="line">
						<label><span>*</span>公司代码：</label>
						<input type="text" class='easyui-textbox text' id="cmpycode" name="cmpycode" data-options="prompt:'公司代码',validType:'length[4,30]',missingMessage:'请输入公司代码'"/>
					</div>
					<div class="line">
						<label><span>*</span>公司电话：</label>
						<input type="text" class='easyui-textbox text' id="cmpytel" name="cmpytel" data-options="prompt:'公司电话',validType:'mobileAndTel',missingMessage:'请输入公司电话'"/>
					</div>
					<div class="line">
						<label><span>*</span>联系人：</label>
						<input type="text" class='easyui-textbox text' id="contactperson" name="contactperson" data-options="prompt:'联系人',validType:'length[2,10]',missingMessage:'请输入联系人'"/>
					</div>
					<div class="line">
						<label><span>*</span>联系人手机：</label>
						<input type="text" class='easyui-textbox text' id="contactmobile" name="contactmobile" data-options="prompt:'联系人手机',validType:'Mobile',missingMessage:'请输入联系人手机'" />
					</div>
					<div class="line">
						<label><span>*</span>所在地：</label>
						<!-- <select class="location" name="provid" id="aprovid" onchange="onSelectChange(this,'acityid')">
							<option value="">请选择</option>
						</select> -->
						<select class="easyui-combobox" name="provid" id="province" style="width:100px;height:23px;" 
							data-options="editable:false,panelHeight:200,
								url:'${pageContext.request.contextPath}/userMgr/provcity.do?parentId=1',valueField:'id',textField:'name',
								onSelect:function(node){
									jQuery('#city').combobox('clear');
									var url = '${pageContext.request.contextPath}/userMgr/provcity.do?parentId='+node.id;
									jQuery('#city').combobox('reload',url);
									jQuery('#provname').val(node.name);
								}">
						</select>
						<!-- <select class="location" name="cityid" id="acityid" onchange="getProvCityName();">
							<option value="">请选择</option>
						</select> -->
						<select class="easyui-combobox" name="cityid" id="city" style="width:100px;height:23px;align-text:center" 
							data-options="editable:false,valueField:'id',textField:'name',panelHeight:200,
								onSelect:function(node){
									jQuery('#cityname').val(node.name);
								}">
						</select>
						<input type="hidden" id="provname" name="provname">
						<input type="hidden" id="cityname" name="cityname">
					</div>
					<div class="line">
						<label><span>*</span>公司地址：</label>
						<input type="text" class='easyui-textbox text' id="cmpyaddr" name="cmpyaddr" data-options="prompt:'公司地址',validType:'length[4,50]',missingMessage:'请输入公司地址'" />
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label><span>*</span>邮政编码：</label>
						<input type="text" class='easyui-textbox text' id="zipcode" name="zipcode" data-options="prompt:'邮政编码',validType:'zipCode',missingMessage:'请输入邮政编码'"/>
					</div>
					<div class="line">
						<label><span>*</span>公司行业：</label>
						<!-- <select class="trade" id="aoneid" name="oneid" onchange="onTradeSelChange(this,'atwoid');">
							<option value="">请选择</option>
						</select> -->
						<select class="easyui-combobox trade" name="oneid" id="aoneid" data-options="editable:false,panelHeight:200,
								url:'${pageContext.request.contextPath}/userMgr/trade.do?tradePrtId=1',valueField:'id',textField:'name',
								onSelect:function(node){
									jQuery('#atwoid').combobox('clear');
									jQuery('#athreeid').combobox('clear');
									var url = '${pageContext.request.contextPath}/userMgr/trade.do?tradePrtId='+node.id;
									jQuery('#atwoid').combobox('reload',url);
									jQuery('#oneidname').val(node.name);
								}">
						</select>
					</div>
					<div class="line">
						<label></label>
						<!-- <select class="trade" id="atwoid" name="twoid" onchange="onTradeSelChange(this,'athreeid');">
							<option value="">请选择</option>
						</select> -->
						<select class="easyui-combobox trade" name="twoid" id="atwoid" data-options="editable:false,panelHeight:200,valueField:'id',textField:'name',
								onSelect:function(node){
									jQuery('#athreeid').combobox('clear');
									var url = '${pageContext.request.contextPath}/userMgr/trade.do?tradePrtId='+node.id;
									jQuery('#athreeid').combobox('reload',url);
									jQuery('#twoidname').val(node.name);
								}">
						</select>
					</div>
					<div class="line">
						<label></label>
						<!-- <select class="trade" id="athreeid" name="threeid" onchange="getTradeName()">
							<option value="">请选择</option>
						</select> -->
						<select class="easyui-combobox trade" name="threeid" id="athreeid" data-options="editable:false,valueField:'id',textField:'name',panelHeight:200,
							onSelect:function(node){
								jQuery('#threeidname').val(node.name);
							}">
						</select>
						<input type="hidden" id="oneidname" name="oneidname">
						<input type="hidden" id="twoidname" name="twoidname">
						<input type="hidden" id="threeidname" name="threeidname">
					</div>
					<div class="line">
						<label><span>*</span>了解途径：</label>
						<select class="easyui-combobox ljtj" id="channel" name="channel" data-options="editable:false,panelHeight:110">
							<!-- <option value="">请选择</option> -->
							<option value="1">官网导购</option>
							<option value="2">电话销售</option>
							<option value="3">销售营销</option>
							<option value="4">其他介绍</option>
						</select>
					</div>
					<div class="line">
						<label>营业执照：</label>
						<!--<span>*</span> <input class="easyui-filebox" id="bizlic" name="uplm" type="text" data-options="buttonText:'请选择文件',buttonAlign:'left'"/> -->
						<input type="file" id="bizlic" name="uplm_abizlic"/>
						<!-- <s:actionerror/> -->
					</div>
					<div class="line">
						<label>LOGO图标：</label>
						<!-- <span>*</span><input class="easyui-filebox" id="corplogo" name="uplm" type="text" data-options="buttonText:'请选择文件',buttonAlign:'left'"/> -->
						<input type="file" id="logofile" name="uplm_alogofile"/>
					</div>
				</div>
			</fieldset>
		</div><!-- 企业基本信息  结束-->
		
		<!-- 政府用户基本信息 开始 -->
		<div id="agovmtinfodiv">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">政府客户基本信息</span></legend>
				<div class="left">
					<div class="line">
						<label><span>*</span>一级单位名称：</label>
						<input id="oneunitid" name="units">
						<span id="oneunitidSpan" style="color:#FF910C"></span>
	                </div>
					<div class="line">
						<label><span>*</span>二级单位名称：</label>
						<input id="twounitid" name="unit" class="easyui-combobox" data-options="valueField: 'unitId',textField: 'unitName',editable:false">
						<span id="twounitidSpan" style="color:#FF910C"></span>
	 				</div>
					<div class="line">
						<label><span>*</span>办公地点：</label>
						<input type="text" class='easyui-textbox text' id="officeloc" name="officeloc" data-options="prompt:'办公地点',validType:'length[2,30]',missingMessage:'请输入办公地点'"/>
						<span id="officelocSpan" style="color:#FF910C"></span>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label><span>*</span>联系人部门：</label>
						<input type="text" class='easyui-textbox text' id="contactpart" name="unitcontactpart" data-options="prompt:'联系人部门',validType:'length[2,30]',missingMessage:'请输入联系人部门'" />
						<span id="contactpartSpan" style="color:#FF910C"></span>
					</div>
					<div class="line">
						<label><span>*</span>单位联系人：</label>
						<input type="text" class='easyui-textbox text' id="contact_person" name="unitcontactperson" data-options="prompt:'单位联系人',validType:'length[2,10]',missingMessage:'请输入单位联系人'"/>
						<span id="contact_personSpan" style="color:#FF910C"></span>
					</div>
					<div class="line">
						<label><span>*</span>联系人电话：</label>
						<input type="text" class='easyui-textbox text' id="contacttel" name="unitcontacttel" data-options="prompt:'联系人电话',validType:'mobileAndTel',missingMessage:'请输入联系人电话'" />
						<span id="contacttelSpan" style="color:#FF910C"></span>
					</div>
					<%--
						<div class="line">
							<label>LOGO图标：</label>
							<!--<span>*</span><input class="easyui-filebox" id="govmtlogo" name="uplm" data-options="buttonText:'请选择文件',buttonAlign:'left'"s/> -->
							<input type="file" id="glogofile" name="uplm" />
						</div>
					 --%>
				</div>
			</fieldset>
		</div><!-- 政府用户基本信息  结束 -->
		</form>
	</div>	
</div>

