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
#project_title_wrap{
  width: 718px;
  height:50px;
  color: #333;
  background:#F9F9F9; 
  border-bottom:1px solid #F0F0F0; 
  padding: 40px 40px 30px 40px ;
}
#project_title{
  font-weight: bold;  
  font-size: 30px;
  float: left;
  letter-spacing: 1px;
  height: 30px;
  margin: 0;
}
#project_from{
  float: left;
  margin-top:5px;
  margin-left: 10px;
}
#project_author{
  height: auto;
  float: left;
  margin-left: 3px;
}
#project_preview{
  float: left;
  height: auto;
  width: 723px; 
}
#project_pic_claim{
  position:absolute;background:none repeat scroll 0% 0% rgba(0, 0, 0, 0.75); padding:15px; color:white;
}
#project_summary{
  float: left;
  height: auto;
  width: 718px;
  padding: 20px 40px;
  display: inline;
}
#project_link{
  float: left;
  height: auto;
  width: 718px;
  padding: 20px 40px;
}
#project_download{
  float: left;
  height: auto;
  width: 718px;
  padding: 20px 40px;
}
a.project_lnk{
  font-size:20px;
  font-weight:bold;
  color:#333;
  text-decoration:none;
}
a.project_lnk:visited{
  color: #666;
  text-decoration: none;
}
a.project_lnk:hover{
  color: #999;
  text-decoration: none;
}
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/alertify.css">
<link type="text/css" rel="stylesheet" href="${ctx}/css/galleryview.css" />
<script type="text/javascript" src="${ctx}/js/func/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="${ctx}/js/func/jquery.galleryview-3.0-dev.js"></script>
<script type="text/javascript" src="${ctx}/js/func/jquery.timers-1.2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.change').mouseover(function(){
		$('.change').css("background", "white");
		$(this).css("background", "#E1EBF5");
	});
	$('.change').mouseout(function(){
		$(this).css("background", "white");
	});

	$('#project1').click(function(){ jcl.go("/CippusWebProject/project"); });
    $('#project2').click(function(){ jcl.go("/CippusWebProject/project2"); });
    $('#project3').click(function(){ jcl.go("/CippusWebProject/project3"); });
    
    $.ajax({
    	url : "getProjectInfo",
    	type : "post",
    	dataType : "json",
    	data : {"project_id":$('#project_id').val()},
    	success : function(data){
    		$('#project_name').text(data.row.PROJECT_NAME);
    		$('#project_group').text(data.row.PROJECT_GROUP);
    		$('#author').text(data.row.AUTHOR);
    		$('#remark1').text(data.row.REMARK1);
    		$('#remark2').text(data.row.REMARK2);
    		var project_link;
    		var link = data.row.PROJECT_LINK;
    		if(link.length==0) {
    			project_link = "暂无项目链接";
    			$('#link').attr("href", "#");
    		}
    		else {
    			project_link = data.row.PROJECT_LINK;
    			var link = project_link.substr(0,4);
    			if(link=="http")
    			    $('#link').attr("href", project_link);
    			else {
    				link = "http://" + project_link;
    				$('#link').attr("href", link);
    			}
    		}
    		$('#link').text(project_link);		
    		if(data.download=="success") {
    			$('#download').text("点击下载项目");
    			$('#download').attr("href", "http://localhost:8080/CippusWebProject/getProjectFileDetail?project_id="+$('#project_id').val());
    		}
    		else
    			$('#download').text("暂无下载资源");
    	}
    });
    
    $('#pic_see').click(function(){
    	$.ajax({
    		url : "isProjectHasPic",
    		type : "post",
    		dataType : "json",
    		data : {"project_id":$('#project_id').val()},
    		success : function(data) {
    			if(data.result=="failed") {
    				alertify.error("该项目目前暂无图片展示！");
    				return false;
    			}
    			else {
    				$.ajax({
    					url : "getProjectPic",
    					type : "post",
    					dataType : "json",
    					data : {"project_id":$('#project_id').val()},
    					success : function(data) {
    						$('#photos').empty();
    						for(var i=0;i<data.list.length;i++) {
    							var dom = "<li><img src='http://localhost:8080/CippusWebProject/getProjectDetail?project_id="+$('#project_id').val()+"&name="+data.list[i]+"' /> </li>";
    						    $('#photos').append(dom);
    						}
    						
    	    				$('#photos').galleryView({
    	    		            panel_width: 600,
    	    		            panel_height: 400,
    	    		            frame_width: 100,
    	    		            frame_height: 100,
    	    		            easing: 'swing',
    	    		            pause_on_hover: true,
    	    		            nav_theme: 'light',
    	    		            overlay_opacity: 0.5,
    	    		            overlay_height: 10
    	    		        });
    	    				$('#gallary').css("display","block");
    					}
    				});
    				
    			}
    		}
    	});
    });
    
    $('#close').click(function(){
    	$('#gallary').css("display","none");
    });
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_5.jsp" %>
<input type="hidden" id="project_id" value="<%=request.getParameter("project_id") %>">
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:1170px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">项目展示</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1 change" id="project1" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">已完成的项目</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="project2" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">正在进行的项目</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="project3" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">正在准备的项目</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">项目详情</span>
        </div>
        <div style="height:1100px; border:1px dashed #999; margin-top:20px; border-radius:4px; padding:0;">
          <div id="project_title_wrap">
            <div id="project_title"><span id="project_name"></span></div>
            <div style="color:#999; float:left; font-size:10px; font-weight:bold; margin-left:40px; margin-top:8px;">from</div>
            <div id="project_from"><span id="project_group"></span></div>
            <div style="width:100%; float:left; margin-top:10px; ">
              <div style="color:#999; float:left; font-size:10px; font-weight:bold; margin:0px 10px 0 5px;">by</div>
              <div id="project_author"><span id="author"></span></div>
            </div>
          </div>
          <div id="project_summary">
            <div style="font-weight:bold; font-size:12px; margin-bottom:10px; padding-top:10px;">项目目的</div>
            <div style="font-size:12px;">
               <p id="remark1"></p>
            </div>
          </div>
          <div id="project_preview">
            <div style="font-weight:bold; font-size:12px; margin:10px 40px; padding-top:10px; border-top: solid 1px #F0F0F0; width: 718px;">
              项目展示
            </div>
                <div id="myCarousel" class="carousel slide" style="width:718px;  margin: 10px 0 20px 42px;">
                  <button class="btn" type="button" id="pic_see">点击查看项目图片展示</button>
                </div>
          </div>
          <div id="project_summary">
            <div style="font-weight:bold; font-size:12px; margin-bottom:10px; border-top: solid 1px #F0F0F0; padding-top:10px;">项目介绍</div>
            <div>
              <p style="background:white; border:none; margin:0; padding:0; " id="remark2"></p>
            </div>
          </div>
          <div id="project_link">
            <div style="font-weight:bold; font-size:12px; margin-bottom:10px;   border-top: solid 1px #F0F0F0; padding-top:10px;">项目链接</div>
            <div><a href="" class="project_lnk" id="link"></a></div>
          </div>
          
          <div id="project_download">
            <div style="font-weight:bold; font-size:12px; margin-bottom:10px;   border-top: solid 1px #F0F0F0; padding-top:10px;">项目下载地址</div>
            <div><a class="project_lnk" id="download" style="cursor:pointer;"></a></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div id="gallary" style="position:absolute; top:100px; left:400px;display:none">
  <img src="${ctx}/images/close.png" id="close" style="width:20px;height:20px;cursor:pointer;position:absolute;top:0px;left:580px;z-index:1011">
  <ul id="photos" style="z-index:999">

  </ul>
</div>
<%@ include file="../main/common/footer.jsp" %>
</body>
</html>
<!-- 

$('#gallary').css("display","block");
    				$('#photos').galleryView({
    		            panel_width: 600,
    		            panel_height: 400,
    		            frame_width: 100,
    		            frame_height: 100,
    		            easing: 'swing',
    		            pause_on_hover: true,
    		            nav_theme: 'light',
    		            overlay_opacity: 0.5,
    		            overlay_height: 10
    		        });
 -->