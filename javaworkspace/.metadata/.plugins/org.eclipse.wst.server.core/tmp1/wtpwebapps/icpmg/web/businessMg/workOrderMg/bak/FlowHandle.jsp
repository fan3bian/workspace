<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
<%@ page import="com.inspur.icpmg.systemMg.vo.SessionInfo " %>
<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.* " %>
<%@ page import="org.apache.struts2.ServletActionContext " %>
<%@ page import="com.inspur.icpmg.util.WebLevelUtil " %>

<%
String path = request.getContextPath();	
String userid = WebLevelUtil.getUserId(ServletActionContext.getRequest());
String username = WebLevelUtil.getUser(ServletActionContext.getRequest()).getUname();
String phone =  WebLevelUtil.getUser(ServletActionContext.getRequest()).getMobile();
String roid = WebLevelUtil.getRoleId(ServletActionContext.getRequest());

ServerWorkOrderVo vo1 = new ServerWorkOrderVo();
FlowStepDetailVo vo2 = new FlowStepDetailVo();
 ArrayList<FormFieldConfigVo> arrayList = new ArrayList<FormFieldConfigVo>();
 ArrayList<FlowDetailVo> arrayList1 = new ArrayList<FlowDetailVo>();
 ArrayList<FlowStepDetailVo> arrayList2 = new ArrayList<FlowStepDetailVo>();
vo1 = (ServerWorkOrderVo)request.getAttribute("vo1");
 //request.setAttribute("vo1",vo1);
arrayList = (ArrayList<FormFieldConfigVo>)request.getAttribute("arrayList");
arrayList1 = (ArrayList<FlowDetailVo>)request.getAttribute("arrayList1");
arrayList2 = (ArrayList<FlowStepDetailVo>)request.getAttribute("arrayList2");
vo2 = (FlowStepDetailVo)request.getAttribute("vo2");
boolean flag = false;
String[] idArray = roid.split(",");
for(int i=0;i<idArray.length;i++){
    if(vo1.getSteproleid().equals(idArray[i]))
       flag = true;
}
//System.out.println("vo1="+vo1.getFlowname());
//System.out.println("arrayList.size():"+arrayList.size());
//System.out.println("vo2.getYesnexbutton()"+vo2.getYesnexbutton());
//System.out.println("vo2.getNonextbutton()"+vo2.getNonextbutton());
 %>
<body>
	<form id="editForm" style="padding: 5px;" method="post" >
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/workOrder/workorder.css"/>

	<script >
		$(document).ready(function(){
			$('#infoTab').panel({
				href:''
				});	
				
				
		});
		


function saveAndSend(str1,str2){
	document.getElementById('nextno1').value=str1;
	document.getElementById('yesorno').value=str2;
		//document.getElementById('editForm').submit();
	//	alert(document.getElementById('nextno').value);
			if ($('#editForm').form('validate')) {
				$('#submitBtn').linkbutton('disable');
			$('#editForm').form('submit',{
		    url:'<%=path%>/workorder/saveAndSend.do',
		    onSubmit: function(){
		    },
		    success:function(data){
				if(data=="success"){
				//$('#centerTab').load('<%=path%>/web/businessMg/workOrderMg/OrderSearch.jsp');
				$('#centerTab').panel({
		href:'<%=path%>/web/businessMg/workOrderMg/toDoOrderList.jsp'
		});	
		alert("操作成功！！！");
				}else{
				    alert("有未完成的操作,请完成操作后提交！！！");
				}
				
				$('#submitBtn').linkbutton('enable');
				
		    }
		});
		}
		//$('#editForm').submit();	
	}		
function openDialog(str, title) {
  <%--   $('#dd').dialog({
        title: title,
        width: 1000,
        height: 500,
        closed: true,
        cache: false,
        //href: '<%=path%>/'+str+'?transferid=${requestScope.vo1.flowid}&stepno=${requestScope.vo1.stepno}', 
        modal: true,
        onClose: function() {
            /*  if(statusTimeout){
          clearTimeout(statusTimeout);
       } */
        }
    });
    $('#dd').dialog('refresh', '<%=path%>/' + str + '?transferid=${requestScope.vo1.flowid}&stepno=${requestScope.vo1.stepno}');
    $('#dd').dialog('open'); --%>
    var url ='<%=path%>/'+ str + "?transferid=${requestScope.vo1.flowid}&stepno=${requestScope.vo1.stepno}";
    addTab('申请资源查看',url)
} 	

