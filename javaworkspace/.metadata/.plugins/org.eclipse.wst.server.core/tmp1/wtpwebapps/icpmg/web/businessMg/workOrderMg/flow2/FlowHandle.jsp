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
	String spModelId = String.valueOf(vo1.getSpmodelid());
	
	//操作标记，区分父流程、子流程实施页面--实施经理页面，和实施人员页面
	String operType = "";//operType = "gdcf";//工单拆分操作标记
	String spflowtype = String.valueOf(vo1.getSpflowtype());//1父流程，2子流程
	String ssdetailid = vo1.getSsdetailid()==null?"":vo1.getSsdetailid().toString();//实施detailid
%>
<body>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/workOrder/workorder.css"/>
	<form id="editForm" style="padding: 5px;" method="post" enctype="multipart/form-data">

	<%-- <script type="text/javascript" src =""<%=path%>/web/businessMg/workOrderMg/flow2/scripts/TextFormat.js"" ></script> --%>

	<div id="tabs" class="easyui-tabs" style="background:#eee" data-options="tabWidth:112, border:false" >
		<div id="tabs-1" title="基本信息" data-options="fit:true" style="padding:10px;">
			<div style="width:90%;height:10px" align="center"></div>
			<table id="toptable" align="center" style="width:90%">
				<caption class="TicketTitle2"><font class="Titlefont2">${requestScope.vo1.modelname}</font></caption>
			</table>
			<table class="wotable" align="center" style="width:90%">
				<tr>
					<td class="FieldLabel5" style="border-top:none !important;">工单标题</td>
					<td class="FieldInput51" style="border-top:none !important;">
					<input type="text"   name="flowname"  id="flowname" readonly="readonly" style="border:none !important;background:none !important;height:25px;width:95% !important" value="${requestScope.vo1.flowname}"  /> </td>
				</tr>
			</table>
			<table class="wotable" align="center" style="width:90%">
				<tr>
					<td class="FieldLabel5" style="border-top:none !important;" >工单编号</td>
					<td class="FieldInput5" style="border-top:none !important;" ><input type="text" name="flowid" id="flowid"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.flowid}" /> </td>
						
					<td class="FieldLabel5" style="border-top:none !important;" >申请单编号</td>
					<td class="FieldInput5" style="border-top:none !important;" ><input type="text" name="orderid" id="orderid"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.orderid}" /> </td>
				</tr>
					<tr>
					<td class="FieldLabel5" >工单类别</td>
					<td class="FieldInput5" ><input type="text" name="flowtypename" readonly="flowtypename" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.flowtypename}" /> </td>
					
					<td class="FieldLabel5" >工单创建时间</td>
					<td class="FieldInput5" ><input type="text" name="ctime"  readonly="ctime" style="border:none !important;background:none !important;height:25px"  value="${requestScope.vo1.ctime}" /> </td>
				</tr>
				<tr>
					<td class="FieldLabel5" > 创建人名称</td>
					<td class="FieldInput5" ><input type="text" name="cusername" id="cusername"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.cusername}" /> </td>
				    <%--
				    	<td class="FieldLabel" >产品名称</td>
						<td class="FieldInput" ><input type="text" name="shopname" id="shopname"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.shopname}" /> </td>
				     --%>
				     <td class="FieldLabel5" >申请单位</td>
					 <td class="FieldInput5" ><input type="text" name="unitname" id="unitname"  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="${requestScope.vo1.unitname}" /> </td>
			</table>
		
			<%-- 流程个性化配置 bmc_form_config --%>
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
					<td class="FieldLabel5"><%=fieldname%></td>
					<td class="FieldInput5">
						<input id="<%=field%>" type="text" name="<%=field%>"  style="border:none !important;background:none !important;height:25px" readonly="readonly" value="<%=fieldvalue %>" />
					</td>  
		            <%  
		              if(i==arrayList.size()-1){
		             %> 
	                <td class="FieldLabel5"></td>
					<td class="FieldInput51">
						<input type="text" name="" id=""  readonly="readonly" style="border:none !important;background:none !important;height:25px" value="" /> 
					</td>
				</tr>
		             <%    
		               }
		             }else{
		              %> 
	               <td class="FieldLabel5"><%=fieldname%> </td>
				   <td class="FieldInput51">
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
				<td  class="FieldLabel5" style="border-top:none !important;" ><%=fieldname %></td>
				<td class="FieldInput51" style="border-top:none !important;" ><textarea rows="5" cols="100" style="border:none !important;background:none !important;" readonly="readonly" name="<%=field %>" ><%=fieldvalue %></textarea></td>
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
                  <td class = "FieldLabel6" >技术方案</td >
                  <td class = "FieldInput6" ><a href="#" onclick="downloadFile('<%=fileUrls%>')"><span style="font-color:blue;"><%=fileNames%></span></a></td>
             </tr >
		  <%	
		 	}
		 %>
		</table>
	</div>
	
	<%--工单审批 tab页 开始 --%>
	<div id="tabs-2" title="工单审批"  class="y-ggsp" data-options="selected:true">
		<div class="y-ggsp-now ">
			<input type="hidden" name="stepno1" id="stepno1" value ="${requestScope.vo1.stepno}" />
			<input type="hidden" name="stepname1" id="stepname1" value ="${requestScope.vo1.stepname}" />
			<input type="hidden" name="nextno1" id="nextno1" value ="" />
			<input type="hidden" name="modelid" id="modelid" value ="${requestScope.vo1.modelid}" />
			<input type="hidden" name="operatorid" id="operatorid" value ="<%=userid%>" />
			<input type="hidden" name="rowid" id="rowid" value ="${requestScope.vo1.steproleid}" />
			<input type="hidden" name="isupload" id="isupload" value="${requestScope.vo2.isupload }">
			<input type="hidden" name="yesorno" id="yesorno" value ="" />
			<input type="hidden" name="operatorname" id="operatorname"  value=<%=username%> /> 
			<input type="hidden" name="rowname" id="rowname" value="${requestScope.vo1.dorolename}" />
			<input type="hidden" name="activityname" id="activityname" value="${requestScope.vo1.stepname}" />
			<input type="hidden" name="time1" id="time1" value="${requestScope.vo1.stepstarttime}" />
			
			<%
				//工单状态vo1.getFstatusid()：5办结，6驳回，7注销
				if (!vo1.getFstatusid().equals("5") && !vo1.getFstatusid().equals("6") && !vo1.getFstatusid().equals("7")) {
			%>
			
            <div class="title"><span class="y-text"><%=vo1.getStepno() %>. 当前环节：${requestScope.vo1.stepname} </span> 
            <span class="y-btn">
            <%
            if (vo1.getStepno() != vo1.getStepnum()) {
				if (flag) {
	              	String opbutton = String.valueOf(vo2.getOpbutton());
					if (opbutton != null && "1".equals(opbutton)) {
						String buttonname = vo2.getOpbuttonname();
						String ophtml = vo2.getOphtml();
            %>
              	<a href="#" onClick="javascript:openDialog('<%=ophtml%>','<%=buttonname%>');"  class="easyui-linkbutton" data-options="iconCls:'icon-search'"><%=buttonname%></a>
            <%
					}
				}
            }	
            %>
            </span>
            
            </div>
            <table width="100%" class="y-table-layout">
                <thead>
                    <tr>
                        <td align="right">处理人：</td>
                        <td><%=username%></td>
                        <td align="right">处理人角色：</td>
                        <td>${requestScope.vo1.dorolename}</td>
                        <td align="right">环节开始时间：</td>
                        <td>${requestScope.vo1.stepstarttime}</td>
                    </tr>
                    <!-- 审批时上传文件  start-->
					<c:if test="${ 1 eq vo2.isupload}">
						<tr>
							<td align="right"><font color="red">*</font>资源申请表扫描件：</td>
							<td colspan="5">
								<input type="file" id="fileload" style="width: 85% !important;height: 30px; " name="fileload" >  
								<%--<input id="fileload" name="fileload" class="easyui-filebox" data-options="prompt:'请选择一个文件', buttonText: '选择文件',buttonIcon:'icon-file' " style="width:100%;">--%>
							</td>
						</tr>
					</c:if>
					<!-- 审批时上传文件  end-->
			
                    <tr>
                        <td align="right">处理备注：</td>
                        <td colspan="5">
                            <textarea name="comments" id="comments" style="width: 79% !important; height: 70px; padding-right:76px;color:#999; overflow-y:auto" class="y-shadow-input " onfocus="if(value=='不得超过250个字符'){value='';this.style.color='#666';}" onblur="if (value ==''){value='不得超过250个字符';this.style.color='#999';}" value==''>不得超过250个字符</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="5">
                        <%
                        if (vo1.getStepno() != vo1.getStepnum()) {
                        	if (flag) {
                        		if (vo2.getYesnexbutton() != null && !"".equals(vo2.getYesnexbutton())) {
                					String buttonname = vo2.getYesnexbutton();
                					String nextno = String.valueOf(vo2.getYesnextop());
                			%>
                			<a href="#" id="submitBtn2" onClick="javascript:saveAndSend('<%=nextno %>','1','');" class="easyui-linkbutton" data-options="iconCls:'icon-ok'"><%=buttonname%></a>&nbsp;&nbsp;&nbsp;
							<%
                        	}
                        	%>
                        	<%
                        	if (vo2.getNonextbutton() != null && !"".equals(vo2.getNonextbutton())) {
            					String buttonname = vo2.getNonextbutton();
            					String nextno = String.valueOf(vo2.getNonextop());
            					
            					//工单拆分子流程 驳回按钮(特殊)
            					if(spflowtype.equals("2")){
            						operType = "gdcf";//工单拆分操作标记
            					}
            					
                        	%>
                        	<a href="#" id="submitBtn" onClick="javascript:saveAndSend('<%=nextno %>','0','<%=operType%>');"
								 class="easyui-linkbutton" data-options="iconCls:'icon-no'"><%=buttonname%></a>
                        	<%
        						}
                        	%>
                       		<%
        						}

                			}
                        	%>
                        </td>
                    </tr>
                </thead>
            </table>
            <br/>
	        <%
			}
	        %>
        </div>
        <%--审批信息结束 --%>
        
		<%-- 审批记录   start --%>
	  	<div class="y-ggsp-spjl">
		    <div class="title"><span class="text">审批记录</span>
		        <hr>
		    </div>
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
					   String cstatusname = vo.getCstatusname();
					   int cstatus = vo.getCstatus();
			%>
	    	<%--一条记录 开始  --%>
	          <div class="easyui-accordion" data-options="multiple:true,collapsible:false,selected:false">
	              <div title=' <span class="title-text" style="display:inline-block;width:330px;"><%=i+1 %>.<%=stepname%></span>
	           		<span class="title-text" style="display:inline-block;width:180px;">处理人:<%=cusername %></span>         
	           		<span class="title-text">        处理时间:<%= ctime%> </span>
	           		<span class="title-text">处理意见：<%=cstatusname %>    </span>' style="overflow:auto;padding:10px;">
	                  <table class="y-wotable" width="100%" align="center">
	                      <tbody>
	                          <tr>
	                              <td class="FieldLabelGd">处理人</td>
	                              <td class="FieldInputGd">
	                                  <input type="text" name="operatorname" field="operatorname" readonly style="border:none !important;background:none !important;" value="<%=cusername %>">
	                              </td>
	                              <td class="FieldLabelGd">处理人角色</td>
	                              <td class="FieldInputGd">
	                                  <input type="text" name="operator" field="operator" readonly style="border:none !important;background:none !important;" value="<%=dorolename %>">
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="FieldLabelGd">环节开始时间</td>
	                              <td class="FieldInputGd">
	                                  <input type="text" name="activityname" field="activityname" readonly style="border:none !important;background:none !important;" value="<%=starttime %>"> </td>
	                              <td class="FieldLabelGd">环节结束时间</td>
	                              <td class="FieldInputGd">
	                                  <input type="text" name="operatorcontacts" field="operatorcontacts" readonly style="border:none !important;background:none !important;" value="<%=ctime %>">
	                              </td>
	                          </tr>
	                          <%--如果有审批附件则进行显示  开始 *** --%>
							  <%
							  	  if(spfj_fileid != null && !"".equals(spfj_fileid)){
						      %>
							  <tr>
									<td  class="FieldLabelGd" >资源申请表扫描件</td>
										<td class="FieldInputGd" colspan="3">
											<a href="#" onClick="javascript:downloadSpfile('<%=spfj_fileid %>','<%=spfj_fileurl%> ');" "><input type="text" name="spfj_fileid" field="spfj_fileid" readonly="readonly" style="border:none !important;background:none !important; color:blue;" value=<%=spfj_filename %> /> </td></a>
										</td>
									</td>
							   </tr>
							   <%	
									}
							   %>	
							    <%--如果有审批附件则进行显示  结束 *** --%>	
	                          <tr>
								<td class="FieldLabelGd" style="border-top:none !important;">处理备注 </td>
								<td class="FieldInputGd" style="border-top:none !important;" colspan="3"><textarea rows="5" cols="100" style="border:none !important;background:none !important;" readonly="readonly" type="text" name="comments" field="comments" ><%=snote %></textarea></td>
							</tr>
	                      </tbody>
	                  </table>
	              </div>
	          </div>
	          <%--一条记录 结束  --%>
	      <%
			    }
			 }
		  %>
	    </div>
	    <%-- 审批记录   end --%>
	</div>
	<%--工单审批tab页结束 --%>
	
		<%-- 重庆政务云    订单详情 tab页   start  sortName:'stepno',sortOrder:'desc',--%>
		<%
		String  modelid = String.valueOf(vo1.getModelid());
		String spmodelid = String.valueOf(vo1.getSpmodelid());
		String ftable = vo1.getFtable();
	  	//if(modelid.equals("0000000020") || modelid.equals("0000000021") || spmodelid.equals("0000000020") || spmodelid.equals("0000000021")){//资源申请
	  	if(ftable.equals("upd_order")){
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
					<th data-options="field:'status',width:30,align:'center',sortable:true,formatter:zybgoperformater">状态</th>
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
		//if(modelid.equals("0000000022") || modelid.equals("0000000023")){//重庆政务云资源变更
		  if(ftable.equals("upd_update_order")){
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
					<th data-options="field:'appname',width:100,align:'center'">应用</th>
					<th data-options="field:'networktype',width:100,align:'center'">网络类型</th>
					<th data-options="field:'tnumber',width:50,align:'center'">数量</th>
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
		//easyui附件控件优化
		var fileCss = setTimeout(function() {
	        changefile();
	    }, 300);
	
	    function changefile() {
	        if ($('.y-ggsp .filebox .textbox-text')) {
	
	            $('.y-ggsp .filebox .textbox-text').attr("disabled", "disabled");
	            $('.y-ggsp .filebox .textbox-text').css({
	                'background-color': '#fff'
	            });
	            clearTimeout(fileCss);
	        }
	    }
    
		$(document).ready(function () {
			//订单详情，显示悬浮框
			$('#dg4').datagrid({ 
				onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				},
			    rowStyler:function(index,row){   
			        if (row.detailid=='<%=ssdetailid%>'){   
			            return 'background-color:yellow;';   
			        }   
			     }   
	        });
			//资源变更详情，显示悬浮框
			$('#dg5').datagrid({ 
				 onLoadSuccess: function (data) {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				 },
				 rowStyler:function(index,row){   
				        if (row.detailid=='<%=ssdetailid%>'){   
				            return 'background-color:yellow;';   
				        }   
				   }   
	        });
	       
		    <%-- 
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
				
			});--%>
			
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

		<%-- 
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
		}--%>

		 //操作类型
	 function operTypeFormater(value,row,index){
		 switch(value){
			 case "1":
				 return "变更";
			 case "2":
				 return "注销";
		 }
	 }
		 
		function saveAndSend(str1, str2, str3) {
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
				if(comments == "不得超过250个字符"){
					comments = "";
				}
				var time1 = $("#time1").val();
				var yesorno = $("#yesorno").val();
				var isupload = $("#isupload").val();
				var orderid = "${requestScope.vo1.orderid}";
				var url = '<%=path%>/workorder/saveAndSend.do?flowid='+flowid+'&stepno1='+stepno1+'&stepname1='+encodeURI(encodeURI(stepname1))+
						'&nextno1='+nextno1+'&modelid='+modelid+'&operatorid='+operatorid+
						'&rowid='+rowid+'&rowname='+encodeURI(encodeURI(rowname))+'&comments='+encodeURI(encodeURI(comments))+'&time1='+time1+
						'&yesorno='+yesorno+'&isupload='+isupload+"&orderId="+orderid+'&operType='+str3+'&spmodelid='+'<%=spModelId%>';
				
				$('#editForm').form('submit', {
					url: url,
					onSubmit: function () {
						if(comments.length>250){
							$.messager.alert('提示', "备注不能多于250字");
							return false;
						}
						if(isupload == 1 && str2 == '1'){//审批通过且要求上传附件
							var filetype = $("#editForm input[name='fileload']")[0].value;
							//var filetype = $("#fileload").filebox('getValue');
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
             
            //处理工单拆分操作标记    
            var operTypeUrl= ""; 
            if('<%=spflowtype%>' == '1'){//1父流程，2子流程
            	operTypeUrl = "&operType=gdcfAssign";
            }else if('<%=spflowtype%>' == '2'){//实施流程
            	operTypeUrl = "&operType=gdcf";
            }
			var url = '<%=path%>/' + str + "?transferid=${requestScope.vo1.flowid}&stepno=${requestScope.vo1.stepno}"+operTypeUrl;
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
		 
		  if('200005'==row.shopid){
			    
			     return icp.formatString('<a style=\"color:blue;cursor:pointer\" onclick=\"viewStoreDetails(\'{0}\',\'{1}\');\">详情</a>', row.detailid,row.orderid);
			  
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
			
			    var url='${pageContext.request.contextPath}/web/ordersMg/orderJGTG.jsp?flowid='+orderid+'&detailid='+detailid+'&appname='+encodeURI(encodeURI(appname));
		     	var dialog = parent.icp.modalDialog({
				  title : '机柜托管详情',
				  width:'800px',
				  url : url,
				  draggable:true
				});
			}
			
			function viewIPDetails(detailid,orderid){
			
			    var url='${pageContext.request.contextPath}/web/ordersMg/orderIp.jsp?flowid='+orderid+'&detailid='+detailid;
		     	var dialog = parent.icp.modalDialog({
				  title : '互联网线路',
				  width:'750px',
				  height:'450px',
				  url : url,
				  draggable:true
				});
			}
			function viewJWDetails(detailid,orderid,appname){
			
			    var url='${pageContext.request.contextPath}/web/ordersMg/orderJWTG.jsp?flowid='+orderid+'&detailid='+detailid+'&appname='+encodeURI(encodeURI(appname));
		     	var dialog = parent.icp.modalDialog({
				  title : '机位托管详情',
				  width:'800px',
				  url : url,
				  draggable:true
				});
			}
			function viewStoreDetails(detailid,orderid){
		        var url="${pageContext.request.contextPath}/web/ordersMg/orderStore.jsp?orderid="+orderid+"&detailid="+detailid;
		     	var dialog = parent.icp.modalDialog({
					title : '云硬盘详情一览',
					width:'700px',
					height: '300px',
					url : url,
					draggable:true
				});
			}
		
		//实施状态
		function zybgoperformater(value, row, index){ 
			switch(value){
				case "0":
					return "未完成";
				case "1":
					return "实施完成";
				case "2":
					return "实施中";
				case "3":
					return "实施失败";
				case "4":
					return "待实施";
				case "5":
					return "驳回";
				case "6":
					return "废弃";
			}
		}
	</script>
</body>