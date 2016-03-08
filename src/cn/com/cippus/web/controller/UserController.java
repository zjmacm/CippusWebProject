package cn.com.cippus.web.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cn.com.cippus.web.service.UserService;
import cn.com.cippus.web.view.Model;

@Controller("userController")
public class UserController {
	
	@Autowired
	private UserService userService;

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping(value="/userLogin", method=RequestMethod.POST)
	public Model userLogin(@RequestParam Map<String, Object> reqs, HttpSession session) {
		Model model = new Model();
		if(!reqs.containsKey("number") || !reqs.containsKey("password")) {
			model.set("result", "failed");
		}
		else {
			Map<String, Object> user = userService.userLogin(reqs);
			if(user.get("result").toString().equals("success")) {
				model.set("result", "success");
				model.set("name", user.get("name"));
				model.set("user_id", user.get("user_id"));
				model.set("user_type", user.get("user_type").toString());
				model.set("user_group", user.get("user_group"));
				model.set("register_time", user.get("register_time"));
				session.setAttribute("user_id", user.get("user_id"));
				session.setAttribute("number", user.get("number"));
				session.setAttribute("name", user.get("name"));
				session.setAttribute("user_type", user.get("user_type"));
				session.setAttribute("user_group", user.get("user_group"));
				session.setMaxInactiveInterval(3600);
			}
			else {
				model.set("result", "failed");
			}
		}
		return model;
	}
	
	@RequestMapping(value="/userRegister", method=RequestMethod.POST)
	public Model userRegister(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		String result = userService.userRegister(reqs);
		model.set("result", result);
		return model;
	}
	
	@RequestMapping(value="/isUserLogin", method=RequestMethod.POST)
	public Model isUserLogin(HttpSession session) {
		Model model = new Model();
		if(null!=session.getAttribute("user_id"))
			model.set("result", "success");
		else {
			model.set("result", "failed");
		}
		return model;
	}
	
	@RequestMapping(value="/user_center", method=RequestMethod.GET)
	public String getUserCenterPage(HttpSession session) {
		try {
		    String user_id = session.getAttribute("user_id").toString();
		    Integer user_type = userService.getUserType(user_id);
			if(user_type==0)
				return "user/normal/user_center";
			else if(user_type==1)
				return "user/admin/user_center";
			else if(user_type==2)
				//超级管理员--路慧
				return "user/admin2/user_center";
			return "user/normal/user_center";
		} catch(Exception exception) {
			return "main/index";
		}
		
	}
	
	@RequestMapping(value="/getUserId", method=RequestMethod.POST)
	public Model getUserId(HttpSession session) {
		Model model = new Model();
		model.set("result", session.getAttribute("user_id"));
		return model;
	}
	
	@RequestMapping(value="/user_info", method=RequestMethod.GET)
	public String getUserInfoPage(HttpSession session) {
		try {
		    String user_id = session.getAttribute("user_id").toString();
		    Integer user_type = userService.getUserType(user_id);
			if(user_type==0)
				return "user/normal/user_info";
			else if(user_type==1)
				return "user/admin/user_info";
			else if(user_type==2)
				return "user/admin2/user_center";
			return "user/normal/user_info";
		} catch(Exception exception) {
			return "main/index";
		}
		
	}
	
	@RequestMapping(value="/getUserInfo", method=RequestMethod.POST)
	public Model getUserInfo(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.setRow(userService.getUserInfo(reqs));
		return model;
	}
	
	@RequestMapping(value = "/getImage")
	public void getImage(@RequestParam Map<String, Object> reqs,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		userService.get_pic(reqs, request, response);
	}
	
	@RequestMapping(value="/delete_temporary",method=RequestMethod.POST)
	public Model cancle(HttpServletRequest request){
		Model model = new Model();
		userService.delete(request);
		return model;
	}
	
	@RequestMapping(value="/upload_pic")
	private ModelAndView upload_pic(@RequestParam Map<String, Object> reqs,
			HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		Model model = new Model();
		String result = userService.upload_pic(reqs, request);
		model.set("result", result);
		return model;
	}
	
