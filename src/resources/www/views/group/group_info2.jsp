<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
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
#project_title_wrap{
  width: 718px;
  height:50px;
  color: #333;
  background:#F9F9F9; 
  border-bottom:1px solid #F0F0F0; 
  padding: 40px 40px 30px 40px ;
}
#project_title{
  font-weight: bold;  
  font-size: 30px;
  float: left;
  letter-spacing: 1px;
  height: 30px;
  margin: 0;
}
#project_from{
  float: left;
  margin-top:5px;
  margin-left: 10px;
}
#project_author{
  height: auto;
  float: left;
  margin-left: 3px;
}
#project_preview{
  float: left;
  height: auto;
  width: 723px; 
}
#project_pic_claim{
  position:absolute;background:none repeat scroll 0% 0% rgba(0, 0, 0, 0.75); padding:15px; color:white;
}
#project_summary{
  float: left;
  height: auto;
  width: 718px;
  padding: 20px 40px;
  display: inline;
}
#project_link{
  float: left;
  height: auto;
  width: 718px;
  padding: 20px 40px;
}
a.lnk{
  margin-right:10px; 
  color:#333;
}
a.lnk:hover{
    text-decoration: none;
}
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/bootstrap.min.css">
<script type="text/javascript" src="${ctx}/js/common/bootstrap.min.js"></script>


