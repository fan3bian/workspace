var currentEle;
var onechart;
var edit_widgetid;
var get_widgetid;
var rootType;
var addFlag;//0是新增，1是编辑
var jsonobject_ret;
var fatherNeId;
var componentId;
var groupid=$('#groupid', parent.document).val();
/*配置路径*/
var hostkpiqueryaction = context_path + "/hostkpioverview/queryDeviceList.do";
var kpiqueryaction = context_path + "/hostkpioverview/queryKpiList.do";
var savelayout = context_path + "/saveLayout/saveLayout.do";
var getwidgetinfo = context_path + "/saveLayout/getWidgetInfo.do";
var deletewidget = context_path + "/saveLayout/deleteWidget.do";
var saveposition = context_path + "/saveLayout/savePosition.do";
var isParentst = context_path + "/hostkpioverview/isParent.do";
/*查询设备列表*/
var getDeviceList = function (value,keyname) {
    $.ajax({
        type: 'POST',
        async: false,
        data:{"type":value,"keyname":keyname},
        url: hostkpiqueryaction + "?type=" + value,
        success: function (return_value) {
            var result = return_value;
            var json_result = JSON.parse(result);
           
            $.each(json_result, function (index, obj) {
            	fatherNeId=obj.neid;

                if (obj.typeid == "VM") {
                    $('#host_list ul').append("<li id='" + obj.neid + "' onclick='list_click(this)'>" + obj.neid + "</li>");
                } else {
                    $('#host_list ul').append("<li id='" + obj.neid + "' onclick='list_click(this)'>" + obj.nename + "</li>");
                }
            });
        }
    });
};
/*查询指标列表*/
var getKpiList = function (value,keyname) {
    $.ajax({
        type: 'POST',
        async: false,
        data:{"type":value,"keyname":keyname},
        url: kpiqueryaction + "?type=" + value,
        success: function (return_value) {
            var result = return_value;
            var json_result = JSON.parse(result);
            $.each(json_result, function (index, obj) {
                $('#kpi_list ul').append("<li id='" + obj.kpiname + "' onclick='list_click(this)'>" + obj.text + "</li>");
            });
        }
    });
};
/*判断是否是root组件*/
var isParent = function (value,typeid) {
	$.ajax({
		type: 'POST',
	    async: false,
		data: {"type":value},
		url: isParentst + "?type=" + value,
		success:function(return_value) {
			 var result = return_value;
	         var json_result = JSON.parse(result);
			 if(json_result=="1"&&typeid=="single-ne-multi-ind-trend-line"){
				$('#is-monitor-com').css("display","block");
				$('#is-monitor-comp').removeAttr("checked");
			 }
			 else{
				 $('#is-monitor-comp').removeAttr("checked");
				 $('#is-monitor-com').css("display","none");				 
			 }
		}
	});
};
var getParentType = function(typevalue,widgetData) {
	$.ajax({
		type: 'POST',
	    async: false,
	    url: context_path + "/getComponent/getAllParentNetype.do?childType=" + typevalue+"&rootType=" +rootType,
	    success:function(return_value){
	    	 var result = return_value;
	            var json_result = JSON.parse(result);
	            componentId=json_result[json_result.length-1];
	            $("#flag_div").html("");
	            for(var ele in json_result){
	            	if(ele>0){
	            	var chartItem='<div style="margin:20px 0 0 50px">'+json_result[ele]+'&nbsp;&nbsp; <input id='+json_result[ele]+'></div>';
	            	$("#flag_div").append(chartItem);
	            	$("#"+json_result[ele]).combobox({
	            		valueField: 'id',
	                    textField: 'name',
	                    width: 110,
	                    editable: false,
	                   // url: context_path + "/getComponent/getAllChildNeList.do?fatherType="+json_result[ele-1]+"&childType="+json_result[ele]+"&fatherNeId="+fatherNeId,
	                    onChange:function(newValue,oldValue){
	                    	var position;
	                    	for(position in json_result){
	                    		if(json_result[position]==$(this).attr("id")){
	                    			break;
	                    		}
	                    	}
	                    	if(position==(json_result.length-1)){
	   
	                    	}
	                    	else{
	                    		fatherNeId=newValue;
	                    		$("#"+json_result[ele]).combobox('reload',context_path + "/getComponent/getAllChildNeList.do?fatherType="+json_result[position]+"&childType="+json_result[parseInt(position)+1]+"&fatherNeId="+newValue);
	                    		}
	                    }
	            	});
	            	}
	            }
	            $("#setWindow2 .model-row:eq(0)").find(".j-step2-right").find("li").each(function (i) {
	            	fatherNeId=$(this).attr("id");
                });
	            $("#"+json_result[1]).combobox('reload',context_path + "/getComponent/getAllChildNeList.do?fatherType="+json_result[0]+"&childType="+json_result[1]+"&fatherNeId="+fatherNeId);
	    }
	});
};
/*点击事件*/
var list_click = function (object,obj) {
    if ($(object).hasClass("active")) {
        $(object).removeClass("active");
    } else {
        $(object).addClass("active");
    }
}
/*宽度调整*/
var changeEleWidth = function (idx) {
    if (currentEle) {
        var newWidth = 567 * idx;
        if(idx==2){
        	newWidth=newWidth-12;
        }
        currentEle.width(newWidth);
    }
    onechart.resize();
}
/*创建新块*/
var openConfig = function (flag,ele) {

    if ($(".j-drag").length >= 12 && flag == 0) {
        alert("最多可以保存12个自定义监控，当前监控数已满，请删除后再添加");
        return false;
    }
    
  if(flag == 1){
    edit_widgetid = $(currentEle).attr("id");
    $.ajax({
        type: 'POST',
        async: false,
        dataType: 'json',
        url: getwidgetinfo + "?editwidgetid=" + edit_widgetid,
        success: function (jsonobject) {
            jsonobject_ret = jsonobject;
        }
      });
	}else{
		jsonobject_ret = null;
	}
	
    addFlag = flag;
    $('#setWinWidgetType').dialog({
        closed: false
    });
}

