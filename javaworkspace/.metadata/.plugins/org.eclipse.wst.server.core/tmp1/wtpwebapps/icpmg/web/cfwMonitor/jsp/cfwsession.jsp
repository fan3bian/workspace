<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body>
<style type="text/css">
    .FieldInput2 {
        width:35%;
        height:25px;
        background-color: #FFFFFF;
        font: normal 12px tahoma, arial, helvetica, sans-serif;
        text-align: left;
        word-wrap: break-word;
        padding-top:0px !important;
        padding-bottom:0px !important;
        border:#BCD2EE 1px solid !important;
    }
    .FieldLabel2 {
        width:20%;
        height:25px;
        background-color: #F0F8FF;
        font: normal 12px tahoma, arial, helvetica, sans-serif;
        text-align: left;
        word-wrap: break-word;
        padding-top:0px !important;
        padding-bottom:0px !important;
        padding-right:10px !important;
        border:#BCD2EE 1px solid !important;
    }
</style>

<script type="text/javascript">





    $(document).ready(function() {

        function loadDataGrid(){
            $('#securitySessionDataGrid').datagrid({
                rownumbers:false,
                border:false,
                striped:true,
//			sortName:'fname',
//			sortOrder:'asc',
                nowarp:false,
                singleSelect:false,
                method:'post',
                loadMsg:'数据装载中......',
                fitColumns:true,
                pagination:true,
                pageSize:10,
                pageList:[5,10,20,30,40,50],
//                url:'../cfwMonitor/jsp/datagrid_dataSession.json'
                url:'${pageContext.request.contextPath}/cfwMonitor/getListPmdSecuritySession.do'
            });
        }
        loadDataGrid();
    });

    function curStatFormatter (value,row,index){
        if (value =="Running"){
            return '运行中';
        } else if(value =="Stopped") {
            return '已停止';
        } else if(value =="Starting"){
            return '正在启用';
        } else if(value =="Stopping"){
            return '正在停止';
        }else{
            return value;
        }
    }

    function resetContent(formId) {
        var clearForm = document.getElementById(formId);
        if (null != clearForm && typeof(clearForm) != "undefined") {
            clearForm.reset();
        }
    }
    function searchDataGrid(){
        $('#securitySessionDataGrid').datagrid('load',icp.serializeObject($('#funcmgr_searchform')));
    }




</script>

<div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
    <div data-options="region:'north',border:false" style="height:30px;overflow:hidden;">
        <form id="funcmgr_searchform">
            <input type="hidden" name="cmd" id="cmd" value="search">
            <table class="tableForm datagrid-toolbar">
                <tr>
                    <td>目的IP：<input class="easyui-textbox" name="destIp" id="destIp" style="width:200px">
                    </td>
                    <td>
                        目的端口：<input class="easyui-textbox" name="destInf" id="destIpInf" style="width:200px">
                    </td>
                    <td>会话时间：<input class="easyui-datetimebox" name="starttime" id="starttime" style="width:200px">
                    </td>
                    <td>协议类型：<input class="easyui-textbox" name="application" id="application" style="width:100px">
                    </td>
                    <td>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="$('#funcmgr_searchform input').not($('#cmd')).val('');">重置</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div data-options="region:'center',border:false">
        <%--{"rows":[{"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","destIp":"172.23.8.4",
        "endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束",
        "sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"},

        {"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","
        destIp":"172.23.8.4","endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束","sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"},{"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","destIp":"172.23.8.4","endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束","sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"},{"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","destIp":"172.23.8.4","endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束","sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"},{"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","destIp":"172.23.8.4","endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束","sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"},{"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","destIp":"172.23.8.4","endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束","sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"},{"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","destIp":"172.23.8.4","endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束","sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"},{"application":"HTTP","closetime":"2016-09-23 15:36:58","destInf":"8080","destIp":"172.23.8.4","endReason":"TCP FIN","inpkts":2,"intraffic":140,"objectid":"jxwshxxhc-SECURITY-Ew-000190","outpkts":4,"outtraffic":272,"policyId":"3","sessionstate":"会话结束","sourceInf":"62712","sourceIp":"10.23.11.14","starttime":"2016-09-23 15:36:39"}],"total":8}--%>
        <table title="" style="width:100%;" id="securitySessionDataGrid">
            <thead>
            <%--{"serverid":"2016-09-10 12:00:00","policy":"Koi","targetportipip":"192.168.1.2","host":"P","targetportipport":1,
            "targetportip":"Large","targetport":"EST-1"},--%>
            <%--{"serverid":"2016-09-10 12:00:00","policy":"Koi","sourceip":"192.168.1.2","host":"P",
            "sourceport":1,"targetportip":"Large","targetport":"EST-1"},--%>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'starttime',width:120,align:'center',sortable:true">时间</th>
                <th data-options="field:'policyId',width:120,align:'center',sortable:true">策略ID</th>
                <th data-options="field:'sourceIp',width:80,align:'center'">源IP</th>
                <th data-options="field:'host',width:80,align:'center'">用户@主机</th>
                <th data-options="field:'sourceInf',width:80,align:'center'">源端口</th>
                <th data-options="field:'destIp',width:80,align:'center'">目的IP</th>
                <th data-options="field:'destInf',width:80,align:'center'">目的端口</th>
                <th data-options="field:'application',width:80,align:'center'">协议</th>
                <th data-options="field:'options',width:80,align:'center'">行为</th>
                <th data-options="field:'outpkts',width:80,align:'center'">发送流量</th>
                <th data-options="field:'inpkts',width:80,align:'center'">接收流量</th>
                <th data-options="field:'endReason',width:80,align:'center'">会话结束原因</th>
            </tr>
            </thead>
        </table>
    </div>


</div>
</body>