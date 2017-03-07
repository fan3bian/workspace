<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="../../icp/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>资源一览</title>
</head>
<body>

<script src="../omsMonitor/inhost/js/runOverview/echarts-all.js"></script>
<div class="easyui-layout" data-options="fit:true,border:false"
     style="padding:10px 20px 10px 10px;margin:10px 20px 10px 10px;height:500px;">
  <div data-options="region:'north',border:false" style="background:#eee;height:40px;overflow:hidden;">
    <span id="userName" style="font-size:14px">用户：</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <span id="boughtNum"  style="font-size:14px">购买容量(M)：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <span id="usedNum"  style="font-size:14px">已使用量(M)：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </div>
  <div data-options="region:'center',border:false" id="resourcesid">
    <div id="overview" style="width: 100%;height:300px;"></div>
    <div id="girdTabs" class="easyui-tabs" >
      <div id="tab1" title="网络客户端">
        <table title="" style="width:99%;" id="DisasterOverviewDataGrid">
          <thead>
          <tr>
            <%--projectid, projectname, unittype, unitid, unitname, objectid, severtypeidlevelfirst,--%>
            <%--servertypenamelevelfirst, servertypeidlevelsecond, servertypenamesecond, appname, bussinessstat, extension1, extension2, extension3, snote--%>
            <th data-options="field:'clientname',hidden:true,width:10," >备份机器名称</th>
            <th data-options="field:'interfacename',width:25,align:'center'">备份机器IP</th>
            <th data-options="field:'osname',width:20,align:'center',sortable:true">操作系统</th>
            <th data-options="field:'idataagent',width:30,align:'center',sortable:true">备份类型</th>
            <%--<th data-options="field:'jobid',width:100,align11:'center'" >任务id</th>--%>
            <%--<th data-options="field:'startdate',align:'center',sortable:true,">开始时间</th>--%>
            <%--<th data-options="field:'enddate',width:100,align:'center'" >结束时间</th>--%>

            <%--<th data-options="field:'jobstatus',width:30,align:'center',sortable:true" formatter="successFormater">是否成功</th>--%>
            <th data-options="field:'incrlevel',align:'center',sortable:true" formatter="increaseFormatter">备份类型</th>
            <th data-options="field:'numbytesuncomMB',align:'center',width:50,sortable:true">备份容量(MB)</th>
            <th data-options="field:'startdate',align:'center',sortable:true" formatter="dateFormatter">备份时间</th>
          </tr>
          </thead>
        </table>
      </div>
      <div id="tab2" title="虚拟客户端"  >
        <table title="" style="width:99%;" id="DisasterOverviewDataGridVM">
          <thead>
          <tr>

            <th data-options="field:'clientname',width:75,align:'center'">资源名称</th>
            <th data-options="field:'osname',width:20,align:'center',sortable:true">操作系统</th>
            <th data-options="field:'incrlevel',align:'center',sortable:true" formatter="increaseFormatter">备份类型</th>
            <th data-options="field:'numbytesuncomMB',align:'center',width:50,sortable:true">备份容量(MB)</th>            
            <th data-options="field:'startdate',align:'center',sortable:true" formatter="dateFormatter">备份时间</th>
          </tr>
          </thead>
        </table>


      </div>

    </div>

  </div>

</div>

