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
<link href="${ctx}/css/flexigrid.css" rel="stylesheet" type="text/css" /> 
<link href="${ctx}/css/jquery.confirm.css" rel="stylesheet" type="text/css" /> 
<style type="text/css">
a{
  text-decoration: none;
  color: black;
  cursor: pointer;
}
a:hover{
  cursor: pointer;
  text-decoration: underline;
}
a:visited{
  cursor: pointer;
  color: #2B2B2B; 
}
.fun1 {display:block; height:33px; width:200px; cursor:pointer; border-radius:4px; }
#about_main_1 { 
  font:12px "Helvetica Neue",Helvetica,Arial,sans-serif;
  width:800px; 
  height:430px; 
  float:left;  
  margin-top:30px; 
  margin-left:30px;
  color: black;
}
#box{
  width: 185px;
  border-radius: 3px;
  background: none repeat scroll 0% 0% #FFF;
  margin: 20px 20px 2px 0px;
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
#grade{
  color: #696969;
  margin-right: 5px;
  float: right;
}
#author{
  color: #2B2B2B;
  float: left;
  width: 120px;
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

#user_add { float:right; height:27px; margin-top:3px; border:1px solid #999; font-size:12px; color:white; background:#71A6E4; border-radius:4px; margin-right:25px;}

