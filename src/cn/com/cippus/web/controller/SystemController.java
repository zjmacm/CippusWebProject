package cn.com.cippus.web.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("systemController")
public class SystemController {

	@RequestMapping(value="/", method=RequestMethod.GET)
	public String getMainPage() {
		return "main/index";
	}
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String getIndexPage() {
		return "main/index";
	}
	
	@RequestMapping(value="/about", method=RequestMethod.GET)
	public String getAboutPage() {
		return "main/about";
	}
	
	@RequestMapping(value="/structor", method=RequestMethod.GET)
	public String getStructorPage() {
		return "main/about";
	}
	
	@RequestMapping(value="/introduction", method=RequestMethod.GET)
	public String getIntroductionPage() {
		return "main/introduction";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String getRegisterPage() {
		return "main/register";
	}
	
	@RequestMapping(value="/resources", method=RequestMethod.GET)
	public String getResourcesPage() {
		return "study/resources_all";
	}
	
	@RequestMapping(value="/project", method=RequestMethod.GET)
	public String getProjectPage() {
		return "project/project_index";
	}
	
	@RequestMapping(value="/group", method=RequestMethod.GET)
	public String getGroupPage() {
		return "group/group_info";
	}
	
	@RequestMapping(value="/group2", method=RequestMethod.GET)
	public String getGroup2Page() {
		return "group/group_info2";
	}
	
	@RequestMapping(value="/group3", method=RequestMethod.GET)
	public String getGroup3Page() {
		return "group/group_info3";
	}
	
	@RequestMapping(value="/contribute", method=RequestMethod.GET)
	public String getPutView() {
		return "main/contribute";
	}
	
	

}