	@RequestMapping(value="/saveUserPic", method=RequestMethod.POST)
	public Model saveUserPic(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		model.set("result", userService.saveUserPic(reqs, request));
		return model;
	}
	
	@RequestMapping(value="/saveUserInfo", method=RequestMethod.POST)
	public Model saveUserInfo(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", userService.saveUserInfo(reqs));
		return model;
	}
	
	@RequestMapping(value="/member_manage", method=RequestMethod.GET)
	public String getMemberManagePage(HttpSession session) {
		if(null==session.getAttribute("user_type") || !"2".equals(session.getAttribute("user_type").toString())) {
			return "main/index";
		}
		else
			return "user/admin2/member_manage";
	}
	
	@RequestMapping(value="/star", method=RequestMethod.GET)
	public String getStarPage(HttpSession session) {
		if(null==session.getAttribute("user_type") || !"2".equals(session.getAttribute("user_type").toString())) {
			return "main/index";
		}
		else
			return "user/admin2/star";
	}
	
	@RequestMapping(value="/isPasswordCorrect", method=RequestMethod.POST)
	public Model isPasswordCorrect(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", userService.isPasswordCorrect(reqs));
		return model;
	}
	
	@RequestMapping(value="/passwordCorrect", method=RequestMethod.POST)
	public Model passwordCorrect(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", userService.passwordCorrect(reqs));
		return model;
	}
	
	@RequestMapping(value="/news_admin", method=RequestMethod.GET)
	public String getNewsTeamPage() {
		return "user/admin/news_publish";
	}
	
	@RequestMapping(value="/getNormalUserId", method=RequestMethod.POST)
	public Model getNormalUserId(HttpSession session) {
		Model model = new Model();
		if(null == session.getAttribute("user_id"))
			model.set("result", "failed");
		else{
			System.out.println("controller-user_id:"+session.getAttribute("user_id"));
			model.set("result", session.getAttribute("user_id"));
		}
		return model;
	}
	
	@RequestMapping(value="/user_info_normal", method=RequestMethod.GET)
	public String getUserInfoView() {
		return "user/normal/user_center";
	}
	
	@RequestMapping(value="/news_normal", method=RequestMethod.GET)
	public String getNewsPublishView() {
		return "user/normal/news_publish";
	}
	
	@RequestMapping(value="/project_normal", method=RequestMethod.GET)
	public String getProjectView() {
		return "user/normal/project_manage";
	}
	
	@RequestMapping(value="/star_normal", method=RequestMethod.GET)
	public String getStarView() {
		return "user/normal/star";
	}
	
	@RequestMapping(value="/hasUserLogin", method=RequestMethod.POST)
	public Model hasUserLogin(HttpSession session) {
		Model model = new Model();
		if(null != session.getAttribute("user_id")) {
			model.set("result", "success");
			model.setRow(userService.getUserBasicInfo(session.getAttribute("user_id").toString()));
		}
		else {
			model.set("result", "failed");
		}
		return model;
	}
	
	
	@RequestMapping(value="/logout")
	public Model logout(HttpSession session) {
		Model model = new Model();
		session.invalidate();
		return model;
	}
	
	@RequestMapping(value="/project_manage_normal", method=RequestMethod.GET)
	public String getAdminProjectManage(HttpSession session) {
		if(null==session.getAttribute("user_id"))
			return "main/index";
		return "user/normal/project_manage";
	}
	
	@RequestMapping(value="/isUserAdmin", method=RequestMethod.POST)
	public Model isUserAdmin(HttpSession session) {
		Model model = new Model();
		if(null == session.getAttribute("user_id")) {
			model.set("result", "failed");
		}
		else if(session.getAttribute("user_type").toString().equals("0")) {
			model.set("result", "failed");
		}
		else {
			model.set("result", "success");
		}
		return model;
	}
	
	@RequestMapping(value="/publishContribute", method=RequestMethod.POST)
	public Model publishContribute(@RequestParam Map<String, Object> reqs, HttpSession session) {
		Model model = new Model();
		String name = session.getAttribute("name").toString();
		reqs.put("publish_name", name);
		model.set("result", userService.publishContribute(reqs));
		return model;
	}
	
}
