package cn.com.cippus.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.com.cippus.web.service.AdminService;
import cn.com.cippus.web.view.Model;

@Controller("adminController")
public class AdminController {

	@Autowired
	private AdminService adminService;

	public AdminService getAdminService() {
		return adminService;
	}

	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	
	@RequestMapping(value="/getRegisterInfo", method=RequestMethod.GET)
	public String getRegisterInfoPage() {
		return "user/admin/register_info";
	}
	
	@RequestMapping(value="/member_info", method=RequestMethod.GET)
	public String getMemberInfoPage(HttpSession session) {
		if(null==session.getAttribute("user_id"))
			return "main/index";
		else
			return "user/admin/member_info";
	}
	
	@RequestMapping(value="/getRegisterDetail", method=RequestMethod.POST)
	public Model getRegisterDetail(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.setRow(adminService.getRegisterDetail(reqs));
		return model;
	}
	
	@RequestMapping(value="/registerAccept", method=RequestMethod.POST)
	public Model registerAccept(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", adminService.registerAccept(reqs));
		return model;
	}
	
	@RequestMapping(value="/registerDelete", method=RequestMethod.POST)
	public Model registerDelete(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", adminService.registerDelete(reqs));
		return model;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value="/getRegisterList", method=RequestMethod.POST)
	public void getAllAddress(@RequestParam Map<String, Object> reqs, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		String user_id = session.getAttribute("user_id").toString();
		Map pageInfo = new HashMap();  
        pageInfo.put("page", Integer.parseInt(reqs.get("page").toString()));  
        pageInfo.put("total", adminService.getRegisterNum(user_id)); 
		String jsonStr = getJsonString(adminService.getAllRegister(user_id), pageInfo);
		response.setContentType("html/txt");  
        response.setCharacterEncoding("utf-8");  
        response.setHeader("Pragma", "no-cache");  
        response.setHeader("Cache-Control", "no-cache, must-revalidate");  
        response.setHeader("Pragma", "no-cache");  
        response.getWriter().write(jsonStr); 
        response.getWriter().flush(); 
        response.getWriter().close();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })  
    private String getJsonString(List list, Map pageInfo) {
        List mapList = new ArrayList();  
        for(int i = 0; i < list.size(); i++) {  
        	Map<String, Object> map = (Map<String, Object>) list.get(i);
        	
            Map cellMap = new HashMap();  
            cellMap.put("id", map.get("USER_ID"));  
            cellMap.put("cell", new Object[] {map.get("NUMBER"), map.get("NAME"), 
            		map.get("TEL"), map.get("EMAIL"), map.get("REGISTER_TIME").toString() });     
            mapList.add(cellMap);  
        }  
        pageInfo.put("rows", mapList);  
        JSONObject object = new JSONObject();
        object.putAll(pageInfo);
        return object.toString();  
    }
	
	@RequestMapping(value="/getAllMembers", method=RequestMethod.POST)
	public Model getAllMembers(@RequestParam Map<String, Object> reqs, HttpSession session) {
		Model model = new Model();
		if(null != session.getAttribute("user_id")) {
			String user_id = session.getAttribute("user_id").toString();
			Integer page = Integer.parseInt(reqs.get("page").toString());
			model.setList(adminService.getAllMembers(user_id, page));
		}
		else
			model.set("result", "failed");
		return model;
	}
	
	@RequestMapping(value="/memberDelete", method=RequestMethod.POST)
	public Model memberDelete(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", adminService.memberDelete(reqs));
		return model;
	}
	
	@RequestMapping(value="/getMemberNum", method=RequestMethod.POST)
	public Model getMemberNum(HttpSession session) {
		Model model = new Model();
		if(null != session.getAttribute("user_id")) {
			String user_id = session.getAttribute("user_id").toString();
			model.set("result", adminService.getMemberNum(user_id));
		}
		else
			model.set("result", "failed");
		return model;
	}
	
	@RequestMapping(value="/member_detail", method=RequestMethod.GET)
	public String getMemberDetailPage(HttpSession session) {
		System.out.println(session.getAttribute("user_type").toString());
		if("0".equals(session.getAttribute("user_type").toString()))
		    return "user/normal/member_detail";
		else if("1".equals(session.getAttribute("user_type").toString()))
			return "user/admin/member_detail";
		else if("2".equals(session.getAttribute("user_type").toString()))
			return "user/admin2/member_detail";
		else
			return "main/index";
	}
	
	@RequestMapping(value="/project_manage", method=RequestMethod.GET)
	public String getGroupProjectPage() {
		return "user/admin/project";
	}
	
	@RequestMapping(value="/getLeaderList", method=RequestMethod.POST)
	public Model getLeaderList(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.setList(adminService.getLeaderList());
		return model;
	}
	
	@RequestMapping(value="/group_member", method=RequestMethod.GET)
	public String getGroupMemberPage() {
		return "user/admin2/group_member";
	}
	
	@RequestMapping(value="/getGroupMember", method=RequestMethod.POST)
	public Model getGroupMember(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		String group = reqs.get("group").toString();
		if("0".equals(group))
			model.setList(adminService.getLeaderList());
		else {
			model.setList(adminService.getGroupMember(reqs));
		}
		return model;
	}
	
	@RequestMapping(value="/user_add", method=RequestMethod.GET)
	public String getUserAddPage(HttpSession session) {
		if("1".equals(session.getAttribute("user_type").toString()))
			return "user/admin/user_add";
		else
			return "main/index";
	}
	
	@RequestMapping(value="/makeUserId")
	private ModelAndView upload_pic(@RequestParam Map<String, Object> reqs,
			HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		Model model = new Model();
		String result = adminService.upload_pic(reqs, request);
		model.set("user_id", result);
		return model;
	}
	
	@RequestMapping(value="/userAdd", method=RequestMethod.POST)
	public Model userAdd(@RequestParam Map<String, Object> reqs, HttpSession session) {
		Model model = new Model();
		String user_group = session.getAttribute("user_group").toString();
		reqs.put("user_group", user_group);
		model.set("result", adminService.userAdd(reqs, session));
		return model;
	}
	
	@RequestMapping(value="/searchMember", method=RequestMethod.POST)
	public Model searchMember(@RequestParam Map<String, Object> reqs, HttpSession session) {
		Model model = new Model();
		if(null != session.getAttribute("user_id")) {
			String user_id = session.getAttribute("user_id").toString();
			model.setList(adminService.search(user_id, reqs));
		}
		else
			model.set("result", "failed");
		return model;
	}
	
	@RequestMapping(value="/user_search", method=RequestMethod.GET)
	public String getUserSearchPage() {
		return "user/admin/user_search";
	}
	
	@RequestMapping(value="/project_manage_admin", method=RequestMethod.GET)
	public String getAdminProjectManage(HttpSession session) {
		if(null==session.getAttribute("user_id"))
			return "main/index";
		return "user/admin/project";
	}
	
	@RequestMapping(value="/addScore", method=RequestMethod.POST)
	public Model addScore(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", adminService.addScore(reqs));
		return model;
	}
	
	@RequestMapping(value="/getIndexInfo", method=RequestMethod.POST)
	public Model getIndexInfo(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("resources", adminService.getResources());
		model.set("project", adminService.getProject());
		model.set("news1", adminService.getNews1());
		model.set("news2", adminService.getNews2());
		model.set("star", adminService.getStar());
		model.set("contribute", adminService.getContribute());
		return model;
	}
}
