‘
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
#login_div {
    float:left;
    width:300px;
    height:300px;
    background:url('${ctx}/images/login_bg.png');
    position:relative;
    left:35px;
    top:25px;
    
}
#user_div {
    float:left;
    width:300px;
    height:300px;
    background:url('${ctx}/images/login_bg_2.png');
    position:relative;
    left:35px;
    top:25px;
    display:none;
}
.login_input { 
    width:240px; 
    height:30px; 
    margin-left:25px; 
    margin-top:60px; 
    outline:none; 
    border:none; 
    background:#E8ECEE;
    padding-left:10px;
    font-size:18px;
    border-radius:4px; 
    color:#75737B;
    vertical-align:middle;
    line-height:30px;
}
.login_button {
    width:250px; 
    height:35px; 
    margin-left:25px; 
    margin-top:20px; 
    outline:none; 
    border:none; 
    background:#E8ECEE;
    font-size:18px;
    color:white;
    border-radius:5px; 
    cursor:pointer;
}
#pics_wrap {
    width:780px; 
    max-width:780px;
    overflow:hidden;
    float:left; 
    height:300px; 
    position:relative;
    left:50px;
    top:25px;
    z-index:950;
    cursor:pointer;
}
.html5zoo-img-box-0 img { display:block; width:780px; height:300px; max-width:780px; cursor:pointer; z-index:999; }
.html5zoo-img-box-0 { display:block; height:300px; }
.html5zoo-bullet-0-1 { margin-left:310px; float:left; margin-top:-23px; z-index:1020; }
.html5zoo-bullet-0-0 { margin-left:280px; float:left; z-index:1020; }
.html5zoo-bullet-0-2 { margin-left:340px; float:left; margin-top:-23px; z-index:1020; }
#announcement { width:300px; height:400px; position:relative; left:35px; top:25px; float:left; }
#announcement_tip, #game_tip, #mvp_tip { margin-left:15px; font-size:24px; }
#announcement_more, #game_more { float:right; font-size:12px; cursor:pointer; line-height:30px; margin-right:20px;}
#game_resources { width:500px; height:400px; position:relative; left:60px; top:25px; float:left; }
#mvp { width:250px; float:left; height:400px; position:relative; left:80px; top:25px; }
#user_center1:hover { text-decoration:underline; }
#logout:hover { text-decoration:underline; }
#put2:hover { text-decoration:underline; }
#more1 { 
    display: block;
    float: left;
    position:relative;
    left:158px;
    top:-2px;
    line-height: 32px;
    width: 82px;
    text-align: center;
    text-decoration: none;height:32px;margin-top:-30px;z-index:1011;
}
#more1:hover { background-position: center bottom; }
#more2 { 
    display: block;
    float: left;
    position:relative;
    left:366px;
    top:-1px;
    line-height: 32px;
    width: 82px;
    text-align: center;
    text-decoration: none;height:32px;margin-top:-30px;z-index:1011;
}
#more2:hover { background-position: center bottom; }
#more3 { 
    display: block;
    float: left;
    position:relative;
    left:366px;
    top:-1px;
    line-height: 32px;
    width: 82px;
    text-align: center;
    text-decoration: none;height:32px;margin-top:-30px;z-index:1011;
}
#more3:hover { background-position: center bottom; }
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/html5zoo.js"></script>
<script type="text/javascript" src="${ctx}/js/func/lovelygallery.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#user_center1').click(function(){
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
    
	$('#username').focus(function(){
	    if($(this).val()=="用户名")
	    	$(this).val("");
	});
	$('#username').blur(function(){
		if($(this).val()=="")
			$(this).val("用户名");
	});
	

	
	$('#register').click(function(){
		jcl.go("/CippusWebProject/register");
	});
	
	$('#login_submit').click(function(){
		//number为username
		var number = $('#username').val();
		var password = $('#password').val();
		var numberTest = /^\d{9}$/;
		var passwordTest = /^\w+$/;
		if(!number.match(numberTest)) {
			alertify.error("请输入正确格式的用户名！");
			return false;
		}
		else if(!password.match(passwordTest)) {
			alertify.error("请输入正确格式的密码！");
			return false;
		}
		else {
			$.ajax({
				url : "userLogin",
				type : "post",
				dataType : "json",
				data : {"number":number,"password":password},
				success : function(data) {
					if(data.result == "failed")
						alertify.error("用户名密码错误，请重新登录");
					else {
						alertify.success("登录成功，详情请点击用户中心！");
						$('#login_div').css("display","none");
						$('#user_div').css("display","block");
						$('#user_id').val(data.user_id);
						$('#name').text(data.name);
						if(data.user_group.length>7)
							$('#group2').text(data.user_group.substr(0,5));
						else
						    $('#group2').text(data.user_group);
						$('#register_time').text(data.register_time);
						if(data.user_type==0 || data.user_type=="0")
						    $('#user_type').text("组员");
						else if(data.user_type==1 || data.user_type=="1")
						    $('#user_type').text("组长");
						else if(data.user_type==2 || data.user_type=="2")
						    $('#user_type').text("管理员");
						var src = "http://localhost:8080/CippusWebProject/getImage?user_id="+data.user_id+"&type=0&time="+new Date().getTime();
						$('#user_pic').attr("src", src);
					}
				}
			});
		}
	});
	
	$.ajax({
		url : "hasUserLogin",
		type : "post",
		data : {},
		dataType : "json",
		success : function(data) {
			if(data.result=="success") {
				var src = "http://localhost:8080/CippusWebProject/getImage?user_id="+data.row.USER_ID+"&type=0&time="+new Date().getTime();
				$('#user_pic').attr("src", src);
				$('#login_div').css("display","none");
				$('#user_div').css("display","block");
				$('#user_id').val(data.row.USER_ID);
				$('#name').text(data.row.NAME);
				if(data.row.USER_GROUP.length>7)
					$('#group2').text(data.row.USER_GROUP.substr(0,5));
				else
				    $('#group2').text(data.row.USER_GROUP);
				if(data.row.USER_TYPE==0 || data.row.USER_TYPE=="0")
				    $('#user_type').text("组员");
				else if(data.row.USER_TYPE==1 || data.row.USER_TYPE=="1")
				    $('#user_type').text("组长");
				else if(data.row.USER_TYPE==2 || data.row.USER_TYPE=="2")
				    $('#user_type').text("管理员");
				$('#register_time').text(data.row.REGISTER_TIME);
			}
			else {
				$('#login_div').css("display","block");
				$('#user_div').css("display","none");
			}
		}
	});
	
	$('#logout').click(function(){
		$.ajax({
			url : "logout",
			type : "post",
			dataType : "json",
			data : {},
			success : function(data){
				location.reload();
			}
		});
	});
	
	$('#put').click(function(){
		alertify.error("登陆之后才能投稿，请先登陆！");
	});
	
	$('#put2').click(function(){
		jcl.go("/CippusWebProject/contribute");
	});
	
	$('#more1').click(function(){ jcl.go("/CippusWebProject/resources"); });
	$('#more2').click(function(){ jcl.go("/CippusWebProject/news"); });
	$('#more3').click(function(){ jcl.go("/CippusWebProject/news_game"); });
	
	$.ajax({
		url : "getIndexInfo",
		type : "post",
		dataType : "json",
		data : {},
		success : function(data) {
			
		}
	});
})
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="common/top.jsp" %>
<%@ include file="nav/nav_1.jsp" %>
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin: auto; height:320px; background:white;">
    <div id="login_div">
      <input class="login_input" type="text" id="username" value="用户名"/><br/>
      <input class="login_input" type="password" id="password" style="margin-top:10px;"/><br/>
      <input class="login_button" type="button" id="login_submit" value="登陆" style="background:#0E4477;">
      <input class="login_button" type="button" id="register" value="加入我们" style="background:#185BA9;margin-top:8px;">
      <input class="login_button" type="button" id="put" value="我要投稿" style="background:#2494D3;margin-top:8px;">
    </div>
    <div id="user_div">
      <img id="user_pic" src="${ctx}/images/user_pic.png" style="width:100px; height:100px; margin-top:70px; margin-left:15px;">
      <div style="width:140px; height:135px; font-size:14px; color:#666; position:relative; left:140px; top:-90px;">
        <input type="hidden" id="user_id" value="">
        <span>姓名：</span><span id="name"></span><br/><br/>
        <span>组别：</span><span id="group2">微软创新俱乐部</span><br/><br/>
        <span>类别：</span><span id="user_type"></span>
      </div>
      <div style="font-size:16px; color:#666; position:relative; left:75px; top:-110px;">
        <span>加入时间：</span><span id="register_time"></span>
      </div>
      <span style="color:#4790CD; font-size:18px; position:relative; top:-90px; left:75px; cursor:pointer" id="user_center1">点击进入用户详情</span>
      <br/>
      <span style="color:#4790CD; font-size:16px; position:relative; top:-80px; left:80px; cursor:pointer" id="put2">我要投稿</span>
      <span style="color:#4790CD; font-size:16px; position:relative; top:-80px; left:110px; cursor:pointer" id="logout">注销</span>
    </div>
    
    <div id="pics_wrap">
      <div id="html5zoo-1" style="height:300px;">
		<ul class="html5zoo-slides" style="display:none;height:300px;">
			<li><a href="#"><img src="${ctx}/images/001.jpg" style="width:780px; height:300px;"/></a></li>
			<li><a href="#"><img src="${ctx}/images/002.jpg" style="width:780px; height:300px;"/></a></li>
			<li><a href="#"><img src="${ctx}/images/003.jpg" style="width:780px; height:300px;"/></a></li>
		</ul>
	  </div>
    </div>
  </div>
  
  <div style="width:85%; min-width:1147px; margin:0 auto; height:480px; background:white;">
    <div id="announcement">
      <div style="height:32px;width:100%; background-color:#EEE;">
          <div style="width:200px;over-flow:hidden;float:left">
            <img src="${ctx}/images/t_bk_l.png" style="z-index:1000;">
            <span style="font-size:12px; float:left; color:#FFF; position:relative;top:-32px;left:35px; line-height:32px;  font-family:'sans-serif'; font-weight:700;">资源&项目</span>
            <a href="#" id="more1" style="background-image: url('${ctx}/images/more_bk.gif');"></a>
          </div>
          
          
      </div>
      <div style="width:100%; height:395px; margin-top:15px; border:1px solid #d0d0d0;">
      
      </div>
    </div>
    
    <div id="game_resources">
      <div style="width:100%; height:35px;background-color:#EEE;">
        <div style="width:200px;over-flow:hidden;float:left">
            <img src="${ctx}/images/t_bk_l.png" style="z-index:1000;">
            <span style="font-size:12px; float:left; color:#FFF; position:relative;top:-32px;left:35px; line-height:32px;  font-family:'sans-serif'; font-weight:700;">中心公告</span>
            <a href="#" id="more2" style="background-image: url('${ctx}/images/more_bk.gif');"></a>
          </div>
      </div>
      <div style="width:100%; height:180px; margin-top:15px; border:1px solid #d0d0d0;">
      
      </div>
      
      <div style="width:100%; position:relative;top:15px; height:35px;background-color:#EEE;">
        <div style="width:200px;over-flow:hidden;float:left;">
            <img src="${ctx}/images/t_bk_l.png" style="z-index:1000;">
            <span style="font-size:12px; float:left; color:#FFF; position:relative;top:-32px;left:35px; line-height:32px;  font-family:'sans-serif'; font-weight:700;">竞赛通知</span>
            <a href="#" id="more3" style="background-image: url('${ctx}/images/more_bk.gif');"></a>
          </div>
      </div>
      <div style="width:100%; height:150px; position:relative;top:25px; border:1px solid #d0d0d0;">
      </div>
    </div>
    
    <div id="mvp">
      <div style="width:100%; height:35px;background-color:#EEE;">
        <div style="width:200px;over-flow:hidden;float:left;">
            <img src="${ctx}/images/t_bk_l.png" style="z-index:1000;">
            <span style="font-size:12px; float:left; color:#FFF; position:relative;top:-32px;left:35px; line-height:32px;  font-family:'sans-serif'; font-weight:700;">成员之星</span>
        
          </div>
      </div>
      <div style="width:100%; height:390px; margin-top:15px; border:1px solid #d0d0d0;">
      </div>
    </div>
  </div>
  
</div>
<%@ include file="common/footer.jsp" %>
</body>
</html>