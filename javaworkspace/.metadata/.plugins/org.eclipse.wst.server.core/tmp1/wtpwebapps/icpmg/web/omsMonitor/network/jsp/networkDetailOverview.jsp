<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>网路监控情界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="newtwork,lb">
	<meta http-equiv="description" content="网路监控情界面">
	<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1"> 

  </head>
<body>
<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/network/css/networkDetailOverview.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/web/omsMonitor/network/css/jquery.bigpage.css" />
		
<script type="text/javascript"  src="${pageContext.request.contextPath}/web/omsMonitor/network/js/jquery.bigpage.js" charset="UTF-8"></script>
  		
<script type="text/javascript">
var neid = '${pageContext.request.getParameter("neid")}';
var typeid = '${pageContext.request.getParameter("typeid")}';
//var neid = 'SLB-jxw-SLB-000066';
			$(document).ready(function() {
				queryNetworkBasic();
				queryNetworkAlarm();
			});
			//查询基本信息
			function queryNetworkBasic(){
				$('#queryNetworkBasic').form(
						'load',
						"${pageContext.request.contextPath}/oms_summary/queryBasicInfo.do?neid="+neid
				);
			};
			
			//查询告警信息
			function queryNetworkAlarm(){
				$("#networkDetailTable_alarm").bigPage({
					data:null,
					ajaxData:{
						url :' ${pageContext.request.contextPath}/oms_summary/queryAlarmEvent.do?almCategory=INHOST&neid='+neid,
								params:{}
						},
						pageSize:10,
						maxPageNumCount:10
					});
			}
			function JumpNetWorkRunPage(){
				var url = '/icpmg/web/omsMonitor/network/jsp/networkRunOverview.jsp';
				if(typeid=='SLB'){
					url = '/icpmg/web/omsMonitor/network/jsp/slbRunOverview.jsp';
				}
				if(typeid=='LINE'){
					url = '/icpmg/web/omsMonitor/network/jsp/lineRunOverview.jsp';
				}
				$('#centerTab').panel({
					href:url,
					queryParams:{
						typeid:typeid,
						neid:neid
					}
				});	
			}
		</script>
	  	<div class="networt_container">
	  	<form id="queryNetworkBasic" method="post">
	  		<div class = "network_top">
	  			<div class = "network_top_o" >
	  				<div class="network_top_o_1 network_top_o_l">基本信息</div>
		  			<div class="network_top_o_2 network_top_o_r"></div>
	  			</div>
	  			<div class = "network_top_t" >
	  				<div class="network_top_o_1 network_top_t_l"><span >名称：</span><input readonly class="top_3_span_top_inserverd_top"  name="neid" ></input></div>
		  			<div class="network_top_o_2 network_top_t_r"></div>
	  			</div>
	  			<div class = "network_top_t" >
	  				<div class="network_top_o_1 network_top_t_l"><span >IP：</span><input readonly class="top_3_span_top_inserverd_top"  name="ipaddr" ></input></div>
		  			<div class="network_top_o_2 network_top_t_r"></div>
	  			</div>
	  			<div class = "network_top_t" >
	  				<div class="network_top_o_1 network_top_t_l"><span >类型：</span><input readonly class="top_3_span_top_inserverd_top"  id="networktypeid" name="typeid" ></input></div>
		  			<div class="network_top_o_2 " style="border-right:1px #ddd solid; height: 50px;line-height: 50px;margin-top: 9px;"></div>
	  			</div>
	  			<div class = "network_top_f" >
	  				<div  class="network_top_f_btn" onclick='JumpNetWorkRunPage()'>
	  					&lt;运行概况
	  				</div>
	  			</div>
	  		</div>
	  		
	  		<div class="work-text">
				<section class="ac-container">
					<div>
						<input id="ac-1" name="accordion-1" type="checkbox" />
						<label for="ac-1" class="grid1"><i></i>基本信息</label>
						<article class="ac-smallone">
							<div  class="inhostDetailTable">
								<div>
									<div class='inhostDetail_FieldLabel2'> 设备名称：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly   name='neid'></input></div>
									<div class='inhostDetail_FieldLabel2'> 设备编码：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='nename'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 设备类型：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='typename'></input></div>
									<div class='inhostDetail_FieldLabel2'> 设备型号：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='omodel'></input></div>
								</div>
							</div>
							<div>
									<div class='inhostDetail_FieldLabel2'> 域名：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='ipname'></input></div>
									<div class='inhostDetail_FieldLabel2'> mac：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='macaddr'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> IP地址：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='ipaddr'></input></div>
									<div class='inhostDetail_FieldLabel2'> 业务IP：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='sip'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>展示名称：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='displayname'></input></div>
									<div class='inhostDetail_FieldLabel2'> 厂商编码：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='vendorname'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>资源位置：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='slocation'></input></div>
									<div class='inhostDetail_FieldLabel2'> 资源用途：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='useinfo'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>管理状态：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='adstat'></input></div>
									<div class='inhostDetail_FieldLabel2'> 操作状态：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='opstat'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>费用状态：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='feestat'></input></div>
									<div class='inhostDetail_FieldLabel2'> 设备等级：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly  name='nelevel'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>删除标志：</div>
									<div class='inhostDetail_FieldLabel2' ><input readonly  name='deleteflag'></input></div>
									<div class='inhostDetail_FieldLabel2' > </div>
									<div class='inhostDetail_FieldLabel2' > </div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>备注：</div>
									<div class='inhostDetail_FieldLabel2' ><input readonly  name='remark'></input></div>
									<div class='inhostDetail_FieldLabel2' > </div>
									<div class='inhostDetail_FieldLabel2' > </div>
								</div>
						</article>
					</div>
					<div>
						<input id="ac-2" name="accordion-1" type="checkbox" />
						<label for="ac-2" class="grid2"><i></i>维护信息</label>
						<article class="ac-smalltwo">
							<div  class="inhostDetailTable">
								<div>
									<div class='inhostDetail_FieldLabel2'> 录入人：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='insertman'></input></div>
									<div class='inhostDetail_FieldLabel2'> 维护人：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='opuser'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>创建时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='buytime'></input></div>
									<div class='inhostDetail_FieldLabel2'> 试运行时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='testtime'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>入网时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='usetime'></input></div>
									<div class='inhostDetail_FieldLabel2'> 退网时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='useendtime'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>配置更新时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='ctime'></input></div>
									<div class='inhostDetail_FieldLabel2'>性能更新时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='ptime'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>告警更新时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='ftime'></input></div>
									<div class='inhostDetail_FieldLabel2'>最后更新时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='infotime'/></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>软件版本：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='softver'/></div>
									<div class='inhostDetail_FieldLabel2'></div>
									<div class='inhostDetail_FieldLabel2'></div>
								</div>
							</div>
						</article>
					</div>
					<div>
						<input id="ac-3" name="accordion-1" type="checkbox" />
						<label for="ac-3" class="grid3"><i></i>归属层级</label>
						<article class="ac-smallthree">
							<div  class="inhostDetailTable">
								<div>
									<div class='inhostDetail_FieldLabel2'> 区域：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='nodename'></input></div>
									<div class='inhostDetail_FieldLabel2'> 省：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='provname'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 地市：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='cityname'></input></div>
									<div class='inhostDetail_FieldLabel2'> </div>
									<div class='inhostDetail_FieldLabel2'></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 机房：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='roomname'></input></div>
									<div class='inhostDetail_FieldLabel2'> 所属资源池：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='poolname'></input></div>
								</div>
							</div>
						</article>
					</div>
					<div>
						<input id="ac-4" name="accordion-1" type="checkbox" />
						<label for="ac-4" class="grid4"><i></i>租户信息</label>
						<article class="ac-smallfour">
							<div  class="inhostDetailTable">
								<div>
									<div class='inhostDetail_FieldLabel2'> 申请人：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='suserid'></input></div>
									<div class='inhostDetail_FieldLabel2'> 应用类型：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='appmodel'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 一级归属：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='groupid'></input></div>
									<div class='inhostDetail_FieldLabel2'> 二级归属：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='puserid'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 归属单位：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='unitname'></input></div>
									<div class='inhostDetail_FieldLabel2'>网络类型：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='networktypename'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>项目名称：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='projectname'></input></div>
									<div class='inhostDetail_FieldLabel2'>应用名称：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='appname'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>一级服务类型：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='severtypeidlevelfirst'></input></div>
									<div class='inhostDetail_FieldLabel2'>二级服务类型：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='servertypeidlevelsecond'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>服务开始时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='sbegin'></input></div>
									<div class='inhostDetail_FieldLabel2'>服务结束时间：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='send'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>订单编码：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='orderid'></input></div>
									<div class='inhostDetail_FieldLabel2'>流程编码：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='flowid'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>详细编码：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='detailid'></input></div>
									<div class='inhostDetail_FieldLabel2'>运行状态：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='curstat'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'>价格：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='perprice'></input></div>
									<div class='inhostDetail_FieldLabel2'>VLAN编码：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='vlanid'></input></div>
								</div>
							</div>
						</article>
					</div>
					<div>
						<input id="ac-5" name="accordion-1" type="checkbox" />
						<label for="ac-5" class="grid5"><i></i>告警信息</label>
						<article class="ac-smallfive">
							<div class="ac-smallfive_space">
								<table border="1" align="center" style="width:99%" id="networkDetailTable_alarm">
									<thead>
										<tr>
											<th style="background-color: #e5f5eb;font-size: 14px;">设备</th>
											<!-- <th>厂商</th> -->
											<th style="background-color: #e5f5eb;font-size: 14px;">IP</th>
											<th style="background-color: #e5f5eb;font-size: 14px;">发生时间</th>
											<th style="background-color: #e5f5eb;font-size: 14px;">事件标题</th>
											<th style="background-color: #e5f5eb;font-size: 14px;">事件类型</th>
											<th style="background-color: #e5f5eb;font-size: 14px;">事件级别</th>
											<th style="background-color: #e5f5eb;font-size: 14px;">确认人</th>
											<th style="background-color: #e5f5eb;font-size: 14px;">确认时间</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</article>
					</div>
					<div>
						<input id="ac-6" name="accordion-1" type="checkbox" />
						<label for="ac-6" class="grid6"><i></i>配置信息</label>
						<article class="ac-smallsix">
							<div  class="inhostDetailTable">
								<div>
									<div class='inhostDetail_FieldLabel2'> 所属平台：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='platformid'></input></div>
									<div class='inhostDetail_FieldLabel2'></div>
									<div class='inhostDetail_FieldLabel2'></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 数据中心：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='datacenter'></input></div>
									<div class='inhostDetail_FieldLabel2'> 集群：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='cluster'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 物理机：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='hostname'></input></div>
									<div class='inhostDetail_FieldLabel2'> 物理存储：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='storage'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 模板：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='templateid'></input></div>
									<div class='inhostDetail_FieldLabel2'></div>
									<div class='inhostDetail_FieldLabel2'></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> cpu颗数：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='cpunum'></input></div>
									<div class='inhostDetail_FieldLabel2'> 内存大小(G)：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='memnum'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 操作系统：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='osname'></input></div>
									<div class='inhostDetail_FieldLabel2'> 杀毒软件：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='antivirus'></input></div>
								</div>
								<div>
									<div class='inhostDetail_FieldLabel2'> 是否可用：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='haenable'></input></div>
									<div class='inhostDetail_FieldLabel2'> 数据盘：</div>
									<div class='inhostDetail_FieldLabel2'><input readonly name='disknum'></input></div>
								</div>
							</div>
						</article>
					</div>
				</section>
			</div>
			</form>
	  	</div>
</body>
</html>
