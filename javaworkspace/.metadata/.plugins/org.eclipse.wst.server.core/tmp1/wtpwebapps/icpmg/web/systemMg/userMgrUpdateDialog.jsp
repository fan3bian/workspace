<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 %>
<style type="text/css">
.updateDialogWrapper{background:#fff;width:750px;margin:0 auto;overflow:hidden;padding:30px 10px 20px 20px;}
.updateDialogWrapper .left{width:350px;float:left;margin-right:10px;overflow:hidden;}
.updateDialogWrapper .line{margin-bottom:5px;width:100%;overflow:hidden;float:left;}
.updateDialogWrapper .line label{display:inline-block;width:120px;text-align:right;}
.updateDialogWrapper .line label span{color:#ff3030;padding:0px 5px;}
.updateDialogWrapper .line input{width:200px;}
.updateDialogWrapper .line .location{width:100px;}
.updateDialogWrapper .line .trade{width:200px;}
.updateDialogWrapper .line .pwpp{width:200px;}
.updateDialogWrapper .line .ukhlx{width:200px;}
.updateDialogWrapper .line .ljtj{width:200px;}
.updateDialogWrapper .line .text{height:20px;line-height:20px;}
fieldset{color:#333; border:#06c dashed 1px;}
</style>

<script type="text/javascript" charset="utf-8">
var ureqestUrl;
$(function(){
	/* $('#ubizlic').filebox({
		buttonText:'请选择文件',
		buttonAlign:'left'
	});
	$('#ucorplogo').filebox({
		buttonText:'请选择文件',
		buttonAlign:'left'
	});
	$('#ugovmtlogo').filebox({
		buttonText:'请选择文件',
		buttonAlign:'left'
	}); */
	$('#ucorpinfodiv').hide();
	$('#ugovmtinfodiv').hide();
	//设置缺省的请求路径
	ureqestUrl = '${pageContext.request.contextPath}/authMgr/editUser.do';
	
	update_setSelect('1','uprovid');
	update_setTradeSelect('1', 'uoneid');
	
	comboxselect_update();
});

function update_onSelectChange(obj,toSelId){
	update_setSelect(obj.value,toSelId);
}
function update_onTradeSelChange(obj,toSelId){
	if('twoid' == toSelId){
		var threeidobj = document.getElementById("threeid");
		threeidobj.options.length=0;
		var nullOp = document.createElement("option");
		nullOp.setAttribute("value","");
		nullOp.appendChild(document.createTextNode("请选择"));
		threeidobj.appendChild(nullOp);
	}
	update_setTradeSelect(obj.value,toSelId);
}
function update_setSelect(fromSelVal,toSelId){
	document.getElementById(toSelId).innerHTML="";
	jQuery.ajax({
	  url:"${pageContext.request.contextPath}/userMgr/provcity.do",
	  cache: false,
	  data:"parentId="+fromSelVal,
	  success: function(data){
	  	update_createSelectObj(data,toSelId);
	  }
	});
}
function update_setTradeSelect(fromSelVal,toSelId){
	document.getElementById(toSelId).innerHTML="";
	jQuery.ajax({
	  url:"${pageContext.request.contextPath}/userMgr/trade.do",
	  cache: false,
	  data:"tradePrtId="+fromSelVal,
	  success: function(data){
	  	update_createSelectObj(data,toSelId);
	  }
	});
}
function update_createSelectObj(data,toSelId){
	var arr = jsonParse(data);
	//var arr = $.parseJSON(data);//将字符串转化为json对象
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
}
function update_getProvCityName(){
	var providobj = document.getElementById("uprovid");
	var cityidobj = document.getElementById("ucityid");
	var provnameobj = document.getElementById("uprovname");
	var citynameobj = document.getElementById("ucityname");
	provnameobj.setAttribute("value", providobj.options[providobj.selectedIndex].text);
	citynameobj.setAttribute("value", cityidobj.options[cityidobj.selectedIndex].text);
}
function update_getTradeName(){
	var oneidobj = document.getElementById("uoneid");
	var twoidobj = document.getElementById("utwoid");
	var threeidobj = document.getElementById("uthreeid");
	
	var oneidnameobj = document.getElementById("uoneidname");
	var twoidnameobj = document.getElementById("utwoidname");
	var threeidnameobj = document.getElementById("uthreeidname");
	oneidnameobj.setAttribute("value", oneidobj.options[oneidobj.selectedIndex].text);
	twoidnameobj.setAttribute("value", twoidobj.options[twoidobj.selectedIndex].text);
	threeidnameobj.setAttribute("value", threeidobj.options[threeidobj.selectedIndex].text);
}

//点击客户类型
function update_clickkhlx(){
	var ukhlx = $('.ukhlx').val();
	var uyhdj = $('#uuuserlevel').val();
	if(uyhdj == 1 && ukhlx == 1){
		//$('#ucorpinfodiv input').val('');
		$('#ucorpinfodiv').hide();
		$('#ugovmtinfodiv').show();
		ureqestUrl = '${pageContext.request.contextPath}/userMgr/updateGovmtInfo.do';
	}else if(uyhdj == 1 && ukhlx == 2){
		//$('#ugovmtinfodiv input').val('');
		$('#ugovmtinfodiv').hide();
		$('#ucorpinfodiv').show();
		ureqestUrl = '${pageContext.request.contextPath}/userMgr/updateCorpInfo.do';
	}else{
		//$('#ugovmtinfodiv input').val('');
		//$('#ucorpinfodiv input').val('');
		$('#ucorpinfodiv').hide();
		$('#ugovmtinfodiv').hide();
		ureqestUrl = '${pageContext.request.contextPath}/authMgr/editUser.do';
	}
}
//添加子帐号，显示或隐藏父帐号字段
function update_showPemailDiv(obj){
	$('#upemail').val('');
	if (obj.checked) {
		$('#upemaildiv').show();
		$('#ubiwaydiv').show();
		$('#ucorpinfodiv').hide();
		$('#ugovmtinfodiv').hide();
		$('#uuuserlevel').val("2");
	} else {
		$('#upemaildiv').hide();
		$('#ubiwaydiv').hide();
		$('#uuuserlevel').val("1");
		
		if($('.ukhlx').val() == 1){
			$('#ugovmtinfodiv input').val('');
			$('#ugovmtinfodiv').show();
		}else if($('.ukhlx').val() == 2){
			$('#ucorpinfodiv input').val('');
			$('#ucorpinfodiv').show();
		}else{
			$('#ucorpinfodiv').hide();
			$('#ugovmtinfodiv').hide();
			$('#ugovmtinfodiv input').val('');
			$('#ucorpinfodiv input').val('');
		}
	}
}

function update_validAlias(email,alias){
	var flag = true;
	if(alias != ''){
		$.ajax({
			url:"${pageContext.request.contextPath}/userMgr/validUAlias.do",
			cache: false,
		 	async: false,
		  	data:{
		  		email:email,
		  		alias:alias
		  	},
		  	success: function(b){
		  		var r = $.parseJSON(b);
				if(r.success){
					if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
						document.getElementById('aliastips').textContent = r.msg;
					}else{
						document.getElementById('aliastips').innerText = r.msg;
					}
		  			flag = false;
				}else{
					if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
						document.getElementById('aliastips').textContent = '';
					}else{
						document.getElementById('aliastips').innerText = '';
					}
					flag = true;
				}
		  	}
		});
	}
	return flag;
}

//表单提交时验证
function updateCheck(){
	var isValid = false;
	//动态设置 扣费方式--子账号
	var iszzh =  $('#uuuserlevel').val();//是否是子账号
	if(iszzh == 2){
		if(user_update_updateForm.gdbiway[0].checked){
			$('#ubiway').val('0');	
		}
		if(user_update_updateForm.gdbiway[1].checked){
			$('#ubiway').val('1');
		}
	}
	
	var ukhlx = $('.ukhlx').val();
	var uyhdj = $('#uuuserlevel').val();
	if(uyhdj == 1 && ukhlx == 1){
		ureqestUrl = '${pageContext.request.contextPath}/userMgr/updateGovmtInfo.do';
	}else if(uyhdj == 1 && ukhlx == 2){
		ureqestUrl = '${pageContext.request.contextPath}/userMgr/updateCorpInfo.do';
	}else{
		ureqestUrl = '${pageContext.request.contextPath}/authMgr/editUser.do';
	}
	
	isValid = $('#user_update_updateForm').form('validate');
	if(!isValid){
		return isValid;
	}
	
	isValid = update_validAlias($('#email').val(),$('#alias').val());
	if(!isValid){
		return isValid;
	}else{
		if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
			document.getElementById('aliastips').textContent = '';
		}else{
			document.getElementById('aliastips').innerText = '';
		}
	}
	
	var uuserlevelobj = document.getElementById('uuserlevel');	//获取复选框obj
	var uaptipsObj = document.getElementById('upemailtips');		
	
	if(uuserlevelobj.checked && $('#upemail').val() == ''){
		if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
			uaptipsObj.textContent = '请输入父账号邮箱！';
		}else{
			uaptipsObj.innerText = '请输入父账号邮箱！';
		}
		return false;
	}
	
	//父帐号有效性验证
	if(uuserlevelobj.checked && $('#upemail').val() != ''){
		$.ajax({
		  url:"${pageContext.request.contextPath}/userMgr/validatePEmail.do",
		  cache: false,
		  async: false,
		  data:{
		  	pemail:$('#upemail').val(),
		  	userType:$('#usertype').val()
		  },
		  success: function(b){
		  	var r = $.parseJSON(b);
			if(!r.success){
				if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
					uaptipsObj.textContent = r.msg;
				}else{
					uaptipsObj.innerText = r.msg;
				}
		  		isValid = false;
			}else{
				if(window.navigator.userAgent.toLowerCase().indexOf('firefox')!=-1){
					uaptipsObj.textContent = '';
				}else{
					uaptipsObj.innerText = '';
				}
				isValid = true;
			}
		  }
		});
	}
	//验证政府用户基本信息
	var auserType = $("#usertype").val();
	var sfzzh =  $('#uuuserlevel').val();//是否是子账号
	if(auserType == "1" && sfzzh == 1){
		var oneunitid = $("#oneunitidUpdate").combobox('getValue');//一级单位
		if(oneunitid == ""){
			$("#oneunitidSpanUpdate").text("请选择一级单位");
			return false;
		}else{
			$("#oneunitidSpanUpdate").text("");
		}
		var twounitid = $("#twounitidUpdate").combobox('getValue');;//二级单位
		if(twounitid == ""){
			$("#twounitidSpanUpdate").text("请选择二级单位");
			return false;
		}else{
			$("#twounitidSpanUpdate").text("");
		}
		if($("#uofficeloc").val()==""){
			$("#officelocSpanUpdate").text("请输入办公地点");
			return false;
		}else{
			$("#officelocSpanUpdate").text("");
		}
		if($("#ucontactpart").val()==""){
			$("#contactpartSpanUpdate").text("请输入联系人部门");
			return false;
		}else{
			$("#contactpartSpanUpdate").text("");
		}
		if($("#ucontact_person").val()==""){
			$("#contact_personSpanUpdate").text("请输入单位联系人");
			return false;
		}else{
			$("#contact_personSpanUpdate").text("");
		}
		if($("#ucontacttel").val()==""){
			$("#contacttelSpanUpdate").text("请输入联系人电话");
			return false;
		}else{
			$("#contacttelSpanUpdate").text("");
		}
	}
	return isValid;
}

