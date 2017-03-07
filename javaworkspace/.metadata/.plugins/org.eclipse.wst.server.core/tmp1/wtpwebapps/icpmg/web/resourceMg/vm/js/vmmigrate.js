$(function(){
	
	$(".migoper").change(function(){
	  var opVal =	$(this).val();
	  var serverId =  $("#migServerid").val();
	  changeMigTab(opVal,serverId);
	});
	
	$("#vmipparam").live("change",function(){
		var currentOper = "1";
		$(".migoper").each(function(){
			if($(this).is(":checked")){
				currentOper = 	$(this).val();	
		 }
		});
		
		if(currentOper == "1" || currentOper == "2"){
			return;
		}
		
		var hostId = $(this).val();
		var serverid =  $("#migServerid").val();
		var migOper = "4";
		changeMigHost(hostId,serverid,migOper);
		
	});
		
});


var closeWindows = function($dialog) {
	$dialog.dialog('destroy');
};
var submitForm = function($dialog,$pjq,neid,nename) {
	submitSave($dialog, $pjq, neid,nename);
};

function checkMigrateValid(migoper){
  
      if(migoper == 1){
       if( $("#vmipparam").val()){
        if($("#vmipparam").val() == "请选择"){
           $("#migrateSelectIpTip").show();
           return false;
         }
       }else{
            $("#migrateSelectIpTip").show();
           return false;
       }
        $("#migrateSelectIpTip").hide();
         return true; 
       }
       
     if(migoper == 2){
       if( $("#vmdsparam").val()){
        if($("#vmdsparam").val() == "请选择"){
           $("#migrateSelectDsTip").show();
           return false;
         }
       }else{
            $("#migrateSelectDsTip").show();
           return false;
       }
        $("#migrateSelectDsTip").hide();
          return true;
       }
       
      if(migoper == 3){
      if( $("#vmipparam").val()){
        if($("#vmipparam").val() == "请选择"){
           $("#migrateSelectIpTip").show();
           return false;
         }
       }else{
            $("#migrateSelectIpTip").show();
           return false;
       }
        $("#migrateSelectIpTip").hide();
      
      
       if( $("#vmdsparam").val()){
        if($("#vmdsparam").val() == "请选择"){
           $("#migrateSelectDsTip").show();
           return false;
         }
       }else{
            $("#migrateSelectDsTip").show();
           return false;
       }
        $("#migrateSelectDsTip").hide();
          return true;
       }

};

var submitSave = function($dialog,$pjq,neid,nename) {

        var migoper = "1";
		$(".migoper").each(function(){
			if($(this).is(":checked")){
				migoper = 	$(this).val();	
		 }
		});
     
          if(!checkMigrateValid(migoper)){
            return ;
          }
           
           var targetip = $("#vmipparam").val();
           var targetds = $("#vmdsparam").val();
			$('#tableform').form('submit',
				{
					url : basePath +'/vm/operate.do',
					queryParams:{
					neid:neid,
					nename:nename,
					type:"migrate",
					targetip:targetip,
					targetds:targetds,
					migoper:migoper
					},
					onSubmit : function() {
					   $.blockUI({
		               message: "<h2>请求已发送,请稍后......</h2>",
		              css: {color:'#fff', border:'3px solid #aaa', backgroundColor:'#CCCCCC' },
		              overlayCSS: {opacity:'0.0'}
		             });
					},
					success : function(retr) {
					    $.unblockUI();
						var _data = $.parseJSON(retr);
						if (_data.success) {
							$pjq.messager.alert('提示', _data.msg, 'info');
							$dialog.dialog('destroy');
						} else {
							$pjq.messager.alert('提示', _data.msg, 'error');
							$dialog.dialog('destroy');
						}
					}
				});
};


