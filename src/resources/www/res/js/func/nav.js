/**
 * 
 */
$(document).ready(function(){
	var css1 = { "background":"url('/CippusWebProject/images/bg_nav_1.png')", "color":"#2665AE" };
	var css2 = { "background":"url('/CippusWebProject/images/bg_nav_2.png')", "color":"white" };
	$(".fun").mouseover(function(){
		$(".fun").css(css2);
		$(this).css(css1);
	});
	$(".fun").mouseout(function(){
		$(this).css(css2);
	});
	
	$('#main').click(function(){ jcl.go("/CippusWebProject/main"); });
	$('#about').click(function(){ jcl.go("/CippusWebProject/about"); });
	$('#resources').click(function(){ jcl.go("/CippusWebProject/resources"); });
	$('#news').click(function(){ jcl.go("/CippusWebProject/news"); });
	$('#project').click(function(){ jcl.go("/CippusWebProject/project"); });
	$('#project123').click(function(){ jcl.go("/CippusWebProject/project"); });
	$('#proj').click(function(){ jcl.go("/CippusWebProject/project"); });
	$('#group').click(function(){ jcl.go("/CippusWebProject/group"); });
	$('#user').click(function(){
		$.ajax({
			url : "isUserLogin",
			type : "post",
			dataType : "json",
			data : {},
			success : function(data) {
				if(data.result=="success")
					jcl.go("/CippusWebProject/user_center");
				else {
					alert("尚未登录，请与首页登陆后再点击查看该部分");
				}
			}
		});
	});
});