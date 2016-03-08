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
#cippus_intr{
  margin:10px 0;
}
#intr_sub_title{
  font-weight:bold;
}
</style>
<script type="text/javascript" src="${ctx}/js/common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/common/jcl.js"></script>
<script type="text/javascript" src="${ctx}/js/func/nav.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.change').mouseover(function(){
		$('.change').css("background", "white");
		$(this).css("background", "#E1EBF5");
	});
	$('.change').mouseout(function(){
		$(this).css("background", "white");
	});
	
	$('#structor').click(function(){ jcl.go("/CippusWebProject/structor"); });
});
</script>
</head>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">

<%@ include file="common/top.jsp" %>
<%@ include file="nav/nav_2.jsp" %>

<div style="background:#EEEEED; width:100%;">
  <div style="width:85%; min-width:1147px; margin:0 auto; height:2100px; background:white;">
    <div id="about_nav_1">
      <div id="about_tip">
        <span id="about_span_1">关于中心</span>
      </div>
      <div id="about_nav_2">
        <div class="fun1 change" id="structor" style="background:#FFF;color:black;border:1px solid #999;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">中心结构</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
        <div class="fun1" style="background:#67B6F1;color:#FFF;margin-top:8px;border:1px solid #67B6F1;">
          <span style="font-size:12px;line-height:33px;margin-left:15px;">中心简介</span>
          <span style="font-size:12px;line-height:33px;float:right;margin-right:25px;font-weight:bold;">></span>
        </div>
      </div>
    </div>
    <div id="about_main_1">
      <div style="width:100%; height:32px; background:#EEEEEE;">
        <div style="height:32px; background:url('${ctx}/images/t_bk_l.png') left no-repeat;">
          <span style="color:#FFF; font-size:12px; line-height:32px; margin-left:35px; font-family:'sans-serif'; font-weight:700;">中心简介</span>
        </div>
        <div style="height:2000px; border:1px dashed #999; margin-top:20px; border-radius:4px; font-size:12px;">
         <div style="width:720px; color:#333; margin:40px; font-family:Arial,Helvetica,sans-serif;"> 
          <p align="center" style="font-weight:bold; font-size:20px;">打造软件人才创新创业的摇篮</p>
          <p align="right">——软件学院创新实践基地建设纪实</p>
          <div style="line-height:23px;">
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;“创青春”全国大学生创业大赛全国金奖、ACM国际大学生程序设计竞赛亚洲区域赛金牌、连续第三年夺得IBM大型主机技术全国大赛冠军，2014年度获得 省级及以上奖项314人次，其中国际级奖项25项75人次，国家级奖项48项119人次。今冬的大连理工大学软件学院捷报频传，创新教育喜结硕果。</p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;这些闪光的荣耀正是软件学院十余年默默立足工程教育改革，注重学生创新教育培养的必然收获。学院以培养复合型、应用型、国际化的精英型软件人才为目标，大胆改革，始终把创新型人才培养放在重要位置，经过十多年的沉淀、完善，逐渐形成了以学生创新小组为主体、创新实践活动为纽带、创新实验项目为支撑、创新引导基金为导向、创新实践指导教师队伍为保障、创业孵化与实践为延长线的创新创业实践教学体系。</p>
          <p align="center" style="font-weight:bold;" id="intr_sub_title">协作创新，让创业团队“活”起来</p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;在学院的大力支持下，软件学院成立了创新实践基地，基地包括大学生创新中心，大学生创 业孵化基地，企业高新技术展示体验中心等，全方位的随时随地让学生感受创新的氛围，激发学生的创新热情。大学生创新中心结合软件专业特色，逐步探索、改 革、发展成为涵盖兴趣小组（ACM、数学建模、智能车、嵌入式、创业组）、校企联合创新俱乐部（微软创新俱乐部、腾讯创新俱乐部、花旗俱乐部、梦创俱乐 部）、学生创新工作室（螺丝工作室、牵机工作室）和中心事务部等四位一体的学生创新组织。在院学生的参与人数由成立之初的几十人发展到现在的500余人， 兼职指导教师参与人数也由原来的三、四人扩展到二十余人。 </p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;各兴趣小组、校企俱乐部、学生工作室以赛会友、以赛促学、以创新创业项目为驱动，广泛开展学术沙龙、前沿技术培训、科技竞赛、前沿讲座、校际交流、项目合作等活动。高年级学生为低年级学生源源不断地提供咨询与指导，“传帮带”传统得到良好的继承与发扬，团队建设高效有序。</p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;创新实践基地将每年的四月份确定为软件学院的“极客嘉年华”，推广、组织重要科技赛事校园选拔活动，为下半年大型比赛做好预选和训练工作；每年的十一月份 确定为学院的“科技文化节”，通过举办不同技术方向的竞赛等一系列活动，激发学生的创新热情，丰富校园文化生活，是软件学院学生活动中浓墨重彩的一笔。每年的“极客嘉年华”和“科技文化月”成为引爆学生创新活动的重要引擎，逐渐成为了软院“极客”切磋与交流的技术盛宴。</p> 
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;创新实践基地将每年的四月份确定为软件学院的“极客嘉年华”，推广、组织重要科技赛事校园选拔活动，为下半年大型比赛做好预选和训练工作；每年的十一月份地每年从学院大学生创新创业项目、科技竞赛作品、其他高校获奖作品中精选有代表性的优秀作品，精心筹备并集中进行实物展出与互动、视频展播，每年吸引了众多学生观看、互动，带动和引领了全院学生更广泛地参与科技创新活动。而每年不定期地邀请校友返校做专题讲座交流、邀请合作企业进行校园技术巡讲、前沿技术讲座、组织成员赴其他高校创新组织进行校际交流等等一系列活动，均助推学院学生科技创新蔚然成风。</p>
          <p id="intr_sub_title" align="center">制度保障，让创新人才“聚”起来 </p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;软件学院领导非常重视大学生创新能力培养，为了保障大学生创新、创业活动的科学、有效运行，软件学院以政策为引导、以规范促管理、用制度促发展，先后出台了《大学生创新实践中心成员管理办法》、《大连理工大学软件学院科技竞赛管理办法》、《大连理工大学软件学院创新引导基金项目管理办法》、《大连理工大学 软件学院大学生创业引导基金管理办法》、《大连理工大学软件学院大学生创业孵化基地管理细则》等文件。通过细化管理、设立学生创新创业专项支持资金、明确 奖惩条例等，不断引导、完善、规范学生创新创业活动。</p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;学院专门设立大学生创新引导基金，每年投入40万元，用于资助全院学生开展各类科技创新活动，支持并组织学生参加课外学术科技竞赛，引导有市 场潜能的科技创新成果的开发，通过政策扶持、资金投入，保障学生科技创新活动有序进行。为此，学院专门制定《大连理工大学软件学院创新引导基金项目管理办 法》，保证基金项目发挥最大效用，规范立项工作，使其扎实、高效、有序、健康地开展。自2012年引导基金设立以来，共已资助大学生创新项目12项，在创 新导师的指导下，项目完成情况良好。一些项目积极备战微软“创新杯”、“挑战杯”、“Intel杯”、IBM大赛、OpenHW开源硬件与嵌入式大赛等全 国大型赛事，甚至在2012年嵌入式物联网设计大赛中获得一等奖、在2012-2014年IBM大型主机全国应用大赛中取得三连冠、在2014年“创青 春”全国大学生创业大赛中获得全国金奖；还有一部分受资助的项目经过不断完善和市场检验，逐渐转化为“微云盘”、“Beannote”云笔记、 “BeanReader”微博阅读器等真真正正的学生创业项目。</p>
          <p id="intr_sub_title" align="center">创业孵化，让创新创业“实”起来</p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;基于学院浓郁的学生创新氛围和IT业本身具有的智能开发、创意创作、个体与团队作业相 结合、工作场所与时间不局限、最易通过自主创业解决就业问题等行业特点，为了将学生的创新成果“化蛹为蝶”，为创新创业搭建更广阔的舞台，大学生创业孵化 基地应运而生。截止目前，由大学生注册的企业已有12家，这些公司经营的产品涉及移动互联网、嵌入式平台、游戏、软件评测平台等领域。孵化基地通过为企业 提供免费办公场地、定期举行企业座谈会、建立创业导师库、邀请企业家进行创业深度培训、与知名校友建立广泛联系等，为企业提供了一系列配套支持。</p>
                    <img src="${ctx}/images/cippus_photo.jpg" style="width:680px; margin:20px 0 20px 20px;" align="cente;" />
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;十余载乘风破浪，十余载披荆斩棘，十余载豪情尽情挥洒，十余载青春淋漓绽放。在学院全体师生的共同努力下，学院学生参与创新创业的热情不断高涨，学生在科技创新、创业方面取得了令人可喜的成绩。</p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;近年来，以学生为第一作者发表的高水平学术论文达30余篇；学生共成功申请国家专利100余项；全院学生自主申报的“大学生创新创业训练项目”年均100 余项，学生参与国家级、省级、校级等各类创新创业项目的比例占全院学生的50%以上；学院学生在传统竞赛上一直保持优势地位，比赛成绩奖次呈上升趋势，保 持了良好的势头，近年来，学生获得各类国际级奖项200余人次，国家级奖项400余人次，省级奖项400余人次。其中在ACM/ICPC亚洲区预选赛摘得 金牌1次，银牌21人次，获国际大学生数学建模竞赛一二等奖74项222人次，全国大学生数学建模竞赛一二等奖25项75人次，在2012年全国嵌入式物 联网设计大赛中获得一等奖，在2012年、2013年2014年IBM大型主机全国应用大赛中取得三连冠，在2014年“创青春”全国大学生创业大赛中获 得全国金奖，取得我校在该项赛事上金奖零的突破</p>
          <p id="cippus_intr">&nbsp;&nbsp;&nbsp;&nbsp;学院大学生创新实践中心和创业孵化基地不断发展壮大，创新创业氛围日益浓厚，一批批创新、创业学子也从这里涌现。十余年来，从创新创业组织中共走出一千余名优秀软件学子，其中约有20%的成员赴清华、北大等国内外知名高校继续深造，其余多数学生被百度、阿里、腾讯、微软、亚马逊等国内外知名软件公司录用，不少学生已成为企业的技术骨干，部分成员毕业后自主创业，逐渐成为行业的佼佼者。</p>
			   </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="common/footer.jsp" %>
</body>
</html>