<script type="text/javascript">
$(document).ready(function(){
	$('.change').mouseover(function(){
		$('.change').css("background", "white");
		$(this).css("background", "#E1EBF5");
	});
	$('.change').mouseout(function(){
		$(this).css("background", "white");
	});
	
	
	$('#group_cippus_1').click(function(){ jcl.go("/CippusWebProject/group"); });
	$('#group_cippus_2').click(function(){ jcl.go("/CippusWebProject/group2"); });
	$('#group_cippus_3').click(function(){ jcl.go("/CippusWebProject/group3"); });
	
	$('.citi').click(function(){
		$('#fun4').css("height","1500px");
		$('#fun5').css("height","1600px");
	});
	
	$('.qq').click(function(){
		$('#fun4').css("height","1500px");
		$('#fun5').css("height","1600px");
	});
	
	$('.dreamart').click(function(){
		$('#fun4').css("height","1500px");
		$('#fun5').css("height","1600px");
	});
	
	$('.micro').click(function(){
		$('#fun4').css("height","3500px");
		$('#fun5').css("height","3600px");
	});
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0" style="background:#EEEEED;">

<%@ include file="../main/common/top.jsp" %>
<%@ include file="../main/nav/nav_3.jsp" %>

<div style="background:#EEEEED; width:100%;">
  <div id="fun5" style="width:85%; min-width:1147px; margin:0 auto; height:1600px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">项目展示</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1 change" id="group_cippus_1" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">兴趣小组</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1" id="group_cippus_2" style="background:#67B6F1;color:#FFF;border:1px solid #67B6F1;margin-top:8px;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">创新俱乐部</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1 change" id="group_cippus_3" style="background:#FFF;color:black;margin-top:8px;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">螺丝工作室</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">兴趣小组</span>
        </div>
        <div id="fun4" style="height:1500px; border:1px dashed #999; margin-top:20px; border-radius:4px; padding:0;">
          <div class="tabbable">
          <ul class="nav nav-pills" style="font-weight:bold; margin:30px auto 20px 40px;">
            <li class="active" style="width:160px;">
              <a href="#citi" data-toggle="tab" class="citi">花旗俱乐部</a>
            </li>
            <li style="width:160px;">
              <a href="#dreamart" data-toggle="tab" class="dreamart">梦创俱乐部</a>
            </li>
            <li style="width:160px;">
              <a href="#qq" data-toggle="tab" class="qq">腾讯俱乐部</a>
            </li>
            <li style="width:160px;">
              <a href="#micro" data-toggle="tab" class="micro">微软创新俱乐部</a>
            </li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="citi"  style="padding:20px;">
            <img src="${ctx}/images/citi.png" style="width:200px;; height:100px; margin-left:250px;">
            <p style="text-indent:2em;margin-left:20px;margin-top:25px; font-family:'微软雅黑'">花旗俱乐部的前身是大连理工大学软件学院创新实践中心金融信息化组与渤海黑山科创团队，俱乐部致力于金融信息化领域的商用软件开发，目前已经与多个校内科创团队、校外创业公司取得合作，并在商务智能领域斩获颇丰。</p>
            <p style="text-indent:2em;margin-left:20px;margin-top:15px; font-family:'微软雅黑'">俱乐部目前有大三成员6人，大二成员10人，大一成员20余人。我们的宗旨是让组员在掌握过硬的专业技能的同时，了解目前的金融形势，为IT与金融行业输送优秀的复合型人才。</p>
            <img src="${ctx}/images/citi_member.jpg">
            <p style="text-indent:2em;margin-left:20px;margin-top:25px; font-family:'微软雅黑'">俱乐部主要参加的比赛包括“花旗杯——金融创新应用大赛”、“IBM——大学生软件创新大赛”等赛事，近年来不断取得优异的比赛成绩。部分奖项如下：</p>
            <p style="text-indent:2em;margin-left:35px;margin-top:10px; font-family:'微软雅黑'"> 2012-2014年 IBM大型主机技术全国大赛 三连冠</p>
            <p style="text-indent:2em;margin-left:35px;margin-top:10px; font-family:'微软雅黑'">2013、2014年“花旗杯”全国总决赛三等奖</p>
            <p style="text-indent:2em;margin-left:35px;margin-top:10px; font-family:'微软雅黑'">2014年“工商银行杯”全国总决赛二等奖</p>
            <p style="text-indent:2em;margin-left:35px;margin-top:10px; font-family:'微软雅黑'">2014年“IBM POWER”全国总决赛三等奖</p>
            <p style="text-indent:2em;margin-left:20px;margin-top:25px; font-family:'微软雅黑'">俱乐部的创新项目、参赛作品等主要涉及到金融安全、信贷风险、电子商务等主题，使用的主要技术为Java EE平台、Android移动端开发、MySQL、MongoDB数据库等。2014年花旗杯参赛作品<span style="color:blue">“优创智融——大数据下的风量量化与实时自动化处理的供应链融资平台”</span>介绍如下：</p>
            <img src="${ctx}/images/citi_project1.jpg" style="margin-left:25px;margin-top:15px;width:300px;height:230px;">
            <img src="${ctx}/images/citi_project2.jpg" style="margin-left:95px;margin-top:15px;width:300px;height:230px;">
            <p style="text-indent:2em;margin-left:20px;margin-top:25px; font-family:'微软雅黑'">优创智融是一款为银行量身定制的、及Web与PC客户端与一体的新型融资平台，通过大数据技术，队企业及上下游配套企业的相关指标进行整合分析处理，得到企业的信息等级，从而量化其贷款融资风险。其外，其自动化处理的功能也将企业的融资申请、银行的操作等变得更加便捷。</p>
            <p style="text-indent:2em;margin-left:20px;margin-top:25px; font-family:'微软雅黑'">项目要点：<span style="font-size:bold">供应链融资&nbsp;&nbsp;&nbsp;一站式服务&nbsp;&nbsp;&nbsp;实时自动化监控</span></p>
            <p style="text-indent:2em;margin-left:20px;margin-top:15px; font-family:'微软雅黑'">技术要点：<span style="font-size:bold">Hadoop&nbsp;&nbsp;&nbsp;MongoDB&nbsp;&nbsp;&nbsp;Java EE</span></p>
            <h3 align="center" style="margin-top:45px;">花旗俱乐部欢迎你的加入</h3>
            </div>
            <div class="tab-pane" id="dreamart">
            	<div>dreamart</div>
            </div>
            <div class="tab-pane" id="qq"><%@ include file="qq.jsp" %>
            </div>
            <div class="tab-pane" id="micro">
                 <div class="tab-pane" id="qq"><%@ include file="groups_info_microsoft.jsp" %>
            </div>
           
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