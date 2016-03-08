<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
a{
  text-decoration: none;
  cursor: pointer;
}
a:hover{
  cursor: pointer;
  text-decoration: underline;
}
a:visited{
  cursor: pointer;;
  color: #2B2B2B; 
}
#about_nav_2 { width:200px; margin-top:30px; }
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
#about_na bqav_2 { width:200px; margin-top:30px; }
.fun1 {display:block; height:33px; width:200px; cursor:pointer; border-radius:4px; }
#about_main_1 { 
  width:800px; 
  height:580px; 
  float:left;
  margin-top:30px;
  margin-left:30px; 
  font:12px "Helvetica Neue",Helvetica,Arial,sans-serif;
}
#box{
  width: 185px;
  border-radius: 3px;
  background: none repeat scroll 0% 0% #FFF;
  margin: 20px 12px 2px 0px;
  position: relative;
  left:0px;
  box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.3);
  float: left;
}
.cover_img{
  width: 100%;
  height: 185px;
  border-radius: 3px 3px 0px 0px;
}
#box_text{
  padding: 6px 10px 10px;
}
#title{
  color: #2B2B2B;
  height: 25px;
  margin-bottom: 12px;
  overflow:   hidden;
  font-weight: bold;
}
#from_line{
  border-bottom: 1px solid #E2E2E2;
  height:22px;
  width: 100%;
}
#from{
  color: #696969;
  margin-right: 5px;
  float: left;
}
#author{
  color: #2B2B2B;
  float: left;
}
#compotition{
  bottom: 34px;
  font-size: 11px;
  height: 25px;
  left: 10px;
  line-height: 30px;
  max-width: 160px;
  overflow: hidden;
  text-overflow:ellipsis;
  color: #696969;
  white-space: nowrap;
}
#box_outline{
  width: 820px;
  position: relative;
}
#search_for_project{
  margin: 40px 0 20px 0;
  width: 100px;
  height:20px;
  padding: 4px 4px 4px 26px;
  font-size: 13px;
  border-radius: 13px;
  height: 19px;
  background: url('${ctx}/images/search.png') no-repeat scroll 9px 8px #FFF !important; 
  border: 1px solid #ACACAC;
  border-color: #CFCFCF;
  box-shadow: 0px 4px 5px -5px rgba(0, 0, 0, 0.3) inset;
}
#upload_project { cursor:pointer; float:right; height:27px; margin-top:3px; border:1px solid #999; font-size:12px; color:white; background:#71A6E4; border-radius:4px; margin-right:25px;}
</style>
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>

<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/alertify.css">
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
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
    
    
    $('#searchSubmit').click(function(){
    	jcl.go("/CippusWebProject/project_search?group="+$('#search_group').val()+"&name="+$('#search_content').val());
    });
    
    $.ajax({
    	url : "searchProject",
    	type : "post",
    	dataType : "json",
    	data : {"page":$('#current_page').val(),"project_group":$('#group_search').val(),"project_name":$('#title_search').val()},
    	success : function(data) {
    		var pageNum;
			if(data.num==0)
				pageNum = 1;
			else if(data.num%10==0)
				pageNum = (data.num)/10;
			else
				pageNum = parseInt((data.num)/10) + 1;
			$('#now_page').text($('#current_page').val());
			$('#pageNum').text(pageNum);
			for(var i=0;i<data.list.length;i++) {
    			var project_id = data.list[i].PROJECT_ID;
    			var src = "http://localhost:8080/CippusWebProject/getProjectImage?project_id="+project_id+"&time="+new Date().getTime();
    			var dom = "<div id='box'><div><div>"+
                "<a style='text-decoration:none;' class='cover_img2' id='"+project_id+"'>"+
                "<img src='"+src+"' class='cover_img'>"+
                "</a></div></div><div id='box_text'><div id='title'>"+
                "<a href='#' class='project_title' id='"+project_id+"'>"+data.list[i].PROJECT_NAME+"</a>"+
                "</div><div id='from_line'><div id='from'>from</div>"+
                "<div id='author'><a href='#'>"+data.list[i].PROJECT_GROUP+"</a>"+
                "</div></div><div id='compotition'>"+
                "<span>"+data.list[i].REMARK1+"</span>"+
                "</div></div></div>";
                $('#box_outline').append(dom);
    		}
    	}
    });
    
    $('#prev').click(function(){
    	var current_page = $('#current_page').val();
    	if(current_page<=1) {
    		alertify.error("你已经在第一页了！");
    		return false;
    	}
    	else {
    		var current_page = $('#current_page').val();
    		$('#current_page').val(parseInt(current_page)-1);
    		$.ajax({
    	    	url : "searchProject",
    	    	type : "post",
    	    	dataType : "json",
    	    	data : {"page":$('#current_page').val(),"project_group":$('#group_search').val(),"project_name":$('#title_search').val()},
    	    	success : function(data) {
    	    		
    				$('#now_page').text($('#current_page').val());
    				$('#box_outline').empty();

    				for(var i=0;i<data.list.length;i++) {
    	    			var project_id = data.list[i].PROJECT_ID;
    	    			var src = "http://localhost:8080/CippusWebProject/getProjectImage?project_id="+project_id+"&time="+new Date().getTime();
    	    			var dom = "<div id='box'><div><div>"+
    	                "<a style='text-decoration:none;' class='cover_img2' id='"+project_id+"'>"+
    	                "<img src='"+src+"' class='cover_img'>"+
    	                "</a></div></div><div id='box_text'><div id='title'>"+
    	                "<a href='#' class='project_title' id='"+project_id+"'>"+data.list[i].PROJECT_NAME+"</a>"+
    	                "</div><div id='from_line'><div id='from'>from</div>"+
    	                "<div id='author'><a href='#'>"+data.list[i].PROJECT_GROUP+"</a>"+
    	                "</div></div><div id='compotition'>"+
    	                "<span>"+data.list[i].REMARK1+"</span>"+
    	                "</div></div></div>";
    	                $('#box_outline').append(dom);
    	    		}
    	    	}
    	    });
    	}
    });
    
    $('#next').click(function(){
    	var current_page = $('#current_page').val();
    	var pageNum = $('#pageNum').text();
    	if(current_page>=pageNum) {
    		alertify.error("你已经在最后一页了！");
    		return false;
    	}
    	else {
    		var current_page = $('#current_page').val();
    		$('#current_page').val(parseInt(current_page)+1);	
    		$.ajax({
    	    	url : "searchProject",
    	    	type : "post",
    	    	dataType : "json",
    	    	data : {"page":$('#current_page').val(),"project_group":$('#group_search').val(),"project_name":$('#title_search').val()},
    	    	success : function(data) {
    	    		
    				$('#now_page').text($('#current_page').val());
    				$('#box_outline').empty();

    				for(var i=0;i<data.list.length;i++) {
    	    			var project_id = data.list[i].PROJECT_ID;
    	    			var src = "http://localhost:8080/CippusWebProject/getProjectImage?project_id="+project_id+"&time="+new Date().getTime();
    	    			var dom = "<div id='box'><div><div>"+
    	                "<a style='text-decoration:none;' class='cover_img2' id='"+project_id+"'>"+
    	                "<img src='"+src+"' class='cover_img'>"+
    	                "</a></div></div><div id='box_text'><div id='title'>"+
    	                "<a href='#' class='project_title' id='"+project_id+"'>"+data.list[i].PROJECT_NAME+"</a>"+
    	                "</div><div id='from_line'><div id='from'>from</div>"+
    	                "<div id='author'><a href='#'>"+data.list[i].PROJECT_GROUP+"</a>"+
    	                "</div></div><div id='compotition'>"+
    	                "<span>"+data.list[i].REMARK1+"</span>"+
    	                "</div></div></div>";
    	                $('#box_outline').append(dom);
    	    		}
    				$('html, body').animate({scrollTop:0}, 'slow');
    	    	}
    	    });
    	}
    });
});
</script>
</head>

