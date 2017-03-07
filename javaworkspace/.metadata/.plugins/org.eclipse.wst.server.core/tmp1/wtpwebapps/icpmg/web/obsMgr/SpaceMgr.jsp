<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

  <!-- CSS样式 -->
  <style type="text/css">
  	.title {
  		color:  #0d5d9e;
  		font-size: 14px;
    }
	.bucket-status{
		margin:3px;
	}   
	 .card {
	    height:160px;
	    width: 30%;
	    margin-top: 25px;
	    margin-left:25px;
	    color: #999;
	    cursor: pointer;
	    display: inline-block;
	    border-radius: 6px;
	    overflow: hidden;
	    background-color: #fff;
	    border: 1px solid #c9ccd0;
	    vertical-align: top;
	    font-size: 12px;
	    position: relative;
    }
	    
	.card:hover {
	    color: #97c9e5;border:1px solid rgba(12,148,222,.8);
	    box-shadow: 0 0 4px rgba(12,148,222,.8);
    }
	
	.plus {
	    font-size: 135px;
	    line-height: 70px;
	    margin-bottom: 10px;
    }
	    
	.word {
	    font-size: 24px;
    }
	    
	.card .up {
	    width: 100%;
	    height: 100px;
	    background-color: #fafafa;
	    border-radius: 6px 6px 0 0;
	    border-bottom: 1px solid #f5f5f5;
	}
	
	.card .up .bucket-name {
	    text-align: center;
	    position: absolute;
	    top: 35px;
	    left: 5px;
	    width: 30%;
	    overflow: hidden;
	    font-size: 16px;
	    color: #666;
	}
	
	.card .up .bucket-name .bucket-name-span {
	    white-space: nowrap;
	    display:block;
	}
	
	.card .up .bucket-chart {
	    position: absolute;
	    top: 15px;
	    right: 0px;
	    width:70%;
	    height: 80px;
	}
	
	.status {
		left : 10px;
	    text-align : center;
	}
	
	.card .down {
	    width: 100%;
	    padding: 20px 0px;
	    color: #8c8c8c;
	}
	
	.card .down .bucket-data {
	    float: left;
	    width: 32.5%;
	    height: 36px;
	    word-break: normal;
	    vertical-align: top;
	    text-align: center;
	    border-right: 1px solid #eee;
	}
	
	.card .down .bucket-data .data {
	    color: #999;
	    font-size: 12px;
	}
  </style>

  <script type="text/javascript" src="${pageContext.request.contextPath}/js/validate.js"></script>
  <script type="text/javascript">
	function my_formatSize($size){
	    var size  = parseFloat($size);
	    var rank =0;
	    var rankchar ='B';
	    while(size>1024){
		size = size/1024;
		rank++;
		    }
		    if(rank==1){
		rankchar="KB";
		    }
		    else if(rank==2){
		rankchar="MB";
		    }
		    else if(rank==3){
		rankchar="GB";
		    }   
		    return size.toFixed(2)+ " "+ rankchar;
 	}
 	//load bucket list
  	$(document).ready(
  		function() {
			loadBucketLst();
		}
	);
	
	//craete busket card
	var bucketNameArray = new Array();
	function loadBucketLst(){
		$.ajax({
				type: "POST"
				, url: urlrootpath + '/obsMgr/lstBucket.do'
				, data: {bucketNameSlice:$("#bucketNameSlice").val()}
				, dataType: "json"
				, success: function(data){
					if(data!=null){
					var bucketCount = 0;
					var bucketName;
					var displayname;
					var storage;
					var flow;
					var apirequest;
					var cards = document.getElementById("cards");
					var create_Bucket = document.getElementById("createBucketCard");
					var card;
					var up;
					var bucket_name;
					var img;
					var span;
					var bucket_chart;
					var bucket_status;//private、public
					var down;
					var store_div;
					var store_p;
					var flow_div;
					var flow_p;
					var api_div;
					var api_p;
				  //清除新建空间外的控件
					for(var index = 0; index < cards.children.length; index++){
						if(cards.children[index].id != "createBucketCard"){
							cards.removeChild(cards.children[index]);
							index--;
						}
					} 
					
					//逐个添加card
					$.each(data,function(index){
						
						//var bucketname=data[index].bucketname;
						//bucketCount & bucketName
						bucketCount = bucketCount + 1;
						bucketName = data[index].bucketname;
						displayname=data[index].displayname;
						storage = data[index].storage;
						flow = data[index].flow;
						apirequest = data[index].apirequest;
						
						//保存桶名称
						bucketNameArray.push([displayname]);
						//已建空间
						card = document.createElement( "li" );
						card.setAttribute('class','card');
						card.setAttribute("onclick", "transferToBucketMgr('" + bucketName + "')");
						cards.insertBefore(card,create_Bucket);
						//空间名称
						up = document.createElement( "div" );
						up.setAttribute('class','up');
						card.appendChild(up); 
						//bucket_status
						bucket_status=document.createElement("img");
						bucket_status.src="${pageContext.request.contextPath}/web/obsMgr/image/lock.png";
						bucket_status.setAttribute('class','bucket-status');
						//bucket-name
						bucket_name = document.createElement( "div" );
						bucket_name.setAttribute('class','bucket-name');
						up.appendChild(bucket_name); 
						if(data[index].permission=='1'){//lock.png
							up.appendChild(bucket_status);
						}
						//image
						img = document.createElement( "img" );
						img.src= "${pageContext.request.contextPath}/web/obsMgr/image/bucket3.png";
						bucket_name.appendChild(img);
						
						//span:bucketName
						span = document.createElement( "span" );
						span.setAttribute('class','bucket-name-span');
						span.setAttribute('width','30%');
					//	span.setAttribute('display','block');
						span.innerText = displayname;
						bucket_name.appendChild(span);
						
						var data2 = [];
						$.ajax({
							type: 'post'
							, url: urlrootpath + '/obsMgr/lstDate.do?daycoun=7&starttime=&endtime='
							, async: false
							, dataType: "json"
							, success: function(value){
								data2=value;
						  	}
						});
						var data3 =[];
						$.ajax({
							type: 'post',
							url: urlrootpath + '/obsMgr/lstStatisticsByDay.do',
							data:{
								statisticstype:'flow',
								daycoun:7,
								bucketName:bucketName,
								starttime:'',
								endtime:''
							}, 
							dataType: "json", 
							async: false,
							success: function(value){
					  		   data3 = value;
					  		}
						});
						//bucket_chart
						bucket_chart = document.createElement( "div" );
						bucket_chart.setAttribute('class','bucket-chart');
						up.appendChild(bucket_chart);
						
						$(bucket_chart).highcharts({
					  		chart: {
					            type: 'areaspline',
					        },
					        title: { 
					  			text: '', //center 
					  		},
					  		xAxis: {
					  			categories: data2,
					  			minTickInterval:2,
					  		}, 
					  		yAxis: { 
					  			title: { 
					  				text: 'MB'
					  			}, 
					            min: 0,
					            minTickInterval:0.25,
					  			plotLines: [{ 
					  				value: 0, 
					  				width: 0.1, 
					  				color: '#808080' 
					  			}] 
					  		}, 
					  		tooltip: { 
					  			valueSuffix: 'MB' 
					  		},
					  		series: [{ 
					  			data: data3
					  		}],
					  		legend: {
					  			enabled: false
					  			},
					  		credits: {
							     enabled: false
							}
						  });
						//空间属性
						down = document.createElement( "div" );
						down.setAttribute('class','down');
						card.appendChild(down);
					
						//文件存储
						store_div = document.createElement( "div" );
						store_div.setAttribute('class','bucket-data');
						down.appendChild(store_div);
						store_p = document.createElement( "p" );
						store_p.setAttribute('class','data');
						store_p.innerText = "文件存储\n" + my_formatSize(storage);
						store_div.appendChild(store_p);
					
						//当月下载流量
						flow_div = document.createElement( "div" );
						flow_div.setAttribute('class','bucket-data');
						down.appendChild(flow_div);
						flow_p = document.createElement( "p" );
						flow_p.setAttribute('class','data');
						flow_p.innerText = "当月下载流量\n" + my_formatSize(flow);
						flow_div.appendChild(flow_p);
					
						//API请求次数
						api_div = document.createElement( "div" );
						api_div.setAttribute('class','bucket-data');
						down.appendChild(api_div);
						api_p = document.createElement( "p" );
						api_p.setAttribute('class','data');
						api_p.innerText = "当月API请求\n" +apirequest+'次';
						api_div.appendChild(api_p);
					});
					document.getElementById("bucketCount").innerHTML = "共创建" + "<font color=\"red\">"+bucketCount + "</font>个空间";
					$('#createBucketCard').css("visibility","visible");
					}
					$('#createBucketCard').css("visibility","visible");
				}
			});
		}
	
 	 	//open createBucket dialog
		function openCreateBucketDialog() {
			$('#tableform').form('clear');
			$("[name='buckettype'][value='0']").attr("checked",true);
			$('#createBucket').window('open');
		//	document.getElementById("bucketName").value = "";
		};

		//createBucket
		function createBucket() {
			
			//桶命名规范校验
			if(!$("#tableform").form('validate')){
		   	 	return false;
		    }

			$('#tableform').form('submit',{
					url : urlrootpath + '/obsMgr/createBucket.do',
					onSubmit : function() {
						//桶命名重复校验 
						
						var inputBucketName = + $.trim($("#bucketName").attr("value"));
						var existBucketName;
						for(var index = 0; index < bucketNameArray.length; index++){
							existBucketName = bucketNameArray[index].join("");
							if(inputBucketName==existBucketName){
								$.messager.alert('消息', "空间名称不能重复!",'error');
								return false;
							}
						}
					},
					success : function(retr) {						
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$.messager.alert('提示', _data.msg, 'info');
							//transferToBucketMgr(_data.obj);
							loadBucketLst();
						} else {
							$.messager.alert('提示', _data.msg, 'error');
						}
						//跳转到新建桶管理主页
						$('#createBucket').window('close');
					}
				}
			);
		}
		
		//select bucket:重置
		$("#formReset").click(function () {
			$("#bucket_searchform").form("reset");
			loadBucketLst();
		});
		
		//select bucket:查询
		$("#search").click(function () {
			loadBucketLst();
		});
		
		//跳转到桶管理界面
		function transferToBucketMgr(bucketName){
			//获取框架父窗口
			var topWindow = window.parent;
			topWindow.$('#centerTab').panel({
				//href:'/icpmg/web/obsMgr/BucketMgr.jsp?bucketName=' + bucketName
				href:'${pageContext.request.contextPath}/obsMgr/queryBucket.do?bucketname='+bucketName
			});
			var titletd = document.getElementById("titletd");
			var titletd_bucketName = document.createElement( "span" ); 
			titletd_bucketName.setAttribute('id','titletd_bucketName');
			titletd_bucketName.innerText = " > " + bucketName.split("_")[1];
			titletd_bucketName.setAttribute('class','title');
			titletd.appendChild(titletd_bucketName);
		} 
		
