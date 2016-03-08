<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="${ctx}/css/alertify.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	 var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	 var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	 $('.fun1').addClass("change");
	 $('#project_manage').removeClass("change");
	 $('.fun1').css(css2);
	 $('#project_manage').css(css1);

	 $.ajax({
		url : "getProjectByGroup",
		type : "post",
		dataType : "json",
		data : {"page":$('#page').val()},
		success : function(data) {
			var pageNum;
			if(data.num==0)
				pageNum = 1;
			else if(data.num%10==0)
				pageNum = (data.num)/10;
			else
				pageNum = parseInt((data.num)/10) + 1;
			$('#now_page').text($('#page').val());
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
	    		var current_page = $('#page').val();
	    		$('#page').val(parseInt(current_page)-1);
	    		
	    		$.ajax({
	    			url : "getProjectByGroup",
	    			type : "post",
	    			dataType : "json",
	    			data : {"page":$('#page').val()},
	    			success : function(data) {
	    				
	    				$('#now_page').text($('#page').val());

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
	    		var current_page = $('#page').val();
	    		$('#page').val(parseInt(current_page)+1);
	    		
	    		$.ajax({
	    			url : "getProjectByGroup",
	    			type : "post",
	    			dataType : "json",
	    			data : {"page":$('#page').val()},
	    			success : function(data) {
	    				
	    				$('#now_page').text($('#page').val());

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
	    
	    document.onkeydown=function(event){
	        var e = event || window.event || arguments.callee.caller.arguments[0];
	        if(e && e.keyCode==13){ 
	        	var page_go = $('#go').val();
	        	var pageTest = /^[0-9]*$/;
	        	if(!page_go.match(pageTest)) {
	        		alertify.error("页数无效！");
	        		return false;
	        	}
	        	else {
	        		var page = parseInt(page_go);
	        		var pageNum = parseInt($('#pageNum').text());
	        		if(page<1 || page>pageNum) {
	        			alertify.error("页数无效");
	        			return false;
	        		}
	        		else {
	            		$('#page').val($('#go').val());
	            		$.ajax({
	    	    			url : "getProjectByGroup",
	    	    			type : "post",
	    	    			dataType : "json",
	    	    			data : {"page":$('#page').val()},
	    	    			success : function(data) {
	    	    				
	    	    				$('#now_page').text($('#page').val());

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
	        	}
	        }
	    }; 
	 
	 $('.project_title').live("click",function(){
	     var project_id = $(this).attr("id");
	     jcl.go("/CippusWebProject/project_update?project_id="+project_id);
	 });
	    
	 $('.cover_img2').live("click",function(){
	     var project_id = $(this).attr("id");
	     jcl.go("/CippusWebProject/project_update?project_id="+project_id);
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
<%@ include file="../../main/nav/nav_user_bootstrap.jsp" %>
<input type="hidden" value="1" id="page">
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:920px; background:white;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1" style="width:800px; height:960px; float:left;  margin-top:30px; margin-left:30px;">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">组内项目</span>
        </div>
        <div style="height:930px; border:1px dashed #999; margin-top:20px; border-radius:4px; font-family:'微软雅黑';">
          
          <div id="box_outline" style="margin-left:10px;">
            
            
          </div>
          
          <div style="float:left; margin-top:800px; margin-left:-20px;  class="input-group">
            <button class="btn" id="prev"> 上一页</button>
            <button class="btn" id="next"> 下一页</button>
                                          当前页：<span id="now_page"></span>/<span id="pageNum"></span>
            <input placeholder="转到" auto-complete="none" id="go" type="text" class="input-mini" style="margin-top:10px;">
          </div>
        </div>
        
      </div>
      
    </div>
  </div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>