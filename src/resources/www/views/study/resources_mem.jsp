<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>
<style type="text/css">
#upload_resources { cursor:pointer; float:right; height:27px; margin-top:3px; border:1px solid #999; font-size:12px; color:white; background:#71A6E4; border-radius:4px; margin-right:25px;}
#about_nav_1 { width:200px; height:900px; float:left; margin-left:30px; margin-top:30px; }
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
#about_main_1 { width:800px; height:900px; float:left;  margin-top:30px; margin-left:30px;}
.resources_name { color:#4183C4; font-family:'Helvetica';font-size:20px;font-weight:bold; cursor:pointer; }
.resources_name:hover { text-decoration:underline; }
#resources_page { width:480px; height:30px; position:relative; left:150px; }
.page_button { width:60px; height:30px; border:1px solid #666; cursor:pointer; border-radius:2px; outline:none; background:#FFF; color:#666; }
.page_button:hover { background:#FAFAFA;}
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/func/resources.js"></script>
<script type="text/javascript" src="${ctx}/js/func/alertify.js"></script>
<link href="${ctx}/css/alertify.css" rel="stylesheet" type="text/css" />
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_6.jsp" %>
<input type="hidden" id="current_page" value="1"/>
<input type="hidden" id="current_type" value="2"/>
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:1180px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">学习资源</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1 change" id="all" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">全部资源</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="acm" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">ACM相关</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">数模相关</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="language" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">编程语言相关</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="hard" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">硬件嵌入式相关</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="design" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">设计相关</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="other" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">其他资源</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:900;">学习资料</span>
          <input type="button" class="but_tj" id="upload_resources" value="上传资源">
        </div>
       
        <div style="height:1100px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <div style="width:100%; float:left;">
            <select style="float:left; margin-top:20px; margin-left:20px; class="form-control" id="search_group">
              <option value="0">选择资源组别</option>
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
            <input id="search_content" type="text" placeholder="&nbsp;查找资源名称" autocomplete="off" style="width:172px; margin-top:20px; margin-left:20px;"> 
            <button class="btn" id="search_submit"  type="button" value="快速搜索" style="margin-top:8px;">搜索</button>
            <div style="width:75%; margin:45px auto; height:auto;" id="resources_add"></div>
          <!-- 
            <div class="resources_info" style="height:83px;">
              <div style="float:left;width:auto;">
                <span id="resources_name">疯狂Java讲义</span>
              </div>
              <div style="float:right;width:auto;height:25px; line-height:35px; font-size:12px; font-family:'微软雅黑'; color:#666;">
                <span id="resources_type2">视频教程</span>
                <span id="resources_type1" style="margin-left:10px;">编程语言</span>
                <span id="upload_user" style="margin-left:10px;">花旗俱乐部-张明宇</span>
                <span id="upload_time" style="margin-left:10px;">2015-02-17</span>
              </div>
              <br/><br/>
              <span style="font-family:'Helvetica'; font-size:14px; color:#666;">Language Savant. If your repository's language is being reported incorrectly, send us a pull request! </span>
            </div>
           -->
          </div>
          
          <div style="float:left; width:100%; margin-left:180px;"  class="input-group">
        <button class="btn" style="font-size:12px;" id="prev"> 上一页</button>
        当前页：<span id="now_page"></span>/<span id="pageNum"></span>
        <button class="btn" style="font-size:12px;" id="next"> 下一页</button>
        <input placeholder="转到" auto-complete="none"  type="text" class="input-mini" style="margin-top:10px;" id="go">
        </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../main/common/footer.jsp" %>
</body>
</html>