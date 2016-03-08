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
#about_nav_1 { width:200px; height:1000px; float:left; margin-left:30px; margin-top:30px; }
#about_tip { width:200px; height:69px; background:url('${ctx}/images/name_l_bk.png'); }
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
#about_main_1 { width:800px; height:110px; float:left;  margin-top:30px; margin-left:30px;}
#register_div { 
    width:750px; 
    height:880px; 
    border:1px solid #999; 
    border-radius:6px; 
    background:#E5E5E5; 
    margin-left:auto; 
    margin-right:auto; 
    position:relative; 
    top:30px;
}    
#register_form { width:600px; height:1000px; margin:25px auto; }
#register_div1 { 
    width:180px; 
    height:35px; 
    line-height:35px; 
    float:left; 
    color:#666; 
    letter-spacing:3px; 
    margin-top:10px; 
    font-family:'微软雅黑';
}
#register_div2 { width:330px; height:35px; float:left; margin-top:10px; margin-left:25px; }
.register_input { 
    width:300px; 
    height:25px; 
    border-radius:4px; 
    margin-top:5px; 
    outline:none; 
    border:1px solid #999; 
    padding-left:8px; 
}
.info_select { width:50px; height:25px; border-radius:4px; border:1px solid #999; margin-top:7px;  }
.group_select { width:105px; height:25px; border-radius:4px; border:1px solid #999; margin-top:7px; float:left; }
#register_submit, #register_delete { 
    width:125px; 
    height:35px; 
    border:1px solid #999; 
    background:#185BA9; 
    border-radius:4px; 
    color:#FFF;
    cursor:pointer;
    position:relative;
    left:180px;
    top:400px; 
}
.register_text { width:300px; height:135px; border:1px solid #999; border-radius:4px; padding-left:4px; }
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('input').attr("readOnly", "readOnly");
	var user_id = $('#user_id').val();
	$.ajax({
		url : "getRegisterDetail",
		type : "post",
		dataType : "json",
		data : {"user_id":user_id},
		success : function(data) {
			$('#number').val(data.row.NUMBER);
			$('#name').val(data.row.NAME);
			$('#tel').val(data.row.TEL);
			$('#email').val(data.row.EMAIL);
			$('#birthday').val(data.row.REGISTER_TIME);
			$('#good_at').val(data.row.GOOD_AT);
			$('#prize').val(data.row.PRIZE);
			$('#self_intro').val(data.row.SELF_INTRO);
		}
	});
	
	$('#register_submit').click(function(){
		$.ajax({
			type : 'post',
			url : 'registerAccept',
			data : {'user_id':user_id},
			dataType : 'json',
			success : function(data){
			    if(data.result=='success'){
			    	alert('已成功通过该申请！');
			    	jcl.go('/CippusWebProject/user_center');
			    }
			    else {
			    	alert('操作失败,请稍后再试！');
			    }
			}
		});
	})
	
	$('#register_delete').click(function(){
		$.ajax({
			type : 'post',
			url : 'registerDelete',
			data : {'user_id':user_id},
			dataType : 'json',
			success : function(data){
			    if(data.result=='success'){
			    	alert('已成功删除该申请！');
			    	jcl.go('/CippusWebProject/user_center');
			    }
			    else {
			    	alert('操作失败,请稍后再试！');
			    }
			}
		});
	});
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_7.jsp" %>
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:1020px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">用户中心</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">审核申请</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="member" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">组内成员</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">申请详情</span>
        </div>
        <div style="height:950px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <div id="register_div">
      <div style="width:800px; height:40px;">
        <span style="line-height:70px; margin-left:25px; font-family:'微软雅黑'; color:#666;">申请人员详细信息，请仔细审查</span>
        <hr style="position:relative; top:-30px; left:-35px; width:85%;"/>
      </div>
      <div id="register_form">
        <input type="hidden" id="user_id" value="<%=request.getParameter("user_id") %>">
        <div>
          <div id="register_div1">
            <span style="float:right;">你的学号：</span>
          </div>
          <div id="register_div2">
            <input type="text" value="" id="number" class="register_input">
          </div>
        </div>
        
        <div>
          <div id="register_div1">
            <span style="float:right;">你的姓名：</span>
          </div>
          <div id="register_div2">
            <input type="text" value="" id="name" class="register_input">
          </div>
        </div>
        <div>
          <div id="register_div1">
            <span style="float:right;">联系电话：</span>
          </div>
          <div id="register_div2">
            <input type="text" value="" id="tel" class="register_input">
          </div>
        </div>
        <div>
          <div id="register_div1">
            <span style="float:right;">你的邮箱：</span>
          </div>
          <div id="register_div2">
            <input type="text" value="" id="email" class="register_input">
          </div>
        </div>
        <div>
          <div id="register_div1">
            <span style="float:right;">你的生日：</span>
          </div>
          <div id="register_div2">
            <input type="text" value="" id="birthday" class="register_input">
          </div>
        </div>
        
        <div>
          <div id="register_div1">
            <span style="float:right;">兴趣爱好：</span>
          </div>
          <div id="register_div2">
            <textarea id="good_at" class="register_text"></textarea>
          </div>
        </div>
        <div style="position:relative;top:125px;">
          <div id="register_div1">
            <span style="float:right;">获奖经历：</span>
          </div>
          <div id="register_div2">
            <textarea id="prize" class="register_text"></textarea>
          </div>
        </div>
        <div style="position:relative;top:250px;">
          <div id="register_div1">
            <span style="float:right;">自我介绍：</span>
          </div>
          <div id="register_div2">
            <textarea id="self_intro" class="register_text"></textarea>
          </div>
        </div>
        <input type="button" value="通过" id="register_submit">
        <input type="button" value="删除" id="register_delete">
      </div>
    </div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>