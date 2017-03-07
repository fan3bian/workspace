/**
 * Created by sunjiyun on 2016/1/25.
 */
(function($){

    $.fn.demo = function(options){

        var setting = $.extend({},options);

        return this.css({
            color: settings.color,
            backgroundColor: settings.backgroundColor
        });

    };
    //调用
//    $( "div" ).greenify({
//    color: "orange"
//});


    $.fn.showLinkLocation = function() {

        this.filter( "a" ).each(function() {
            var link = $( this );
            link.append( " (" + link.attr( "href" ) + ")" );
        });

        return this;

    };

}(jQuery));
