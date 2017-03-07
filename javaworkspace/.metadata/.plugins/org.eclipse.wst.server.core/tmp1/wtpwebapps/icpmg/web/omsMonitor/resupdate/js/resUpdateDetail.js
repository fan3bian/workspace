$(function(){
	
//	var resUpdate_detail_action_path = context_path + "/web/omsMonitor/resupdate/jsp/resUpdateDetail.jsp";
/***************************************************************************************************/
/**
 * 呼出详情窗口
 */
	$('#res-update-detail-dialog').dialog({    
	    title: '资源变更详情',    
	    width: 700,    
	    height: 500,    
	    closed: true,    
	    cache: false,
//	    href:resUpdate_detail_action_path,
	    iconCls:'icon-objmanage',
	    modal: true,
	    collapsible:true,
	    onBeforeOpen:function(){

	    }
	}); 
/***************************************************************************************************/
/**
 * 呼出台账窗口
 */
	$('#res-update-history-dialog').dialog({    
	    title: '资源变更详情',    
	    width: 800,    
	    height: 600,    
	    closed: true,    
	    cache: false,
//		    href:resUpdate_detail_action_path,
	    iconCls:'icon-objmanage',
	    modal: true,
	    collapsible:true,
	    onBeforeOpen:function(){

	    }
	}); 	
	
});