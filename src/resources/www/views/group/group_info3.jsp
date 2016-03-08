<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组内风采</title>
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
#about_main_1 { width:800px; height:900px; float:left;  margin-top:30px; margin-left:30px;}
#project_summary{
  float: left;
  height: auto;
  width: 718px;
  display: inline;
  padding: 20px;
}
a{
  text-decoration: none;
  color: black;
  cursor: pointer;
}
a:hover{
  cursor: pointer;
  text-decoration: underline;
}
</style>

<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.change').mouseover(function(){
		$('.change').css("background", "white");
		$(this).css("background", "#E1EBF5");
	});
	$('.change').mouseout(function(){
		$(this).css("background", "white");
	});
	
	$('#group1').click(function(){ jcl.go("/CippusWebProject/group"); });
	$('#group2').click(function(){ jcl.go("/CippusWebProject/group2"); });
	$('#group3').click(function(){ jcl.go("/CippusWebProject/group3"); });
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_3.jsp" %>

<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:900px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">组内风采</span>
      </div>
            <div id="about_nav_2">
        <div class="fun1 change" id="group1" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">兴趣小组</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="group2" style="background:#FFF;color:black;border:1px solid #999;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">创新俱乐部</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1" id="group3" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">螺丝工作室</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div> 
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">螺丝工作室</span>
        </div>
        <div style="height:800px; border:1px dashed #999; margin-top:20px; border-radius:4px; padding:40px;">
          <img src="${ctx}/images/sss1.png" style="height:200px; margin-left:240px;">
          <p style="font-weight:bold;">螺丝工作室简介：</p>
          <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;螺丝工作室成立于2014年，位于大连理工大学软件学院创新实践中心，工作室成员为原创新技术联盟，数媒组，web组，网络组，平面组，软件组的精英。致力于移动互联网领域的研究，涉及web端开发，服务器开发与运维，Android应用开发，ios应用开发，产品与营销。我们每个人都是使这个世界运转的一颗螺丝，我们将是改变世界的IT精英。</p>
          <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我们主要内容是移动互联网开发,包括Android,web,游戏等.</p>
          <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作室包含运维组,开发组,设计组和产品组,是由原来的创新几个小组合并而成.</p>
          <img src="${ctx}/images/sss_op.png" style="height:255px; margin:40px -40px;">
          <img src="${ctx}/images/sss_dev.png" style="height:255px; margin:40px -40px;">
          <img src="${ctx}/images/sss_ds.png" style="height:255px; margin:40px -40px;">
          <img src="${ctx}/images/sss_pm.png" style="height:255px; margin:40px -40px;">

          </p>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../main/common/footer.jsp" %>
</body>
</html>