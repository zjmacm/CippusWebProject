<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
#about_nav_1 { width:200px; height:580px; float:left; margin-left:30px; margin-top:30px; }
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
#about_nav_2 { width:200px; margin-top:30px; }
.fun1 {display:block; height:33px; width:200px; cursor:pointer; border-radius:4px; }
#about_main_1 { width:800px; height:580px; float:left;  margin-top:30px; margin-left:30px;}
#project_title_wrap{
  width: 718px;
  height:50px;
  color: #333;
  background:#F9F9F9; 
  border-bottom:1px solid #F0F0F0; 
  padding: 40px 40px 30px 40px ;
}
#project_title{
  font-weight: bold;  
  font-size: 30px;
  float: left;
  letter-spacing: 1px;
  height: 30px;
  margin: 0;
}
#project_from{
  float: left;
  margin-top:5px;
  margin-left: 10px;
}
#project_author{
  height: auto;
  float: left;
  margin-left: 3px;
}
#project_preview{
  float: left;
  height: auto;
  width: 723px; 
}
#project_pic_claim{
  position:absolute;background:none repeat scroll 0% 0% rgba(0, 0, 0, 0.75); padding:15px; color:white;
}
#project_summary{
  float: left;
  height: auto;
  width: 718px;
  padding: 20px 40px;
  display: inline;
}
#project_link{
  float: left;
  height: auto;
  width: 718px;
  padding: 20px 40px;
}
a.lnk{
  margin-right:10px; 
  color:#333;
}
a.lnk:hover{
    text-decoration: none;
}
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.change').mouseover(function(){
		$('.change').css("background", "white");
		$(this).css("background", "#E1EBF5");
	});
	$('.change').mouseout(function(){
		$(this).css("background", "white");
	});
	
	
	$('#group_cippus_1').click(function(){ jcl.go("/CippusWebProject/group"); });
	$('#group_cippus_2').click(function(){ jcl.go("/CippusWebProject/group2"); });
	$('#group_cippus_3').click(function(){ jcl.go("/CippusWebProject/group3"); });
	
	$('.acm').click(function(){
		$('#fun4').css("height","2000px");
		$('#fun5').css("height","2100px");
	});
	
    $('.mcm').click(function(){
		$('#fun4').css("height","1700px");
		$('#fun5').css("height","1800px");
	});
    
    $('.mcu').click(function(){
		$('#fun4').css("height","2700px");
		$('#fun5').css("height","2800px");
	});
    
    $('.embaded').click(function(){
		$('#fun4').css("height","4700px");
		$('#fun5').css("height","4800px");
	});
    
    $('.startUp').click(function(){
		$('#fun4').css("height","1500px");
		$('#fun5').css("height","1600px");
	});
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_3.jsp" %>

<div style="background:#EEEEED; width:100%;">
  <div id="fun5" style="width:85%; min-width:1147px; margin:0 auto; height:2100px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">项目展示</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1" id="group_cippus_1" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">兴趣小组</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="group_cippus_2" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">创新俱乐部</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="group_cippus_3" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">螺丝工作室</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">兴趣小组</span>
        </div>
        <div id="fun4" style="height:2000px; border:1px dashed #999; margin-top:20px; border-radius:4px; padding:0;">
          <div class="tabbable">
          <ul class="nav nav-pills" style="font-weight:bold; margin:30px auto 20px 40px;">
            <li class="active">
              <a href="#acm" data-toggle="tab" class="acm">ACM组</a>
            </li>
            <li>
              <a href="#mcm" data-toggle="tab" class="mcm">数模组</a>
            </li>
            <li>
              <a href="#mcu" data-toggle="tab" class="mcu">智能车组</a>
            </li>
            <li>
              <a href="#embaded" data-toggle="tab" class="embaded">嵌入式组</a>
            </li>
            <li>
              <a href="#startUp" data-toggle="tab" class="startUp">创业组</a>
            </li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="acm">
              <%@ include file="group_info_acm.jsp" %>
            </div>
            <div class="tab-pane" id="mcm">
              <%@ include file="group_info_mcm.jsp" %>
            </div>
            <div class="tab-pane" id="mcu">
              <%@ include file="group_info_mcu.jsp" %>
            </div>
            <div class="tab-pane" id="embaded">
              <%@ include file="group_info_embaded.jsp" %>
            </div>
            <div class="tab-pane" id="startUp">
              <%@ include file="group_info_startup.jsp" %>
            </div>
          </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../main/common/footer.jsp" %>
</body>
</html>