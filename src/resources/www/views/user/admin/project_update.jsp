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
#groups_title{
  font-weight: bold;
  font-size: 12px;
  color: #333;
  margin: 10px auto;
  float: left;
  width: 100%;
}
</style>

<style type="text/css">
.Popup {width: 470px;height:auto;position: absolute; left:700px; top:280px;background-color: #FFF;border: 1px solid #666; border-radius:6px; z-index: 999;}
.Popup_top { height:30px; border-bottom: 1px solid #cccccc; }
.Popup_top span { font-weight:bold; dislay:block; float:left; font-size:14px; font-family:Arial, Helvetica, sans-serif; width:80px; margin-left:25px; margin-top:10px; }
.Close { position:relative; left:270px; top:10px; }
</style>

<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/alertify.css">
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	$('.fun1').addClass("change");
	$('#project_manage').removeClass("change");
	$('.fun1').css(css2);
	$('#project_manage').css(css1);
	
	$.ajax({
		url : "getProjectInfoDetail",
		type : "post",
		dataType : "json",
		data : {"project_id":$('#project_id').val()},
		success : function(data) {
			$('#project_name').val(data.row.PROJECT_NAME);
			$('#author').val(data.row.AUTHOR);
			$('#project_group').val(data.row.PROJECT_GROUP);
			$('#remark1').text(data.row.REMARK1);
			$('#remark2').text(data.row.REMARK2);
			$('#type').val(data.row.PROJECT_STATUS);
			$('#project_link').val(data.row.PROJECT_LINK);
			
		}
	});
	
	var file_num = 1;
	
	$('.but_tj').click(function(){
		if(confirm("该操作将会删除项目之前上传的图片！")) {
			$('.Popup').css("display","block");
			$('html, body').animate({scrollTop:0}, 'slow');
		}
		else {
			return false;
		}
	});
	
	$('#add').click(function(){
		file_num++;
		var file_name = "file_name_" + file_num;
		var file = "file_" + file_num;
		var file_delete = "file_delete_" + file_num;
		var dom = "<div style='margin-top:15px;'>"+
	              "<input type='file' style='width:200px;margin-left:50px;' id='"+file+"' name='"+file+"'/>"+
	              "<input type='button' style='margin-left:4px;' value='删除' class='file_delete' id='"+file_delete+"'>";
	    $('#file_info').append(dom);
	});
	
	$('.file_delete').live("click", function(){
		file_num--;
		$(this).parent().remove();
	});
	
	$('#file_submit').click(function(){
		for(var i=1;i<=file_num;i++) {
			var file = "file_" + i;
			$.ajaxFileUpload({
			    url:"update_project_pic",  
			    type:"post",
			    data: { "project_id":$('#project_id').val(), "file_select":file, "i":i}, 
			    secureuri:false,  
			    fileElementId:file, 
			    dataType:"json",  
			    success:function (data , status) {
                    $('.Popup').hide();
                    alertify.success("图片上传成功！");
			    },
			    error:function (data, status, e) {  
			        alertify.error("图片上传失败！");
			    }
			});
		}
	});
	
	$('#project_submit').click(function(){
		var project_name = $('#project_name').val();
		var author = $('#author').val();
		var project_group = $('#project_group').val();
		var remark1 = $('#remark1').val();
		var remark2 = $('#remark2').val();
		var type = $('#type').val();
		var project_link = $('#project_link').val();
		if(project_name.length==0) {
			alertify.error("请输入项目标题！");
			return false;
		}
		else if(author.length==0) {
			alertify.error("请输入项目作者！");
			return false;
		}
		else if(project_group==0 || project_group=="0") {
			alertify.error("请选择项目组别！");
			return false;
		}
		else if(remark1.length==0) {
			alertify.error("请输入项目目的！");
			return false;
		}
		else if(type==0 || type=="0") {
			alertify.error("请选择项目状态！");
			return false;
		}
		else if(remark2.length==0) {
			alertify.error("请输入项目简介！");
			return false;
		}
		else {
			if($('#project_select2').val()!="") {
				$.ajaxFileUpload({
					url : "updateProjectWithFile",
					type : "post",
					dataType : "json",
					data : {"file_select":"project_select2","project_id":$('#project_id').val(),"project_name":project_name,"author":author,"project_group":project_group,"remark1":remark1,"project_status":type,"remark2":remark2,"project_link":$('#project_link').val()},
					fileElementId:"project_select2",
					success : function(data) {
					    if(data.result == "success") {
					    	alert("项目更新成功！");
					    	jcl.go("/CippusWebProject/project_manage_admin");
					    }
					    else if(data.result == "login") {
					    	alertify.error("修改失效，请重新登录后再发布项目！");
					    }
					    else {
					    	alertify.error("网络错误，请稍后再试！");
					    }
					}
				});
			}
			else {
				$.ajax({
					url : "updateProjectWithoutFile",
					type : "post",
					dataType : "json",
					data : {"project_id":$('#project_id').val(),"project_name":project_name,"author":author,"project_group":project_group,"remark1":remark1,"project_status":type,"remark2":remark2,"project_link":$('#project_link').val()},
					success : function(data) {
					    if(data.result == "success") {
					    	alert("项目更新成功！");
					    	jcl.go("/CippusWebProject/project_manage_admin");
					    }
					    else if(data.result == "login") {
					    	alertify.error("修改失效，请重新登录后再发布项目！");
					    }
					    else {
					    	alertify.error("网络错误，请稍后再试！");
					    }
					}
				});
			}
		}
	});
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_user_bootstrap.jsp" %>
<input type="hidden" id="project_id" value="<%=request.getParameter("project_id") %>">
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:1050px; background:white;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">发布项目</span>
        </div>
        <div style="height:950px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <div style="margin:20px 40px; width:718px;">
            <p id="groups_title">作者信息</p>
            <input type="text" id="project_name" placeholder="作品题目" style="width:703px;">
            <input type="text" id="author" placeholder="作者&nbsp;&nbsp;&nbsp;&nbsp;以“#”隔开" style="width:550px; 	">
            <select style="color:#666; width:150px;" id="project_group">
              <option value="0">作者组别</option>
              <option value="ACM组">ACM组</option>
              <option value="数模组">数模组</option>
              <option value="嵌入式组">嵌入式组</option>
              <option value="智能车组">智能车组</option>
              <option value="创业组">创业组</option>
              <option value="花旗俱乐部">花旗俱乐部</option>
              <option value="梦创俱乐部">梦创俱乐部</option>
              <option value="微软创新俱乐部">微软创新俱乐部</option>
              <option value="腾讯俱乐部">腾讯俱乐部</option>
              <option value="螺丝工作室">螺丝工作室</option>
            </select>
          </div>
          <div style="margin:20px 40px; width:718px;">
            <p id="groups_title">项目目的</p>
            <textarea style="width:703px; height:100px; resize:none;" id="remark1" placeholder="项目目的"></textarea>
            <select style="color:#666; width:150px;" id="type">
              <option value="0">项目状态</option>
              <option value="1">已完成</option>
              <option value="2">正在进行</option>
              <option value="3">准备中</option>
            </select>
          </div>
          <div style="margin:0px 40px 40px 40px; width:718px;">
            <p id="groups_title" style="width:100%;">项目展示</p>
            <input type="button" class="but_tj" value="点击上传项目展示图片" style="width:auto; height:30px; color:#666; background:white; border:1px solid #999; border-radius:4px;"/>
        </div>
        <div style="margin:20px 40px; width:718px;">
            <p id="groups_title" style="width:100%; position:relative;">项目介绍</p>
            <textarea style="width:703px; height:150px; resize:none;" placeholder="项目介绍" id="remark2"></textarea>
        </div>
        <div style="margin:0px 40px; width:718px;">
          <p id="groups_title" style="width:100%;">项目链接</p>
          <input type="text" placeholder="项目链接" style="width:703px;" id="project_link">
        </div>
        <div style="margin:0px 40px; width:718px;">
          <p id="groups_title" style="width:100%;">项目上传</p>
          <input type="file" id="project_select2" name="project_select2">
        </div>
        <button class="btn" style="margin-left:320px; margin-top:20px; width:120px; height:34px;" id="project_submit">完成修改</button>
      </div>
    </div>
  </div>
</div>
<div class="Popup" style="position:absolute; top:150px; left:500px; display: none"><!-- 隐藏div -->
  <div class="Popup_top">
    <span style="width:auto;">上传项目展示图片</span>
    <a href="#" class="Close">关闭</a>
  </div> 
  <div style="width:700px; margin:15px auto; height:auto; min-height:50px;">
    <div id="file_info">
      <div>
        
        <input type="file" style="width:200px;margin-left:50px;" id="file_1" name="file_1"/>
        <input type="button" value="删除" id="file_delete_1">
        <input type="button" value="继续添加" id="add">
      </div>
    </div>
    <input type="button" value="提交" id="file_submit" style="display:block; width:auto; height:30px; margin-top:25px; margin-left:205px; color:#666; background:white; border:1px solid #999; border-radius:4px;">   
  </div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>