<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../../../icp/include/taglib.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>浪潮云服务</title>
		<%@ include file="../../../icp/include/import.jsp"%>
		<script type="text/javascript" src="${ctx}/icp/js/jquery.SuperSlide2.js"></script>
		<style>	
			.mr_frbox{height:60px;padding:14px 0px 0px;}
			.mr_frBtnL{cursor:pointer;display:inline;float:left;height:46px;margin:40px 10px 0 0;width:28px;}
			.mr_frBtnR{float:right;display:inline;margin-top:40px;cursor:pointer;width:28px;height:46px;}
			.mr_frUl{float:left;height:150px;width:500px;margin-left:10px;}
		</style>	
	</head>
	<body>

		<form id="conditionForm" action="${ctx}/resourceinfo/resourceInfo.do" method="post">
		<input type="hidden" name="pageNo" id="pageNo" value="1"/>
			<div class="container-wrap">
				<div class="container center-container">
					<div class="container-left">
						<div class="sub-menu sub-menu-new">
							<ul>
								<li style="background:#fff;"><img src="${ctx}/icp/images/resmanage.png" alt=""/></li>
								<li><a href="#" class="on">资源一览1</a></li>
								<li><a href="${ctx}/resourceinfo/resourceInfo.do?method=operate">资源操作</a></li>
								<li><a href=" ${ctx}/image/imageList.do">镜像管理</a></li>
							</ul>
						</div>
					</div>
					<div class="container-right">
						<div class="container-cell">
							<div class="pay-hd cf">
								<div class="line two-input">
								<p class="title">起止日期：</p>
									<div class="infor">
										<p>
											<input type="text" class='text dateStart' id="starttime" name="starttime" value="${starttime}" />
										</p>
									</div>
									<div class="lineBg"></div>
									<div class="infor ml30">
										<p>
											<input type="text" class='text dateEnd' id="endtime" name="endtime" value="${endtime}" />
										</p>
									</div>
									<%-- <input class="easyui-datebox" id="beginTime" name="beginTime" value="${beginTime}" style="width:181px;"/>&nbsp;至
								<input class="easyui-datebox" id="endTime" name="endTime" value="${endTime}" style="width:181px;"/> --%>
								</div>
								<div class="line">
									<p class="title">资源：</p>
									<div class="infor">
										<p>
											<input type="text" class='text' id="resourceid" name="resourceid" value="${resourceid}" onBlur="if(value==defaultValue){value=''}"/>
										</p>
									</div>
								</div>
								<div class="button" onclick="query()">
									<input type="submit" value='查询' />
								</div>
								<div class="button" onclick="clearquery()">
									<input type="submit" value='重置' />
								</div>
							</div>
							<table class="accounts-table">
								<thead>
									<tr>
										<th width="20%">IP</th>
										<th width="10%">名称</th>
										<th width="20%">配置</th>
										<th width="15%">开通时间</th>
										<th width="15%">订单号</th>
										<th width="20%">工单号</th>
										<th width="10%">状态</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(resourceList) > 0}">
										<c:forEach items="${resourceList}" var="vo">
											<tr class="bcffe6d9" align="center">
												<td>${vo.ipaddr}</td>
												<td>${vo.nename}</td>
												<td >
                                                    <c:if test="${fn:containsIgnoreCase(vo.osname, 'centos')}">
                                                    <img src="${ctx}/icp/images/CentOS.png">-${vo.cpunum}核-${vo.memnum}G-${vo.disknum}G
                                                    </c:if>
                                                    <c:if test="${fn:containsIgnoreCase(vo.osname, 'win')}">
                                                    <img src="${ctx}/icp/images/winServer.png">-${vo.cpunum}核-${vo.memnum}G-${vo.disknum}G
                                                    </c:if>
                                                    <c:if test="${fn:containsIgnoreCase(vo.osname, 'ubuntu')}">
                                                    <img src="${ctx}/icp/images/Ubuntu.png">-${vo.cpunum}核-${vo.memnum}G-${vo.disknum}G
                                                    </c:if>

                                                </td>
												<td>${vo.sbegin}</td>
												<td>${vo.orderid}</td>
												<td>${vo.flowid}</td>
												<td>
													<c:if test="${vo.curstat=='Stopped'}"><font color='red'>停止</font></c:if>
													<c:if test="${vo.curstat=='Running'}">运行</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${fn:length(resourceList) == 0}">
										<tr class="bcffe6d9" align="center">
											<td colspan="7">暂无数据</td>
										</tr>
									</c:if>
									<tr>
								        <td colspan="7">
											<%--<jsp:include page="../../include/page.jsp"></jsp:include>--%>
										</td>
							        </tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</form>
		<%--<jsp:include page="../../include/indexFoot.jsp" />--%>
	
		<!-- 一级弹出层  -->
		<div class="floatLayer"></div>
		<div class="floatLayerBg"></div>
		<!-- 二级弹出层  -->
		<div class="floatLayers"></div>
		<div class="floatLayerBgs"></div>
		<script type="text/javascript" src="../icp/gov2/gov2.js">
		</script>
		<script type="application/javascript">
			gov2.initSecondMenu();
		</script>
	</body>

</html>
