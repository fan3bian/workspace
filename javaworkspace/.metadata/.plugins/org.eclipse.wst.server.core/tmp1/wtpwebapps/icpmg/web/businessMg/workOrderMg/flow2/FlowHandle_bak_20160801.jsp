<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" 
import="java.util.*"
	language="java" %>
<%@ page import="com.inspur.icpmg.systemMg.vo.SessionInfo " %>
<%@ page import="com.inspur.icpmg.businessMg.workorder.vo.* " %>
<%@ page import="org.apache.struts2.ServletActionContext " %>
<%@ page import="com.inspur.icpmg.util.WebLevelUtil ,java.text.DecimalFormat" %>

<%
	String path = request.getContextPath();
	String userid = WebLevelUtil.getUserId(ServletActionContext.getRequest());
	String username = WebLevelUtil.getUser(ServletActionContext.getRequest()).getUname();
	String phone = WebLevelUtil.getUser(ServletActionContext.getRequest()).getMobile();
	String roid = WebLevelUtil.getRoleId(ServletActionContext.getRequest());

	String orderpirce = "0.0";
	String apriceApprove = "0.0";
	DecimalFormat formatter = new DecimalFormat("##0.00");
	ServerWorkOrderVo vo1 = new ServerWorkOrderVo();
	FlowStepDetailVo vo2 = new FlowStepDetailVo();
	ArrayList<FormFieldConfigVo> arrayList = new ArrayList<FormFieldConfigVo>();
	ArrayList<FlowDetailVo> arrayList1 = new ArrayList<FlowDetailVo>();
	ArrayList<FlowStepDetailVo> arrayList2 = new ArrayList<FlowStepDetailVo>();
	vo1 = (ServerWorkOrderVo) request.getAttribute("vo1");
	//request.setAttribute("vo1",vo1);
	arrayList = (ArrayList<FormFieldConfigVo>) request.getAttribute("arrayList");
	arrayList1 = (ArrayList<FlowDetailVo>) request.getAttribute("arrayList1");
	arrayList2 = (ArrayList<FlowStepDetailVo>) request.getAttribute("arrayList2");
	vo2 = (FlowStepDetailVo) request.getAttribute("vo2");
	boolean flag = false;
	String[] idArray = roid.split(",");
	for (int i = 0; i < idArray.length; i++) {
		if (vo1.getSteproleid().equals(idArray[i]))
			flag = true;
	}
	//String fileid = (String) request.getAttribute("fileid");
