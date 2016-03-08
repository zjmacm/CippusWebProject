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
#about_main_1 { width:800px; height:700px; float:left;  margin-top:30px; margin-left:30px;}
#fun2, #fun3 { border:1px solid #999; }
#resources_name {display:block; width:400px; float:left; font-size:26px; color:#67B6F1; font-weight:bold; padding-top:8px; }
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
	$.ajax({
		url : "getResourcesInfo",
		type : "post",
		dataType : "json",
		data : {"resources_id":$('#resources_id').val()},
		success : function(data) {
			var type1;
			if(data.row.RESOURCES_TYPE1==1)
				type1 = "ACM相关";
			else if(data.row.RESOURCES_TYPE1==2)
				type1 = "数模相关";
			else if(data.row.RESOURCES_TYPE1==3)
				type1 = "编程语言相关";
			else if(data.row.RESOURCES_TYPE1==4)
				type1 = "硬件嵌入式";
			else if(data.row.RESOURCES_TYPE1==5)
				type1 = "设计相关";
			else if(data.row.RESOURCES_TYPE1==6)
				type1 = "其他资源";
			var type2;
			if(data.row.RESOURCES_TYPE2==0)
				type2 = "视频教程";
			else if(data.row.RESOURCES_TYPE2==1)
				type2 = "文档资源";
			else if(data.row.RESOURCES_TYPE2==2)
				type2 = "源代码";
			
			$('#resources_name').text(data.row.RESOURCES_NAME);
			var dom1 = "<option>"+type1+"</option>";
			var dom2 = "<option>"+type2+"</option>";
			
			$('#type1').append(dom1);
			$('#type2').append(dom2);
			
			$('#remark').val(data.row.REMARK);
			

			$('#upload_group').text(data.row.UPLOAD_GROUP);
			$('#upload_user').text(data.row.UPLOAD_USER);
			$('#upload_time').text(data.row.UPLOAD_TIME);
			
			var link_file = data.row.LINK_FILE;
			if(link_file==1 || link_file=="1") {
				var dom = "<a href='http://localhost:8080/CippusWebProject/getResourcesFileDetail?resources_id="+$('#resources_id').val()+"' class='file_name' style='cursor:pointer; color:#56A2E8; font-weight:bold;'>"+data.row.FILE_NAME+"</a>";
				$('#resources_file').append(dom);
				$('#resources_file').css("display","block");
				$('#resources_link').css("display","none");
			}
			else {
				var link = data.row.LINK_ADDRESS.substr(0,4);
				if(link=="http") {
					var dom = "<a class='link' style='cursor:pointer; color:#56A2E8; font-weight:bold;' href='"+data.row.LINK_ADDRESS+"'>"+data.row.LINK_NAME+"</a>";
					$('#resources_link').append(dom);
					$('#resources_file').css("display","none");
					$('#resources_link').css("display","block");
				}
				else {
					var dom = "<a class='link' style='cursor:pointer; color:#56A2E8; font-weight:bold;' href='http://"+data.row.LINK_ADDRESS+"'>"+data.row.LINK_NAME+"</a>";
					$('#resources_link').append(dom);
					$('#resources_file').css("display","none");
					$('#resources_link').css("display","block");
				}
			}
		}
	});
	
	$('#back').click(function(){
		jcl.go("/CippusWebProject/resources_unaccept");
	});
	
	$('#accept').click(function(){
		$.ajax({
			url : "acceptResources",
			type : "post",
			dataType : "json",
			data : {"resources_id":$('#resources_id').val()},
			success : function(data){
				if(data.result=="success") {
					alert("资源审核成功！");
					jcl.go("/CippusWebProject/resources_unaccept");
				}
				else {
					alert("网络错误，请稍后再试！");
				}
			}
		});
	});
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_6.jsp" %>
<input type="hidden" id="resources_id" value="<%=request.getParameter("resources_id") %>">
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:600px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">用户中心</span>
      </div>
      <div style="width:200px; margin-top:30px;">
        <div class="fun1 change" id="register_accept" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">审核申请</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1" id="resources_unaccept" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">资源审核</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="user_info" style="background:#FFF;color:black;border:1px solid #999;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">个人资料</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="member" style="background:#FFF;color:black;border:1px solid #999;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">组内成员</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="news1" style="background:#FFF;color:black;border:1px solid #999; margin-top:8px;" >
          <span style="font-size:12px;line-height:33px;margin-left:15px;">发布新闻</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="project_manage" style="background:#FFF;color:black;border:1px solid #999; margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">项目管理</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">资源审核</span>
        </div>
      </div>
        <div style="height:600px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <div style="margin:40px auto 10px 40px;">
            <span id="resources_name"></span>
            <select style="color:#666; width:130px;" id="type1">
              
            </select> 
            <select style="color:#666; width:130px;" id="type2">
              
            </select> 
          </div>
          <div style="font-size:12px;">
            <span id="upload_group" style="position:relative;bottom:10px;left:45px;top:4px;"></span>&nbsp;&nbsp;<span id="upload_user" style="position:relative;bottom:10px;left:45px;top:4px;"></span>&nbsp;&nbsp;<span id="upload_time" style="position:relative;bottom:10px;left:45px;top:4px;"></span>&nbsp;&nbsp;<span style="position:relative;bottom:10px;left:45px;top:4px;">上传</span>
          </div>
          <div style="margin:0 40px 0 40px; height:auto; border-bottom: solid 1px #eee; padding-bottom:5px;">
            <div class="tabbable">
              
              
          	</div>
          </div>
          <textarea style="margin:20px auto auto 40px ;width:705px; height:300px; resize:none;" id="remark"></textarea>
          <div id="fileOrLink" style="margin-top:25px; margin-left:45px;">
            <div id="resources_file" style="display:none;">
              <h3>资源下载</h3>
            </div>
            <div id="resources_link" style="display:none;">
              <h3>资源链接</h3>
            </div>
          </div>
          <input type="button" value="通过审核" id="accept" style="border:1px solid #999; border-radius:4px; height:25px; background:#FFF; margin-left:280px; margin-top:20px;">
          <input type="button" value="返回" id="back" style="border:1px solid #999; border-radius:4px; height:25px; background:#FFF; margin-left:30px; margin-top:20px;">
        </div>
    </div>
  </div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>