//单位下拉框显示
function comboxselect_update(){
	$('#oneunitidUpdate').combobox({    
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
	            	   $('#twounitidUpdate').combobox({    
		                   url:urlson,    
		                   valueField:'unitId',    
		                   textField:'unitName',  
		                   editable:true,
		             	   onLoadSuccess: function () { //加载完成后,设置选中第一项
	              				var data = $('#twounitidUpdate').combobox('getData');
					            if (data.length > 0) {
					            	$('#twounitidUpdate').combobox('select', data[0].unitId);
					            } 
					       }   
         			   }).combobox('clear');
          			},
		          onLoadSuccess: function () { //加载完成后,设置选中第一项
		               //jQuery('#twounitidUpdate').combobox('clear');
		               var parentId= $('#oneunitidUpdate').combobox('getValue');  
		               var url2='${pageContext.request.contextPath}/project/getUnitsForRegistNext.do?unitid='+parentId; 
		               $('#twounitidUpdate').combobox('reload', url2);  
		                
		          }    
		}); 
}

function clearAllMsg(){
		$("#oneunitidSpanUpdate").empty();
		$("#twounitidSpanUpdate").empty();
		$("#officelocSpanUpdate").empty();
		$("#contactpartSpanUpdate").empty();
		$("#contact_personSpanUpdate").empty();
		$("#contacttelSpanUpdate").empty();
}
</script>