/*拖拽初始化*/
var initDrag = function () {
    $("#dragWrap").sortable();
    /*设置文字无法选中*/
    $("#dragWrap").disableSelection();
}
/*菜单初始化*/
var initMenuWithChart = function (ele, chart) {
    ele.click(function () {
        $("#mm").menu({
            onShow: function () {
                currentEle = ele.parents(".indexs-item").eq(0);
                onechart = chart;
            }
        });
        $('#mm').menu('show', {
            left: ele.offset().left - 20,
            top: ele.offset().top + 20
        });
    });
}
/*块删除*/
var deleteBlock = function (ele) {
    ele.click(function () {
        $.messager.confirm('提示', '确定要删除吗?', function (r) {
            if (r) {
                ele.closest(".indexs-item").remove();
                var deletewidgetid = ele.parent().parent().attr("id");
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: deletewidget + "?deletewidgetid=" + deletewidgetid
                });
            }
        });
    });
}
/*保存布局*/
var saveLayout = function (object, flag, editwidgetid) {
    var str = JSON.stringify(object);

    //var groupid=$('#groupid', parent.document).val();
    $.ajax({
        type: 'POST',
        async: false,
        data: {data: str},
        dataType: 'JSON',
        url: savelayout + "?flag=" + flag + "&editwidgetid=" + editwidgetid+"&groupid="+groupid,
        success: function (ret) {
            get_widgetid = ret.msg;
            if(flag == 0){
				var widgetid = get_widgetid ;
				var widgetname = object.widgetname ;
				var chartItem = '<div class="indexs-item j-drag" id ="'+widgetid+'">' ;
				chartItem = chartItem +  '<div class="btnbox"><i class="icon close j-close"></i> <i class="icon export"></i><i class="icon set j-set"></i></div>' ;
				chartItem = chartItem +  '<div class="item-drag drag-title"> ' ;
				chartItem = chartItem +  '<div class="indexs-title">'+widgetname+'</div> ' ;
              	chartItem = chartItem +  '<div class="indexs-con"><div id="chart'+widgetid+'" style="width: 100%; height: 100%;"></div></div>' ;
          		chartItem = chartItem +  ' </div>' ;
          		chartItem = chartItem +  ' </div>' ;
				$("#"+widgetid).remove() ;
				$("#dragWrap").append(chartItem) ;
				$("#dragWrap .indexs-item").addClass("indexs-item j-drag") ;
				$("#dragWrap .btnbox").addClass("btnbox") ;
				$("#dragWrap .item-drag").addClass("item-drag drag-title") ;
				$("#dragWrap .indexs-title").addClass("indexs-title") ;
				$("#dragWrap .indexs-con").addClass("indexs-con") ;	
				initChart(widgetid,1);	
            }else{
				var widgetid = editwidgetid ;
				var widgetname = object.widgetname ;
				 $("#" + widgetid).find('.indexs-title')[0].innerText = widgetname;
				initChart(widgetid, object.widgetwidth);	
            }
            
        }
    });
}
/*单指标单设备校验*/
var checkSingle = function (obj, widgetdata, str) {
    if (widgetdata.widgetstyleid.indexOf(str) >= 0) {
        if (obj.parents(".model-row").find(".j-step2-right ul li").length >= 1) {
            return false;
        } else {
            return true;
        }
    } else {
        return true;
    }
}
/*保存widget位置*/
var savePosition = function () {
    var positionArr = new Array;
    //var positionData = {};
    $(".j-drag").each(function (index) {
        var positionData = {};
        positionData.position = index;
        positionData.widgetid = $(this).attr("id");
        positionData.width = $(this).css("width").substring(0, $(this).css("width").indexOf("p")) / 600;
        //console.log(positionData);
        positionArr.push(positionData);
        //console.log(positionData);
    });
    console.log(positionArr);
    var str = JSON.stringify(positionArr);
    $.ajax({
        type: 'POST',
        async: false,
        url: saveposition + "?position=" + str,
        success: function () {
            alert("保存成功！");
        }
    })
}

