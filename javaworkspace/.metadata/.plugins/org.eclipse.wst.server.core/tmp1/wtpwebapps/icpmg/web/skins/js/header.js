 $(document).ready(function() {
	$("ul#topnav li").hover(function() { //Hover over event on list item
	//	$(this).css({ 'background' : '#1376c9 url(topnav_active.gif) repeat-x'}); //Add background color + image on hovered list item
		$(this).find("span").show(); //Show the subnav
		$(this).css({ 'background' : '#fff'});
	} , function() { //on hover out...
		$(this).css({ 'background' : 'none'}); //Ditch the background
		$(this).find("span").hide(); //Hide the subnav
	});
	
});
 

/**
 * ����iframeת��
 * @param url
 */
function openUrl(url){
	var target = $('.ext_app_iframe');
	target.attr('src', url);
}