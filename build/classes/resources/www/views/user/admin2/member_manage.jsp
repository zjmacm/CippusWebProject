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
.fun1 {display:block; height:33px; width:200px; cursor:pointer; border-radius:4px; }
#about_main_1 { width:800px; height:430px; float:left;  margin-top:30px; margin-left:30px;}
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/ajaxfileupload.js"></script>
<link href="${ctx}/css/jquery.confirm.css" rel="stylesheet" type="text/css" /> 
<script type="text/javascript" src="${ctx}/js/common/jquery.confirm.js"></script>
<script type="text/javascript">
var isHaveAttach = 0;
$(document).ready(function(){
	var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	$('.fun1').addClass("change");
	$('#member_manage').removeClass("change");
	$('.fun1').css(css2);
	$('#member_manage').css(css1);
	
	$.ajax({
		url : "getLeaderList",
		type : "post",
		dataType : "json",
		data : {},
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
	                    				  url : "getLeaderList",
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
	$('.cover_img').live("click", function() {
        var user_id = $(this).attr("alt");
		jcl.go("/CippusWebProject/member_detail?user_id="+user_id);
	});
	$('.name_detail').live("click", function() {
	    var user_id = $(this).attr("alt");
		jcl.go("/CippusWebProject/member_detail?user_id="+user_id);
	});
	
	$('#member_search').click(function(){
		var group = $('#group_select').val();
		jcl.go("/CippusWebProject/group_member?group="+group);
	});
});
</script>
<script type="text/javascript" src="${ctx}/kindEditor/kindeditor-4.1.7/kindeditor.js"></script>
<link rel="stylesheet" href="${ctx}/kindEditor/kindeditor-4.1.7/themes/default/default.css" />
<link rel="stylesheet" href="${ctx}/kindEditor/kindeditor-4.1.7/plugins/code/prettify.css" />
<script charset="utf-8" src="${ctx}/kindEditor/kindeditor-4.1.7/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx}/kindEditor/kindeditor-4.1.7/plugins/code/prettify.js"></script>
<link href="${ctx}/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.Popup {width: 770px;height:auto;position: absolute; left:700px; top:280px;background-color: #FFF;border: 1px solid #666; border-radius:6px; z-index: 999;}
.Popup_top { height:30px; border-bottom: 1px solid #cccccc; }
.Popup_top span { font-weight:bold; dislay:block; float:left; font-size:14px; font-family:Arial, Helvetica, sans-serif; width:80px; margin-left:25px; margin-top:10px; }
.Close { position:relative; left:620px; top:10px; }
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
  width:820px;
  position: relative;
  margin-left:25px;
}
</style>

</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_user_bootstrap.jsp" %>

<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin: auto; height:auto; background:white; min-height:1300px;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">成员管理</span>
        </div>
      </div>
      <div style="height:1200px; border:1px dashed #999; margin-top:20px; border-radius:4px; ">
        <div style="height:40px; line-height:40px; margin-left:80px; margin-top:15px;">
          <span style="font-size:18px;">选择组别：</span>
          <select style="margin-top:5px; class="form-control" id="group_select">
              <option value="0">各组组长</option>
              <option value="数模组">数模组</option>
              <option value="ACM组">ACM组</option>
              <option value="嵌入式组">嵌入式组</option>
              <option value="智能车组">智能车组</option>
              <option value="创业组">创业组</option>
              <option value="花旗俱乐部">花旗俱乐部</option>
              <option value="梦创俱乐部">梦创俱乐部</option>
              <option value="腾讯俱乐部">腾讯俱乐部</option>
              <option value="微软创新俱乐部">微软创新俱乐部</option>
              <option value="螺丝工作室-运维组">螺丝工作室-运维组</option>
              <option value="螺丝工作室-设计组">螺丝工作室-设计组</option>
              <option value="螺丝工作室-开发组">螺丝工作室-开发组</option>
          </select>
          <button class="btn"  type="button" value="快速搜索" style="margin-top:-5px; margin-left:10px;" id="member_search">搜索</button>
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
	  </div>
    </div>
  </div>
</div>

<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>