$(function () {
    // 全局变量
    var insertRow = "";
    var widgetData = {};//保存图表配置相关信息
    initDrag();
    var _setWinWidgetType = $('#setWinWidgetType').dialog({
        title: "图表设置",
        iconCls: 'icon-add',
        width: 890,
        height: 430,
        closed: true,
        modal: true,
        cache: false,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        enableNext: false,
        buttons: [{
            text: '下一步',
            iconCls: 'icon-ok',
            handler: function () {
                _setWinWidgetType.find("input").each(function () {
                    if ($(this).is(':checked')) {
                        widgetData.imageType = $(this).attr("id");
                    }
                });
                _setWinWidgetType.find("img").each(function () {
                    if ($(this).attr("name") == 'selected') {
                        widgetData.widgetstyleid = $(this).attr("id");
                    }
                });
                if (_setWinWidgetType.find("img[name='selected']").length == 1) {
                    _setWinWidgetType.dialog("options").enableNext = true;
                } else {
                    $.messager.alert("提示", "空间展现的图标样式需要选中一个，不能为空", "info");
                    return;
                }
                _setWinWidgetType.dialog("close");
                $('#setWindow2').dialog('open');              
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function () {
                $('#setWinWidgetType').dialog({closed: true});
            }
        }],
        onOpen: function () {
            if (!jsonobject_ret) {
                _setWinWidgetType.find("input[type='radio']:eq(0)").trigger("click");
            } else {
                if (jsonobject_ret.widget.widgetstyleid.indexOf("line") > 0) {
                    _setWinWidgetType.find("input[type='radio']:eq(1)").trigger("click");
                    _setWinWidgetType.find("img[id='" + jsonobject_ret.widget.widgetstyleid + "']").trigger("click");
                } else if (jsonobject_ret.widget.widgetstyleid.indexOf("bar") > 0) {
                    if (jsonobject_ret.widget.widgetstyleid.indexOf("topn") > 0) {
                        _setWinWidgetType.find("input[type='radio']:eq(3)").trigger("click");
                        _setWinWidgetType.find("img[id='" + jsonobject_ret.widget.widgetstyleid + "']").trigger("click");
                    } else {
                        _setWinWidgetType.find("input[type='radio']:eq(0)").trigger("click");
                        _setWinWidgetType.find("img[id='" + jsonobject_ret.widget.widgetstyleid + "']").trigger("click");
                    }
                } else if (jsonobject_ret.widget.widgetstyleid.indexOf("tiao") > 0) {
                    if (jsonobject_ret.widget.widgetstyleid.indexOf("topn") > 0) {
                        _setWinWidgetType.find("input[type='radio']:eq(3)").trigger("click");
                        _setWinWidgetType.find("img[id='" + jsonobject_ret.widget.widgetstyleid + "']").trigger("click");
                    } else {
                        _setWinWidgetType.find("input[type='radio']:eq(2)").trigger("click");
                        _setWinWidgetType.find("img[id='" + jsonobject_ret.widget.widgetstyleid + "']").trigger("click");
                    }
                } else if (jsonobject_ret.widget.widgetstyleid.indexOf("area") > 0) {
                    _setWinWidgetType.find("input[type='radio']:eq(4)").trigger("click");
                    _setWinWidgetType.find("img[id='" + jsonobject_ret.widget.widgetstyleid + "']").trigger("click");
                } else if (jsonobject_ret.widget.widgetstyleid.indexOf("pointer") > 0) {
                    _setWinWidgetType.find("input[type='radio']:eq(5)").trigger("click");
                    _setWinWidgetType.find("img[id='" + jsonobject_ret.widget.widgetstyleid + "']").trigger("click");
                }
            }
        }
    });
    // 弹层1交互
    $(".j-select ul li").click(function () {
        $(this).addClass("active").siblings().removeClass("active");
        $(".j-right").html($(this).find("img").clone());
        $(".j-right img").show();
    });
    // 弹层2配置
    $('#setWindow2').dialog({
        title: "图表设置",
        iconCls: 'icon-add',
        width: 890,
        height: 430,
        cache: false,
        closed: true,
        modal: true,
        collapsible: false,
        minimizable: false,
        maximizable: false,
        resizable: false,
        buttons: [{
        	id:'setWindow2_btn_ok',
            text: '下一步',
            iconCls: 'icon-ok',
            handler: function () {
            	
            	var tab = $('#setWindow2-step2').tabs('getSelected');
            	var tabindex = $('#setWindow2-step2').tabs('getTabIndex',tab);
            
           	
            	if(tabindex == 0){
            		if (widgetData.widgetstyleid.indexOf("single-ne") >= 0 && $(".j-step2-right:eq(0)").find("li").length > 1) {
                        $.messager.alert('提示', '您选择的为单设备图，只能选择一个设备', 'info');
                        return false;
                    }else if ($(".j-step2-right:eq(0)").find("li").length == 0) {
                             $.messager.alert('提示', '请至少选择一个设备', 'info');
                             return false;
                         
                    }else if($('#is-monitor-comp').is(':checked')) {
                    	$('#setWindow2-step2').tabs('getTab',"组件选择").panel('options').tab.show();
            			$('#select_comp').combobox('reload',context_path + "/getComponent/ getAllChildNetype.do?netype=" +  $("#select_combo").combobox('getValue')); 
            			$('#setWindow2-step2').tabs('select',1);
            			return false;
                    }
                    else{
                    	$('#setWindow2-step2').tabs('select',2);
                    	return false;
                    }
            	}
            	if(tabindex == 1){
            		if($('#'+componentId).combobox('getValue').length==0){
            			 $.messager.alert('提示', '请至少选择一个设备', 'info');
                         return false;
            		}
            		else{
            			$('#setWindow2-step2').tabs('select',2);
            			return false;
            			}
            	}
            	if(tabindex == 2){
            		if (widgetData.widgetstyleid.indexOf("single-ind") >= 0 && $(".j-step2-right:eq(1)").find("li").length > 1) {
                        $.messager.alert('提示', '您选择的为单指标图，只能选择一个指标', 'info');
                        return false;
                    } else if ($(".j-step2-right:eq(1)").find("li").length == 0) {
                        $.messager.alert('提示', '请至少选择一个指标', 'info');
                        return false;
                    }else {
                    	$('#setWindow2-step2').tabs('select',3);
                    	return false;
                    }
            		
            	}
            	
            	
                if (widgetData.widgetstyleid.indexOf("single-ne") >= 0 && $(".j-step2-right:eq(0)").find("li").length > 1) {
                    $.messager.alert('提示', '您选择的为单设备图，只能选择一个设备', 'info');
                    return false;
                } else if (widgetData.widgetstyleid.indexOf("single-ind") >= 0 && $(".j-step2-right:eq(1)").find("li").length > 1) {
                    $.messager.alert('提示', '您选择的为单指标图，只能选择一个指标', 'info');
                    return false;
                } else {
                    if ($(".j-step2-right:eq(0)").find("li").length == 0) {
                        $.messager.alert('提示', '请至少选择一个设备', 'info');
                        return false;
                    }
                    if ($(".j-step2-right:eq(1)").find("li").length == 0) {
                        $.messager.alert('提示', '请至少选择一个指标', 'info');
                        return false;
                    }   
                    if ($("#widgettitle").val() == "") {
                        $.messager.alert('提示', '请输入控件标题', 'info');
                        return false;
                    }
                    if ($("#time_span").css("display")=="inline") {
                    	if(Date.parse($("#fromtime").datebox('getValue'))>=Date.parse($("#totime").datebox('getValue'))
                    			||$("#fromtime").datebox('getValue').length==0||$("#totime").datebox('getValue').length==0){
                    		$.messager.alert('提示', '请输入正确的时间', 'info');
                    		return false;
                    	}
                    }

                    var neidArr = new Array();
                    var kpiidArr = new Array();
                    /*获取已选设备*/
                    
                    	$("#setWindow2 .model-row:eq(0)").find(".j-step2-right").find("li").each(function (i) {
                        neidArr.push($(this).attr("id")); });
                    /*获取已选指标*/
                    $("#setWindow2 .model-row:eq(1)").find(".j-step2-right").find("li").each(function (i) {
                        kpiidArr.push($(this).attr("id"));
                    });
                    /*以逗号分隔*/
                    widgetData.neid = neidArr.join(",");
                    widgetData.kpiid = kpiidArr.join(",");
                    var timeDimision = $("#interval").combobox("getValue");
                    var timeRange = $("#timeRange").val();
                    var topN = $("#topN").combobox("getValue");
                    var title = $("#widgettitle").val();
                    widgetData.timedimension = timeDimision;
                    if($("#time_function").val()=="time_range"){
                    	widgetData.timerange = timeRange;
                    }
                    else{
                    	widgetData.timerange= $("#fromtime").datebox("getValue")+","+$("#totime").datebox("getValue");
                    }
                    //widgetData.timerange = timeRange;
                    widgetData.topn = topN;
                    widgetData.widgetname = title;
                    widgetData.widgetwidth = $("#" + edit_widgetid).width()/567;
                  
                    widgetData.widgetposition = $("#" + edit_widgetid).index();
                    var componenttype=new Array();
                    var componentid=new Array();
                    for(var ele=0;ele<$("#flag_div").find("input").each(function(){}).length;ele++){
                    	if($("#flag_div").find("input").each(function(){})[ele].id.length>0){
                    		componenttype.push($("#flag_div").find("input").each(function(){})[ele].id);
                    		componentid.push($("#"+$("#flag_div").find("input").each(function(){})[ele].id).combobox('getValue'));
                    	}
                    }
                    widgetData.componenttype=componenttype.join(",");
                    widgetData.componentid=componentid.join(",");
                    saveLayout(widgetData, addFlag, edit_widgetid);

                    $('#setWindow2').dialog({
                        closed: true
                    });
                }
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function () {
                $('#setWindow2').dialog({
                    closed: true
                });
            }
        }],
        onBeforeOpen: function () {
        	$('#setWindow2-step2').tabs('getTab',"组件选择").panel('options').tab.hide();
            if (widgetData.imageType != "Topn") {
                $("#topn_select").css("display", "none");
                $("#time_function").removeAttr("style");
                $("#time_range").removeAttr("style");
                $("#time_interval").removeAttr("style");
            } else {
                $("#topn_select").removeAttr("style");
                $("#time_range").css("display", "none");
                $("#time_function").css("display", "none");
                $("#time_interval").css("display", "none");
            }
            if (widgetData.imageType == "面积图") {
            	 $("#topn_select").css("display", "none");
                 $("#time_function").removeAttr("style");
                 $("#time_range").removeAttr("style");
                 $("#time_interval").removeAttr("style");
            } else if (widgetData.imageType == "指针图") {
                $("#time_range").css("display", "none");          
                $("#time_function").css("display", "none");
                $("#time_interval").css("dispaly", "none");
            }
            if(widgetData.widgetstyleid.indexOf("trend")>=0){
            	$("#topn_select").css("display", "none");
                $("#time_function").removeAttr("style");
                $("#time_range").removeAttr("style");
                $("#time_interval").removeAttr("style");
            }else{
            	$("#time_range").css("display", "none");
            	$("#time_span").css("display", "none");  
                $("#time_function").css("display", "none");
                $("#time_interval").css("dispaly", "none");          	
            }
            $("#time_span").css("display", "none");
            $("#time_interval").css("display", "none");
            
            if (!_setWinWidgetType.dialog("options").enableNext) {
                return false;
            } else {
                return true;
            }
        },
        onOpen: function () {
        	
            $("#setWindow2-step2").tabs("select", 0);
            //$("#time_function").value="time_range";
            /*清除上一个已选列表*/
            $("#setWindow2").find(".j-toleft-more").each(function () {
                $(this).trigger("click");
            });
            if (!jsonobject_ret) {
                /*新建widget时默认值*/
            	$("#time_function").val("time_range");
                $(".model-row").find("input[id='timeRange']").val("7");
                $(".model-row").find("input[id='widgettitle']").val("");   
                $("#select_combo").combobox('unselect', $("#select_combo").combobox("getValue"));
                $("#select_comp").combobox('unselect', $("#select_comp").combobox("getValue"));
                $('#setWindow2-step2').tabs('getTab',"组件选择").panel('options').tab.hide();   
                $("#flag_div").empty();//清空“组件选择”除类型选择的元素
                $("#fromtime").datebox("setValue","");
                $("#totime").datebox("setValue","");
                $("#interval").combobox("select", "M5");
                $("#topN").combobox("select", "5");
                $('#is-monitor-comp').prop('checked',false);
                if($('#single-ne-multi-ind-trend-line').attr('name')!="selected"){
             	   $('#is-monitor-com').css("display","none");
                }else{
                	isParent($("#select_combo").combobox('getValue'),"single-ne-multi-ind-trend-line");
                }
              

                
            } else {
            		 $('#is-monitor-comp').removeAttr("checked");
            	     $('#is-monitor-com').css("display","none");	
            	     $("#select_combo").combobox('unselect', $("#select_combo").combobox("getValue"));
            	     $("#select_combo").combobox('reload',context_path + "/saveLayout/getDeviceType.do");
            		 $("#select_combo").combobox("select", jsonobject_ret.widget.netypeid);
            	     for (var i = 0; i < jsonobject_ret.widget_ne.length; i++) {
            	            $("#setWindow2").find("li[id='" + jsonobject_ret.widget_ne[i].id + "']").trigger("click");
            	     }
            	      if(jsonobject_ret.widget.childtypeid!=null&&jsonobject_ret.widget.childtypeid.length>0&&widgetData.widgetstyleid==jsonobject_ret.widget.widgetstyleid){
            	           $('#is-monitor-com').css("display","block");
                   		   $('#is-monitor-comp').prop('checked',true);
                   		   $("#select_comp").combobox('unselect', $("#select_comp").combobox("getValue"));
                   		   $("#select_comp").combobox('reload');
                   		   $("#select_comp").combobox("select", jsonobject_ret.widget.childtypeid); 
                   		   $('#setWindow2-step2').tabs('getTab',"组件选择").panel('options').tab.show();   
                   		   $('#is-monitor-comp').prop('checked',true);
                   		   for(var t in jsonobject_ret.widget_ne_child){
                   			   $("#"+jsonobject_ret.widget_ne_child[t].netypeid).combobox("select",jsonobject_ret.widget_ne_child[t].id);
            				 }
                   		}
            	      if(widgetData.widgetstyleid!=jsonobject_ret.widget.widgetstyleid&&jsonobject_ret.widget.widgetstyleid=="single-ne-multi-ind-trend-line"){
            	    	  $("#setWindow2").find(".j-toright-only:eq(0)").each(function () {
       	                    $(this).trigger("click");
       	                })
            	      }
            	      else{
            	    	  for (var i = 0; i < jsonobject_ret.widget_ind.length; i++) {
       	                    $("#setWindow2").find("li[id='" + jsonobject_ret.widget_ind[i].name + "']").trigger("click");
       	                } 
            	    	  $("#setWindow2").find(".j-toright-only").each(function () {
       	                    $(this).trigger("click");
       	                })
            	      }
            		   
     	                
            
                if(jsonobject_ret.widget.timerange.indexOf(",")<0&&jsonobject_ret.widget.topn==0){
                	$("#time_span").css("display", "none");
            		$("#time_range").removeAttr("style");
            		$(".model-row").find("select[id='time_function']").prop("value", "time_range");
                	$(".model-row").find("input[id='timeRange']").prop("value", jsonobject_ret.widget.timerange);
                }else if(jsonobject_ret.widget.timerange.indexOf(",")>0&&jsonobject_ret.widget.topn==0){
                	$("#time_range").css("display", "none");
            		$("#time_span").removeAttr("style");
            		$(".model-row").find("select[id='time_function']").prop("value", "time_span");
                	var strs= new Array(); 
                	strs=jsonobject_ret.widget.timerange.split(","); 
                	$('#fromtime').datebox('setValue',strs[0]);
                	$("#totime").datebox('setValue',strs[1]);

                }
     	        if(jsonobject_ret.widget.widgetstyleid.indexOf("trend")<0){
                	$("#time_range").css("display", "none");
                	$("#time_span").css("display", "none");
                }
          
                $(".model-row").find("input[id='widgettitle']").prop("value", jsonobject_ret.widget.widgetname);
                $("#interval").combobox("select", jsonobject_ret.widget.timedimension);
                $("#topN").combobox("select", jsonobject_ret.widget.topn);
            }
        },
        onClose: function () {
            $("#setWindow2").find(".j-toleft-more").each(function () {
                $(this).trigger("click");
            });
        }
    });
    // 弹层2-tab配置
    $('#setWindow2-step2').tabs({
        fit: true,
        plain: true,
        tabWidth: 286,
        onSelect:function(title){    
            if(title == '设备选择'){
            	$('#setWindow2_btn_ok').linkbutton({text:'下一步'});
            }else if(title == '组件选择'){
            	$('#setWindow2_btn_ok').linkbutton({text:'下一步'});
            }else if(title == '指标选择'){
            	$('#setWindow2_btn_ok').linkbutton({text:'下一步'});
            }else if(title == '时间范围'){
            	$('#setWindow2_btn_ok').linkbutton({text:'确定'});
            }  
        }    

    });
    // 选中toright
    $(".j-toright-only:eq(0)").click(function () {
        var str = "single-ne";
        if ($(this).parents(".model-row").find(".j-step2-select li.active").length == 0) {
            $.messager.alert('提示', '没有选中项！', 'info');
        } else if (checkSingle($(this), widgetData, str)) {
            $(this).parents(".model-row").find(".j-step2-select li.active").appendTo($(this).parents(".model-row").find(".j-step2-right ul"));
            $(this).parents(".model-row").find(".j-step2-right ul li").removeClass("active");
        } else {
            $.messager.alert('提示', '您选择的为单设备图，只能选择一个设备', 'info');
        }
    });
    $(".j-toright-only:eq(1)").click(function () {
        var str = "single-ind";
        if ($(this).parents(".model-row").find(".j-step2-select li.active").length == 0) {
            $.messager.alert('提示', '没有选中项！', 'info');
        } else if (checkSingle($(this), widgetData, str)) {
            $(this).parents(".model-row").find(".j-step2-select li.active").appendTo($(this).parents(".model-row").find(".j-step2-right ul"));
            $(this).parents(".model-row").find(".j-step2-right ul li").removeClass("active");
        } else {
            $.messager.alert('提示', '您选择的为单指标图，只能选择一个指标', 'info');
        }
    });
    // 全部toright
    $(".j-toright-more:eq(0)").click(function () {
        if (widgetData.widgetstyleid.indexOf("single-ne") >= 0) {
            $.messager.alert('提示', '您选择的为单设备图，只能选择一个设备', 'info');
        } else {
            $(this).parents(".model-row").find(".j-step2-select li").appendTo($(this).parents(".model-row").find(".j-step2-right ul"));
            $(this).parents(".model-row").find(".j-step2-right ul li").removeClass("active");
        }
    });
    $(".j-toright-more:eq(1)").click(function () {
        if (widgetData.widgetstyleid.indexOf("single-ind") >= 0) {
            $.messager.alert('提示', '您选择的为单指标图，只能选择一个指标', 'info');
        } else {
            $(this).parents(".model-row").find(".j-step2-select li").appendTo($(this).parents(".model-row").find(".j-step2-right ul"));
            $(this).parents(".model-row").find(".j-step2-right ul li").removeClass("active");
        }
    });
    // 选中toleft
    $(".j-toleft-only").click(function () {
        if ($(this).parents(".model-row").find(".j-step2-right li.active").length == 0) {
            $.messager.alert('提示', '没有选中项！', 'info');
        } else {
            $(this).parents(".model-row").find(".j-step2-right li.active").appendTo($(this).parents(".model-row").find(".j-step2-select ul"));
            $(this).parents(".model-row").find(".j-step2-select ul li").removeClass("active");
        }
    });
    // 全部toleft
    $(".j-toleft-more").click(function () {
        $(this).parents(".model-row").find(".j-step2-right li").appendTo($(this).parents(".model-row").find(".j-step2-select ul"));
        $(this).parents(".model-row").find(".j-step2-select ul li").removeClass("active");
    });
    // 时间粒度
    $("#interval").combobox({
        valueField: 'timeDemision',
        textField: 'timeDemisionText',
        data: [{
            timeDemisionText: '5分钟',
            timeDemision: 'M5'
        }, {
            timeDemisionText: '一小时',
            timeDemision: 'H'
        }, {
            timeDemisionText: '一天',
            timeDemision: 'D'
        }, {
            timeDemisionText: '一月',
            timeDemision: 'M'
        }]
    });
    $("#topN").combobox({
        valueField: 'id',
        textField: 'text',
        data: [{
            "text": "5",
            "id": 5
        }, {
            "text": "10",
            "id": 10
        }, {
            "text": "15",
            "id": 15
        }]
    });
    $("#select_combo").combobox({
        valueField: 'typeid',
        textField: 'typename',
        width: 110,
        editable: false,
        url: context_path + "/saveLayout/getDeviceType.do",
        onChange: function (newValue, oldValue) {
            $("#host_list").find("li").remove();
            $("#kpi_list").find("li").remove();
            $(".j-step2-right").find("li").remove();
            $('#setWindow2-step2').tabs('getTab',"组件选择").panel('options').tab.hide();
            $("#flag_div").empty();           
            $('#select_comp').combobox('reload',context_path + "/getComponent/ getAllChildNetype.do?netype=" + newValue); 
            isParent(newValue,widgetData.widgetstyleid);
            getDeviceList(newValue);
            getKpiList(newValue);
            widgetData.type = newValue;
            rootType=newValue;
        }
    });
 

    // 弹层2的search
    $('#set').searchbox({
    searcher:function(value,name){ 
    	$("#host_list").find("li").remove();
      var currentType =	$('#select_combo').combobox('getValue');
      getDeviceList(currentType,value);
    }
    });
    
    $('#type').searchbox({
    searcher:function(value,name){ 
    	 $("#kpi_list").find("li").remove();
    	 var currentType =	$('#select_combo').combobox('getValue');
        getKpiList(currentType,value); 
    }   	
    });
    //下级组件 选择设备类型
    $("#select_comp").combobox({
    	valueField: 'typeid',
        textField: 'typename',
        width: 110,
        editable: false,
        url: context_path + "/getComponent/ getAllChildNetype.do",
        onChange:function(newValue,oldValue){
            $("#kpi_list").find("li").remove();
            widgetData.childtype=newValue;
        	getKpiList(newValue);
        	getParentType(newValue);  		
        }
   });
   
});