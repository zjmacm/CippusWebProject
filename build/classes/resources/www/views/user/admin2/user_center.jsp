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
<script type="text/javascript">
var isHaveAttach = 0;
$(document).ready(function(){
	var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	$('.fun1').addClass("change");
	$('#news_publish').removeClass("change");
	$('.fun1').css(css2);
	$('#news_publish').css(css1);
	
	$.ajax({
        type : "post",
        url  : "delete_news_temporary",
        data : {},
        dataType: "json",
        success: function(data){
        	
        }
    });
	
	
	
	var file_num = 1;
	
	$(function(){
		//第一个参数是按钮的class属性值，第二个是被隐藏的div属性值
		popupLayer("but_tj","Popup");
		closeLayer("Close","Popup");
	});

	//我们通过点击添加或修改按钮后使当前操作的div隐藏
	//closeAdd("Popup");
	function closeAdd(targetClass){
		$("."+targetClass).hide();
		$("#spm").hide();
	} 
	
	//popup layer
	function isIE(num){
	    var num = num || "",
	    tester = document.createElement('div');
	    tester.innerHTML = '<!--[if IE ' + num + ']><i></i><![endif]-->';
	    return !!tester.getElementsByTagName('i')[0];
	}
	function popupLayer(objClass,targetClass){
	    $("."+objClass).click(function(){
	    $("#spm").show();
	    var target=$("."+targetClass);
	    var targetWidth=target.outerWidth();
	    var targetHeight=target.outerHeight();
	    if(isIE(6)){
	        $("#spm").hide();
	        //$("select").hide();
	        var top=$(document).scrollTop()+$(window).height()/2;
	        target.css({"top":top+"px"});
	        $(window).scroll(function(){
	            var top=$(document).scrollTop()+$(window).height()/2;
	            target.css({"top":top+"px"});
	        });
	    }
	    target.css({"margin-top":-parseInt(targetHeight/2)+"px","margin-left":-parseInt(targetWidth/2)+"px"});
	    target.show();
	    return false;

	    });
	}
	//隐藏div的操作
	function closeLayer(objClass,targetClass) {
	    $("."+objClass).click(function(){
	    $(this).parents("."+targetClass).hide();
	    $("#spm").hide();
	});
	}
	
	$('#add').click(function(){
		file_num++;
		var file_name = "file_name_" + file_num;
		var file = "file_" + file_num;
		var file_delete = "file_delete_" + file_num;
		var dom = "<div><input class='input-block-level' type='text' id='"+file_name+"' placeholder='附件名称' style='width:360px;  margin:10px auto 10px auto;'>"+
	              "<input type='file' style='width:200px;margin-left:4px;' id='"+file+"' name='"+file+"'/>"+
	              "<input type='button' style='margin-left:4px;' value='删除' class='file_delete' id='"+file_delete+"'>";
	    $('#file_info').append(dom);
	});
	
	$('.file_delete').live("click", function(){
		file_num--;
		$(this).parent().remove();
	});
	
	$('#file_submit').click(function(){
        $.ajax({
        	url : "makeNewsId",
        	type : "post",
        	data : {},
        	dataType : "json",
        	success : function(data) {
        		if(data.id=="failed") {
        			alert("上传失败，请重试！");
        			return false;
        		}
        		else {
        			var news_id = data.id;
        			$('#news_id').val(news_id);
        			for(var i=1;i<=file_num;i++) {
        				var file_name = "#file_name_" + i;
        				var file = "file_" + i;
        				$.ajaxFileUpload({
        				    url:"upload_attach",  
        				    type:"post",
        				    data: { "news_id":news_id, "attach_name":$(file_name).val(), "file_select":file }, 
        				    secureuri:false,  
        				    fileElementId:file, 
        				    dataType:"json",  
        				    success:function (data , status) {
                                $('.Popup').hide();
                                isHaveAttach = 1;
        				    },
        				    error:function (data, status, e) {  
        				        alert("附件上传失败！");  
        				    }
        				});
        			}
        		}
        	}
        });
	});

});
</script>
<script type="text/javascript" src="${ctx}/kindEditor/kindeditor-4.1.7/kindeditor.js"></script>
<link rel="stylesheet" href="${ctx}/kindEditor/kindeditor-4.1.7/themes/default/default.css" />
<link rel="stylesheet" href="${ctx}/kindEditor/kindeditor-4.1.7/plugins/code/prettify.css" />
<script charset="utf-8" src="${ctx}/kindEditor/kindeditor-4.1.7/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx}/kindEditor/kindeditor-4.1.7/plugins/code/prettify.js"></script>
<link href="${ctx}/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
						var type = $('#type').val();
						if(isHaveAttach == 0) {
							$.ajax({
								url : "publishNews",
								type : "post",
								dataType : "json",
								data : {"info":content,"title":title,"type":type},
								success : function(data) {
									if(data.result=="success") {
										alert("新闻发布成功");
										location.reload();
									}
									else {
										alertify.error("新闻发布失败，请重试！");
									}
								}
							})
						}
						else {
							$.ajax({
								url : "publishNews",
								type : "post",
								dataType : "json",
								data : {"info":content,"news_id":$('#news_id').val(),"title":title,"type":type},
								success : function(data) {
									if(data.result=="success") {
										alert("新闻发布成功");
										location.reload();
									}
									else {
										alertify.error("新闻发布失败，请重试！");
									}
								}
							})
						}
						
					});
				}
			});
			prettyPrint();
			
		});
		