function addTab(title, url) {
    if ($('#tabs').tabs('exists', title)) {
        $('#tabs').tabs('select', title);
    } else {
    	console.log($("#tabs-1"));
        var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>';
        $('#tabs').tabs('add', {
        	id:'orderdetails',
            title: title,
            content: content,
           href: url,
          //  width: $("#tabs").parent().width(), padding:10px;width:100%;height:100%;background:#eee
          //width:100%,
         // height:100%,background:#eee, 
 		//	height: "800" ,
 	//	fit:true,
            closable: true
        });
      
       $('#tabs').tabs({
        	
        	height:'800'
        });
       $('#tabs').tabs('select',title);
    }
}
	</script>
	<div id="tabs" class="easyui-tabs" style="width:100%;height:100%background:#eee" data-options="tabWidth:112, border:false" >
	<div id="tabs-1" title="基本信息" data-options="fit:true" style="padding:10px;background:#eee" >
		<table id="toptable" align="center" style="width:90%;height:10px">
			
		</table>
		<table id="toptable" align="center" style="width:90%">
			<caption  class="TicketTitle" ><font class="Titlefont">${requestScope.vo1.modelname}</font></caption>
		</table>
	
		<table class="wotable" align="center" style="width:90%">
			<tr>
				<td class="FieldLabel2" style="border-top:none !important;">工单标题</td>
				<td class="FieldInput2" style="border-top:none !important;">
				<input type="text"   name="flowname"  id="flowname" readonly="readonly" style="border:none !important;background:none !important;height:25px;width:900px " value="${requestScope.vo1.flowname}"  /> </td>
			</tr>
		</table>
		<table class="wotable" align="center" style="width:90%">
			<tr>
				<td class="FieldLabel" style="border-top:none !important;" >工单编号</td>
				<td class="FieldInput" style="border-top:none !important;" ><input type="text" name="flowid" id="flowid"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.flowid}" /> </td>
					
				<td class="FieldLabel" style="border-top:none !important;" >订单编号</td>
				<td class="FieldInput" style="border-top:none !important;" ><input type="text" name="orderid" id="orderid"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.orderid}" /> </td>
			</tr>
				<tr>
				<td class="FieldLabel" >工单类别</td>
				<td class="FieldInput" ><input type="text" name="flowtypename" readonly="flowtypename" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.flowtypename}" /> </td>
				
				<td class="FieldLabel" >工单创建时间</td>
				<td class="FieldInput" ><input type="text" name="ctime"  readonly="ctime" style="border:none !important;background:none !important;height:25px"  value="${requestScope.vo1.ctime}" /> </td>
			</tr>
			<tr>
				<td class="FieldLabel" > 创建人名称</td>
				<td class="FieldInput" ><input type="text" name="cusername" id="cusername"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.cusername}" /> </td>
			    <td class="FieldLabel" >产品名称</td>
				<td class="FieldInput" ><input type="text" name="shopname" id="shopname"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.shopname}" /> </td>
			    
		</table>
		
		<table class="wotable" align="center" style="margin-top:15px;width:90%">
		<%
		    int y=1; 
		       for(int i=0;i<arrayList.size();i++){
		          if(arrayList.get(i).getIsshow().endsWith("1")){
		              String fieldname = arrayList.get(i).getFieldname();
		              String fieldvalue = arrayList.get(i).getFieldvalue()==null?"":arrayList.get(i).getFieldvalue();
		              String field  = arrayList.get(i).getFormfield();
		             if(y%2==1){
		         %>  
		         <tr>
				<td class="FieldLabel"><%=fieldname%> </td>
				<td class="FieldInput">
				
				<input id="<%=field%>" type="text" name="<%=field%>"  style="border:none !important;background:none !important;height:25px" readonly="readonly" value="<%=fieldvalue %>" />
				
				</td>  
		           
		           <%  
		              if(i==arrayList.size()-1){
		              
		             %> 
		             
		                <td class="FieldLabel"></td>
				<td class="FieldInput">
					<input type="text" name="" id=""  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="" /> 
			
				</td>
			</tr>
		             
		             
		             <%    
		              }
		             }else{
		              %> 
		              <td class="FieldLabel"><%=fieldname%></td>
				<td class="FieldInput">
					<input type="text" name="<%=field%>" id="<%=field%>"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="<%=fieldvalue %>" /> 
			
				</td>
			</tr>
		              
		              <%  
		              
		             }
		             y++;
		          }
		       }
		        
		
		
		
		%>
			
			
		</table>
		<table class="wotable" align="center" style="width:90%">
		<%
		     for(int i=0;i<arrayList.size();i++){
		       
		        if(arrayList.get(i).getFormfield().endsWith("snote")){
		              String fieldname = arrayList.get(i).getFieldname();
		              String fieldvalue = arrayList.get(i).getFieldvalue();
		              String field  = arrayList.get(i).getFormfield();
		             
		     %>	          
		    <tr>
				<td  class="FieldLabel2" style="border-top:none !important;" ><%=fieldname %> <font color="red">(Max 500)</font></td>
				<td class="FieldInput2" style="border-top:none !important;" ><textarea rows="5" cols="100" style="border:none !important;background:none !important;" readonly="readonly" name="<%=field %>" ><%=fieldvalue %></textarea></td>
			</tr>          
		              
		    <%          
		     } 
		     }        
		 %>		
		</table>
	</div>
	<div id="tabs-2" title="处理" data-options="selected:true" style="padding:10px;background:#eee">
       <% 
       if(vo1.getStepno()!=vo1.getStepnum()){
       if(flag==true){
       %>
		<div style="padding:0 5px 0 5px;margin:10px 5px 0 40px;width: 50%;">
		<%
		   if(vo2.getYesnexbutton()!=null && !"".equals(vo2.getYesnexbutton())){
		   String buttonname = vo2.getYesnexbutton();
		   String nextno = String.valueOf(vo2.getYesnextop());
		  %>  
		  
		    <a href="#" onClick="javascript:saveAndSend('<%=nextno %>','1');" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"><%=buttonname%></a>
		  
		  <% 
		   }
		 %>
		 
		 <%
		   if(vo2.getNonextbutton()!=null && !"".equals(vo2.getNonextbutton())){
		   String buttonname = vo2.getNonextbutton();
		   String nextno = String.valueOf(vo2.getNonextop());
		  %>  
		  
		     &nbsp;&nbsp;&nbsp;<a href="#" onClick="javascript:saveAndSend('<%=nextno %>','0');"  class="easyui-linkbutton" data-options="iconCls:'icon-no'"><%=buttonname%></a>
		  
		  <% 
		   }
		 %>
		 
		  <%
		    String opbutton = String.valueOf(vo2.getOpbutton());
		  //System.out.println("opbutton="+opbutton);
		  // if(String.valueOf(vo2.getOpbutton())!=null && "1".equals(vo2.getOpbutton())){
		   if(opbutton!=null && "1".equals(opbutton)){
		   String buttonname = vo2.getOpbuttonname();
		   String ophtml =vo2.getOphtml();
		  %>  
		  
		     &nbsp;&nbsp;&nbsp;<a href="#" onClick="javascript:openDialog('<%=ophtml %>','<%=buttonname%>');"  class="easyui-linkbutton" data-options="iconCls:'icon-search'"><%=buttonname%></a>
		  <% 
		   }
		 %>
		 
	    </div> 	
	    <% 
	    }
	    %>
		<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
		<input type="hidden" name="stepno1" id="stepno1" value ="${requestScope.vo1.stepno}" />
		<input type="hidden" name="stepname1" id="stepname1" value ="${requestScope.vo1.stepname}" />
		<input type="hidden" name="nextno1" id="nextno1" value ="" />
		<input type="hidden" name="modelid" id="modelid" value ="${requestScope.vo1.modelid}" />
		<input type="hidden" name="operatorid" id="operatorid" value ="<%=userid%>" />
		<input type="hidden" name="rowid" id="rowid" value ="${requestScope.vo1.steproleid}" />
		<input type="hidden" name="yesorno" id="yesorno" value ="" />
		
		<table class="wotable" width="93%" align="center" >
	   		<tr>
				<td  class="FieldLabel" >处理人</td>
				<td class="FieldInput"><input type="text" name="operatorname" id="operatorname" readonly="readonly" style="border:none !important;background:none !important;" value=<%=username%> /> </td>
				
				<td  class="FieldLabel" >处理人角色</td>
				<td class="FieldInput"><input type="text" name="rowname" id="rowname" readonly="readonly" style="border:none !important;background:none !important;" value="${requestScope.vo1.dorolename}" /></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >工单环节</td>
				<td class="FieldInput"><input type="text" name="activityname" id="activityname" readonly="readonly" style="border:none !important;background:none !important;" value="${requestScope.vo1.stepname}" /> </td>
				
				<td  class="FieldLabel" >环节开始时间</td>
				<td class="FieldInput"><input type="text" name="time1" id="time1" readonly="readonly" style="border:none !important;background:none !important;" value="${requestScope.vo1.stepstarttime}" /></td>
			</tr>	
			</table>
			<table class="wotable" width="93%" align="center" >		
			<tr>
				<td  class="FieldLabel2" style="border-top:none !important;" >处理备注<font color="red">(Max 500)</font></td>
				<td class="FieldInput2" style="border-top:none !important;" ><textarea rows="5" cols="100" type="text" name="comments" id="comments" ></textarea><font color="red">*</font></td>
			</tr>
		</table>
	
	</div>
	  <% 
       }
       %>
		<div class="easyui-accordion" data-options="collapsible:false,selected:true" style="padding:0 5px 0 5px;margin:10px 5px 0 35px;width: 94%;">
		<%
		    if(arrayList1!=null){
		    for(int i=0;i<arrayList1.size();i++){
		       FlowDetailVo vo = new FlowDetailVo();
		       vo = arrayList1.get(i);
		       String stepname = vo.getStepname();
		       String cusername =vo.getCusername();
		       String ctime =vo.getCtime();
		       String dorolename =vo.getDorolename();
		       String starttime = vo.getStarttime();
		       String snote = vo.getSnote();
		    %> 
		  <div title=' <span style="color: #fff;font-size:15px"> <%=i+1 %>.&nbsp;&nbsp;&nbsp;工单环节：<%=stepname %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 处理人:<%=cusername %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;处理时间:<%= ctime%></span>' icon="icon-ok" style="overflow:auto;padding:10px;" >    
		    <table class="wotable" width="100%" align="center" >
	   		<tr>
		    <td  class="FieldLabel" >处理人</td>
				<td class="FieldInput"><input type="text" name="operatorname" field="operatorname" readonly="readonly" style="border:none !important;background:none !important;" value=<%=cusername %> /> </td>
				
				<td  class="FieldLabel" >处理人角色</td>
				<td class="FieldInput"><input type="text" name="operator" field="operator" readonly="readonly" style="border:none !important;background:none !important;" value="<%=dorolename %>"  /></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >环节开始时间</td>
				<td class="FieldInput"><input type="text" name="activityname" field="activityname" readonly="readonly" style="border:none !important;background:none !important;" value="<%=starttime %>" /> </td>
				
				<td  class="FieldLabel" >环节结束时间</td>
				<td class="FieldInput"><input type="text" name="operatorcontacts" field="operatorcontacts" readonly="readonly" style="border:none !important;background:none !important;" value="<%=ctime %>" /></td>
			</tr>
			</table>
			<table class="wotable" width="100%" align="center" >		
			<tr>
				<td  class="FieldLabel2" style="border-top:none !important;" >处理备注 <font color="red">(Max 500)</font></td>
				<td class="FieldInput2" style="border-top:none !important;" ><textarea rows="5" cols="100" style="border:none !important;background:none !important;" readonly="readonly" type="text" name="comments" field="comments" ><%=snote %></textarea></td>
			</tr>
		</table>
			</div>	
		    <%
		    }
		   }
		
		 %>
	</div>
	</div>
	<div id="tabs-3" title="待处理节点"  style="padding:10px;width:100%;height:100%;background:#eee">
	
		<table id="dg" class="easyui-datagrid" style="width:100%"
		data-options="rownumbers:false,border:false,striped : true,sortName:'stepno',sortOrder:'desc',nowarp:false,singleSelect: true,url:'${pageContext.request.contextPath}/workorder/nodeToDo.do?transid=${requestScope.vo1.flowid}',method:'post',loadMsg:'数据装载中......',fitColumns:true,idField:'stepno'">
		<thead>
			<tr>
				<th data-options="field:'stepno',width:60,align:'center',sortable:true">环节序号</th>
				<th data-options="field:'stepname',width:120,align:'center',sortable:true">环节名称</th>
				<th data-options="field:'dorolename',width:100,align:'center',sortable:true">处理人角色</th>
				<th data-options="field:'yesnextop',width:80,align:'center',sortable:true">同意(下一步)</th>
				<th data-options="field:'nonextop',width:80,align:'center',sortable:true">不同意(下一步)</th>
				<th data-options="field:'fstatus',width:80,align:'center',sortable:true">工单状态</th>
				<th data-options="field:'ctime',width:80,align:'center',sortable:true">完成时间</th>
			</tr>
		</thead>
	</table>
	
	
	
	</div>
	</div>
		</form>
	<div id="dd" title="orderdetail">   
	</div>
</body>