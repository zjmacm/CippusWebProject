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
#about_main_1 { width:800px; height:580px; float:left;  margin-top:30px; margin-left:30px;}
</style>
<link href="${ctx}/css/alertify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/birthday.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#group_1').change(function(){
		var group1 = $(this).val();
		if(group1=="2") {
			$('#group_2').css("display", "block");
			$('#group_3').css("display", "none");
			$('#group_4').css("display", "none");
		}
		else if(group1=="3") {
			$('#group_3').css("display", "block");
			$('#group_2').css("display", "none");
			$('#group_4').css("display", "none");
		}
		else if(group1=="4") {
			$('#group_4').css("display", "block");
			$('#group_2').css("display", "none");
			$('#group_3').css("display", "none");
		}
	});
	
	$('#register_submit').click(function(){
		var numberTest = /^\d{9}$/;
		var passwordTest = /^\w+$/;
		var telTest = /^\d{11}$/;
		var emailTest = /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/;
		var group1 = $('#group_1').val();
	    var number = $('#number').val();
		var password = $('#password').val();
		var repassword = $('#repassword').val();
		var name = $('#name').val();
		var tel = $('#tel').val();
		var email = $('#email').val();
		var year = $('#sel_year').val();
		var month = $('#sel_month').val();
		var day = $('#sel_day').val();
		var good_at = $('#good_at').val();
		var prize = $('#prize').val();
		var self_intro = $('#self_intro').val();
		if(!number.match(numberTest)) {
			alertify.error("学号格式错误！");
			return false;
		}
		else if(!password.match(passwordTest)) {
			alertify.error("密码只能包括数字、字母与下划线！");
			return false;
		}
		else if(repassword!=password) {
			alertify.error("请确保两次输入的密码一致！");
			return false;
		}
		else if(year==0 || month==0 || day==0) {
			alertify.error("请输入你的生日！");
			return false;
		}
		else if(!tel.match(telTest)) {
			alertify.error("请输入正确的手机号！");
			return false;
		}
		else if(!email.match(emailTest)) {
			alertify.error("请输入正确的邮箱地址！");
			return false;
		}
		else if(group1=="0") {
			alertify.error("请选择要加入的组别！");
			return false;
		}
		else if(good_at.length<5 || prize.length==0 || self_intro.length<10) {
			alertify.error("请填写你的个人信息！");
			return false;
		}
		else {
			var group;
			if(group1=="2")
				group = $('#group_2').val();
			else if(group1=="3")
				group = $('#group_3').val();
			else if(group1=="4")
				group = $('#group_4').val();
			if(month.length==1)
			    month = "0" + month;
		    if(day.length==1)
			    day = "0" + day;
		    var birthday = year + "-" + month + "-" + day;
		    $.ajax({
		    	url : "userRegister",
		    	type : "post",
		    	dataType : "json",
		    	data : {"number":number,"password":password,"name":name,"tel":tel,"email":email,"birthday":birthday,"user_group":group,"good_at":good_at,"self_intro":self_intro,"prize":prize},
		    	success : function(data) {
		    		if(data.result=="success") 
		    			alertify.success("你的申请已经成功提交，请耐心等待我们与你联系！");
		    		else if(data.result=="repeat")
		    			alertify.error("该学号已经被注册！");
		    		else
		    			alertify.error("网络错误，请稍后再试！");
		    	}
		    });
		}
	});
});
</script>
<style type="text/css">
#register_div { 
    width:800px; 
    height:1010px; 
    border:1px solid #999; 
    border-radius:6px; 
    background:#E5E5E5; 
    margin-left:auto; 
    margin-right:auto; 
    position:relative; 
    top:30px;
}    
#register_form { width:600px; height:400px; margin:25px auto; }
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
#register_submit { 
    width:125px; 
    height:35px; 
    border:1px solid #999; 
    background:#185BA9; 
    border-radius:4px; 
    color:#FFF;
    cursor:pointer;
    position:relative;
    left:230px;
    top:400px; 
}
.register_text { width:300px; height:135px; border:1px solid #999; border-radius:4px; padding-left:4px; }
</style>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="common/top.jsp" %>
<%@ include file="nav/nav_0.jsp" %>

<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin: auto; height:1050px; background:white;">
    <div id="register_div">
      <div style="width:800px; height:40px;">
        <span style="line-height:70px; margin-left:25px; font-family:'微软雅黑'; color:#666;">欢迎成为创新中心的一员，如果您已有账号，请返回首页登陆</span>
        <hr style="position:relative; top:-30px; width:95%;"/>
      </div>
      <div id="register_form">
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
            <span style="float:right;">设置密码：</span>
          </div>
          <div id="register_div2">
            <input type="password" value="" id="password" class="register_input">
          </div>
        </div>
        <div>
          <div id="register_div1">
            <span style="float:right;">重复密码：</span>
          </div>
          <div id="register_div2">
            <input type="password" value="" id="repassword" class="register_input">
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
            <select class="info_select" id="sel_year" style="width:65px;"></select>年
            <select class="info_select" id="sel_month"></select>月
            <select class="info_select" id="sel_day"></select>日<br/><br/><br/>
          </div>
        </div>
        <div>
          <div id="register_div1">
            <span style="float:right;">选择组别：</span>
          </div>
          <div id="register_div2">
            <select class="group_select" id="group_1">
              <option value="0">请选择</option>
              <option value="2">兴趣小组</option>
              <option value="3">创新俱乐部</option>
              <option value="4">螺丝工作室</option>
            </select>
            <select class="group_select" id="group_2" style="display:none;margin-left:15px;">
              <option value="数模组">数模组</option>
              <option value="ACM组">ACM组</option>
              <option value="嵌入式组">嵌入式组</option>
              <option value="智能车组">智能车组</option>
              <option value="创业组">创业组</option>
            </select>
            <select class="group_select" id="group_3" style="display:none;margin-left:15px;">
              <option value="花旗俱乐部">花旗俱乐部</option>
              <option value="梦创俱乐部">梦创俱乐部</option>
              <option value="腾讯俱乐部">腾讯俱乐部</option>
              <option value="微软创新俱乐部">微软创新俱乐部</option>
            </select>
            <select class="group_select" id="group_4" style="display:none;margin-left:15px;">
              <option value="运维组">运维组</option>
              <option value="设计组">设计组</option>
              <option value="开发组">开发组</option>
            </select>
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
        <input type="button" value="提交申请" id="register_submit">
      </div>
    </div>
  </div>
</div>
<script>  
$(function () {
	$.ms_DatePicker({
            YearSelector: ".sel_year",
            MonthSelector: ".sel_month",
            DaySelector: ".sel_day"
    });
	$.ms_DatePicker();
}); 
</script>
<%@ include file="common/footer.jsp" %>
</body>
</html>