<script type="text/javascript">
  /*
   *  删除数组元素:Array.removeArr(index)
   */
  Array.prototype.removeArr = function (index) {
    if (isNaN(index) || index>= this.length) { return false; }
    this.splice(index, 1);
  }
  /*
   *  插入数组元素:Array.insertArr(dx)
   */
  Array.prototype.insertArr = function (index, item) {
    this.splice(index, 0, item);
  };
  var flagck = 0;  //  初始化为0
  $(document).ready(function () {
    var option = {
      title: {
        text: '云容灾购买使用量占比图',
        subtext: '',
        x: 'center'
      },
      animation:true,
      tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
      },
      legend: {
        orient: 'vertical',
        x: 'left',
        y:'center',
        align: 'right',
        padding:10,
        textStyle:{
          color:'auto'
        },
        data: [{
          name:'使用量',
          icon : 'bar',
          textStyle:{fontWeight:'bold', color:'green'}
        }, {
          name:'未使用量',
          icon : 'bar',
          textStyle:{fontWeight:'bold', color:'blue'}
        }]
      },
      series: [
        {
          name: '云容灾购买使用量',
          type: 'pie',
          radius: '80%',
          center: ['55%', '50%'],
          itemStyle: {
            emphasis: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };

    var tab2Data ={};
    init();
    $("#girdTabs").tabs({
      onSelect : function (title,index) {
        if( 1 == index){
          var _datagridVM =  $('#DisasterOverviewDataGridVM').datagrid({
            rownumbers: false,
            scrollbarSize:0,
            checkOnSelect: true,
            selectOnCheck: false,
            border: false,
            striped: true,
            nowarp: false,
            singleSelect: true,
            method: 'post',
            loadMsg: '数据装载中......',
            fitColumns: true,
            pagination: true,
            pageSize:10,
            pageNumber:1,
            pageList: [5,10,20,30]});

          $('#DisasterOverviewDataGridVM').datagrid({

            onLoadSuccess: function (data) {
              var pageopt = _datagridVM.datagrid('getPager').data("pagination").options;
              var  _pageSize = pageopt.pageSize;
              var  _rows = _datagridVM.datagrid("getRows").length;
              var total = pageopt.total; //显示的查询的总数
              if (_pageSize >= 10) {
                for(i=10;i>_rows;i--){
//							{ itemid: '<div style="text-align:center;color:red">没有相关记录！</div>' }
                  //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
                  $(this).datagrid('appendRow', {operation:'', incrlevel:'-1',jobstatus:'-1' })
                }
                _datagridVM.datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
                  total: total
                });
                //	$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
              }else{
                //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
                $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
              }


            }

          }).datagrid('loadData', tab2Data);
        }
      }
    });

    function init() {
      loadDataGrid();
      getBasicInfoAndDrawPie();
    }


    function drawPie(option){
      var boughtnum = {
        value: 1024,
        name: '购买容量'
      };
      var myChart = echarts.init(document.getElementById('overview'));
      myChart.setOption(option);
    }


    function loadDataGrid() {
      var _datagrid = $('#DisasterOverviewDataGrid').datagrid({
        rownumbers: false,
        scrollbarSize:0,
        checkOnSelect: true,
        selectOnCheck: false,
        border: false,
        striped: true,
        nowarp: false,
        singleSelect: true,
        method: 'post',
        loadMsg: '数据装载中......',
        fitColumns: true,
        pagination: true,
        pageSize:10,
        pageNumber:1,
        pageList: [5,10,20,30],
        url: '${pageContext.request.contextPath}/report/DisasterOverview.do',
        onLoadSuccess: function (data) {
          var pageopt = _datagrid.datagrid('getPager').data("pagination").options;
          var  _pageSize = pageopt.pageSize;
          var  _rows = _datagrid.datagrid("getRows").length;
          var total = pageopt.total; //显示的查询的总数
          if (_pageSize >= 10) {
            for(i=10;i>_rows;i--){
//							{ itemid: '<div style="text-align:center;color:red">没有相关记录！</div>' }
              //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
              $(this).datagrid('appendRow', {operation:'', incrlevel:'-1',jobstatus:'-1' })
            }
            _datagrid.datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
              total: total
            });
            //	$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
          }else{
            //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
            $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
          }


        },
        loadFilter :function(data){
          return dataTrans(data,tab2Data);
//					return tab1Data;
        }


      });

    }

    function dataTrans(data,tab2Data){

      var rowsNew1 = [];
      tab2Data.rows = [];
      $(data.rows).each(function(i,element){
        console.log(element.interfacename == "unknown");
        if(element.interfacename.trim() == "unknown"){


          tab2Data.rows.insertArr(tab2Data.rows.length,element);
          tab2Data.total = tab2Data.rows.length;

          data.rows.removeArr(i);
        }else{
          rowsNew1.insertArr(rowsNew1.length,element);
        }
      });
      //debugger;
      data.rows =  rowsNew1;
      data.total = rowsNew1.length;
//			debugger;
      console.log(data);
      return data;

    }

    function getBasicInfoAndDrawPie(){
      $.ajax({
        url: '${pageContext.request.contextPath}/report/BasiceInfo.do',
        dataType:'JSON',
        success:function(data){
          $('#userName').append(data.userName);
          $('#boughtNum').append(data.boughtMB);
          $("#usedNum").append(data.usedNum);
          var _data = [];
          var usedNum = {
            value: data.usedNum,
            name: '使用量'
          };
          var unusedNum = {
            value: data.boughtMB - data.usedNum,
            name: '未使用容量'
          };
          _data[0] = usedNum;
          _data[1] = unusedNum;
          option.series[0].data = _data.sort(function (a, b) { return a.value - b.value});
          drawPie(option);
        }
      });
    }

  });

  function increaseFormatter(value,row,index){
    //	console.log(value == 0);
    if (value == 1){
      return "增量备份";
    } else if(value == 0) {
      return "全量备份";
    }else{
      return ""
    }
  }
  function successFormater(value,row,index){
    if("Success" == value || "PartialSuccess" == value) {
      return " 成功";
    }else if("-1" == value){
      return "";
    }else{
      return "失败";
    }
  }

  function dateFormatter(value,row,index){
	    //	console.log(value == 0);
	  if (value) { 
	        var arr1 = value.split("."); 
	        return arr1[0];
	       //  var sdate = arr1[0].split('-'); 
	       // var date = new Date(sdate[0], sdate[1], sdate[2]); 
	       // return date; 
	    } 
	  else return "";
	  }

  function getRootPath() {
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    return (localhostPaht + projectName+"/");
  }

</script>


</body>
</html>