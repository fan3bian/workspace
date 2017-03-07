<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<style type="text/css">
.FieldInput2 {
	width: 35%;
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
	width: 20%;
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
		function getnowtime() {
            var nowtime = new Date();
            var year = nowtime.getFullYear();
            var month = padleft0(nowtime.getMonth() + 1);
            var day = padleft0(nowtime.getDate());
            var hour = padleft0(nowtime.getHours());
            var minute = padleft0(nowtime.getMinutes());
            var second = padleft0(nowtime.getSeconds());
            return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second ;
        }
        //补齐两位数
        function padleft0(obj) {
            return obj.toString().replace(/^[0-9]{1}$/, "0" + obj);
        }
	
		var addOrUpdate = "add" ;
		var toolbar = [{
			text:'增加',
			iconCls:'icon-add',
			handler:function()
				{
					$("#customPropertyTable").empty() ;
					$("#tableform").form('reset'); 
					initTableformProperty() ;
					initRadioPropertyTd() ;
					addOrUpdate = "add" ;
					var curtime =getnowtime(); //获取当前时间
					$("[class=fillcurtime]").each(function(){
						$(this).val(curtime) ;
					});
					
					
					//resetContent('resetContent');
					//$('#w').window('open');
					 $('#serviceWindow').dialog({
			            closed: false
			        });
				}
			},
			{
				text:'删除',
				iconCls:'icon-remove',
				handler:host_removeFun
			},
			{
				text:'修改',
				iconCls:'icon-modify',
				handler:host_preEdit
				}];
	
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
		
		function initTableformProperty()
		{
			$("#adstat").val("1") ;
			$("#opstat").val("1") ;
			$("#deleteflag").val("1") ;
		}
		
		function initCellTip(obj)	
		{	
				var email = $(obj).text() ;
				if(email == null || email.length == 0)
					return ;
				$.ajax({
						url : urlrootpath+'/common/getUserBsInfo.do',
						data : {
							email : email
						},
						dataType : 'json',
						success : function(result) {
							if(result == null) return ;
							var value = result.usertype ;
							var usertypeStr = "" ;
							if (value =="1"){
								usertypeStr = '政府客户';
							} else if(value =="2") {
								usertypeStr = '企业客户';
							} else if(value =="3"){
								usertypeStr = '公众客户';
							} else if(value =="4"){
								usertypeStr = '管理员';
							}
							
							$("#emailTd").html(result.email) ;
							$("#unameTd").html(result.uname) ;
							$("#usertypeTd").html(usertypeStr) ;
							$("#mobileTd").html(result.mobile) ;
							
							$(obj).tooltip({
								content: $("#userbaseinfo").html(),
								showEvent: 'hover',
								onShow: function(){
									var t = $(this);
									t.tooltip('tip').unbind().bind('mouseenter', function(){
										t.tooltip('show');
									}).bind('mouseleave', function(){
										t.tooltip('hide');
									});
								}
							});
						}
					});
		
		}
		
		function resetContent(formId) {
			var clearForm = document.getElementById(formId);
			if (null != clearForm && typeof(clearForm) != "undefined") {
				clearForm.reset();
				}
			}

		function host_removeFun() {
			var rows = $('#dg').datagrid('getChecked');
			//var rows = $('#dg').datagrid('getChecked');
			var ids = [];
			if (rows.length > 0) {
				$.messager.confirm('确认', '您是否要删除当前选中的项目？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
								ids.push(rows[i].neid);
						}
						$.ajax({
							url : urlrootpath+'/rmdobject/deleteRmdObject.do',
							data : {
								neids : ids.join(',')
							},
							dataType : 'json',
							success : function(result) {
								if (result.success) {
									$.messager.alert('消息',result.msg); 
									$('#dg').datagrid('load');
									$('#dg').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
								}else{
									$.messager.alert('消息','删除失败'); 
								}
							}
						});
					}
				});
			} else {
				$.messager.alert('消息','请至少选择一条记录！'); 
			}
		}
		
		function host_preEdit(){
			$("#tableform").form('reset'); 
			var rows = $('#dg').datagrid('getSelections');
			var ids = [];
			if (rows.length ==1) {
					for ( var i = 0; i < rows.length; i++) {
							ids.push(rows[i].neid);
					}
					var cfgtable = rows[0].cfgtable ;
					$.ajax({
						url : urlrootpath+'/rmdobject/getObjectByNeid.do',
						async: false,   // 太关键了，学习了，同步和异步的参数
						data : {
							neid : ids.join(','),
							cfgtable:cfgtable
						},
						dataType : 'json',
						success : function(result) {
							
							curtypeid = result.obj.typeid ;
							
							freshCustomTypeProperty(curtypeid,result) ;
							
							addOrUpdate = "update" ;
							
							 
							//$('#w').window('open');
						$('#serviceWindow').dialog({
				            closed: false
				        });
						}
					});
			} else if (rows.length ==0) {
				$.messager.alert('消息','请至少选择一条记录！'); 
			}else if (rows.length >1) {
				$.messager.alert('消息','只能选择一条记录！'); 
			}
		}
		$(document).ready(function() {
			loadDataGrid();
			
		});
		function loadDataGrid()
		{
			$('#dg').datagrid({
				rownumbers:false,
				border:true,
				striped:true,
				sortName:'fname',
				sortOrder:'asc',
				nowarp:false,
				singleSelect:false,
				method:'post',
				loadMsg:'数据装载中......',
				fitColumns:true,
				idField:'neid',
				pagination:true,
				pageSize:10,
				pageList:[5,10,20,30,40,50],
				toolbar:toolbar, 
			    url:'${pageContext.request.contextPath}/rmdobject/getObjectList.do',
			    onLoadSuccess:function(data){   
				    initSeleValues();
				    $("[field=opuser],[field=suserid]").each(function(){
				    	$(this).hover(function(){
				    		 initCellTip(this);
				    	});
			   		 });
			    
				 var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
			      var  _pageSize = pageopt.pageSize;
			      var  _rows = $('#dg').datagrid("getRows").length;
			      var total = pageopt.total; //显示的查询的总数
			      if (_pageSize >= 10) {
			         for(var i=10;i>_rows;i--){
			            //添加一个新数据行，其中{} 中的operation 为最后一列 的列名 如下图说明
			            $(this).datagrid('appendRow', {neid:''  });
			         }
			         $('#dg').datagrid('getPager').pagination('refresh',{	// 改变选项，并刷新分页栏-条数信息
				    		total: total,
				    	});
			         // $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
			      }else{
			         //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
			         $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			      }
			      //设置不显示复选框
			      var rows = data.rows;
			      if (rows.length) {
						 $.each(rows, function (idx, val) {
							if(val.neid==''){  
								$('#objectListDiv input:checkbox').eq(idx+1).css("display","none");
								 
							}
						}); 
			      }
			 } ,
			 //没数据的行不能被点击
			 onClickRow: function (rowIndex, rowData) {
						if   (rowData.neid==''){
							 $(this).datagrid('unselectRow', rowIndex);
						}else{
							flagck=0;
						}
						//判断时候已经有全部选择
						if(flagck ==1){
							$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
						}
			}, 
			 //全选问题
			onCheckAll: function(rows) {
				flagck = 1;
					$.each(rows, function (idx, val) {
						if   (val.neid==''){
							$("#dg").datagrid('uncheckRow', idx);
							//增加全选复选框被选中
							$('div.datagrid-header-check input:checkbox').eq(0).attr("checked","checked");
						}
					});
			}, 
			onUncheckAll: function(rows) {
				flagck = 0;
			} 
 
			}); 
			
		}
		
		
			
		function searchDataGrid(){
			
			$('#dg').datagrid('load',icp.serializeObject($('#funcmgr_searchform')));
		};
		
		
		function formatAdstat(val,row){
			if (val == 1){
				return '可管理';
			} else if(val == 0){
				return '不可管理';
			}
			else return "" ;
		}
	
		function formatOpstat(val,row){
			if (val == 1){
				return '可操作';
			}else if(val == 0){
				return '不可操作';
			}
			else return "" ;
		}
		
		function formatFeestat(val,row){
			if (val == 1){
				return '试运行';
			} else if (val == 2) {
				return '计费';
			}else if (val == 3) {
				return '计费结束';
			}
		}
		
		
		
		function showSelectWin()
		{
			 $('#condiSearch').textbox({onClickButton:function()
			 {
			 	$('#condiSearchTable').datagrid('clearChecked');
			 	$('#condiSearchTable').datagrid('reload',{
						condi: 'Suserid',
						condiSearch: this.value
						});
			 }});
			 condiSearchTableLoad();
			 $('#search1').window('open');
		}
		function condiSearchTableLoad()
		{
			$('#condiSearchTable').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					pagination:true,
					pageSize:10,
					pageList:[10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/authMgr/getCondiByCondi.do',
				    queryParams: {
						condi: 'Suserid',
						condiSearch: $('#condiSearch').textbox('getValue')
					}
				    
					}); 
		}
		
		function showSelectWin2()
		{
			 $('#condiSearch').textbox({onClickButton:function()
			 {
			 	$('#condiSearchTable1').datagrid('clearChecked');
			 	$('#condiSearchTable1').datagrid('reload',{
						condi: 'Suserid',
						condiSearch: this.value
						});
			 }});
			 condiSearchTableLoad1();
			 $('#search2').window('open');
		}
		
		function condiSearchTableLoad1()
		{
			$('#condiSearchTable1').datagrid({
					rownumbers:false,
					border:false,
					striped:true,
					nowarp:false,
					singleSelect:false,
					method:'post',
					loadMsg:'数据装载中......',
					fitColumns:true,
					pagination:true,
					pageSize:10,
					pageList:[10,20,30,40,50],
				    url:'${pageContext.request.contextPath}/authMgr/getCondiByCondi.do',
				    queryParams: {
						condi: 'Suserid',
						condiSearch: $('#condiSearch').textbox('getValue')
					}
				    
					}); 
		}
		
		
	</script>
	
	<!-- tc.jsp中的js -->
	<script>
    
    function formatUsertype(value,row){
		
		var usertypeStr = "" ;
		if (value =="1"){
			usertypeStr = '政府客户';
		} else if(value =="2") {
			usertypeStr = '企业客户';
		} else if(value =="3"){
			usertypeStr = '公众客户';
		} else if(value =="4"){
			usertypeStr = '管理员';
		}
		
		return usertypeStr ;
		
	}
    
    function initRadioPropertyTd()
    {
    	$("[class=radioPropertyTd]").each(function(){
    		var liValue = $(this).find("input").val() ;
    		$(this).find("li.li"+liValue+"").addClass('active').siblings().removeClass('active');
    	});
    }
    
    function initRemoteSeleValue(target,url)
    {
    	$('#'+target).combobox({
    		url:url,
    	    valueField:'selekey',
    	    textField:'selevalue',
    	    onSelect:function(rec){
   	    		var targetname = target.substr(0,target.length -2 )+"name" ;
   	    		
    			$("#"+targetname).val(rec.selevalue) ;
    	    }
    	});  
    }
    
    function initLocalSeleValue(target,data)
    {
    	$('#'+target).combobox({
    		data:data,
    	    valueField:'selekey',
    	    textField:'selevalue'
    	});  
    }
    
    function initSeleValues()
    {
    	initRemoteSeleValue('typeid', urlrootpath+'/common/getTypeSelelist.do');
    	initRemoteSeleValue('vendorid', urlrootpath+'/common/getVendorSelelist.do');
    	initRemoteSeleValue('poolid', urlrootpath+'/common/getPoolSelelist.do');
    	initRemoteSeleValue('roomid', urlrootpath+'/common/getRoomSelelist.do');
    	initRemoteSeleValue('cityid', urlrootpath+'/common/getRegionSelelist.do');
    	initRemoteSeleValue('provid', urlrootpath+'/common/getRegionSelelist.do');
    	initRemoteSeleValue('nodeid', urlrootpath+'/common/getNodeSelelist.do');
    	initRemoteSeleValue('unitid', urlrootpath+'/common/getUnitSelelist.do');
    	initRemoteSeleValue('groupid', urlrootpath+'/common/getUnitSelelist.do');
    	initRemoteSeleValue('projectid', urlrootpath+'/common/getProjectSelelist.do');
    	initRemoteSeleValue('appid', urlrootpath+'/common/getAppSelelist.do');
    	initRemoteSeleValue('severtypeidlevelfirstid', urlrootpath+'/common/getServertypeSelelist.do');
    	initRemoteSeleValue('networktypeid', urlrootpath+'/common/getNetworktypeSelelist.do');
    	initRemoteSeleValue('vlanid', urlrootpath+'/common/getVlanSelelist.do');
    	
    	var nelevelValues =  [{selekey: '1',selevalue: '一级'},{selekey: '2',selevalue: '二级'},{selekey: '3',selevalue: '三级'},{selekey: '4',selevalue: '四级'},{selekey: '5',selevalue: '五级'}] ;
    	initLocalSeleValue("nelevel",nelevelValues) ;
    	
    	
    	var curstatValues =  [{selekey: 'Running',selevalue: '运行中'},{selekey: 'Stopped',selevalue: '已停止'},{selekey: 'Starting',selevalue: '正在启用'},{selekey: 'Stoping',selevalue: '正在停止'}] ;
    	initLocalSeleValue("curstat",curstatValues) ;
    	
    	var feeValues =  [{selekey:1,selevalue:'试运行'},{selekey:2,selevalue:'计费'},{selekey:3,selevalue:'计费结束'}] ;
    	initLocalSeleValue("feestat",feeValues) ;
		
    	initRadioPropertyTd();
    	
    	$('#typeid').combobox({
    	    onSelect:function(rec){
    			$("#typename").val(rec.selevalue) ;
    			if(rec.selekey == "VM") $("#cfgtable").val("rmd_vm") ;
    			else
    				$("#cfgtable").val("") ;
    			
    			
    			freshCustomTypeProperty(rec.selekey,null) ;
    	    }
    	});  
    	
    	$('#severtypeidlevelfirstid').combobox({
    	    onSelect:function(rec){
    	    	$("#severtypeidlevelfirstname").val(rec.selevalue);
    	    	initRemoteSeleValue('servertypeidlevelsecondid', urlrootpath+'/common/getServertypeSelelist.do?pid='+rec.selekey);
    	    }
    	});  
    	
    	$('#roomid').combobox({
    	    onSelect:function(rec){
    	    	
    	    	$.ajax({
					url : urlrootpath+'/common/getRoomInfo.do',
					data : {
						roomid : rec.selekey
					},
					dataType : 'json',
					success : function(result) {
							var provid = result.proid ;
							var cityid = result.cityid ;
							
							$("#provid").combobox('select', provid);
							
							
							$('#cityid').combobox({
								url : urlrootpath+'/common/getRegionSelelist.do?parentId='+provid,
					    	    valueField:'selekey',
					    	    textField:'selevalue',
					    	    onLoadSuccess:function(){
					    	    	$("#cityid").combobox('select', cityid);
	    			    	    },
					    	    onSelect:function(rec){
					    			$("#cityname").val(rec.selevalue) ;
					    	    }
					    	});  
							
					}
    	    	});	
    	    	
    	    	
    	    	initRemoteSeleValue('servertypeidlevelsecondid', urlrootpath+'/common/getServertypeSelelist.do?pid='+rec.selekey);
    	    }
    	});  
    }
    
    
    
    function freshCustomTypeProperty(typeid,objItem)
	{
		$.ajax({
					url : urlrootpath+'/common/getCustomPropertyByType.do',
					data : {
						typeid : typeid
					},
					dataType : 'json',
					success : function(result) {
						var tableContent = "" ;
						$("#customPropertyTable").empty() ;
						
						for(var i = 0 ;i<result.length ;i ++)
						{
							if(i % 2 ==  0 )
								tableContent = tableContent + "<tr>" ;
							
							
							tableContent = tableContent + "<td align=\"right\" width=\"15%\">"+result[i].propertylable+"：</td>" ; 	
							if(result[i].propertytype == 0)
							{
								tableContent = tableContent + "<td  align=\"left\" width=\"35%\" style=\"display:none;\"><input  type=\"text\" class=\"ty-top-input\"  id=\""+result[i].propertykey+"\"  name=\""+result[i].propertykey+"\" style=\"width:170px;\"> </td> " ;
							}
							if(result[i].propertytype == 1)
							{
								tableContent = tableContent + "<td  align=\"left\" width=\"35%\"><input  type=\"text\" class=\"ty-top-input\"  id=\""+result[i].propertykey+"\"  name=\""+result[i].propertykey+"\" style=\"width:170px;\"> </td> " ;
							}
							if(result[i].propertytype == 3)
							{
								tableContent = tableContent + "<td  align=\"left\" width=\"35%\"><input  type=\"text\" class=\"ty-top-input\"  id=\""+result[i].propertykey+"\"  name=\""+result[i].propertykey+"\" style=\"width:170px;\"> </td> " ;
							}
							
							if(result[i].propertytype == 4 )
							{
								tableContent = tableContent + "<td  align=\"left\" width=\"35%\" class=\"radioPropertyTd\"><input  type=\"hidden\" class=\"ty-top-input\"  id=\""+result[i].propertykey+"\"  name=\""+result[i].propertykey+"\" style=\"width:182px;\" >" ;
								
								tableContent = tableContent + "<ul class=\"ty-tabscon-item-ul j-item-toggle\">" ;
								
								var radiokeyvalues = result[i].listvalue.split(",") ;
								var defaultvalue = result[i].defaultvalue ;
								
								for(var j= 0 ;j < radiokeyvalues.length;j++)
								{
									var radiovalues = radiokeyvalues[j].split(":") ;
									var liclass =  radiovalues[0] ;

									if(radiovalues[0] == defaultvalue)
										liclass = liclass + " active" ;
									
									tableContent = tableContent + "<li class=\"li"+ liclass +"\" >"+radiovalues[1]+"</li>" ;
								}
								
								tableContent = tableContent + "</ul></td> " ;
							}
							
							if(i  % 2 !=  0 )
								tableContent = tableContent + "</tr>" ;
						}
						
						if(result.length > 1 && result.length % 2 != 0)
						{
							tableContent = tableContent + "</tr>" ;
						}
						$("#customPropertyTable").append(tableContent) ;
						

						for(var i = 0 ;i<result.length ;i ++)
						{
							
							if(result[i].propertytype == 3)
							{
								initRemoteSeleValue(result[i].propertykey, urlrootpath+result[i].listvalue);
								//initRemoteSeleValue(result[i].propertykey, urlrootpath+"/common/getCusProValueByProid.do?proid="+result[i].id);
							}
						}
						
						$('#customPropertyTable .j-item-toggle li').click(function(event) {
					        $(this).addClass('active').siblings().removeClass('active');
					        
					        var liclass = $(this).attr("class") ;
					        
					        var livalue = liclass.substr(liclass.indexOf("li")+2,1) ;
					        $(this).parent().parent().find("input").val(livalue) ;
					    });
						if(objItem != null)
						{
							$('#tableform').form('load',objItem.obj);
							$("#suserid").val(objItem.obj.Suserid);
							
							var puseridUrl = urlrootpath+'/common/getUnitSelelist.do?punitid='+objItem.obj.groupid ;
							$('#puserid').combobox({
	    			    		url:puseridUrl,
	    			    	    valueField:'selekey',
	    			    	    textField:'selevalue',
	    			    	    onLoadSuccess:function(){
	    			    	    	$("#puserid").combobox('select', objItem.obj.Puserid);
	    			    	    },
	    			    	    onSelect:function(rec){
	    			   	    		
	    			    	    }
	    			    	});  
						}

					}
				});
	}
    
    function freshOpuser()
    {
    	var searchContent = $("#searchOpuser").val() ;
    	loaduserdata("opuserSearch",searchContent) ;
    }
    
    function freshSuser()
    {
    	var searchContent = $("#searchSuser").val() ;
    	loaduserdata("userPopSearch",searchContent) ;
    }
    
    function loaduserdata(target, searchContent)
    {
    	$('#'+target).datagrid({
			rownumbers:false,
			border:true,
			striped:true,
			sortName:'fname',
			sortOrder:'asc',
			nowarp:false,
			singleSelect:false,
			method:'post',
			loadMsg:'数据装载中......',
			fitColumns:true,
			idField:'email',
			pagination:true,
			pageSize:5,
			pageList:[5,10,20,30,40,50],
	    	singleSelect:true,
		    url:'${pageContext.request.contextPath}/common/getUserBsList.do',
		     queryParams:{searchContent:searchContent},
		    onLoadSuccess:function(data){   
			} 
		   
			}); 
    	var pager = $('#'+target).datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			
			displayMsg: ''
		});
    }
    
    
    function openOpuserWindow() {
    	
    	loaduserdata("opuserSearch","") ;
        $('#serviceWindow2-1').dialog({

            closed: false
        })
    }
    
    
    function freshPoolList()
    {
    	searchContent = $("#poolSearch").val() ;
    	$.ajax({
			url : urlrootpath+'/common/getPoolList.do',
			data : {
				searchContent : searchContent
			},
			dataType : 'json',
			success : function(result) {
				$("#poolListUl").empty() ;
				var liListContent = "" ;
				for(var i = 0 ; i <result.rows.length ;i++)
				{
					var displayname = result.rows[i].poolname ;
					if(displayname == null) displayname = "" ;
					
					var regionname = result.rows[i].regionname ;
					if(regionname == null) regionname = "" ;
					
					liListContent = liListContent + "<li><p class=\"pool-name\">名称："+displayname+"</p>" ;
					liListContent = liListContent + "<input type=\"hidden\" name=\"poolid\" value=\""+result.rows[i].poolid+"\"/>" ;
					liListContent = liListContent + "<p >地区："+ regionname+"</p></li>" ;
				}
				$("#poolListUl").append(liListContent) ;
				
				$('#poolListUl li').click(function(event) {
			        $(this).addClass('active').siblings().removeClass('active');
			        
			    });
				
				  $('#page').pagination({
			        total: result.total,
			        pageSize: 20,
			        showPageList: false,
			        showRefresh: false,
			        displayMsg: ""
				});
			}
    	});
    }

    function openPoolWindow() {
    	freshPoolList() ;
      
        $('#serviceWindow3-1').dialog({

            closed: false
        })

    }

    function openApplicant() {
    	loaduserdata("userPopSearch","") ;
        $('#serviceWindow4-1').dialog({
			
            closed: false
        })
    }
    // 交互
    $('#tcPop').click(function(event) {
        $('#serviceWindow').dialog({
            closed: false
        });

    });
    $('#easyTab').tabs({
        border: false,
        onSelect: function(title) {
            alert(title + ' is selected');
        }
    });
    $('.j-tabs li').click(function(event) {
        $(this).addClass('active').siblings().removeClass('active');
        $('.j-tabs-con').eq($(this).index()).show().siblings().hide();
        if ($(this).index() == 1) {

        }
    });
    //选项卡1切换，选项卡3 弹层切换
    $('.j-item-toggle li').click(function(event) {
        $(this).addClass('active').siblings().removeClass('active');
        
        var liclass = $(this).attr("class") ;
        
        var livalue = liclass.substr(liclass.indexOf("li")+2,1) ;
        $(this).parent().parent().find("input").val(livalue) ;
    });
    // 选项卡2
    $(document).on('click', '.j-name tbody tr', function(event) {

        $(this).addClass('active').siblings().removeClass('active');
    });
    // 选项卡3
   // $('#searchPool').click(function(event) {
     //   openResourcePool();
    //});
    // 初始化
    $('#serviceWindow').dialog({
        title: "资源信息维护",
        width: 760,
        height: 570,
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
				
            	submitSave() ;
            
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
                $('#serviceWindow').dialog('close');
            }
        }]
    });
    $('.j-datetime').datetimebox({
        showSeconds: false
    });
    $('.j-search').linkbutton({
        iconCls: 'icon-search',
        plain: true,
    });


    // 选项卡2中弹层
    $('#serviceWindow2-1').dialog({
        title: "选择维护人",
        width: 560,
        height: 350,
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
            	var row = $('#opuserSearch').datagrid('getSelected');
            	$("#opuser").val(row.email) ;
            	$("#searchOpuser").val("") ;
                $('#serviceWindow2-1').dialog('close');

            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
        	    $("#searchOpuser").val("") ;
                $('#serviceWindow2-1').dialog('close');
            }
        }]
    });
    // 选项卡3中弹层
    $('#serviceWindow3-1').dialog({
        title: "选择资源池",
        width: 640,
        height: 360,
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
            	var poolid = $("#poolListUl li.active input").val() ;
				$("#poolid").combobox('select', poolid);
            	$("#poolSearch").val("") ;
            	
                $('#serviceWindow3-1').dialog('close');

            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
            	$("#poolSearch").val("") ;
                $('#serviceWindow3-1').dialog('close');
            }
        }]
    });
    $('#page').pagination({
        total: 120,
        pageSize: 10,
        showPageList: false,
        showRefresh: false,
        displayMsg: ""
    });
    // 选项卡4中弹层
    $('#serviceWindow4-1').dialog({
        title: "选择申请人",
        width: 560,
        height: 350,
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
            	var row = $('#userPopSearch').datagrid('getSelected');
            	$("#suserid").val(row.email) ;
            	
            	$.ajax({
    				url : urlrootpath+'/common/getUnitOfUser.do',
    				data :{suserid:row.email},
    				dataType : 'json',
    				success : function(result) {
    					$("#groupid").combobox('select', result.punitid);
    					
    					$('#puserid').combobox({
    			    		url:urlrootpath+'/common/getUnitSelelist.do?punitid='+result.punitid,
    			    	    valueField:'selekey',
    			    	    textField:'selevalue',
    			    	    onLoadSuccess:function(){
    			    	    	$("#puserid").combobox('select', result.unitid);
    			    	    },
    			    	    onSelect:function(rec){
    			   	    		
    			    	    }
    			    	});  
    					
    				}
            	});
            	$("#searchSuser").val("") ;
                $('#serviceWindow4-1').dialog('close');

            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function() {
            	$("#searchSuser").val("") ;
                $('#serviceWindow4-1').dialog('close');
            }
        }]
    });
    
    
    function submitSave()
	{
		var validateFlag  = $("#tableform").form('validate');
		if(validateFlag == false)
		{
			$.messager.alert('消息','请完整填写内容');  
			return false ;
		}
		
		$("#tableform input.required").each(function(){
			var value = $("#"+$(this).attr("id")).val() ;
			if(value == null || value.length == 0 || value == -1)
			//if($(this).val() == null || $(this).val().length == 0 || $(this).val() == -1)
			{
				$.messager.alert('消息','请完整填写内容');  
				validateFlag = false ;
				return false;
			}
		});
		
		if(validateFlag == false)
			return false ;
		
		var obj = icp.serializeObject($("#tableform"));
		var url =null;
		if(addOrUpdate == "add"){
			 url =urlrootpath+'/rmdobject/addRmdObject.do';
		}else{
			url =urlrootpath+'/rmdobject/updateRmdObject.do';
		}
		$.ajax({
				url : url,
				data :icp.serializeObject($("#tableform")),
				dataType : 'json',
				success : function(result) {
					if(result.success){
						$.messager.alert('消息',result.msg);  
						$('#dg').datagrid('reload',icp.serializeObject($('#funcmgr_searchform')));
						$('#dg').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						
		                $('#serviceWindow').dialog('close');
		            	
						return true ;
			    	}
					else
					{
						$.messager.alert('消息',result.msg);  
						return false ;
					}
				}
			});
	}
    </script>
	
	
	<%@include file="tc.jsp" %>
	
	<div class="easyui-layout" data-options="fit:true,border:false"
		style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
		<div data-options="region:'north',border:false"
			style="height:30px;overflow:hidden;">
			<form id="funcmgr_searchform">
				<table class="tableForm datagrid-toolbar">
					<tr>
						<td>
							资源类型：<input id="typeidSearch" style="height:25px"
							name="typeid" class="easyui-combobox"
							data-options="valueField:'selekey',textField:'selevalue',url:'../../common/getTypeSelelist.do',panelHeight:'200',height:200" />
						</td>
						<td>使用单位：<input id="unitidSearch" style="height:25px" name="unitid"
							class="easyui-combobox"
							data-options="valueField:'selekey',textField:'selevalue',url:'../../common/getUnitSelelist.do',panelHeight:'300',height:200" />
						</td>
						<td>名称/IP：<input class="easyui-textbox" name="searchContent"
							id="searchContent" style="width:200px"></td>
						<td>状态：<input id="feestatSearch" style="height:25px" name="feestat"
							class="easyui-combobox"
							data-options="valueField:'feestat',textField:'feestatText',data:[{feestat:-1,feestatText:'全部'},{feestat:1,feestatText:'试运行'},{feestat:2,feestatText:'计费'},{feestat:3,feestatText:'计费结束'}],panelHeight:'auto',height:200" />
							
							<select class="easyui-combobox"
										name="opstat" id="opstatStat"
										data-options="panelHeight:'auto',required:true,editable:false"
										style="width:120px;height:25px;">
											<option value="-1" selected>请选择</option>
											<option value="0" selected>不可操作</option>
											<option value="1" selected>可操作</option>
									</select>
						</td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'" onclick="searchDataGrid()">查询</a>&nbsp;&nbsp;
							<a href="javascript:void(0);" class="easyui-linkbutton"
							data-options="iconCls:'icon-redo'"
							onclick="$('#funcmgr_searchform input').val('');$('#servername').textbox('clear');$('#status').combobox('select','-1');">重置</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false"  id="objectListDiv">
			<table title="" style="width:100%;" id="dg">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'neid',width:120,align:'center',sortable:true">编码</th>
						<th data-options="field:'nename',width:80,align:'center'">名称</th>
						<th data-options="field:'ipaddr',width:80,align:'center'">管理IP</th>
						<th data-options="field:'sip',width:80,align:'center'">业务IP</th>
						<th data-options="field:'typeid',width:80,align:'center',hidden:true"></th>
						<th data-options="field:'cfgtable',width:80,align:'center',hidden:true"></th>
						<th data-options="field:'typename',width:80,align:'center'">类型</th>
						<th data-options="field:'vendorname',width:80,align:'center',hidden:true">厂家</th>
						<th data-options="field:'adstat',width:80,align:'center',formatter:formatAdstat">管理状态</th>
						<th data-options="field:'opstat',width:80,align:'center',formatter:formatOpstat">操作状态</th>
						<th data-options="field:'feestat',width:80,align:'center',formatter:formatFeestat">计费状态</th>
						<th data-options="field:'buytime',width:80,align:'center'">创建时间</th>
						<th data-options="field:'useendtime',width:80,align:'center'">退役时间</th>
						<th data-options="field:'suserid',width:120,align:'center'" >申请人</th>
						<th data-options="field:'unitname',width:80,align:'center'">使用单位</th>
						<th data-options="field:'opuser',width:120,align:'center'" >维护人</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="userbaseinfo" style="width: 400px;display: none;">
		<div   class="easyui-panel" title="用户信息" data-options="fit:true,border:false">
			<table align="center" style="width:100%">
				<tr>
					<td class="FieldLabel2" style="border-top:!important;word-break: keep-all;">
						用户名称：</td>
					<td class="FieldInput2" id="unameTd" style="border-top:!important;word-break: keep-all;" >&nbsp;</td>
	
					<td class="FieldLabel2" style="border-top:!important;word-break: keep-all;">用户类型：</td>
					<td class="FieldInput2"  id="usertypeTd" style="border-top:!important;word-break: keep-all;">&nbsp;</td>
				</tr>
				<tr>
					<td class="FieldLabel2" style="border-top:!important;word-break: keep-all;">
						电子邮箱：</td>
					<td class="FieldInput2" id="emailTd" style="border-top:!important;word-break: keep-all;">&nbsp;</td>
	
					<td class="FieldLabel2" style="border-top:!important;word-break: keep-all;">手机号码：</td>
					<td class="FieldInput2"  id="mobileTd" style="border-top:!important;word-break: keep-all;">&nbsp;</td>
				</tr>
			</table>
		</div>
		</div>
		
		
	</div>


</body>
</html>