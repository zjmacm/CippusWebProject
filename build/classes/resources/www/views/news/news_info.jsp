<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<style type="text/css">
#about_nav_1 { width:200px; height:300px; min-height:300px; float:left; margin-left:30px; margin-top:30px; }
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
#about_main_1 { width:800px; height:1300px; float:left;  margin-top:30px; margin-left:30px;}
#news_title { display:block; width:auto; text-align:center; font-size:24px; font-weight:bold; margin-top:15px;}
.atta { cursor:pointer; }
a:hover { color:red; }
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/news.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<script type="text/javascript">
var current_page = 1;
var current_type = 0;
$(document).ready(function(){
	var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	$('.change').mouseover(function(){
		$(this).css(css1);
	});
	$('.change').mouseout(function(){
		$(this).css(css2);
	});
	
	$('#news_1').click(function(){ jcl.go("/CippusWebProject/news"); });
	$('#news_2').click(function(){ jcl.go("/CippusWebProject/news_game"); });
	$('#news_3').click(function(){ jcl.go("/CippusWebProject/news_team"); });
	
	$.ajax({
		url : "getNewsDetail",
		type : "post",
		dataType : "json",
		data : {"news_id":$('#news_id').val()},
		success : function(data) {
			$('#news_title').text(data.row.TITLE);
			$('#publish_time').text(data.row.PUBLISH_TIME);
			$('#publish_name').text(data.row.PUBLISH_NAME);
			$('#focus').text(data.row.FOCUS);
			$('#content').html(data.row.CONTENT);
			var attachment = data.row.ATTACHMENT;
			if(attachment==1) {
				var file = data.row.FILE;
				var strs= new Array();
				strs = file.split("#");
				for(var i=0;i<strs.length;i++) {
					var array = new Array();
					array = strs[i].split("=");

					var dom = "<a href='http://localhost:8080/CippusWebProject/getFileDetail?news_id="+$('#news_id').val()+"&name="+array[1]+"' class='atta' style='line-height:38px;color:#0646C9; text-decoration:underline;'>"+array[0]+"</a><br/>";
				    $('#attachment').append(dom);

				}
			}
		}
	});
	
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_4.jsp" %>
<input type="hidden" id="news_id" value="<%=request.getParameter("news_id") %>">
<input type="hidden" id="path" value="request.getSession().getServletContext().getRealPath('/WEB-INF/news/');">
<div style="background:#EEEEED;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:1200px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">综合新闻</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1 change" id="news_1" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">中心新闻</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="news_2" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
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
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">新闻详情</span>
        </div>
        <div style="height:1200px; padding-bottom:25px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <span id="news_title"></span>
          <div id="info1" style="width:auto;margin:8px auto; text-align:center; font-size:14px; font-weight:bold; color:#333;">
            <span style="">发布时间：</span><span id="publish_time"></span>
            <span style="margin-left:18px;">发布人：</span><span id="publish_name"></span>
            <span style="margin-left:18px;">点击量：</span><span id="focus"></span>
          </div>
          <div style="width:750px;margin:45px auto;height:1100px;">
            <div id="content">
            </div>
            <div id="attachment" style="margin-top:25px; color:#0646C9; margin-left:50px;">
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="../main/common/footer.jsp" %>
</body>
</html>