</script>
<style type="text/css">
.Popup {width: 770px;height:auto;position: absolute; left:700px; top:280px;background-color: #FFF;border: 1px solid #666; border-radius:6px; z-index: 999;}
.Popup_top { height:30px; border-bottom: 1px solid #cccccc; }
.Popup_top span { font-weight:bold; dislay:block; float:left; font-size:14px; font-family:Arial, Helvetica, sans-serif; width:80px; margin-left:25px; margin-top:10px; }
.Close { position:relative; left:620px; top:10px; }
</style>

</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_user_bootstrap.jsp" %>
<input type="hidden" id="news_id">
<div class="Popup" style="display: none"><!-- 隐藏div -->
  <div class="Popup_top">
    <span>添加附件</span>
    <a href="#" class="Close">关闭</a>
  </div> 
  <div style="width:700px; margin:15px auto; height:auto; min-height:50px;">
    <div id="file_info">
      <div>
        <input class="input-block-level" type="text" id="file_name_1" placeholder="附件名称" style="width:360px;  margin:10px auto 10px auto;">
        <input type="file" style="width:200px;" id="file_1" name="file_1"/>
        <input type="button" value="删除" id="file_delete_1">
        <input type="button" value="继续添加" id="add">
      </div>
    </div>
    <input type="button" value="提交" id="file_submit" style="display:block; width:auto; height:30px; margin-left:13px; color:#666; background:white; border:1px solid #999; border-radius:4px; margin:25px auto;">   
  </div>
</div>

<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin: auto; height:auto; background:white; min-height:800px;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">发布新闻</span>
        </div>
      </div>
      <div style="height:auto; border:1px dashed #999; margin-top:20px; border-radius:4px; ">
		<div style="margin-left:40px; margin-top:15px;">
		  <input class="input-block-level" id="title" type="text" placeholder="新闻标题" style="width:460px;  margin:10px auto 10px auto;">
		  <select class="span2" style="margin-top:10px; margin-left:13px; color:#666;" id="type">
		  	<option value="0">中心新闻</option>
		  	<option value="1">比赛公告</option>
		  	<option value="2">团队招募</option>
		  </select>
		  <input type="button" class="but_tj" value="附件信息" style="width:auto; height:30px; margin-left:13px; color:#666; background:white; border:1px solid #999; border-radius:4px;"/>
		  <textarea id="content1" name="content1" style="width:710px; height:500px;resize: none;"></textarea>
		  <input type="button" id="submit" value="提交" style="margin:30px auto 30px 300px; width:90px; height:30px; background:#0066CC;color:white; border:none; border-radius:5px;">
		</div>        
	  </div>
    </div>
  </div>
</div>

<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>