<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>订单管理</title>
    
</head>

<body>
	<script>
		var starttime ;
    	$(document).ready(function() {
    		starttime = getLastMonth() ;
			$("#tdate").val(starttime) ;
			
			loadCenterList() ;
		});
		
    	
    	function getLastMonth(){
    		var date = new Date();
		    var year = date.getFullYear();          //获取当前日期的年
		    var month = date.getMonth() +1 ;        //获取当前日期的月
		 
		    var year2 = year;
		    var month2 = parseInt(month)-1;
		    if(month2==0) {
		        year2 = parseInt(year2)-1;
		        month2 = 12;
		    }
		    
		    if(month2<10) {
		        month2 = '0'+month2;
		    }
		    
		    var m = year2.toString();
		    var n= month2.toString();
		    var t2 = m+"-"+n;
		    return t2;
		}
    	function loadCenterList()
    	{
    		$.ajax({
					url : urlrootpath+'/cloudcenter/getCenterList.do?starttime='+$("#tdate").val(),
					dataType : 'json',
					success : function(result) {
						$("#centerListUl").empty() ;
						
						for(var i = 0 ;i<result.rows.length ;i ++)
						{
							var liContent = "<li" ;
							if(result.rows[i].isfinish == 1)
								liContent = liContent +" class=\"hasdafen\" " ;
							
							liContent = liContent +" name=\""+result.rows[i].ccid+"\">" +result.rows[i].ccname+"</li>";

							$("#centerListUl").append(liContent) ;
						}
						$.parser.parse($("#centerListUl"));
						for(var i = 0 ;i<result.rows.length ;i ++)
						{
							if(result.rows[i].isfinish == 0)
							{
								freshIndScore(result.rows[i].ccid) ;
								break ;
							}
						}
						
						$("#centerListUl li").click(function(){
							
							if($(this).hasClass("active") == false)
							{
								var ccid = $(this).attr("name") ;
								freshIndScore(ccid) ;
								/*								
								$.messager.confirm('确认', '您是否要放弃保存当前结果？', function(r) {
									if(r)
										freshIndScore(ccid) ;
								});
								*/
							}
						
						});
					}
					});
    	}
    	
    	
    	function freshIndScore(ccid)
    	{
    		$("[name='"+ccid+"']").siblings().removeClass("active") ;
    		$("[name='"+ccid+"']").addClass("active") ;
    		$.ajax({
					url : urlrootpath+'/cloudcenter/getIndScoreList.do',
					data:{indtype:'0,1',ccid:ccid,starttime:$("#tdate").val()},
					dataType : 'json',
					success : function(result) {
						$("#ccid").val(ccid);
						$("#indScoreTable").empty() ;
						$("#selectCCName").html($("[name='"+ccid+"']").html()) ;
						for(var i = 0 ;i<result.length ;i ++)
						{
							var trContent = "<tr id='"+result[i].indid+"' name='indtype"+result[i].indtype+"'>" ;
                        	trContent = trContent + "<td><input type='hidden' name='indid"+result[i].indid+"'  value='"+result[i].indid+"'>"+result[i].indname+"</input></td>" ;
                            trContent = trContent + "<td> "+result[i].remark+"</td> ";
                            trContent = trContent + "<td> " ;
                            if(result[i].indtype == 0 )
                            	trContent = trContent + "   <input style=\"width: 99%; height: 28px\" class=\"easyui-numberbox\" min=\"0\"  max=\""+result[i].maxvalue+"\" type=\"text\" id=\"indvalue"+result[i].indid+"\" name=\"indvalue"+result[i].indid+"\" value='"+result[i].indvalue+"' data-options='required:true'></input> ";
                            else
                            	trContent = trContent + "<div style='text-align:left'> <input type='hidden' name='indvalue"+result[i].indid+"' value='"+result[i].indvalue+"' >" + result[i].indvalue +"</div> ";
                            trContent = trContent + "</td> ";
                         	trContent = trContent + "</tr> ";
							

							$("#indScoreTable").append(trContent) ;
						}
						
						$("input[name^='indvalue']:visible").numberbox({
						    min:0,
						    "onChange":function(){
						    	freshTotalScore() ;
						    }
						});  
						
						freshTotalScore() ;
						
					}
					});
    	}
    	
    	function freshTotalScore()
    	{
    		var totalScore = 0 ;
			$("[name^='indvalue']").each(function(){
				totalScore = totalScore + parseInt($(this).val()) ;
			});
			$("#totalScore").html(totalScore) ;
    	}
    </script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/web/cloudCenter/css/manualScore.css">
    
    <div class="easyui-layout" data-options="fit:true,border:false" style="padding:10px 20px 50px 20px;margin:10px 20px 30px 20px;">
        <div data-options="region:'north',border:false" style="height:37px;overflow:hidden;background-color: #eee">
            <form id="resource_searchform">
                <table class="lcy-search">
                    <tr>
                        <td>
                            <label for="">记分周期：</label>
                            <input id="tdate" name="tdate" style="height: 25px; width: 200px;" data-options="panelHeight:190">
                            <input type="hidden" id="ccid" name="ccid" >
                        </td>
                        <td align="center" colspan="1">
                            <a href="javascript:void(0);" id="search" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div data-options="region:'center',border:false">
            <div class="y-dafen-sectors">
                <div class="y-title">云中心列表</div>
                <ul id="centerListUl">
              
                </ul>
            </div>
            <div class="y-dafen-dafenbox">
                <div class="y-title"><span class="y-text" id="selectCCName"></span>
                    <a href="javascript:void(0);" onclick="saveCCScore()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交打分</a>
                </div>
	            
	            <form id="manualScoreForm" >
	                    
                <table width="100%" cellspacing="0" cellpadding="0">
                    <thead>
                        <tr>
                            <th width="30%">指标项</th>
                            <th width="40%">指标描述</th>
                            <th width="30%">打分</th>
                        </tr>
                    </thead>
                    <tbody id="indScoreTable">
                       
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="2" style="text-align: center;">总分</th>
                            <th id="totalScore" style="text-align: left;padding-left: 1%;"></th>
                        </tr>
                    </tfoot>
                </table>
                
                </form> 
            </div>
        </div>
    </div>
    
    
    
    
    <script type="text/javascript">
    function IndScore(indid,indvalue){

	    this.indid = indid;
		
	    this.indvalue = indvalue;
	
	}
    
    $('.y-dafen-sectors ul li').unbind('click');
    $('.y-dafen-sectors ul li').click(function(event) {
        $(this).addClass('active').siblings().removeClass('active')
    });

    function saveCCScore() {
    	freshTotalScore() ;
    	
    	$.messager.confirm('确认', $("#selectCCName").html()+'打分结果为'+$("#totalScore").html()+',确定提交？', function(r) {
    	if(r)
    	{
    		var indScoreArray = new Array() ;
    	
	    	$("[name=indtype0]").each(function(){
	    		var indid = $(this).attr("id") ;
	    		var indvalue = $("#indvalue"+indid).val() ;
				
				var indScore = new IndScore(indid,indvalue);
	
	 			indScoreArray.push(indScore);    		 
	    	});
	    	
	    	var params = JSON.stringify(indScoreArray );
	    	
	    	$.ajax({
					url : urlrootpath+'/cloudcenter/saveCCScore.do',
					data :{ccid:$("#ccid").val(),indScoreContent:params,starttime:$("#tdate").val(),totalScore:$("#totalScore").html()},
					dataType : 'json',
					success : function(result) {
						if(result.success){
							$("[name='"+$("#ccid").val()+"']").addClass("hasdafen") ;
							$.messager.alert('消息',result.msg);  
			            	
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
    	}
    	);
    	
    }

 // 扩展月选择插件
    $.extend($.fn.combobox.methods, {
        yym: function(jq) {
            return jq.each(function() {
                var obj = $(this).combobox();
                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth() ;
                var table = $('<table width="180px;">');
                var tr1 = $('<tr>');
                var tr1td1 = $('<td>', {
                    text: '-',
                    click: function() {
                        var y = $(this).next().html();
                        y = parseInt(y) - 1;
                        $(this).next().html(y);
                        $('.ty-gray').removeClass('ty-gray');
                    }
                });
                tr1td1.appendTo(tr1);
                var tr1td2 = $('<td>', {
                    text: year
                }).appendTo(tr1);

                var tr1td3 = $('<td>', {
                    text: '+',
                    click: function() {
                        var y = $(this).prev().html();
                        if (y < year) {
                            y = parseInt(y) + 1;

                        }
                        $(this).prev().html(y);
                        if (y == year) {
                            $(this).addClass('ty-gray');
                            for (var i = month; i < 12; i++) {
                                $(this).parents('table').find('td').eq(i + 3).addClass('ty-gray');
                            }
                        }


                    }
                }).appendTo(tr1).addClass('ty-gray');
                tr1.appendTo(table);

                var n = 1;
                for (var i = 1; i <= 4; i++) {
                    var tr = $('<tr>');
                    for (var m = 1; m <= 3; m++) {
                        var td = $('<td>', {
                            text: n,
                            click: function() {
                                if ($(this).hasClass('ty-gray')) {
                                    return;
                                } else {
                                    var yyyy = $(table).find("tr:first>td:eq(1)").html();
                                    var cell = $(this).html();
                                    var v = yyyy + '-' + (cell.length < 2 ? '0' + cell : cell);
                                    obj.combobox('setValue', v).combobox('hidePanel');
                                }

                            }
                        });
                        if (n == month) {
                            td.addClass('tdbackground');
                        }
                        if (n > month) {
                            td.addClass('ty-gray');
                        }
                        td.appendTo(tr);
                        n++;
                    }
                    tr.appendTo(table);
                }
                table.addClass('mytable cursor');
                table.find('td').hover(function() {
                    $(this).addClass('tdbackground');
                }, function() {
                    $(this).removeClass('tdbackground');
                });
                table.appendTo(obj.combobox("panel"));

            });
        }
    });


    $('#tdate').combobox('yym');
    </script>
    	
    
</body>

</html>
