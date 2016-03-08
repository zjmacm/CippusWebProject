/**
 * 
 */
$(document).ready(function(){
	$('.change').mouseover(function(){
	    $('.change').css("background", "white");
	    $(this).css("background", "#E1EBF5");
    });
    $('.change').mouseout(function(){
	    $(this).css("background", "white");
    });
    
    $('#upload_resources').click(function(){
    	$.ajax({
    		url : "isUserLogin",
    		type : "post",
    		dataType : "json",
    		data : {},
    		success : function(data) {
    			if(data.result == "success") {
    				jcl.go("/CippusWebProject/upload_resources");
    			}
    			else {
    				alertify.error("尚未登陆，无法上传资源！");
    				return false;
    			}
    		}
    	});
    	
    });

    $('#all').click(function(){ jcl.go("/CippusWebProject/resources_all"); });
    $('#acm').click(function(){ jcl.go("/CippusWebProject/resources_acm"); });
    $('#mem').click(function(){ jcl.go("/CippusWebProject/resources_mem"); });
    $('#language').click(function(){ jcl.go("/CippusWebProject/resources_language"); });
    $('#hard').click(function(){ jcl.go("/CippusWebProject/resources_hard"); });
    $('#design').click(function(){ jcl.go("/CippusWebProject/resources_design"); });
    $('#other').click(function(){ jcl.go("/CippusWebProject/resources_other"); });
    
    $.ajax({
		url : "getResources",
		type : "post",
		dataType : "json",
		data : {"resources_type":$('#current_type').val(),"page":$('#current_page').val()},
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
			$('#resources_add').empty();
			for(var i=0;i<data.list.length;i++) {
				
				var type1;
				if(data.list[i].RESOURCES_TYPE1==1)
					type1 = "ACM相关";
				else if(data.list[i].RESOURCES_TYPE1==2)
					type1 = "数模相关";
				else if(data.list[i].RESOURCES_TYPE1==3)
					type1 = "编程语言相关";
				else if(data.list[i].RESOURCES_TYPE1==4)
					type1 = "硬件嵌入式";
				else if(data.list[i].RESOURCES_TYPE1==5)
					type1 = "设计相关";
				else if(data.list[i].RESOURCES_TYPE1==6)
					type1 = "其他资源";
				var type2;
				if(data.list[i].RESOURCES_TYPE2==0)
					type2 = "视频教程";
				else if(data.list[i].RESOURCES_TYPE2==1)
					type2 = "文档资源";
				else if(data.list[i].RESOURCES_TYPE2==2)
					type2 = "源代码";
				var upload_user = data.list[i].UPLOAD_GROUP+"-"+data.list[i].UPLOAD_USER;
				var upload_time = data.list[i].UPLOAD_TIME;
				var remark = data.list[i].REMARK;
				var dom = "<div class='resources_info' style='height:83px;'>"+
                          "<div style='float:left;width:auto;'>"+"<span id='resources_id' style='display:none;'>"+data.list[i].RESOURCES_ID+"</span>"+
                          "<span class='resources_name' id='"+data.list[i].RESOURCES_ID+"'>"+data.list[i].RESOURCES_NAME+"</span></div>"+
                          "<div style='float:right;width:auto;height:25px; line-height:35px; font-size:12px; font-family:'微软雅黑'; color:#666;'>"+
                          "<span id='resources_type2'>"+type2+"</span>"+
                          "<span id='resources_type1' style='margin-left:10px;'>"+type1+"</span>"+
                          "<span id='upload_user' style='margin-left:10px;'>"+upload_user+"</span>"+
                          "<span id='upload_time' style='margin-left:10px;'>"+upload_time+"</span>"+
                          "</div><br/><br/>"+
                          "<span style='font-family:'Helvetica'; font-size:14px; color:#666;'>"+remark+"</span>"+
                          "</div><hr style='margin-top:-15px;'/>";
				$('#resources_add').append(dom);
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
    		var current_page = $('#current_page').val();
    		$('#current_page').val(parseInt(current_page)-1);
    		$.ajax({
    			url : "getResources",
    			type : "post",
    			dataType : "json",
    			data : {"resources_type":$('#current_type').val(),"page":$('#current_page').val()},
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
    				$('#resources_add').empty();
    				for(var i=0;i<data.list.length;i++) {
    					
    					var type1;
    					if(data.list[i].RESOURCES_TYPE1==1)
    						type1 = "ACM相关";
    					else if(data.list[i].RESOURCES_TYPE1==2)
    						type1 = "数模相关";
    					else if(data.list[i].RESOURCES_TYPE1==3)
    						type1 = "编程语言相关";
    					else if(data.list[i].RESOURCES_TYPE1==4)
    						type1 = "硬件嵌入式";
    					else if(data.list[i].RESOURCES_TYPE1==5)
    						type1 = "设计相关";
    					else if(data.list[i].RESOURCES_TYPE1==6)
    						type1 = "其他资源";
    					var type2;
    					if(data.list[i].RESOURCES_TYPE2==0)
    						type2 = "视频教程";
    					else if(data.list[i].RESOURCES_TYPE2==1)
    						type2 = "文档资源";
    					else if(data.list[i].RESOURCES_TYPE2==2)
    						type2 = "源代码";
    					var upload_user = data.list[i].UPLOAD_GROUP+"-"+data.list[i].UPLOAD_USER;
    					var upload_time = data.list[i].UPLOAD_TIME;
    					var remark = data.list[i].REMARK;
    					var dom = "<div class='resources_info' style='height:83px;'>"+
    	                          "<div style='float:left;width:auto;'>"+"<span id='resources_id' style='display:none;'>"+data.list[i].RESOURCES_ID+"</span>"+
    	                          "<span class='resources_name' id='"+data.list[i].RESOURCES_ID+"'>"+data.list[i].RESOURCES_NAME+"</span></div>"+
    	                          "<div style='float:right;width:auto;height:25px; line-height:35px; font-size:12px; font-family:'微软雅黑'; color:#666;'>"+
    	                          "<span id='resources_type2'>"+type2+"</span>"+
    	                          "<span id='resources_type1' style='margin-left:10px;'>"+type1+"</span>"+
    	                          "<span id='upload_user' style='margin-left:10px;'>"+upload_user+"</span>"+
    	                          "<span id='upload_time' style='margin-left:10px;'>"+upload_time+"</span>"+
    	                          "</div><br/><br/>"+
    	                          "<span style='font-family:'Helvetica'; font-size:14px; color:#666;'>"+remark+"</span>"+
    	                          "</div><hr style='margin-top:-15px;'/>";
    					$('#resources_add').append(dom);
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
    		var current_page = $('#current_page').val();
    		$('#current_page').val(parseInt(current_page)+1);
    		$.ajax({
    			url : "getResources",
    			type : "post",
    			dataType : "json",
    			data : {"resources_type":$('#current_type').val(),"page":$('#current_page').val()},
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
    				$('#resources_add').empty();
    				for(var i=0;i<data.list.length;i++) {
    					
    					var type1;
    					if(data.list[i].RESOURCES_TYPE1==1)
    						type1 = "ACM相关";
    					else if(data.list[i].RESOURCES_TYPE1==2)
    						type1 = "数模相关";
    					else if(data.list[i].RESOURCES_TYPE1==3)
    						type1 = "编程语言相关";
    					else if(data.list[i].RESOURCES_TYPE1==4)
    						type1 = "硬件嵌入式";
    					else if(data.list[i].RESOURCES_TYPE1==5)
    						type1 = "设计相关";
    					else if(data.list[i].RESOURCES_TYPE1==6)
    						type1 = "其他资源";
    					var type2;
    					if(data.list[i].RESOURCES_TYPE2==0)
    						type2 = "视频教程";
    					else if(data.list[i].RESOURCES_TYPE2==1)
    						type2 = "文档资源";
    					else if(data.list[i].RESOURCES_TYPE2==2)
    						type2 = "源代码";
    					var upload_user = data.list[i].UPLOAD_GROUP+"-"+data.list[i].UPLOAD_USER;
    					var upload_time = data.list[i].UPLOAD_TIME;
    					var remark = data.list[i].REMARK;
    					var dom = "<div class='resources_info' style='height:83px;'>"+
    	                          "<div style='float:left;width:auto;'>"+"<span id='resources_id' style='display:none;'>"+data.list[i].RESOURCES_ID+"</span>"+
    	                          "<span class='resources_name' id='"+data.list[i].RESOURCES_ID+"'>"+data.list[i].RESOURCES_NAME+"</span></div>"+
    	                          "<div style='float:right;width:auto;height:25px; line-height:35px; font-size:12px; font-family:'微软雅黑'; color:#666;'>"+
    	                          "<span id='resources_type2'>"+type2+"</span>"+
    	                          "<span id='resources_type1' style='margin-left:10px;'>"+type1+"</span>"+
    	                          "<span id='upload_user' style='margin-left:10px;'>"+upload_user+"</span>"+
    	                          "<span id='upload_time' style='margin-left:10px;'>"+upload_time+"</span>"+
    	                          "</div><br/><br/>"+
    	                          "<span style='font-family:'Helvetica'; font-size:14px; color:#666;'>"+remark+"</span>"+
    	                          "</div><hr style='margin-top:-15px;'/>";
    					$('#resources_add').append(dom);
    				}
    				$('html, body').animate({scrollTop:0}, 'slow');
    			}
    			
    		});
    	}
    });
    
    $('#search_submit').click(function(){
    	jcl.go("/CippusWebProject/resources_search?group="+$('#search_group').val()+"&name="+$('#search_content').val());
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
            		$('#current_page').val($('#go').val());
            		$.ajax({
            			url : "getResources",
            			type : "post",
            			dataType : "json",
            			data : {"resources_type":$('#current_type').val(),"page":$('#current_page').val()},
            			success : function(data) {

            				$('#now_page').text($('#current_page').val());

            				$('#resources_add').empty();
            				for(var i=0;i<data.list.length;i++) {
            					
            					var type1;
            					if(data.list[i].RESOURCES_TYPE1==1)
            						type1 = "ACM相关";
            					else if(data.list[i].RESOURCES_TYPE1==2)
            						type1 = "数模相关";
            					else if(data.list[i].RESOURCES_TYPE1==3)
            						type1 = "编程语言相关";
            					else if(data.list[i].RESOURCES_TYPE1==4)
            						type1 = "硬件嵌入式";
            					else if(data.list[i].RESOURCES_TYPE1==5)
            						type1 = "设计相关";
            					else if(data.list[i].RESOURCES_TYPE1==6)
            						type1 = "其他资源";
            					var type2;
            					if(data.list[i].RESOURCES_TYPE2==0)
            						type2 = "视频教程";
            					else if(data.list[i].RESOURCES_TYPE2==1)
            						type2 = "文档资源";
            					else if(data.list[i].RESOURCES_TYPE2==2)
            						type2 = "源代码";
            					var upload_user = data.list[i].UPLOAD_GROUP+"-"+data.list[i].UPLOAD_USER;
            					var upload_time = data.list[i].UPLOAD_TIME;
            					var remark = data.list[i].REMARK;
            					var dom = "<div class='resources_info' style='height:83px;'>"+
            	                          "<div style='float:left;width:auto;'>"+"<span id='resources_id' style='display:none;'>"+data.list[i].RESOURCES_ID+"</span>"+
            	                          "<span class='resources_name' id='"+data.list[i].RESOURCES_ID+"'>"+data.list[i].RESOURCES_NAME+"</span></div>"+
            	                          "<div style='float:right;width:auto;height:25px; line-height:35px; font-size:12px; font-family:'微软雅黑'; color:#666;'>"+
            	                          "<span id='resources_type2'>"+type2+"</span>"+
            	                          "<span id='resources_type1' style='margin-left:10px;'>"+type1+"</span>"+
            	                          "<span id='upload_user' style='margin-left:10px;'>"+upload_user+"</span>"+
            	                          "<span id='upload_time' style='margin-left:10px;'>"+upload_time+"</span>"+
            	                          "</div><br/><br/>"+
            	                          "<span style='font-family:'Helvetica'; font-size:14px; color:#666;'>"+remark+"</span>"+
            	                          "</div><hr style='margin-top:-15px;'/>";
            					$('#resources_add').append(dom);
            				}
            				$('html, body').animate({scrollTop:0}, 'slow');
            			}
            			
            		});
        		}
        	}
        }
    }; 
    
    $('.resources_name').live("click", function(){
    	var resources_id = $(this).attr("id");
    	jcl.go("/CippusWebProject/getResourcesDetail?resources_id="+resources_id);
    });
});