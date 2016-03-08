<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
li { display:block;
     width:130px; 
     height:42px; 
     line-height:42px; 
     list-style:none; 
     float:left; 
     text-align:center;
     cursor:pointer; 
     letter-spacing:3px;
     margin-left:1px;
}
</style>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<div style="background:#EEEEED; width:100%; height:42px;">
  <div style="width:85%; min-width:1147px; height:42px; margin:-1px auto; background:#1E4A9E;">
    <div style="width:1024px; margin:-17px auto; height:42px;">
      <ul style="list-style:none;">
        <li id="main" class="fun" style="background:url('${ctx}/images/bg_nav_2.png'); color:white; font-size:18px;">首页</li>
        <li id="about" class="fun" id="about" style="background:url('${ctx}/images/bg_nav_2.png'); color:white; font-size:18px;">关于中心</li>
        <li class="fun" id="group" style="background:url('${ctx}/images/bg_nav_2.png'); color:white; font-size:18px;">组内风采</li>
        <li class="fun" id="news" style="background:url('${ctx}/images/bg_nav_2.png'); color:white; font-size:18px;">综合新闻</li>
        <li class="fun" id="project" style="background:url('${ctx}/images/bg_nav_2.png'); color:white; font-size:18px;">项目展示</li>
        <li class="fun" id="resources" style="background:url('${ctx}/images/bg_nav_2.png'); color:white; font-size:18px;">学习资源</li>
        <li class="fun" id="user" style="background:url('${ctx}/images/bg_nav_2.png'); color:white; font-size:18px;">用户中心</li>
      </ul>
    </div>
  </div>
</div>

</body>
</html>