<div id="user_update_dialog" class="easyui-dialog" data-options="title:'修改用户',modal:true,inline:false,closed:true,draggable:true,resizable:true,closable:false,buttons:[{
				text:'取消',
				handler:function(){
					$('#user_update_updateForm input').val('');
					$('#user_update_dialog').dialog('close');
				}
			},{
				text:'保存',
				handler:function(){
					if(updateCheck()){
						$('#user_update_updateForm').form('submit',{
							<%-- url:'${pageContext.request.contextPath}/authMgr/editUser.do', --%>
							url:ureqestUrl,
							queryParams:{email:$('#email').val(),unitid:$('#twounitidUpdate').combobox('getValue'),unitname:$('#twounitidUpdate').combobox('getText'),
										alias:$('#alias').val(),usertype:$('#usertype').val()},
							success:function(r){
								var obj = jQuery.parseJSON(r);
								if(obj.success){
									$('#ugovmtinfodiv input').val('');
									$('#ucorpinfodiv input').val('');
									$('#user_update_dialog').dialog('close');
								}
								$.messager.show({
									title:'提示',
									msg:obj.msg
								});
								datagrid.datagrid('load');
							}
						});		
					}
				}
			}]">
	<div class="updateDialogWrapper">
		<form id="user_update_updateForm" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">用户帐号基本信息</span></legend>
				<div class="left">
					<div class="line">
						<label><span>*</span>电子邮箱：</label>
						<input type="text" class='easyui-validatebox text' id="email" name="email" data-options="required:true,prompt:'电子邮箱',validType:['email','length[10,30]'],missingMessage:'请输入电子邮箱'" disabled/>
						<div><span id="uemailtips" style="color:#FF910C"></span></div>
					</div>
					<%--
						<div class="line">
						<label><span>*</span>登录密码：</label>
						<input type="password" class='easyui-validatebox text' id="passwd" name="passwd" value="******" data-options="prompt:'密码'" readOnly/>
					</div>
					 --%>
					<div class="line">
						<label><span>*</span>昵称：</label>
						<input type="text" class='easyui-validatebox text' id="alias" name="alias" data-options="required:true,prompt:'别名',validType:'length[4,20]',missingMessage:'有效长度4-20'" disabled />
						<div><span id="aliastips" style="color:#FF910C"></span></div>
					</div>
	 				<div class="line">
						<label><span>*</span>联系电话：</label>
						<input type="text" class='easyui-validatebox text' id="mobile" name="mobile" data-options="required:true,prompt:'联系电话',validType:'mobileAndTel',missingMessage:'请输入联系电话'"/>
					</div>
					<div class="line">
						<label><span>*</span>真实姓名：</label>
						<input type="text" class='easyui-validatebox text' id="uname" name="uname" data-options="required:true,prompt:'真实姓名',validType:'length[2,20]',missingMessage:'有效长度2-20'"/>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label>是否子帐号：</label>
						<input type="checkbox" id="uuserlevel" onclick="update_showPemailDiv(this);" style="width:20px;line-height:20px;" disabled/>
						<input type="hidden" id="uuuserlevel" name="userlevel" />
					</div>
					<div class="line" id="upemaildiv">
						<label><span>*</span>父账号：</label>
						<input id="upemail" name="pemail" type="text" class='easyui-validatebox text' data-options="prompt:'父账户电子邮箱',validType:['email','length[4,30]'],missingMessage:'请输入电子邮箱'"/>
						<span id="upemailtips" style="color:#FF910C"></span>
					</div>
					<div class="line" id="ubiwaydiv">
						<label><span>*</span>扣费方式：</label>
						<input type="radio" id="bw1" name="gdbiway" value="0" style="width:20px;line-height:20px;"/><span style="width:80px;">共享计费</span>
						<input type="radio" id="bw2" name="gdbiway" value="1" style="width:20px;line-height:20px;"/><span style="width:80px;">独立计费</span>
						<input type="hidden" id="ubiway" name="biway" />
					</div>
					<div class="line">
						<label>密保问题：</label>
						<select class="pwpp" id="pwdpp" name="pwdpp">
							<option value="我的名字叫什么？">我的名字叫什么？</option>
							<option value="我的email地址？">我的email地址？</option>
							<option value="我的手机号？">我的手机号？</option>
						</select>
					</div>
					<div class="line">
						<label>密保答案：</label>
						<input type="text" class="easyui-validatebox text" id="pwdppanswer" name="pwdppanswer" data-options="prompt:'密保答案',validType:'length[2,30]',missingMessage:'密保答案'"/>
					</div>
					<div class="line">
						<label><span>*</span>客户类型：</label>
						<select class="ukhlx" id="usertype" name="usertype" onchange="update_clickkhlx();" disabled>
							<option value="1">政府客户</option>
							<option value="2">企业客户</option>
							<!--<option value="3">公众客户</option> -->
							<option value="4" selected>管理员</option>
						</select>
					</div>
				</div>
			</fieldset>
			
		<!-- 企业基本信息  开始-->
		<div id="ucorpinfodiv">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">企业客户基本信息</span></legend>	
				<div class="left">
					<div class="line">
						<label><span>*</span>公司全称：</label>
						<input type="text" class='easyui-validatebox text' id="ucmpyname" name="cmpyname" data-options="prompt:'公司全称',validType:'length[4,30]',missingMessage:'请输入公司全称'"/>
					</div>
					<div class="line">
						<label><span>*</span>公司代码：</label>
						<input type="text" class='easyui-validatebox text' id="ucmpycode" name="cmpycode" data-options="prompt:'公司代码',validType:'length[4,30]',missingMessage:'请输入公司代码'"/>
					</div>
					<div class="line">
						<label><span>*</span>公司电话：</label>
						<input type="text" class='easyui-validatebox text' id="ucmpytel" name="cmpytel" data-options="prompt:'公司电话',validType:'mobileAndTel',missingMessage:'请输入公司电话'"/>
					</div>
					<div class="line">
						<label><span>*</span>联系人：</label>
						<input type="text" class='easyui-validatebox text' id="ucontactperson" name="contactperson" data-options="prompt:'联系人',validType:'length[2,10]',missingMessage:'请输入联系人'"/>
					</div>
					<div class="line">
						<label><span>*</span>联系人手机：</label>
						<input type="text" class='easyui-validatebox text' id="ucontactmobile" name="contactmobile" data-options="prompt:'联系人手机',validType:'Mobile',missingMessage:'请输入联系人手机'"/>
					</div>
					<div class="line">
						<label><span>*</span>所在地：</label>
						<select class="location" name="provid" id="uprovid" onchange="update_onSelectChange(this,'ucityid')">
							<option value="">请选择</option>
						</select>
						<select class="location" name="cityid" id="ucityid" onchange="update_getProvCityName();">
							<option value="">请选择</option>
						</select>
						<input type="hidden" id="uprovname" name="provname">
						<input type="hidden" id="ucityname" name="cityname">
					</div>
					<div class="line">
						<label><span>*</span>公司地址：</label>
						<input type="text" class='easyui-validatebox text' id="ucmpyaddr" name="cmpyaddr" data-options="prompt:'公司地址',validType:'length[4,50]',missingMessage:'请输入公司地址'"/>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label><span>*</span>邮政编码：</label>
						<input type="text" class='easyui-validatebox text' id="uzipcode" name="zipcode" data-options="prompt:'邮政编码',validType:'zipCode',missingMessage:'请输入邮政编码'"/>
					</div>
					<div class="line">
						<label><span>*</span>公司行业：</label>
						<select class="trade" id="uoneid" name="oneid" onchange="update_onTradeSelChange(this,'utwoid');">
							<option value="">请选择</option>
						</select>
					</div>
					<div class="line">
						<label></label>
						<select class="trade" id="utwoid" name="twoid" onchange="update_onTradeSelChange(this,'uthreeid');">
							<option value="">请选择</option>
						</select>
					</div>
					<div class="line">
						<label></label>
						<select class="trade" id="uthreeid" name="threeid" onchange="update_getTradeName()">
							<option value="">请选择</option>
						</select>
						<input type="hidden" id="uoneidname" name="oneidname">
						<input type="hidden" id="utwoidname" name="twoidname">
						<input type="hidden" id="uthreeidname" name="threeidname">
					</div>
					<div class="line">
						<label><span>*</span>了解途径：</label>
						<select class="ljtj" id="uchannel" name="channel">
							<option value="">请选择</option>
							<option value="1">官网导购</option>
							<option value="2">电话销售</option>
							<option value="3">销售营销</option>
							<option value="4">其他介绍</option>
						</select>
					</div>
					<div class="line">
						<label>营业执照：</label>
						<!-- <span>*</span><input id="ubizlic" name="uplm" /> -->
						<input type="file" id="ubizlic" name="uplm_bizlic" />
						<!-- <s:actionerror/> -->
					</div>
					<div class="line">
						<label>LOGO图标：</label>
						<!-- <span>*</span><input id="ucorplogo" name="uplm" /> -->
						<input type="file" id="ucorplogo" name="uplm_corplogo" />
					</div>
				</div>
			</fieldset>
		</div><!-- 企业基本信息  结束-->
		
		<!-- 政府用户基本信息 开始 -->
		<div id="ugovmtinfodiv">
			<fieldset>
				<legend><span style="color:#06c;font-weight:800;background:#fff;">政府客户基本信息</span></legend>
				<div class="left">
					<div class="line">
						<label><span>*</span>一级单位名称：</label>
						<input id="oneunitidUpdate" name="units" data-options="required:true,missingMessage:'请选择一级单位'">
						<span id="oneunitidSpanUpdate" style="color:#FF910C"></span>
	                </div>
					<div class="line">
						<label><span>*</span>二级单位名称：</label>
						<input id="twounitidUpdate" name="unit" class="easyui-combobox" data-options="required:true,valueField: 'unitId',textField: 'unitName',editable:false,missingMessage:'请选择一级、二级单位'">
						<span id="twounitidSpanUpdate" style="color:#FF910C"></span>
	 				</div>
	 				<!-- 
 					<div class="line">
						<label><span>*</span>单位名称：</label>
						<input type="text" class='easyui-validatebox text' id="uunitname" name="unitname" data-options="prompt:'单位名称',validType:'length[2,30]',missingMessage:'请输入单位名称'"/>
					</div>
	 				 -->
					<div class="line">
						<label><span>*</span>办公地点：</label>
						<input type="text" class='easyui-validatebox text' id="uofficeloc" name="officeloc" data-options="required:true,prompt:'办公地点',validType:'length[2,30]',missingMessage:'请输入办公地点'"/>
						<span id="officelocSpanUpdate" style="color:#FF910C"></span>
					</div>
				</div>
				<div class="left">
					<div class="line">
						<label><span>*</span>联系人部门：</label>
						<input type="text" class='easyui-validatebox text' id="ucontactpart" name="unitcontactpart" data-options="required:true,prompt:'联系人部门',validType:'length[2,30]',missingMessage:'请输入联系人部门'" />
						<span id="contactpartSpanUpdate" style="color:#FF910C"></span>
					</div>
					<div class="line">
						<label><span>*</span>单位联系人：</label>
						<input type="text" class='easyui-validatebox text' id="ucontact_person" name="unitcontactperson" data-options="required:true,prompt:'单位联系人',validType:'length[2,10]',missingMessage:'请输入单位联系人'"/>
						<span id="contact_personSpanUpdate" style="color:#FF910C"></span>
					</div>
					<div class="line">
						<label><span>*</span>联系人电话：</label>
						<input type="text" class='easyui-validatebox text' id="ucontacttel" name="unitcontacttel" data-options="required:true,prompt:'联系人电话',validType:'mobileAndTel',missingMessage:'请输入联系人电话'"/>
						<span id="contacttelSpanUpdate" style="color:#FF910C"></span>
					</div>
					<%--
						<div class="line">
							<label>LOGO图标：</label>
							<!--<span>*</span> <input id="ugovmtlogo" name="uplm" /> -->
							<input type="file" id="ugovmtlogo" name="uplm" />
						</div>
					 --%>
				</div>
			</fieldset>
		</div><!-- 政府用户基本信息  结束 -->
		</form>
	</div>	
</div>