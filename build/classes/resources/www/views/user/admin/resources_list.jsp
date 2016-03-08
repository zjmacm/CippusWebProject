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
<script type="text/javascript" src="${ctx}/js/common/flexigrid.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var css1 = {"background":"#67B6F1","color":"#FFF","border":"1px solid #67B6F1"};
	var css2 = {"background":"#FFF","color":"black","border":"1px solid #999"};
	$('.fun1').addClass("change");
	$('#resources_unaccept').removeClass("change");
	$('.fun1').css(css2);
	$('#resources_unaccept').css(css1);
	
	var grid=$("#register_list").flexigrid({  
		width: 722,
		height: 250,
		singleSelect : true,
        url: 'getResourcesUnAcceptList',
        dataType: 'json',  
        colModel : [  
                {display:"资源名称", name:"resources_name", width:300, sortable:false, align:'center'}, 
                {display:"上传者", name:"upload_user", width:80, sortable:false, align:'center'}, 
                {display:"上传时间", name:"upload_time", width:80, sortable:false, align:'center'},  
                {display:"资源类别", name :"resources_type1", width:100, sortable:false, align:'center'},  
                {display:"资源类型", name :"resources_type2", width:100, sortable:false, align:'center'}
        ],  
        buttons : [  
            {name: '查看详情', bclass: 'modify', onpress :toolbar}, 
            {name: '删除申请', bclass: 'delete', onpress :toolbar},
            {name: '接受申请', bclass: 'add', onpress : toolbar}
        ],  
          
        errormsg: '发生异常',  
        sortname: "upload_time",  
        sortorder: "desc",  
        usepager: true,  
        title: '资源发布审核列表', 
        useRp: true,  
        rp: 10,  
        rpOptions: [10], //可选择设定的每页结果数  
        nomsg: '没有符合条件的记录存在',  
        minColToggle: 1, //允许显示的最小列数  
        showTableToggleBtn: true,  
        autoload: true, //自动加载，即第一次发起ajax请求  
        resizable: false, //table是否可伸缩  
        procmsg: '加载中, 请稍等 ...',  
        pagestat: '显示记录从{from}到{to}，总数 {total} 条', 
        hideOnSubmit: true, //是否在回调时显示遮盖  
        blockOpacity: 0.5,//透明度设置  
        rowbinddata: true,  
        showcheckbox: true,
        checkbox:true,
        autoScroll:true
    });
	
	function toolbar(com,grid){
		if(com == '查看详情') {
			if($('.trSelected',grid).length == 0)
				alert('请选择要查看的数据!');
			else {
				var id = $('.trSelected', grid).attr("id").replace("row","");
                jcl.go('/CippusWebProject/getResourcesUnacceptInfo?resources_id='+id);
			}
		}
		else if(com == '删除申请') {
			if($('.trSelected',grid).length == 0)
				alert('请选择要删除的数据');
			else {
				if(confirm('是否删除这 ' + $('.trSelected',grid).length + ' 条记录吗?')){
                    var id = $('.trSelected', grid).attr("id").replace("row",""); 
                    $.ajax({
            			type : 'post',
            			url : 'resourcesRegisterDelete',
            			data : {'resources_id':id},
            			dataType : 'json',
            			success : function(data){
            			    if(data.result=='success'){
            			    	alert('已成功删除该申请！');
            			    	jcl.go('/CippusWebProject/resources_unaccept');
            			    }
            			    else {
            			    	alert('操作失败,请稍后再试！');
            			    }
            			}
            		});
				}
			}
		}
		else if(com == '接受申请'){
			if($('.trSelected',grid).length == 0){
				alert('请选择要接受的数据');
			}
			else{
				if(confirm('是否接受这' + $('.trSelected',grid).length + ' 条记录吗?')){
					var id = $('.trSelected',grid).attr("id").replace("row","");
					$.ajax({
						type : 'post',
						url : 'acceptResources',
						data : {'resources_id':id},
						dataType : 'json',
						success : function(data){
							if(data.result == 'success'){
								alert('已成功接受该申请！');
								jcl.go('/CippusWebProject/user_center');
							}
							else{
								alert('操作失败，请稍后再试！');
							}
						}
						
					});
				}
			}
		}
	}
	
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="../../main/common/top.jsp" %>
<%@ include file="../../main/nav/nav_7.jsp" %>
<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin: auto; height:450px; background:white;">
    <%@ include file="user_nav.jsp" %>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">审核申请</span>
        </div>
        <div style="height:400px; border:1px dashed #999; margin-top:20px; border-radius:4px;">
          <div style="position:relative; left:35px; top:20px;">
            <table id="register_list" style="display:none"></table>  
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="../../main/common/footer.jsp" %>
</body>
</html>