</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/common/flexigrid.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jquery.confirm.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
  var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
  $('.fun1').addClass("change");
  $('#member').removeClass("change");
  $('.fun1').css(css2);
  $('#member').css(css1);
  
  
  $('.member_delete').live("click", function(){
	  var elem = $(this).closest('.item');
	  var user_id = $(this).attr("id");
      $.confirm({
          'title': '确认删除',
          'message': '你确定要删除该组员吗？删除操作无法恢复',
          'buttons': {
              'Yes': {
                  'class': 'blue',
                  'action': function(){
                      elem.slideUp();
                      
                      $.ajax({
                    	  url : "memberDelete",
                    	  type : "post",
                    	  dataType : "json",
                    	  data : { "user_id" : user_id },
                    	  success : function(data) {
                    		  if(data.result == "success") {
                    			  alertify.success("已成功删除该成员");
                    			  $('#box_outline').empty();
                    			  $.ajax({
                    				  url : "getAllMembers",
                    				  type : "post",
                    				  dataType : "json",
                    				  data : { "page":$('#page').val() },
                    				  success : function(data) {
                    					  for(var i=0;i<data.list.length;i++) {
                    						  var src = "http://localhost:8080/CippusWebProject/getImage?user_id="+data.list[i].USER_ID+"&type=0&time="+new Date().getTime();
                    						  var group = data.list[i].NUMBER.substring(2,4);
                    						  var dom = "<div id='box'><div><div>"+
                  	                        "<a href='#_same_as_title' style='text-decoration:none;'>"+
                  	                        "<img src='"+src+"' class='cover_img' alt="+data.list[i].USER_ID+"></a></div></div>"+
                  	                        "<div id='box_text'><div id='title'>"+
                  	                        "<a href='#_same_as_img_above'>"+data.list[i].NAME+"</a>"+
                  	                        "<div id='grade'><span>"+group+"</span>级</div></div><div id='from_line'>"+  
                  	                        "<div id='author'><span>"+data.list[i].USER_GROUP+"</span></div></div>"+
                  	                        "<div id='compotition'>"+
                  	                        "<span>加入:</span><span>"+data.list[i].REGISTER_TIME+"</span>&nbsp;&nbsp;<a href='#' class='member_delete' id="+data.list[i].USER_ID+">删除成员</a>"
                  	                        "</div></div></div>";
                    			              $('#box_outline').append(dom);
                    					  }
                    				  }
                    			  });
                    		  }
                    		  else
                    			  alertify.error("网络异常，请稍后再试");
                    	  }
                      });
                  }
              },
              'No': {
                  'class': 'gray',
                  'action': function(){}// Nothing to do in this case. You can as well omit the action property.
              }
          }
      });
  });
  
  $('#current').text($('#page').val());
  
  
  
  $('.cover_img').live("click", function() {
	  var user_id = $(this).attr("alt");
	  jcl.go("/CippusWebProject/member_detail?user_id="+user_id);
  });
  $('.name_detail').live("click", function() {
	  var user_id = $(this).attr("alt");
	  jcl.go("/CippusWebProject/member_detail?user_id="+user_id);
  });
  
  $('#user_add').click(function(){ jcl.go("/CippusWebProject/user_add"); });
  $('#search_submit').click(function(){ jcl.go("/CippusWebProject/user_search?name="+$('#search').val()); });
  
  $.ajax({
	  url : "searchMember",
	  type : "post",
	  dataType : "json",
	  data : { "page":$('#page').val(), "name":$('#name_search').val() },
	  success : function(data) {
		  var num = data.list.length;
		  if(num==0)
			  $('#num2').text("1");
		  else if(num%20==0)
			  $('#num2').text(parseInt(num/20));
		  else 
			  $('#num2').text(parseInt(num/20)+1);
		  for(var i=0;i<data.list.length;i++) {
			  var src = "http://localhost:8080/CippusWebProject/getImage?user_id="+data.list[i].USER_ID+"&type=0&time="+new Date().getTime();
			  var group = data.list[i].NUMBER.substring(2,4);
			  var dom = "<div id='box'><div><div>"+
                        "<a href='#_same_as_title' style='text-decoration:none;'>"+
                        "<img src='"+src+"' class='cover_img' alt="+data.list[i].USER_ID+"></a></div></div>"+
                        "<div id='box_text'><div id='title'>"+
                        "<a href='#_same_as_img_above' alt="+data.list[i].USER_ID+" class='name_detail'>"+data.list[i].NAME+"</a>"+
                        "<div id='grade'><span>"+group+"</span>级</div></div><div id='from_line'>"+  
                        "<div id='author'><span>"+data.list[i].USER_GROUP+"</span></div></div>"+
                        "<div id='compotition'>"+
                        "<span>加入:</span><span>"+data.list[i].REGISTER_TIME+"</span>&nbsp;&nbsp;<a href='#' class='member_delete' id="+data.list[i].USER_ID+">删除成员</a>"
                        "</div></div></div>";
              $('#box_outline').append(dom);
		  }
	  }
  });
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_user_bootstrap.jsp" %>
<input type="hidden" id="page" value="1">
<input type="hidden" id="name_search" value="<%=request.getParameter("name") %>" >
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:1700px; background:white;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">组内成员</span>
          <input type="button" id="user_add" value="添加成员">
        </div>
      </div>
          <div>
            <input id="search" type="text" placeholder="&nbsp;成员姓名" autocomplete="off" style="width:172px; margin-top:20px; "> 
            <button class="btn" id="search_submit" type="button" value="快速搜索" style="margin-top:8px;">搜索</button>
          </div>
          <div id="box_outline">
          <!-- 
            <div id="box" >
            <div>
                <div>
                  <a href="#_same_as_title" style="text-decoration:none;">
                  <img src="${ctx}/images/s2556434.jpg" id="cover_img">
                  </a>
                </div>
            </div>
            <div id="box_text">
              <div id="title">
                <a href="#_same_as_img_above">某某人</a>
                <div id="grade"><span>10</span>级</div>
              </div>
              <div id="from_line">  
                <div id="author">
                  <span>花旗俱乐部</span>
                </div>
              </div>
              <div id="compotition">
                <span>加入:</span><span>2014-8-8</span>&nbsp;&nbsp;<a href="#">删除成员</a>
              </div>
            </div>
          </div>
        -->

            
    </div>
    <div style="float:left; width:100%; margin:20px;"  class="input-group">
        <button class="btn" style="font-size:12px;" id="prev"> 上一页</button>
        当前页：<span id="current"></span>/<span id="num2"></span>
        <button class="btn" style="font-size:12px;" id="next"> 下一页</button>
        <input placeholder="转到" auto-complete="none"  type="text" class="input-mini" style="margin-top:10px;" id="go">
        </div>
  </div>
</div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>