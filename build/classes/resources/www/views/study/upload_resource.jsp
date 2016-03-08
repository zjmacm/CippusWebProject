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
	var fleOrLink = 0;
	var css1 = {"background":"#0088CC", "color":"white"};
	var css2 = {"background":"white", "color":"#67B6F1"};
	$('#fun2').click(function(){
		$('#sharing_files').css("display","block");
		$('#sharing_links').css("display","none");
		$('#fun2').css(css1);
		$('#fun3').css(css2);
		fleOrLink = 0;
	});
	
	$('#fun3').click(function(){
		$('#sharing_files').css("display","none");
		$('#sharing_links').css("display","block");
		$('#fun2').css(css2);
		$('#fun3').css(css1);
		fleOrLink = 1;
	});
	
	$('#upload_submit').click(function(){
		var resources_name = $('#resources_name').val();
		var resources_type1 = $('#type1').val();
		var resources_type2 = $('#type2').val();
		var remark = $('#remark').val();
		if(resources_type1==0 || resources_type1=="0") {
			alertify.error("请选择资源类别！");
			return false;
		}
		else if(resources_type2==-1 || resources_type2=="-1") {
			alertify.error("请选择资源种类！");
			return false;
		}
		else {
			if(fleOrLink==1) {
				var link_name = $('#link_name').val();
				var link_address = $('#link_address').val();
				if(resources_name.length==0 || link_name.length==0 || link_address.length==0) {
					alertify.error("请输入完整的资源信息！");
					return false;
				}
				else {
					$.ajax({
						url : "addResourcesLink",
						type : "post",
						dataType : "json",
						data : {"resources_name":resources_name,"resources_type1":resources_type1,"resources_type2":resources_type2,"remark":remark,"link_name":link_name,"link_address":link_address},
						success : function(data) {
							if(data.result=="success")
								alertify.success("资源上传成功！");
							else if(data.result=="success_1")
								alertify.success("上传的资源已交给组长审核，请耐心等待");
							else if(data.result=="login")
								alertify.error("尚未登录，无法上传资源！");
							else
								alertify.error("网络错误，请稍后再试！");
						}
					});
				}
			}
			else {
				var file_name = $('#file_name').val();
				if(resources_name.length==0 || file_name.length==0) {
					alertify.error("请输入完整的资源信息！");
					return false;
				}
				else {
					$.ajaxFileUpload({
						url : "addResourcesFile",
						type:"post",
					    data: { "resources_name":resources_name,"resources_type1":resources_type1,"resources_type2":resources_type2,"remark":remark,"file_name":file_name,"file_select":"file_select"}, 
					    secureuri:false,  
					    fileElementId:'file_select', 
					    dataType:"json",  
					    success:function (data , status) {
					    	if(data.result=="success")
								alertify.success("资源上传成功！");
					    	else if(data.result=="success_1")
								alertify.success("上传的资源已交给组长审核，请耐心等待");
							else if(data.result=="login")
								alertify.error("尚未登录，无法上传资源！");
							else
								alertify.error("网络错误，请稍后再试！");
					    },
					    error:function (data, status, e) {  
					        alertify.error("上传失败，请稍后再试");  
					    }
					});
				}
			}
		}
		
	})
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_6.jsp" %>

<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:600px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">资源分享</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">资源分享</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">资源分享</span>
        </div>
      </div>
        <div style="height:auto; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <div style="margin:40px auto 10px 40px;">
            <input placeholder="资源名称" id="resources_name" type="text" style="width:400px;">
            <select style="color:#666; width:130px;" id="type1">
              <option value="0">资源类别</option>
              <option value="1">ACM相关</option>
              <option value="2">数模相关</option>
              <option value="3">编程语言相关</option>
              <option value="4">硬件嵌入式</option>
              <option value="5">设计相关</option>
              <option value="6">其他资源</option>
            </select> 
            <select style="color:#666; width:130px;" id="type2">
              <option value="-1">资源种类</option>
              <option value="0">视频资源</option>
              <option value="1">文档资源</option>
              <option value="2">源代码</option>
            </select> 
          </div>
          <div style="margin:0 40px 0 40px; height:auto; border-bottom: solid 1px #eee; padding-bottom:5px;">
            <div class="tabbable">
              <ul class="nav nav-pills" style="margin-bottom:0;">
              <li class="active">
              <a href="#" data-toggle="tab" id="fun2">分享文件</a>
              </li>
              <li>
              <a href="#" data-toggle="tab" id="fun3">分享链接</a>
              </li>
              </ul>
              <div class="tab-content" style="height:45px;">
                <div class="tab-pane active" id="sharing_files">
                    <div style=" height:41px; width:128px; position:relative; cursor:pointer; border-radius:3px;">
                      
                      <input type="file" name="file_select" id="file_select" style="display:block;width:300px; float:left; cursor:pointer; height:30px; margin-top:8px;">
                      <input type="text" placeholder="文件名" id="file_name" style="position:absolute; left:200px; top:8px;">
                      
                    </div>
                </div>
                <div class="tab-pane" id="sharing_links">
                  <input type="text" id="link_name" placeholder="请输入链接名称" style="width:330px; margin-left:0; margin-top:5px;">
                  <input type="text" id="link_address" placeholder="请输入链接地址" style="width:330px; margin-left:25; margin-top:5px;">
                </div>
              </div>
          	</div>
          </div>
          <textarea style="margin:20px auto auto 40px ;width:705px; height:300px; resize:none;" id="remark" placeholder="资源描述"></textarea>
          <button class="btn" style="width:200px; margin:20px auto 50px 280px;" id="upload_submit">提交</button>
        </div>
    </div>
  </div>
</div>
<%@ include file="../main/common/footer.jsp" %>
</body>
</html>