<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="${ctx}/css/alertify.css" rel="stylesheet" type="text/css" />
<style type="text/css">
#about_nav_1 { width:200px; height:450px; float:left; margin-left:30px; margin-top:30px; }
#about_tip { width:200px; height:69px; background:url('${ctx}/images/name_l_bk.png') no-repeat; }
#about_span_1 { 
    display:block; 
    width:90px; 
    margin-left:auto;
    margin-right:auto; 
    font-size:22px; 
    color:#FFF; 
    font-family:"Microsoft YaHei","华文新魏"; 
    line-height:60px; 
    
}
#user_info,#member,#project { margin-top:8px; }
.fun1 { cursor:pointer; border-radius:4px; }
</style>
<script type="text/javascript">
$(document).ready(function(){
	var user_id;
	$.ajax({
		url : "getUserId",
		type : "post",
		dataType : "json",
		data : {},
		success : function(data) {
			user_id = data.result;
		}
	});
	
	$('.change').mouseover(function(){
		$('.change').css("background", "white");
		$(this).css("background", "#E1EBF5");
	});
	$('.change').mouseout(function(){
		$(this).css("background", "white");
	});
	
	$('#news_publish').click(function(){ jcl.go("/CippusWebProject/user_center"); });
	$('#member_manage').click(function(){ jcl.go("/CippusWebProject/member_manage"); });
	$('#star').click(function(){ jcl.go("/CippusWebProject/star"); });
});
</script>

</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">用户中心</span>
      </div>
      <div style="width:200px; margin-top:30px;">
        <div class="fun1 change" id="news_publish" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">发布新闻</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="member_manage" style="background:#FFF;color:black;border:1px solid #999;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">成员管理</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="star" style="background:#FFF;color:black;border:1px solid #999;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">成员之星</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
</body>
</html>