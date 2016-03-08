package cn.com.cippus.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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

import cn.com.cippus.web.service.ResourcesService;
import cn.com.cippus.web.view.Model;

@Controller("resourcesController")
public class ResourcesController {

	@Autowired
	private ResourcesService resourcesService;

	public ResourcesService getResourcesService() {
		return resourcesService;
	}

	public void setResourcesService(ResourcesService resourcesService) {
		this.resourcesService = resourcesService;
	}
	
	@RequestMapping(value="/resources_all", method=RequestMethod.GET)
	public String getResourcesAllPage() {
		return "study/resources_all";
	}
	
	@RequestMapping(value="/resources_acm", method=RequestMethod.GET)
	public String getResourcesAcmPage() {
		return "study/resources_acm";
	}
	
	@RequestMapping(value="/resources_mem", method=RequestMethod.GET)
	public String getResourcesMemPage() {
		return "study/resources_mem";
	}
	
	@RequestMapping(value="/resources_language", method=RequestMethod.GET)
	public String getResourcesLanguagePage() {
		return "study/resources_language";
	}
	
	@RequestMapping(value="/resources_hard", method=RequestMethod.GET)
	public String getResourcesHardPage() {
		return "study/resources_hard";
	}
	
	@RequestMapping(value="/resources_design", method=RequestMethod.GET)
	public String getResourcesDesignPage() {
		return "study/resources_design";
	}
	
	@RequestMapping(value="/resources_other", method=RequestMethod.GET)
	public String getResourcesOtherPage() {
		return "study/resources_other";
	}
	
	@RequestMapping(value="/getResources", method=RequestMethod.POST)
	public Model getResources(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("num", resourcesService.getResourcesNum(reqs));
		model.set("list", resourcesService.getResources(reqs));
		return model;
	}
	
	@RequestMapping(value="/upload_resources", method=RequestMethod.GET)
	public String getUploadPage(HttpSession session) {
		return "study/upload_resource";
	}
	
	@RequestMapping(value="/addResourcesLink", method=RequestMethod.POST)
	public Model addResources(@RequestParam Map<String, Object> reqs, HttpSession session) {
		Model model = new Model();
		if(null==session.getAttribute("user_id"))
			model.set("result", "login");
		else
		    model.set("result", resourcesService.addResourcesLink(reqs, session));
		return model;
	}
	
	@RequestMapping(value="/addResourcesFile", method=RequestMethod.POST)
	public Model addResourcesFile(@RequestParam Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		Model model = new Model();
		if(null==session.getAttribute("user_id"))
			model.set("result", "login");
		else
		    model.set("result", resourcesService.addResourcesFile(reqs, session, request));
		return model;
	}
	
	@RequestMapping(value="/resources_search", method=RequestMethod.GET)
	public String getSearchPage() {
		return "study/resources_search";
	}
	
	@RequestMapping(value="/resourcesSearch", method=RequestMethod.POST)
	public Model resourcesSearch(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("num", resourcesService.searchNum(reqs));
		model.setList(resourcesService.search(reqs));
		return model;
	}
	
	@RequestMapping(value="/getResourcesDetail", method=RequestMethod.GET)
	public String getResourcesDetail(@RequestParam Map<String, Object> reqs) {
		return "study/resources_detail";
	}
	
	@RequestMapping(value="/getResourcesInfo", method=RequestMethod.POST)
	public Model getResourcesInfo(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.setRow(resourcesService.getResourcesInfo(reqs));
		return model;
	}
	
	@RequestMapping(value="/getResourcesFileDetail")
	public HttpServletResponse getImage(@RequestParam Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response){
		String resources_id = reqs.get("resources_id").toString();
		String real_name = resourcesService.getFileRealName(resources_id);
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/resources") + "\\" + resources_id + "\\" + real_name;
		try {
            // path是指欲下载的文件的路径。
            File file = new File(path);
            // 取得文件名。
            String filename = file.getName();
            // 取得文件的后缀名。
            String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();

            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return response;
	}
	
	@RequestMapping(value="/resources_unaccept", method=RequestMethod.GET)
	public String getresources_unacceptPage(){
		return "user/admin/resources_list";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value="/getResourcesUnAcceptList", method=RequestMethod.POST)
	public void getAllAddress(@RequestParam Map<String, Object> reqs, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		String user_id = session.getAttribute("user_id").toString();
		Map pageInfo = new HashMap();  
        pageInfo.put("page", Integer.parseInt(reqs.get("page").toString()));  
        pageInfo.put("total", resourcesService.getRegisterNum(user_id)); 
		String jsonStr = getJsonString(resourcesService.getAllRegister(user_id), pageInfo);
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
		System.out.println(pageInfo);
		System.out.println(list);
        List mapList = new ArrayList();  
        for(int i = 0; i < list.size(); i++) {  
        	Map<String, Object> map = (Map<String, Object>) list.get(i);
        	String type1 = map.get("RESOURCES_TYPE1").toString();
        	String type2 = map.get("RESOURCES_TYPE2").toString();
        	String real_type1 = "";
        	String real_type2 = "";
        	if(type1.equals("1"))
        		real_type1 = "ACM相关";
        	else if(type1.equals("2"))
        		real_type1 = "数模相关";
        	else if(type1.equals("3"))
        		real_type1 = "编程语言相关";
        	else if(type1.equals("4"))
        		real_type1 = "硬件嵌入式相关";
        	else if(type1.equals("5"))
        		real_type1 = "设计相关";
        	else if(type1.equals("6"))
        		real_type1 = "其他资源";
        	
        	if(type2.equals("0"))
        		real_type2 = "视频资源";
        	else if(type2.equals("1"))
        		real_type2 = "文档资源";
        	else if(type2.equals("2"))
        		real_type2 = "源代码";
            Map cellMap = new HashMap();  
            cellMap.put("id", map.get("RESOURCES_ID"));  
            cellMap.put("cell", new Object[] {map.get("RESOURCES_NAME"), map.get("UPLOAD_USER"), 
            		map.get("UPLOAD_TIME").toString(), real_type1, real_type2 });     
            mapList.add(cellMap);  
        }  
        pageInfo.put("rows", mapList);  
        JSONObject object = new JSONObject();
        object.putAll(pageInfo);
        return object.toString();  
    }
	
	@RequestMapping(value="/resourcesRegisterDelete", method=RequestMethod.POST)
	public Model resourcesRegisterDelete(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", resourcesService.resourcesRegisterDelete(reqs));
		return model;
	}
	@RequestMapping(value="/resourcesRegisterAccept", method=RequestMethod.POST)
	public Model resourcesRegisterAccept(@RequestParam Map<String, Object> reqs){
		Model model = new Model();
		model.set("result", resourcesService.resourcesRegisterAccept(reqs));
		return model;
	}
	
	
	@RequestMapping(value="/getResourcesUnacceptInfo", method=RequestMethod.GET)
	public String getResourcesUnacceptInfoPage() {
		return "user/admin/resources_info";
	}
	
	@RequestMapping(value="/acceptResources", method=RequestMethod.POST)
	public Model acceptResources(@RequestParam Map<String, Object> reqs,HttpSession session) {
		Model model = new Model();
		model.set("result", resourcesService.acceptResources(reqs));
		return model;
	}
}
