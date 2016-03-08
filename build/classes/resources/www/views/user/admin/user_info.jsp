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
	$('#user_info').removeClass("change");
	$('.fun1').css(css2);
	$('#user_info').css(css1);
	
	$.ajax({
        type : "post",
        url  : "delete_temporary",
        data : {},
        dataType: "json",
        success: function(data){
        	
        }
    });
	
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
	
	$('#file_see').click(function(){
		var f=document.getElementById('file_select').value;  
		if(!/\.(gif|jpg|jpeg|png|JPG|PNG)$/.test(f)) {  
		    alert("图片类型必须是.jpeg,jpg,png中的一种");
		    return false;  
		} 
		$.ajaxFileUpload({
		    url:"upload_pic",  
		    type:"post",
		    data: { "user_id":user_id }, 
		    secureuri:false,  
		    fileElementId:'file_select', 
		    dataType:"json",  
		    success:function (data , status) {
		    	var src = "http://localhost:8080/CippusWebProject/getImage?user_id="+$('#user_id').val()+"&type=1&time="+new Date().getTime();
		    	$('#user_pic').attr("src", src);
		    },
		    error:function (data, status, e) {  
		        alert("图片上传失败,请重新选择图片");  
		    }
		}); 
	});
	
	$('#file_upload').click(function(){
		$.ajax({
			url : "saveUserPic",
			type : "post",
			dataType : "json",
			data : {"user_id":user_id},
			success : function(data) {
				if(data.result=="success")
					alertify.success("已成功上传图片！");
				else
					alertify.error("网络异常，请稍后再试！");
			}
		});
	});
	
	$('#save').click(function(){
		var good_at = $('#good_at').val();
		var prize = $('#prize').val();
		var self_intro = $('#self_intro').val();
		var tel = $('#tel').val();
		var email = $('#email').val();
		$.ajax({
			url : "saveUserInfo",
			type : "post",
			dataType : "json",
			data : {"user_id":user_id,"good_at":good_at,"prize":prize,"self_intro":self_intro,"tel":tel,"email":email},
			success : function(data) {
				if(data.result=="success")
					alertify.success("信息保存成功！");
				else
					alertify.error("网络异常，请稍后再试！");
			}
		});
	});
	
	$('#password_update').click(function(){
		
	});
	
	
	$(function(){
		//第一个参数是按钮的class属性值，第二个是被隐藏的div属性值
		popupLayer("but_tj","Popup");
		closeLayer("Close","Popup");
	});
	
	//我们通过点击添加或修改按钮后使当前操作的div隐藏
	//closeAdd("Popup");
	function closeAdd(targetClass){
		$("."+targetClass).hide();
		$("#spm").hide();
	} 
	
	//popup layer
	function isIE(num){
	    var num = num || "",
	    tester = document.createElement('div');
	    tester.innerHTML = '<!--[if IE ' + num + ']><i></i><![endif]-->';
	    return !!tester.getElementsByTagName('i')[0];
	}
	function popupLayer(objClass,targetClass){
	    $("."+objClass).click(function(){
	    $("#spm").show();
	    var target=$("."+targetClass);
	    var targetWidth=target.outerWidth();
	    var targetHeight=target.outerHeight();
	    if(isIE(6)){
	        $("#spm").hide();
	        //$("select").hide();
	        var top=$(document).scrollTop()+$(window).height()/2;
	        target.css({"top":top+"px"});
	        $(window).scroll(function(){
	            var top=$(document).scrollTop()+$(window).height()/2;
	            target.css({"top":top+"px"});
	        });
	    }
	    target.css({"margin-top":-parseInt(targetHeight/2)+"px","margin-left":-parseInt(targetWidth/2)+"px"});
	    target.show();
	    return false;

	    });
	}
	//隐藏div的操作
	function closeLayer(objClass,targetClass) {
	    $("."+objClass).click(function(){
	    $(this).parents("."+targetClass).hide();
	    $("#spm").hide();
	});
	}
	
	$('#repassword_1').click(function(){
		var old_password = $('#old_password').val();
		var user_id = $('#user_id').val();
		$.ajax({
			url : "isPasswordCorrect",
			type : "post",
			dataType : "json",
			data : {"user_id":user_id,"password":old_password},
			success : function(data) {
				if(data.result == "failed") {
					alertify.error("密码错误，修改失败！");
					$('.Popup').hide();
				}
				else {
					$('.Popup').hide();
					$('.Popup2').show();
				}
			}
		});
	});
	
	$('.Close').click(function(){ $('#Popup').hide(); });
	
	$('#repassword_2').click(function(){
		var new_password1 = $('#new_password').val();
		var new_password2 = $('#new_password2').val();
		if(new_password1!=new_password2)
			alertify.error("请确保两次输入的密码一致！");
		else {
			var user_id = $('#user_id').val();
			$.ajax({
				url : "passwordCorrect",
				type : "post",
				dataType : "json",
				data : {"user_id":user_id,"password":new_password1},
				success : function(data) {
					if(data.result == "failed") {
						alertify.error("网络异常，请重试！");
						$('.Popup2').hide();
					}
					else {
						alertify.success("密码已修改成功！");
						$('.Popup2').hide();
					}
				}
			})
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
#user_pic2 { width:250px; height:300px;  float:left; position:relative; left:35px; top:-615px; }
#password_update { cursor:pointer; float:right; height:27px; margin-top:3px; border:1px solid #999; font-size:12px; color:white; background:#71A6E4; border-radius:4px; margin-right:25px;}

.Popup {width: 770px;height:auto;position: absolute; left:700px; top:280px;background-color: #FFF;border: 1px solid #666; border-radius:6px; z-index: 999;}
.Popup_top { height:30px; border-bottom: 1px solid #cccccc; }
.Popup_top span { font-weight:bold; dislay:block; float:left; font-size:14px; font-family:Arial, Helvetica, sans-serif; width:80px; margin-left:25px; margin-top:10px; }
.Close { position:relative; left:620px; top:10px; }

.Popup2 {width: 770px;height:auto;position: absolute; left:300px; top:180px;background-color: #FFF;border: 1px solid #666; border-radius:6px; z-index: 999;}
.Popup_top2 { height:30px; border-bottom: 1px solid #cccccc; }
.Popup_top2 span { font-weight:bold; dislay:block; float:left; font-size:14px; font-family:Arial, Helvetica, sans-serif; width:80px; margin-left:25px; margin-top:10px; }
.Close2 { position:relative; left:620px; top:10px; }
</style>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_7.jsp" %>
<div class="Popup" style="display: none"><!-- 隐藏div -->
  <div class="Popup_top">
    <span>修改密码</span>
    <a href="#" class="Close">关闭</a>
  </div> 
  <div style="width:500px; margin:15px auto; height:auto; min-height:50px;">
    <span>请输入原始密码：</span>
    <input type="password" id="old_password" style="width:300px; height:25px; background:white; padding-left:8px; border-radius:4px; border:1px #666 solid; outline:none; margin-left:20px;">
    <input type="button" value="提交" id="repassword_1" style="cursor:pointer; display:block; width:auto; height:30px; margin-left:13px; color:#666; background:white; border:1px solid #999; border-radius:4px; margin:25px auto;">   
  </div>
</div>
<div class="Popup2" style="display: none"><!-- 隐藏div -->
  <div class="Popup_top2">
    <span>修改密码</span>
    <a href="#" class="Close2">关闭</a>
  </div> 
  <div style="width:500px; margin:15px auto; height:auto; min-height:50px;">
    <span>请输入新密码：</span>
    <input type="password" id="new_password" style="width:300px; height:25px; background:white; padding-left:8px; border-radius:4px; border:1px #666 solid; outline:none; margin-left:20px;">
    <br/><br/>
    <span>请输入新密码：</span>
    <input type="password" id="new_password2" style="width:300px; height:25px; background:white; padding-left:8px; border-radius:4px; border:1px #666 solid; outline:none; margin-left:20px;">
    <input type="button" value="提交" id="repassword_2" style="cursor:pointer; display:block; width:auto; height:30px; margin-left:13px; color:#666; background:white; border:1px solid #999; border-radius:4px; margin:25px auto;">   
  </div>
</div>

<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:920px; background:white;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1" style="width:800px; height:960px; float:left;  margin-top:30px; margin-left:30px;">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">个人资料</span>
          <input type="button" class="but_tj" id="password_update" value="修改密码">
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
            <input type="button" id="save" value="保存修改">
            
          </div>
          
        </div>
        
      </div>
      <div id="user_pic2">
        <img id="user_pic" style="width:200px; height:200px; border:1px solid black;"><br/>
        <input type="file" id="file_select" name="file_select" style="margin-top:15px; width:230px;"/><br/><br/>
        <input type="button" id="file_see" value="预览" style="width:50px;margin-top:5px;">
        <input type="button" id="file_upload" value="确定上传" style="width:68px;margin-top:5px;">
      </div>
    </div>
  </div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>