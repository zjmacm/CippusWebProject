<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="${ctx}/css/alertify.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/flexigrid.css" rel="stylesheet" type="text/css" /> 
<style type="text/css">
.fun1 {display:block; height:33px; width:200px; cursor:pointer; border-radius:4px; }
#about_main_1 { width:800px; height:430px; float:left;  margin-top:30px; margin-left:30px;}
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript">
var isHaveAttach = 0;
$(document).ready(function(){
	var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	$('.fun1').addClass("change");
	$('#star').removeClass("change");
	$('.fun1').css(css2);
	$('#star').css(css1);
	
	$('#submit').click(function(){
		var name = $('#name').val();
		var score = $('#score').val();
		$.ajax({
			url : "addScore",
			type : "post",
			dataType : "json",
			data : {"name":name,"score":score},
			success : function(data) {
				if(data.result=="success")
					alertify.success("加分成功！");
				else
					alertify.error("网络错误，请稍后再试！");
			}
		});
	});

});
</script>
<link href="${ctx}/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.Popup {width: 770px;height:auto;position: absolute; left:700px; top:280px;background-color: #FFF;border: 1px solid #666; border-radius:6px; z-index: 999;}
.Popup_top { height:30px; border-bottom: 1px solid #cccccc; }
.Popup_top span { font-weight:bold; dislay:block; float:left; font-size:14px; font-family:Arial, Helvetica, sans-serif; width:80px; margin-left:25px; margin-top:10px; }
.Close { position:relative; left:620px; top:10px; }
</style>

</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_user_bootstrap.jsp" %>


<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin: auto; height:550px; background:white; min-height:500px;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">成员之星</span>
        </div>
      </div>
      <div style="height:450px; border:1px dashed #999; margin-top:20px; border-radius:4px; ">
          <h3 style="display:block;width:200px;margin:30px auto;">成员之星特殊加分</h3>
          <span style="margin-top:25px;margin-left:150px;font-weight:bold;color:#666;">组员姓名：</span>
          <input type="text" id="name" style="width:300px;height:25px;margin-left:55px;border:1px solod #666;"><br/><br/><br/>
          <span style="margin-top:25px;margin-left:150px;font-weight:bold;color:#666;">加分分数：</span>
          <input type="text" id="score" style="width:300px;height:25px;margin-left:55px;border:1px solod #666;"><br/><br/><br/>
          <span style="margin-top:25px;margin-left:150px;font-weight:bold;color:#666;">加分原因：</span>
          <input type="text" id="reason" style="width:300px;height:25px;margin-left:55px;border:1px solod #666;"><br/><br/><br/>
	      <input type="button" value="确定" id="submit" style="width:85px;height:35px;color:white;margin-left:350px;border:1px solid #666;outline:none;border-radius:4px;background:#67B6F1;">
	  </div>
    </div>
  </div>
</div>

<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>