<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_5.jsp" %>
<input type="hidden" id="current_page" value="1">
<input type="hidden" id="group_search" value="<%=request.getParameter("group") %>">
<input type="hidden" id="title_search" value="<%=request.getParameter("name") %>">
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin: auto; height:750px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">项目展示</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1 change" id="project1" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">已完成的项目</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="project2" style="background:#FFF;color:black;border:1px solid #999;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">正在进行的项目</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="project3" style="background:#FFF;color:black;border:1px solid #999;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">正在准备的项目</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>

    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">项目搜索</span>
          <input type="button" class="but_tj" id="upload_project" value="发布项目">
        </div>
        <div style="height:800px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
        <select style="float:left; margin:20px 0px 0px 20px; width:185px;" id="search_group" class="form-control" >
          <option value="0">选择作品组别</option>
          <option value="ACM组">ACM组</option>
          <option value="数模组">数模组</option>
          <option value="智能车组">智能车组</option>
          <option value="嵌入式组">嵌入式组</option>
          <option value="创业组">创业组</option>
          <option value="花旗俱乐部">花旗俱乐部</option>
          <option value="梦创俱乐部">梦创俱乐部</option>
          <option value="微软创新俱乐部">微软创新俱乐部</option>
          <option value="腾讯俱乐部">腾讯俱乐部</option>
          <option value="螺丝工作室">螺丝工作室</option>
        </select>
        <div class="input-append" style="float:left; margin:20px 210px 0px 20px;">
          <input id="search_content" type="text" placeholder="&nbsp;查找项目名称" autocomplete="off" style="width:172px;">
          <button class="btn" type="button" id="searchSubmit">搜索</button>
        </div>
        
        <div id="box_outline" style="margin-left:10px;">
            <!-- box start 
            <div id="box" >
            <div>
                <div>
                  <a href="#_same_as_title" style="text-decoration:none;">
                  <img src="${ctx}/images/s2556434a.jpg" id="cover_img">
                  </a>
                </div>
            </div>
           <div id="box_text">
              <div id="title">
                <a href="#_same_as_img_above">比赛作品的名称</a>
              </div>
              <div id="from_line">  
                <div id="from">from</div>
                <div id="author">
                  <a href="#_link_to_certain_groups">作品组别</a>
                </div>
              </div>
              <div id="compotition">
                <span>作品要参加的比赛的名称</span>,<span>自行参与的项目</span>,<span>逗号隔开</span>
              </div>
            </div>
          </div>
           end -->

            
        </div>
        
        
      </div>
      
    </div>
        
    </div>
    
    <div style="float:left; margin-top:180px; margin-left:480px;  class="input-group">
          <button class="btn" id="prev"> 上一页</button>
          <button class="btn" id="next"> 下一页</button>
                                    当前页：<span id="now_page"></span>/<span id="pageNum"></span>
          <input placeholder="转到" auto-complete="none" id="go" type="text" class="input-mini" style="margin-top:10px;">
        </div>
  </div>
</div>

<%@ include file="../main/common/footer.jsp" %>
</body>
</html>