function changeMigHost(hostId,serverid,migOper){
	
	   $.ajax({  
			 url:  basePath +'/vm/changeMigrateOper.do?migrateOper='+migOper+"&serverid="+serverid + "&selHostid="+hostId,
		    type:'post',  
		    dataType:'json',  
		    success:function(data){      	
		    	
		    	if(data.success){
		    				            		            				 
					  var dsMidHtml = "<option value=\"请选择\">请选择</option>";
					  if(data.obj){
						  for(var idx = 0; idx <data.obj.length; idx ++){
							  var eachObj = data.obj[idx];
							  dsMidHtml = dsMidHtml + "<option value=\""+eachObj+"\">"+eachObj+"</option>";
						  }
					  }
		            		           
		            
		              $('#vmdsparam option').remove();
		              $('#vmdsparam').append(dsMidHtml);
		              
		    	}
		    	 
		    }  
		});
	
}

function  changeMigTab(migOper,serverid){
	
	   $.ajax({  
		 url:  basePath +'/vm/changeMigrateOper.do?migrateOper='+migOper+"&serverid="+serverid,
	    type:'post',  
	    dataType:'json',  
	    success:function(data){      	
	    	//debugger;
	    	if(data.success){
	    		var hostHtmlBegin = "<tr>" +
				"<td class=\"FieldLabel2\" style=\"border-top:!important;\">集群内主机：</td>"+
				"<td class=\"FieldInput2\"><select class=\"text\" id=\"vmipparam\" name=\"vmipparam\" style=\"width:350px; padding:0px; height:30px;\">"+
				"<option value=\"请选择\">请选择</option>";
						
				var hostHtmlEnd = "</select><font id=\"migrateSelectIpTip\" color=\"red\" style=\"display:none\">&emsp;请选择主机</font></td>";
			 "</tr>";
	    	
				var dsHtmlBegin = "<tr>" +
				"<td class=\"FieldLabel2\" style=\"border-top:!important;\">主机的存储：</td>"+
				"<td class=\"FieldInput2\"><select class=\"text\" id=\"vmdsparam\" name=\"vmdsparam\" style=\"width:350px; padding:0px; height:30px;\">"+
						"<option value=\"请选择\">请选择</option>";
						
				var dsHtmlEnd = "</select><font id=\"migrateSelectDsTip\" color=\"red\" style=\"display:none\">&emsp;请选择存储</font></td>";
			 "</tr>";
	    		
			    var resultObj = "";
	            if(migOper == "1"){	            				 
				  var hostMidHtml = "";
				  if(data.obj){
					  for(var idx = 0; idx <data.obj.length; idx ++){
						  var eachObj = data.obj[idx];
						  hostMidHtml = hostMidHtml + "<option value=\""+eachObj+"\">"+eachObj+"</option>";
					  }
				  }
	               resultObj = hostHtmlBegin + hostMidHtml + hostHtmlEnd;				  
	            }else if(migOper == "2"){	            		            				 
				  var dsMidHtml = "";
				  if(data.obj){
					  for(var idx = 0; idx <data.obj.length; idx ++){
						  var eachObj = data.obj[idx];
						  dsMidHtml = dsMidHtml + "<option value=\""+eachObj+"\">"+eachObj+"</option>";
					  }
				  }
	               resultObj = dsHtmlBegin + dsMidHtml + dsHtmlEnd;	            	
	            }else if(migOper == "3"){				 				 
				  var hostMidHtml = "";
				  if(data.obj){
					  for(var idx = 0; idx <data.obj.length; idx ++){
						  var eachObj = data.obj[idx];
						  hostMidHtml = hostMidHtml + "<option value=\""+eachObj+"\">"+eachObj+"</option>";
					  }
				  }
	               resultObj = hostHtmlBegin + hostMidHtml + hostHtmlEnd + dsHtmlBegin + dsHtmlEnd;
	            }
	            
	              $('#migrateTable tr').remove();
	              $('#migrateTable').append(resultObj);
	              
	    	}
	    	 
	    }  
	});
}

