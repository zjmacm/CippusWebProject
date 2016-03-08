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

</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/ajaxfileupload.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var user_id = $('#user_id').val();
	var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	$('.fun1').addClass("change");
	$('#member_manage').removeClass("change");
	$('.fun1').css(css2);
	$('#member_manage').css(css1);
	

	$('input').attr('readOnly', 'readOnly');
	$('textarea').attr('readOnly', 'readOnly');
	
	$.ajax({
		url : "getUserInfo",
		type : "post",
		dataType : "json",
		data : {"user_id":user_id},
		success : function(data) {
			$('#name').val(data.row.NAME);
			$('#number').val(data.row.NUMBER);
			$('#user_group').val(data.row.USER_GROUP);
			$('#register_time').val(data.row.REGISTER_TIME);
			$('#birthday').val(data.row.BIRTHDAY);
			$('#tel').val(data.row.TEL);
			$('#email').val(data.row.EMAIL);
			$('#good_at').val(data.row.GOOD_AT);
			$('#prize').val(data.row.PRIZE);
			$('#self_intro').val(data.row.SELF_INTRO);
			var src = "http://localhost:8080/CippusWebProject/getImage?user_id="+$('#user_id').val()+"&type=0&time="+new Date().getTime();
			$('#user_pic').attr("src",src);
		}
	});
	
});
</script>
<style type="text/css">
.info_tip { position:relative; float:right;  }
.info_input { width:260px; height:22px; outline:none; border:1px solid #999; padding-left:10px; border-radius:4px; }
.info_area { width:260px; height:155px; outline:none; border:1px solid #999; border-radius:4px; padding-left:10px; resize:none;}
#save { 
    width:125px; 
    height:35px; 
    border:1px solid #999; 
    background:#185BA9; 
    border-radius:4px; 
    color:#FFF;
    cursor:pointer;
    position:relative;
    left:180px;
    top:60px; 
}
#user_pic2 { width:250px; height:300px;  float:left; position:relative; left:35px; top:-540px; }
</style>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_7.jsp" %>
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:920px; background:white;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1" style="width:800px; height:960px; float:left;  margin-top:30px; margin-left:30px;">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">成员详情</span>
        </div>
        <div style="height:930px; border:1px dashed #999; margin-top:20px; border-radius:4px; font-family:'微软雅黑';">
          <div style="width:400px; margin:25px 65px;">
            <input type="hidden" id="user_id" value="<%=request.getParameter("user_id") %>">
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">姓名：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <input type="text" id="name" class="info_input" value="" readOnly="readOnly">
              </div>
            </div>
            <br/><br/>
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">学号：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <input type="text" id="number" class="info_input" value="" readOnly="readOnly">
              </div>
            </div>
            <br/><br/>
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">组别：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <input type="text" id="user_group" class="info_input" value="" readOnly="readOnly">
              </div>
            </div>
            <br/><br/>
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">加入时间：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <input type="text" id="register_time" class="info_input" value="" readOnly="readOnly">
              </div>
            </div>
            <br/><br/>
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">生日：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <input type="text" id="birthday" class="info_input" value="" readOnly="readOnly">
              </div>
            </div>
            <br/><br/>
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">联系方式：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <input type="text" id="tel" class="info_input" value="">
              </div>
            </div>
            <br/><br/>
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">邮箱：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <input type="text" id="email" class="info_input" value="">
              </div>
            </div>
            <br/><br/>
            <div>
              <div style="width:80px; float:left">
                <span class="info_tip">技能树：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <textarea id="good_at" class="info_area"></textarea>
              </div>
            </div>
            <div style="position:relative; top:20px;">
              <div style="width:80px; float:left">
                <span class="info_tip">获奖经历：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <textarea id="prize" class="info_area"></textarea>
              </div>
            </div>
            <div style="position:relative; top:40px;">
              <div style="width:80px; float:left">
                <span class="info_tip">自我介绍：</span>
              </div>
              <div style="width:300px; float:left; margin-left:20px;">
                <textarea id="self_intro" class="info_area"></textarea>
              </div>
            </div>
            
          </div>
          
        </div>
        
      </div>
      <div id="user_pic2">
        <img id="user_pic" style="width:200px; height:200px; border:1px solid black;"><br/>
      </div>
    </div>
  </div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>