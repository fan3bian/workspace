/**
 * @auther zhangshy
 * easyui 组件常用方法
 */
function searchDataGrid(formId,gridId){
	$('#'+gridId).datagrid('load',icp.serializeObject($('#'+formId)));
}
function reset(formId,gridId){
	$('#'+formId).form('reset');
	$('#'+gridId).datagrid('load',{});
}
function formatter (value){
	if(!value) return '';
};
/**
 * 遮罩
 * @param msg
 */
function loadMask(msg) {
    $("<div class=\"window-mask AA\"></div>").css({
        display: "block",
        width: "100%",
       'z-index':'99',
       
        height: $(window).height()
    }).appendTo("body");
    $("<div class=\"datagrid-mask-msg\"></div>").html(msg).appendTo("body").css({
        display: "block",
        'z-index':'100',
        left: ($(document.body).outerWidth(true) - 190) / 2,
        top: ($(window).height() - 45) / 2
    });
}

/**
 * 取消遮罩
 */
function disLoad() {
    $(".window-mask").remove();
    $(".datagrid-mask-msg").remove();
}