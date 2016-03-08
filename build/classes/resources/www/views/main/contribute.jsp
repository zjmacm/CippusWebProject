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
	
});
</script>
<script type="text/javascript" src="${ctx}/kindEditor/kindeditor-4.1.7/kindeditor.js"></script>
<link rel="stylesheet" href="${ctx}/kindEditor/kindeditor-4.1.7/themes/default/default.css" />
<link rel="stylesheet" href="${ctx}/kindEditor/kindeditor-4.1.7/plugins/code/prettify.css" />
<script charset="utf-8" src="${ctx}/kindEditor/kindeditor-4.1.7/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx}/kindEditor/kindeditor-4.1.7/plugins/code/prettify.js"></script>
<script>

		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="content1"]', {
				cssPath : '${ctx}/kindEditor/kindeditor-4.1.7/plugins/code/prettify.css',
				uploadJson : 'upload_json',
				fileManagerJson : 'file_manager_json',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					$('#submit').click(function(){
						
						var content = editor1.html();
						var title = $('#title').val();
						$.ajax({
							url : "publishContribute",
							type : "post",
							dataType : "json",
							data : {"content":content,"title":title},
							success : function(data) {
								if(data.result=="success") {
									alert("投稿成功");
									location.reload();
								}
								else {
									alertify.error("投稿失败，请重试！");
								}
							}
						});
					});
				}
			});
			prettyPrint();
			
		});
		
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_0_bootstrap.jsp" %>
<div style="background:#EEEEED;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:900px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">我要投稿</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">我要投稿</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
        <div style="width:100%; height:32px; background:#EEEEEE;">
          <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
            <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">投稿</span>
          </div>
          <div style="height:800px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <div style="margin-top:25px;margin-left:40px;">
            <input class="input-block-level" id="title" type="text" placeholder="稿件标题" style="width:460px;  margin:10px auto 10px auto;">
            <textarea id="content1" name="content1" style="width:710px; height:650px;resize: none;"></textarea>
		    <input type="button" id="submit" value="提交" style="margin:30px auto 30px 300px; width:90px; height:30px; background:#0066CC;color:white; border:none; border-radius:5px;">
          </div>
          </div>
        </div>
    </div>
  </div>
</div>

<%@ include file="../main/common/footer.jsp" %>
</body>
</html>