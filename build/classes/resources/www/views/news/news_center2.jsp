<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/alertify.css">
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
a{
  text-decoration: none;
}
td{
  background-color: #EEEEEE;
}
table{
  cellspacing:10px;
  width: 715px;
}
tr{
  background-color: #EEEEEE;
  line-height: 30px;
}
#news_date{
  width: 100px;
  height: 30px;
  padding: 0 0 0 10px;
  border:solid 1px white;
}
#news_from{
  width: 115px;
  height: 30px;
  padding: 0 0 0 10px;
    border:solid 1px white;
}
#news_title{
  width: 500px;
  height: 30px;
  padding: 0 0 0 20px;
  border:solid 1px white;
}
.news_title { padding-left:10px; cursor:pointer; }
.news_title:hover { color:blue; text-decoration:underline; }
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<script type="text/javascript">
$(document).ready(function(){
	$('.change').mouseover(function(){
		$('.change').css("background", "white");
		$(this).css("background", "#E1EBF5");
	});
	$('.change').mouseout(function(){
		$(this).css("background", "white");
	});

	$('#news_1').click(function(){ jcl.go("/CippusWebProject/news"); });
	$('#news_2').click(function(){ jcl.go("/CippusWebProject/news_game"); });
	$('#news_3').click(function(){ jcl.go("/CippusWebProject/news_team"); });
	
	$.ajax({
		url : "getNewsList",
		type : "post",
		dataType : "json",
		data : {"page":$('#current_page').val(),"type":$('#current_type').val()},
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
			$('#news_info').empty();
			for(var i=0;i<data.list.length;i++) {
				var dom = "<tr>"+
                          "<td id='"+data.list[i].NEWS_ID+"' class='news_title'>"+data.list[i].TITLE+"</td>"+
                          "<td id='news_date'>"+data.list[i].PUBLISH_TIME+"</td>"+
                          "<td id='news_from'>"+data.list[i].PUBLISH_NAME+"</td>"+
                          "</tr>";
				$('#news_info').append(dom);
			}
			
		}
	});
	
	$('.news_title').live("click", function() {
		var news_id = $(this).attr("id");
		jcl.go("/CippusWebProject/getNewsInfo?news_id="+news_id);
	});
	
	$('#prev').click(function(){
    	var current_page = $('#current_page').val();
    	if(current_page==1) {
    		alertify.error("你已经在第一页了！");
    		return false;
    	}
    	else {
    		var current_page = $('#current_page').val();
    		$('#current_page').val(parseInt(current_page)-1);
    		$.ajax({
    			url : "getNewsList",
    			type : "post",
    			dataType : "json",
    			data : {"page":$('#current_page').val(),"type":$('#current_type').val()},
    			success : function(data) {
    				$('#now_page').text($('#current_page').val());
    				$('#news_info').empty();
    				for(var i=0;i<data.list.length;i++) {
    					var dom = "<tr>"+
    	                          "<td id='"+data.list[i].NEWS_ID+"' class='news_title'>"+data.list[i].TITLE+"</td>"+
    	                          "<td id='news_date'>"+data.list[i].PUBLISH_TIME+"</td>"+
    	                          "<td id='news_from'>"+data.list[i].PUBLISH_NAME+"</td>"+
    	                          "</tr>";
    					$('#news_info').append(dom);
    				}
    			}
    		});
    	}
    });
    
    $('#next').click(function(){
    	var current_page = $('#current_page').val();
    	var pageNum = $('#pageNum').text();
    	if(current_page==pageNum) {
    		alertify.error("你已经在最后一页了！");
    		return false;
    	}
    	else {
    		var current_page = $('#current_page').val();
    		$('#current_page').val(parseInt(current_page)+1);
    		$.ajax({
    			url : "getNewsList",
    			type : "post",
    			dataType : "json",
    			data : {"page":$('#current_page').val(),"type":$('#current_type').val()},
    			success : function(data) {
    				$('#now_page').text($('#current_page').val());
    				$('#news_info').empty();
    				for(var i=0;i<data.list.length;i++) {
    					var dom = "<tr>"+
    	                          "<td id='"+data.list[i].NEWS_ID+"' class='news_title'>"+data.list[i].TITLE+"</td>"+
    	                          "<td id='news_date'>"+data.list[i].PUBLISH_TIME+"</td>"+
    	                          "<td id='news_from'>"+data.list[i].PUBLISH_NAME+"</td>"+
    	                          "</tr>";
    					$('#news_info').append(dom);
    				}
    				$('html, body').animate({scrollTop:0}, 'slow');
    			}
    		});
    	}
    });
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_4.jsp" %>
<input type="hidden" id="current_page" value="1">
<input type="hidden" id="current_type" value="1">
<div style="background:#EEEEED;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:600px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">综合新闻</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1 change" id="news_1" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">中心新闻</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">比赛公告</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="news_3" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">团队招募</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">中心新闻</span>
        </div>
        <div style="height:520px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
        <div class="input-append" style="margin:20px 0 0 20px;">
          <input class="span2" id="appendInputButton" type="text" placeholder="&nbsp;按标题搜索" style="width:250px">
          <button class="btn" type="button">搜索</button> 
        </div>
        <div style="margin:25px 40px 0 40px;">
        <table  data-toggle="table">
          <tbody id="news_info">
          <!-- 
            <tr>
              <td id="news_title">asdfasdfasdf</td>
              <td id="news_date">adsf</td>
              <td id="news_from">asdf</td>
            </tr>
          -->
          </tbody>
        </table>
        </div>
        <div style="float:left; margin:20px 0 20px 180px;"  class="input-group">
        <button class="btn" id="prev"> 上一页</button>
        <button class="btn" id="next"> 下一页</button>
        当前页：<span id="now_page">1</span>/<span id="pageNum">N</span>
        <input placeholder="转到" auto-complete="none"  type="text" class="input-mini" style="margin-top:10px;">
        </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../main/common/footer.jsp" %>
</body>
</html>