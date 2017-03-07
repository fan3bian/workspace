 ;
 // $("input").placeholder();
 (function($) {
     $.fn.placeholder = function(options) {
         var opts = $.extend({}, $.fn.placeholder.defaults, options);
         var isIE = document.all ? true : false;
         return this.each(function() {

             var _this = this,
                 placeholderValue = _this.getAttribute("placeholder"); //缓存默认的placeholder值
             if (_this.value == "" || _this.value == placeholderValue) {
                 _this.style.color = '#999'
             } else {
                 _this.style.color = '#333'

             }
             if (isIE) {
                 // _this.setAttribute("value", placeholderValue);
                 _this.onfocus = function() {
                     $.trim(_this.value) == placeholderValue ? _this.value = "" : '';
                     _this.style.color = '#333'

                 };
                 _this.onblur = function() {
                     $.trim(_this.value) == "" ? _this.value = placeholderValue : '';
                     if (_this.value == "" || _this.value == placeholderValue) {
                         _this.style.color = '#999'
                     }
                 };
             }
         });
     };
 })(jQuery);