%>
<body>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/workOrder/workorder.css"/>
	<form id="editForm" style="padding: 5px;" method="post" enctype="multipart/form-data">

	<%-- <script type="text/javascript" src =""<%=path%>/web/businessMg/workOrderMg/flow2/scripts/TextFormat.js"" ></script> --%>

	<div id="tabs" class="easyui-tabs" style="width:100%;height:100%background:#eee" data-options="tabWidth:112, border:false" >
			<div id="tabs-1" title="基本信息" data-options="fit:true" style="padding:10px;background:#eee">

				<div style="width:90%;height:10px" align="center"></div>
				<table id="toptable" align="center" style="width:90%">
					<caption class="TicketTitle"><font class="Titlefont">${requestScope.vo1.modelname}</font></caption>
				</table>

		<table class="wotable" align="center" style="width:90%">
			<tr>
				<td class="FieldLabel2" style="border-top:none !important;">工单标题</td>
				<td class="FieldInput2" style="border-top:none !important;">
				<input type="text"   name="flowname"  id="flowname" readonly="readonly" style="border:none !important;background:none !important;height:25px;width:95% !important" value="${requestScope.vo1.flowname}"  /> </td>
			</tr>
		</table>
		<table class="wotable" align="center" style="width:90%">
			<tr>
				<td class="FieldLabel" style="border-top:none !important;" >工单编号</td>
				<td class="FieldInput" style="border-top:none !important;" ><input type="text" name="flowid" id="flowid"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.flowid}" /> </td>
					
				<td class="FieldLabel" style="border-top:none !important;" >申请单编号</td>
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
			    <%--
			    	<td class="FieldLabel" >产品名称</td>
					<td class="FieldInput" ><input type="text" name="shopname" id="shopname"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.shopname}" /> </td>
			     --%>
			     <td class="FieldLabel" >申请单位</td>
				 <td class="FieldInput" ><input type="text" name="unitname" id="unitname"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.unitname}" /> </td>
		</table>
		
		<table class="wotable" align="center" style="margin-top:15px;width:90%">
		<%
		    int y=1; 
		       for(int i=0;i<arrayList.size();i++){
		          if(arrayList.get(i).getIsshow().endsWith("1")){
		              String fieldname = arrayList.get(i).getFieldname();
                      String formField = arrayList.get(i).getFormfield();
		              String fieldvalue = arrayList.get(i).getFieldvalue()==null?"":arrayList.get(i).getFieldvalue();
		              if("tprice".equalsIgnoreCase(formField.trim())){
		            	  orderpirce  = String.valueOf(fieldvalue);
		              }
		              if("aprice".equalsIgnoreCase(formField.trim())){
		            	  apriceApprove = String.valueOf(fieldvalue);
		              }
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
				<td  class="FieldLabel2" style="border-top:none !important;" ><%=fieldname %> <font color="red">(不得超过500个字符)</font></td>
				<td class="FieldInput2" style="border-top:none !important;" ><textarea rows="5" cols="100" style="border:none !important;background:none !important;" readonly="readonly" name="<%=field %>" ><%=fieldvalue %></textarea></td>
			</tr>          
		              
		    <%          
		     } 
		     }        
		 %>	
		 <%
		 	String fileUrls = vo1.getFileurls();
		 	String fileNames = vo1.getFilenames();
		 	if(!"".equals(fileUrls) && !"".equals(fileNames)){
 		  %>	
 		  	  <tr>
                  <td class = "FieldLabel2" >技术方案</td >
                  <td class = "FieldInput2" ><a href="#" onclick="downloadFile('<%=fileUrls%>')"><span style="font-color:blue;"><%=fileNames%></span></a></td>
             </tr >
 		  	
		  <%	
		 	}
		 %>
		</table>
	</div>
	<div id="tabs-2" title="处理" data-options="selected:true" style="padding:10px;background:#eee">
		<%
			if (vo1.getStepno() != vo1.getStepnum()) {
				if (flag) {
		%>
		<div style="padding:0 5px 0 5px;margin:10px 5px 0 40px;width: 50%;">
			<%
				if (vo2.getYesnexbutton() != null && !"".equals(vo2.getYesnexbutton())) {
					String buttonname = vo2.getYesnexbutton();
					String nextno = String.valueOf(vo2.getYesnextop());
			%>

			<a href="#" id="submitBtn2" onClick="javascript:saveAndSend('<%=nextno %>','1');" class="easyui-linkbutton"
			   data-options="iconCls:'icon-ok'"><%=buttonname%>
			</a>

			<%
				}
			%>

			<%
				if (vo2.getNonextbutton() != null && !"".equals(vo2.getNonextbutton())) {
					String buttonname = vo2.getNonextbutton();
					String nextno = String.valueOf(vo2.getNonextop());
			%>
			&nbsp;&nbsp;&nbsp;<a href="#" id="submitBtn" onClick="javascript:saveAndSend('<%=nextno %>','0');"
								 class="easyui-linkbutton" data-options="iconCls:'icon-no'"><%=buttonname%>
		</a>
			<%
				}
			%>
			
			<%
			  	//String  modelid = String.valueOf(vo1.getModelid());
			  	//if(modelid.equals("0000000020") || modelid.equals("0000000021")){//重庆政务云
			  %>
			  <!--  &nbsp;&nbsp;&nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-download'" onclick="downloadFileFun('<=fileid%>')">资源查看</a>&nbsp; -->
			  <% 
			  	//}else{
			  		String opbutton = String.valueOf(vo2.getOpbutton());
					if (opbutton != null && "1".equals(opbutton)) {
						String buttonname = vo2.getOpbuttonname();
						String ophtml = vo2.getOphtml();
				%>
					 &nbsp;&nbsp;&nbsp;
             		 <a href="#" onClick="javascript:openDialog('<%=ophtml%>','<%=buttonname%>');"  class="easyui-linkbutton" data-options="iconCls:'icon-search'"><%=buttonname%></a>
			 <%
					}
				//}
			  %>
		</div>
		<%
			}
		%>
		<div class="GroupBoxDiv" style="width: 100%;height:auto;">	
		<input type="hidden" name="stepno1" id="stepno1" value ="${requestScope.vo1.stepno}" />
		<input type="hidden" name="stepname1" id="stepname1" value ="${requestScope.vo1.stepname}" />
		<input type="hidden" name="nextno1" id="nextno1" value ="" />
		<input type="hidden" name="modelid" id="modelid" value ="${requestScope.vo1.modelid}" />
		<input type="hidden" name="operatorid" id="operatorid" value ="<%=userid%>" />
		<input type="hidden" name="rowid" id="rowid" value ="${requestScope.vo1.steproleid}" />
		<input type="hidden" name="isupload" id="isupload" value="${requestScope.vo2.isupload }">
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
			
			<!-- 审批时上传文件  start-->
			<c:if test="${ 1 eq vo2.isupload}">
				<tr>
					<td  class="FieldLabel" >资源申请表扫描件</td>
					<td class="FieldInput" colspan="3">
						<input type="file" id="fileload" style="width: 500px !important;height: 30px; " name="fileload" > <!--onClick="javascript:saveUpload();"  -->
						<font color="red">*</font>
					</td>
				</tr>
			</c:if>
			<!-- 审批时上传文件  end-->
			
			</table>
			<table class="wotable" width="93%" align="center" >		
			<tr>
				<td  class="FieldLabel2" style="border-top:none !important;" >处理备注<font color="red">(不得超过500个字符)</font></td>
				<td class="FieldInput2" style="border-top:none !important;" ><textarea rows="5" cols="100" type="text" name="comments" id="comments" ></textarea></td>
			</tr>
			
		</table>
            <c:if test="${1 eq vo2.iseditprice}">
				<table class="wotable" width="93%" align="center">
					<tr height="20px">
						<td class="FieldLabel" style="border-top:none !important;margin-left: 5px;" colspan="4">
							审批价格:&nbsp;<input id="apriceApprove" name="apriceApprove"
											  value="<%=formatter.format(Float.parseFloat(apriceApprove))%>"
											  style="font-size: 16px;color: #00a2ca;margin-left: 5px;border-left:0px;border-top:0px;border-right:0px;border-bottom: 1px solid #000000;">
							<font color="red">审批价格可修改</font>
						</td>
                            <%-- <td class="FieldInput" style="border-top:none !important;" >
                            <!-- <textarea rows="5" cols="100" type="text" name="comments" id="comments" ></textarea><font color="red">*</font> -->
                            <input name="aprice" value="<%=formatter.format(Float.parseFloat(orderpirce))%>">
                            </td> --%>

									<%-- <input type="text" name="time1" id="time1" readonly="readonly" style="border:none !important;background:none !important;" value="${requestScope.vo1.tprice }" /> --%>

					</tr>
					<tr>
						<td class="FieldLabel" colspan="4">订单价格:	<span
								style="font-size: 16px;color: #00a2ca;margin-left: 5px;">
					<%=formatter.format(Float.parseFloat(orderpirce))%>
					<input type="hidden" name="tprice" id="tprice"
						   value="<%=formatter.format(Float.parseFloat(orderpirce))%>">
				</span>
						</td>
					</tr>
				</table>

            </c:if>

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
		       String spfj_fileid = vo.getFileid();
		       String spfj_filename = vo.getFilename();
		       String spfj_fileurl = vo.getFileurl();
//				cstatus,cstatusname
				String cstatusname = vo.getCstatusname();
				int cstatus = vo.getCstatus();
		    %>

		  <div title='<span style="color: #fff;font-size:15px">
		  	<%=i+1 %>.&nbsp;&nbsp;&nbsp;</span>
		  	 <span style="color: #fff;font-size:15px;display:inline-block;width:330px;">工单环节：<%=stepname%></span>
		  	 <span style="color: #fff;font-size:15px;display:inline-block;width:180px;">处理人:<%=cusername %></span>
		  	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		  	<span style="color: #fff;font-size:15px">
		  	处理时间:<%= ctime%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 处理意见：<%=cstatusname %>
		  	</span>' icon="icon-ok" style="overflow:auto;padding:10px;" >

			  <table class="wotable" width="100%" align="center">
				  <tr>
					  <td class="FieldLabel">处理人</td>
					  <td class="FieldInput">
						  <input type="text" name="operatorname" field="operatorname"
								 readonly="readonly"
								 style="border:none !important;background:none !important;"
								 value='<%=cusername %>' />
					  </td>
				
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
			
			<%--如果有审批附件则进行显示 --%>
			<%
				if(spfj_fileid != null && !"".equals(spfj_fileid)){
			%>
				<tr>
					<td  class="FieldLabel" >资源申请表扫描件</td>
						<td class="FieldInput" colspan="3">
							<a href="#" onClick="javascript:downloadSpfile('<%=spfj_fileid %>','<%=spfj_fileurl%> ');" "><input type="text" name="spfj_fileid" field="spfj_fileid" readonly="readonly" style="border:none !important;background:none !important; color:blue;" value=<%=spfj_filename %> /> </td></a>
						</td>
					</td>
					
				</tr>
			<%	
				}
			%>		
			<tr>
				<td  class="FieldLabel2" style="border-top:none !important;" >处理备注 <font color="red">(不得超过500个字符)</font></td>
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
	
		<%-- 重庆政务云    订单详情 tab页   start  sortName:'stepno',sortOrder:'desc',--%>
		<%
		String  modelid = String.valueOf(vo1.getModelid());
	  	if(modelid.equals("0000000020") || modelid.equals("0000000021")){//重庆政务云
	  	%>
		<div id="tabs-4" title="申请单详情"  style="padding:10px;width:100%;height:100%;background:#eee">
			<table id="dg4" style="width:100%"
				   data-options="rownumbers:false,border:false,striped : true,nowarp:false,singleSelect: true,
				   sortName:'detailid',sortOrder:'asc',
				   url:'${pageContext.request.contextPath}/workorder/findOrderDetailCqzwy.do?flowid=${requestScope.vo1.flowid}',
				   method:'post',loadMsg:'数据装载中......',fitColumns:true,idField:'detailid'">
				<thead>
				<tr>
					<th data-options="field:'detailid',width:20,align:'center',sortable:true">序号</th>
					<th data-options="field:'orderid',width:20,align:'center',hidden:true">订单编码</th>
					<th data-options="field:'shopid',width:40,align:'center',sortable:true">服务编码</th>
					<th data-options="field:'pname',width:80,align:'center',sortable:true">资源名称</th>
					<th data-options="field:'appname',width:50,align:'center',sortable:true">应用</th>
					<th data-options="field:'configure',width:170,align:'center',sortable:true">规格</th>
					<th data-options="field:'networktype',width:30,align:'center',sortable:true">网络类型</th>
					<th data-options="field:'tnumber',width:20,align:'center',sortable:true">数量</th>
					<th data-options="field:'measureunit',width:30,align:'center',sortable:true">单位</th>
					<th data-options="field:'status',width:30,align:'center',sortable:true">状态</th>
					<th data-options="field:'ops',width:30,align:'center',formatter:detailsformater">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	  	<%
	  	}else 
		%>
		<%-- 重庆政务云     订单详情 tab页     end --%>
		
		<%-- 重庆政务云    资源变更详情 tab页   start  sortName:'stepno',sortOrder:'desc',--%>
		<%
		if(modelid.equals("0000000022") || modelid.equals("0000000023")){//重庆政务云资源变更
	  	%>
		<div id="tabs-5" title="变更详情"  style="padding:10px;width:100%;height:100%;background:#eee">
			<table id="dg5" style="width:100%"
				   data-options="rownumbers:false,border:false,striped : true,nowarp:false,singleSelect: true,
				   sortName:'detailid',sortOrder:'asc',
				   url:'${pageContext.request.contextPath}/resourcechange/findResourceChangeToDo.do?transferid=${requestScope.vo1.flowid}',
				   method:'post',loadMsg:'数据装载中......',fitColumns:true,idField:'detailid'">
				<thead>
				<tr>
					<th data-options="field:'detailid',width:50,align:'center',sortable:true">序号</th>
					<th data-options="field:'useunitname',width:140,align:'center'">使用单位</th>
					<th data-options="field:'pname',width:100,align:'center'">服务名称</th>
					<th data-options="field:'neid',width:160,align:'center'">实例名称</th>
					<th data-options="field:'oldappname',width:100,align:'center'">应用</th>
					<th data-options="field:'oldnetworktype',width:100,align:'center'">网络类型</th>
					<th data-options="field:'oldtnumber',width:50,align:'center'">数量</th>
					<th data-options="field:'oldconfigure',width:170,align:'center'">原有规格</th>
					<th data-options="field:'newconfigure',width:170,align:'center'">变更规格</th>
					<th data-options="field:'operatetype',width:70,align:'center',formatter:operTypeFormater">操作类型</th>
					<th data-options="field:'status',width:70,align:'center',formatter:zybgoperformater">状态</th>
				</tr>
				</thead>
			</table>
		</div>
	  	<%
	  	}
		%>
		<%-- 重庆政务云    资源变更详情  tab页     end --%>
		
		
		<%--待处理节点tab页   start --%>
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
		<%--待处理节点tab页  end --%>
		
	</div>
		</form>
	<div id="dd" title="orderdetail">
	</div>

	<script >
		$(document).ready(function () {
			//订单详情，显示悬浮框
			$('#dg4').datagrid({ 
				onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					}
	        });
			//资源变更详情，显示悬浮框
			$('#dg5').datagrid({ 
				onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					}
	        });
	       
		
			$("#apriceApprove").blur(function () {
				var aprice = $(this).val();
				var _regrule = "^(/d*/./d{0,2}|/d+).*$";
				var decimalReg = /^\d{0,8}\.{0,1}(\d{1,2})?$/;//var decimalReg=/^[-\+]?\d{0,8}\.{0,1}(\d{1,2})?$/;
				var re = /([0-9]+.[0-9]{2})[0-9]*/;
				aprice = aprice.replace(re, "$1");
				if (aprice == "" || aprice == null) {
					alert("审核价格不能为空");
					aprice = $("#tprice").val().replace(re, "$1");
					$(this).val(aprice);
					return false;
				}

				if (aprice != "" && aprice != "undefined") {
					var r = decimalReg.test(aprice);
					if (!r) {
						alert("您输入的审核价格的格式不正确");
						// aprice = $("#tprice").val().replace(re,"$1");
						aprice = changeTwoDecimal_f($("#tprice").val());
						$(this).val(aprice);
						return false;
					} else {
						aprice = changeTwoDecimal_f(aprice);
						$(this).val(aprice);

						//  return false;
					}
				}
				checkprice();
				
			});

			function changeTwoDecimal_f(x) {
				var f_x = parseFloat(x);
				if (isNaN(f_x)) {
					//alert('function:changeTwoDecimal->parameter error');
					return false;
				}
				var f_x = Math.round(x * 100) / 100;
				var s_x = f_x.toString();
				var pos_decimal = s_x.indexOf('.');
				if (pos_decimal < 0) {
					pos_decimal = s_x.length;
					s_x += '.';
				}
				while (s_x.length <= pos_decimal + 2) {
					s_x += '0';
				}
				return s_x;
			}

		});


		function checkprice() {
			var aprice = document.getElementById("apriceApprove").value;

			var userid = $("#operatorid").val();
			var roleid = $("#roleid").val();
			var modelid = $("#modelid").val();
			var tprice = $("#tprice").val();

			jQuery.ajax({
				url: '${pageContext.request.contextPath}/workorder/checkPrice.do',
				type: 'post',
				data: {
					aprice: aprice,
					userid: userid,
					roleid: roleid,
					modelid: modelid,
					tprice: tprice
				},
				dataType: 'json',
				success: function (data) {
					//console.log(data)
					if (!data.valid) {
						alert("您的审核价格过低或者您的权限不足以折扣这么多!");
						return false;
					}
				}
			})
		}

		 //操作类型
	 function operTypeFormater(value,row,index){
		 switch(value){
			 case "1":
				 return "变更";
			 case "2":
				 return "注销";
		 }
	 }
		 
		function saveAndSend(str1, str2) {
			document.getElementById('nextno1').value = str1;
			document.getElementById('yesorno').value = str2;
			if ($('#editForm').form('validate')) {
				var flowid = $("#flowid").val();
				var stepno1 = $("#stepno1").val();
				var stepname1 = $("#stepname1").val();
				var nextno1 = $("#nextno1").val();
				var modelid = $("#modelid").val();
				var operatorid = $("#operatorid").val();
				var rowid = $("#rowid").val();
				var rowname = $("#rowname").val();
				var comments = $("#comments").val();
				var time1 = $("#time1").val();
				var yesorno = $("#yesorno").val();
				var isupload = $("#isupload").val();
				var orderid = "${requestScope.vo1.orderid}";
				var url = '<%=path%>/workorder/saveAndSend.do?flowid='+flowid+'&stepno1='+stepno1+'&stepname1='+encodeURI(encodeURI(stepname1))+
						'&nextno1='+nextno1+'&modelid='+modelid+'&operatorid='+operatorid+
						'&rowid='+rowid+'&rowname='+encodeURI(encodeURI(rowname))+'&comments='+encodeURI(encodeURI(comments))+'&time1='+time1+
						'&yesorno='+yesorno+'&isupload='+isupload+"&orderId="+orderid;
				
				$('#editForm').form('submit', {
					url: url,
					onSubmit: function () {
						if(isupload == 1 && str2 == '1'){//审批通过且要求上传附件
							var filetype = $("#editForm input[name='fileload']")[0].value;
							var fileTemp = filetype.substring(filetype.lastIndexOf(".")+1);
							/*var arr = new Array("BMP","JPG","JPEG","PNG","GIF","bmp","jpg","jpeg","png","gif");*/
							var flag = 0;
							if(!filetype){
								$.messager.alert('消息', "附件不能为空，请进行上传！","info");
								return false;
							}else{
								/*
								for(var i=0;i<arr.length;i++){
									if(arr[i]==fileTemp){
										flag = "1";
									}
								}  
								if(flag=="0"){
									$.messager.alert('消息', '暂不支持该类型文件上传！请上传图片格式文件',"info");
									return false;
								}*/
							}
						}
						$('#submitBtn').linkbutton('disable');
						$('#submitBtn2').linkbutton('disable');
					},
					success: function (data) {
						if (data == "success") {
							//$('#centerTab').load('<=path%>/web/businessMg/workOrderMg/OrderSearch.jsp');
							$('#centerTab').panel({
								href: '<%=path%>/web/businessMg/workOrderMg/toDoOrderList.jsp'
							});
							$.messager.alert('提示',"操作成功！",'info');
						} else if( data == "failure"){
							$.messager.alert('提示',"有未完成的操作,请完成操作后提交！",'info');
						}else{
							$.messager.alert('提示',"操作失败！",'info');
						}

						$('#submitBtn').linkbutton('enable');
						$('#submitBtn2').linkbutton('enable');

					}
				});
			}
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
			var url = '<%=path%>/' + str + "?transferid=${requestScope.vo1.flowid}&stepno=${requestScope.vo1.stepno}";
			 
			addTab(title, url)
		}

		function addTab(title, url) {
			if ($("#tabs").tabs('exists', title)) {
				$("#tabs").tabs('select', title);
			} else {
				var content = '<iframe id="details" scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:98%;"></iframe>';
				//重庆资源变更采用非iframe加载
				if('${requestScope.vo1.modelid}' == "0000000022" || '${requestScope.vo1.modelid}'=="0000000023"){
					$("#tabs").tabs('add', {
						id: 'orderdetails',
						title: title,
						//content: content,
						href:url,
						closable: true
					});
				}else{//采用iframe夹杂
					$("#tabs").tabs('add', {
						id: 'orderdetails',
						title: title,
						content: content,
						//href:url,
						closable: true
					});
				}

				$("#tabs").tabs({
					height: '600'
				});
				$("#tabs").tabs('select', title);
			}
		}
		//下载--资源查看
		function downloadFileFun(fileid) {
			$.ajax({
				type: 'post',
				url: '<%=path%>/documentMg/loadFile.do',//${pageContext.request.contextPath} ctx
				data: {
					fileid: fileid
				},
				dataType: 'text',
				async: false,
				success: function (result) {
					url = '<%=path%>' + result;
					var temp = url.split(".");
					var str = temp[temp.length - 1];
					if (str == "doc" || str == "docx" || str == "xls" || str == "xlsx") {
						window.location.href = url;
					} else {
						window.open(url);
					}
				}
			});
		}
		
		//重庆政务云审批附件下载专用
		function downloadSpfile(fileid,fileurl){
			var url = '<%=path%>'+fileurl;
			var temp = url.split(".");
			var str = temp[temp.length-1];
			if(str=="doc"||str=="docx"||str=="xls"||str=="xlsx"){
				window.location.href = url;
			}else{
				window.open(url);
			}
		}
		 
		//根据url下载查看
		function downloadFile(fileUrl) {
			var url = '<%=path%>' + fileUrl;
			var temp = url.split(".");
			var str = temp[temp.length - 1];
			if (str == "doc" || str == "docx" || str == "xls" || str == "xlsx") {
				window.location.href = url;
			} else {
				window.open(url);
			}
		}
		
		//datagrid悬浮框处理
		$.extend($.fn.datagrid.methods, {
	        /**
	         * 开打提示功能
	         * @param {} jq
	         * @param {} params 提示消息框的样式
	         * @return {}
	         */
	        doCellTip: function(jq, params){
	            function showTip(data, td, e){
	                if ($(td).text() == "") 
	                    return;
	                data.tooltip.text($(td).text()).css({
	                    top: (e.pageY + 10) + 'px',
	                    left: (e.pageX + 20) + 'px',
	                    'z-index': $.fn.window.defaults.zIndex,
	                    display: 'block'
	                });
	            };
	            return jq.each(function(){
	                var grid = $(this);
	                var options = $(this).data('datagrid');
	                if (!options.tooltip) {
	                    var panel = grid.datagrid('getPanel').panel('panel');
	                    //var fields=$(this).datagrid('getColumnFields',false);////获取列
	                    var defaultCls = {
	                        'border': '1px solid #333',
	                        'padding': '2px',
	                        'color': '#333',
	                        'background': '#f7f5d1',
	                        'position': 'absolute',
	                        'max-width': '200px',
							'border-radius' : '4px',
							'-moz-border-radius' : '4px',
							'-webkit-border-radius' : '4px',
	                        'display': 'none'
	                    }
	                    var tooltip = $("<div id='celltip'></div>").appendTo('body');
	                    tooltip.css($.extend({}, defaultCls, params.cls));
	                    options.tooltip = tooltip;
	                    panel.find('.datagrid-body').each(function(){
	                        var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
	                        $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {
	                            'mouseover': function(e){
	                                if (params.delay) {
	                                    if (options.tipDelayTime) 
	                                        clearTimeout(options.tipDelayTime);
	                                    var that = this;
	                                    options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                                }
	                                else {
	                                    showTip(options, this, e);
	                                }
	                                
	                            },
	                            'mouseout': function(e){
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                options.tooltip.css({
	                                    'display': 'none'
	                                });
	                            },
	                            'mousemove': function(e){
									var that = this;
	                                if (options.tipDelayTime) 
	                                    clearTimeout(options.tipDelayTime);
	                                //showTip(options, this, e);
									options.tipDelayTime = setTimeout(function(){
	                                        showTip(options, that, e);
	                                    }, params.delay);
	                            }
	                        });
	                    });
	                    
	                }
	                
	            });
	        },
	        /**
	         * 关闭消息提示功能
	         *
	         * @param {}
	         *            jq
	         * @return {}
	         */
	        cancelCellTip: function(jq){
	            return jq.each(function(){
	                var data = $(this).data('datagrid');
	                if (data.tooltip) {
	                    data.tooltip.remove();
	                    data.tooltip = null;
	                    var panel = $(this).datagrid('getPanel').panel('panel');
	                    panel.find('.datagrid-body').undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove')
	                }
	                if (data.tipDelayTime) {
	                    clearTimeout(data.tipDelayTime);
	                    data.tipDelayTime = null;
	                }
	            });
	        }
	    });
	    
	    	//专享详情操作
	    function detailsformater(value,row,index)
		 {
		  if('200060'==row.shopid){
		  return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewDetails(\'{0}\',\'{1}\');\">详情</a>', row.detailid,row.orderid);
		  // return icp.formatString('<img src=\"${pageContext.request.contextPath}/images/btnchakan.png\" title="查看" onclick="showDetail(\'{0}\');"/>', row.modelid);
		  }
		  if('200008'==row.shopid){
		    
		     return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewJGDetails(\'{0}\',\'{1}\',\'{2}\');\">详情</a>', row.detailid,row.orderid,row.appname);
		  
		  }
		   if('200009'==row.shopid){
		    
		     return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewIPDetails(\'{0}\',\'{1}\');\">详情</a>', row.detailid,row.orderid);
		  
		  }
		 if('200012'==row.shopid){
		    
		     return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewJWDetails(\'{0}\',\'{1}\',\'{2}\');\">详情</a>', row.detailid,row.orderid,row.appname);
		  
		  }
		 }
	     function viewDetails(detailid,orderid){
	        var url="${pageContext.request.contextPath}/web/ordersMg/vipAllDetails.jsp?orderid="+orderid+"&detailid="+detailid;
	     	var dialog = parent.icp.modalDialog({
			title : '专享详情一览',
			url : url,
			draggable:true
		});
				
			}
			
			function viewJGDetails(detailid,orderid,appname){
			
			    var url='${pageContext.request.contextPath}/web/ordersMg/orderJGTG.jsp?flowid='+$("#flowid").val()+'&detailid='+detailid+'&appname='+encodeURI(encodeURI(appname));
		     	var dialog = parent.icp.modalDialog({
				  title : '机柜托管详情',
				  width:'800px',
				  url : url,
				  draggable:true
				});
			}
			
			function viewIPDetails(detailid,orderid){
			
			    var url='${pageContext.request.contextPath}/web/ordersMg/orderIp.jsp?flowid='+$("#flowid").val()+'&detailid='+detailid;
		     	var dialog = parent.icp.modalDialog({
				  title : '互联网线路',
				  width:'750px',
				  height:'450px',
				  url : url,
				  draggable:true
				});
			}
			function viewJWDetails(detailid,orderid,appname){
			
			    var url='${pageContext.request.contextPath}/web/ordersMg/orderJWTG.jsp?flowid='+$("#flowid").val()+'&detailid='+detailid+'&appname='+encodeURI(encodeURI(appname));
		     	var dialog = parent.icp.modalDialog({
				  title : '机位托管详情',
				  width:'800px',
				  url : url,
				  draggable:true
				});
			}
			
		 //资源变更状态
	     function zybgoperformater(value, row, index){ 
			switch (value) {
				case "0":
					return "未完成";
				case "1":
					return "实施完成";
				case "2":
					return "实施中";
				case "3":
					return "实施失败";
			}
	  	}
	</script>
</body>