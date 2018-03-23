$(document).ready(function() { 
/*导航菜单*/
$("#nav li").hover(function(){
	$(this).parent().find('.menucur').hide();
	$(this).find('.nav_menu').show();
},function(){
	$(this).find('.nav_menu').hide();
	
	$(this).parent().find('.menucur').show();
});
/*幻灯片效果*/
$('.slideshow').smallslider({
        textPosition: 'top',
        textAlign: 'center',
        textSwitch: 2
});
});