</script>
 
  <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 10px 20px;margin:10px 20px 10px 20px;">
	
	  <!-- 上侧   -->
	  <div data-options="region:'north',border:false" style="height:50px;overflow:hidden;">
		  <form id="bucket_searchform">
			  <table style="width:96%">
				  <tr>
					  <td style="padding-left:30px;width:68%">空间名称：<input class="easyui-textbox" name="bucketNameSlice" id="bucketNameSlice">
						  <a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"style="margin-left:48px;">查询</a>&nbsp;&nbsp;
						  <a href="javascript:void(0);" id="formReset" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">重置</a>
					  </td>
					  <td id="bucketCount" style="float:right;padding:15px 30px;"></td>
				  </tr>
			  </table>
		  </form>
	  </div>
		
	  <!-- 下侧   -->
	  <div data-options="region:'center',border:false">
	    <ul id="cards">
	      <!-- 新建空间 -->
	      <li class="card"  id="createBucketCard" onclick="openCreateBucketDialog();" style="visibility:hidden;">
	        <div class="add-wapper" style="text-align:center; margin-top:25px;">
	        	<div class="plus">+</div>
	         	<div class="word">新建空间</div>
	        </div>
	      </li>
	    </ul>
	  </div>
	</div>
	
	<!-- 创建空间对话框 -->
	<div id="createBucket" class="easyui-window" title="创建空间" data-options="closed:true,iconCls:'icon-save',inline:true" style="width:500px;height:160px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center'" style="padding:10px;">
				<form id="tableform" method="post">
					<table align="center"  style="width:80%">
						<tr>
							<td style="border-top:!important;">空间名称：</td>
							<td><input id="bucketName"style="height:25px" name="bucketName" class="tx easyui-textbox" data-options="height:28,validType:'bucketName',required:true,missingMessage:'名称由字母开头，4~63个字符长可包含字母、数字、中划线'"/>
								<font color="red">*</font>
							</td>
						</tr>
						<tr style="height:40px">
							<td>空间类型</td>
							<td>
								<label><input type="radio" name="buckettype" value="0">公开空间</label>
								<label><input type="radio" name="buckettype" value="1">私有空间</label>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="createBucket();" style="width:80px">确定</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$('#createBucket').window('close');" style="width:80px">取消</a>
			</div>
		</div>
	</div>

