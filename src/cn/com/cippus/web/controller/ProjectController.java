package cn.com.cippus.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cn.com.cippus.web.service.ProjectService;
import cn.com.cippus.web.view.Model;

@Controller("projectController")
public class ProjectController {

	@Autowired
	private ProjectService projectService;

	public ProjectService getProjectService() {
		return projectService;
	}

	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	@RequestMapping(value="/getProjectByType", method=RequestMethod.POST)
	public Model getProjectByType(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("num", projectService.getProjectNumByType(reqs));
		model.setList(projectService.getProjectByType(reqs));
		return model;
	}
	
	@RequestMapping(value="/project2", method=RequestMethod.GET)
	public String getProject2Page() {
		return "project/project_index2";
	}
	
	@RequestMapping(value="/project3", method=RequestMethod.GET)
	public String getProject3Page() {
		return "project/project_index3";
	}
	
	@RequestMapping(value="/project_publish", method=RequestMethod.GET)
	public String getProjectPublishPage() {
		return "project/project_publish";
	}
	
	@RequestMapping(value="/delete_project_temporary", method=RequestMethod.POST)
	public Model deleteProjectTempory(HttpServletRequest request) {
		Model model = new Model();
		projectService.delete(request);
		return model;
	}
	
	@RequestMapping(value="/makeProjectId", method=RequestMethod.POST)
	public Model makeProjectId(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		model.set("id", projectService.makeProjectId(request));
		return model;
	}
	
	@RequestMapping(value="/upload_project_pic", method=RequestMethod.POST)
	public Model uploadPic(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		model.set("result", projectService.uploadPic(reqs, request));
		return model;
	}
	
	@RequestMapping(value="/uploadProjectWithoutFile", method=RequestMethod.POST)
	public Model uploadProjectWithoutFile(@RequestParam Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		Model model = new Model();
		if(null==session.getAttribute("user_id"))
			model.set("result", "login");
		else {
			reqs.put("upload_user", session.getAttribute("user_id").toString());
			model.set("result", projectService.uploadProjectWithoutFile(reqs, request));
		}
		return model;
	}
	
	@RequestMapping(value="/uploadProjectWithFile", method=RequestMethod.POST)
	public Model uploadProjectWithFile(@RequestParam Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		Model model = new Model();
		if(null==session.getAttribute("user_id"))
			model.set("result", "login");
		else {
			reqs.put("upload_user", session.getAttribute("user_id").toString());
		    model.set("result", projectService.uploadProjectWithFile(reqs, request));
		}
		return model;
	}
	
	@RequestMapping(value="/updateProjectWithFile", method=RequestMethod.POST)
	public Model updateProjectWithFile(@RequestParam Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		Model model = new Model();
		if(null==session.getAttribute("user_id"))
			model.set("result", "login");
		else {
			reqs.put("upload_user", session.getAttribute("user_id").toString());
			model.set("result", projectService.updateProjectWithFile(reqs, request));
		}
		return model;
	}
	
	@RequestMapping(value="/updateProjectWithoutFile", method=RequestMethod.POST)
	public Model updateProjectWithoutFile(@RequestParam Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		Model model = new Model();
		if(null==session.getAttribute("user_id"))
			model.set("result", "login");
		else {
			reqs.put("upload_user", session.getAttribute("user_id").toString());
		    model.set("result", projectService.updateProjectWithoutFile(reqs, request));
		}
		return model;
	}
	
	@RequestMapping(value="/getProjectImage")
	public void getProjectImg(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> reqs) {
		projectService.getProjectImg(reqs, request, response);
	}
	
	@RequestMapping(value="/getProjectById", method=RequestMethod.GET)
	public String getProjectDetailPage() {
		return "project/project_detail";
	}
	
	@RequestMapping(value="/getProjectInfo", method=RequestMethod.POST)
	public Model getProjectInfo(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		model.setRow(projectService.getProjectInfo(reqs));
		model.set("download", projectService.getProjectDownload(reqs, request));
		return model;
	}
	
	@RequestMapping(value="/project_search", method=RequestMethod.GET)
	public String getProjectSearch() {
		return "project/project_search";
	}
	
	@RequestMapping(value="/searchProject", method=RequestMethod.POST)
	public Model searchProject(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("num", projectService.getSearchNum(reqs));
		model.setList(projectService.searchProject(reqs));
		return model;
	}
	
	@RequestMapping(value="/getProjectFileDetail")
	public HttpServletResponse getImage(@RequestParam Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response){
		String project_id = reqs.get("project_id").toString();
		String real_name = projectService.getFileRealName(project_id, request);
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\" + real_name;
		System.out.println(path);
		try {
            // path是指欲下载的文件的路径。
            File file = new File(path);
            // 取得文件名。
            String filename = file.getName();
            // 取得文件的后缀名。

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
	
	@RequestMapping(value="/isProjectHasPic", method=RequestMethod.POST)
	public Model isProjectHasPic(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		String project_id = reqs.get("project_id").toString();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
		File[] files = new File(path).listFiles();
		String result = "failed";
		for(int i=0;i<files.length;i++) {
			String name = files[i].getName();
			if(name.split("_")[1].substring(0,1).equals("1")) {
				result = "success";
				break;
			}
		}
		model.set("result", result);
		return model;
	}
	
	@RequestMapping(value="/getProjectPic", method=RequestMethod.POST)
	public Model getProjectPic(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		List<String> list = new ArrayList<String>();
		String project_id = reqs.get("project_id").toString();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
		File[] files = new File(path).listFiles();
		for(int i=0;i<files.length;i++) {
			String name = files[i].getName();
			if(!name.split("_")[1].substring(0,1).equals("a")) {
				list.add(files[i].getName());
			}
		}
		System.out.println(list);
		model.setList(list);
		return model;
	}
	
	@RequestMapping(value="/getProjectDetail")
	public void getProjectDetail(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> reqs) {
		projectService.getProjectDetail(reqs, request, response);
	}
	
	@RequestMapping(value="/getProjectByGroup", method=RequestMethod.POST)
	public Model getProjectByGroup(@RequestParam Map<String, Object> reqs, HttpSession session) {
		Model model = new Model();
		String user_id = session.getAttribute("user_id").toString();
		model.set("num", projectService.getProjectNumByGroup(reqs, user_id));
		model.set("list", projectService.getProjectByGroup(reqs, user_id));
		return model;
	}
	
	@RequestMapping(value="/project_update", method=RequestMethod.GET)
	public String getProjectUpdatePage() {
		return "user/admin/project_update";
	}
	
	@RequestMapping(value="/getProjectInfoDetail", method=RequestMethod.POST)
	public Model getProjectInfoDetail(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.setRow(projectService.getProjectInfoDetail(reqs));
		return model;
	}
	
	@RequestMapping(value="/update_project_pic", method=RequestMethod.POST)
	public Model updatePic(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		model.set("result", projectService.updatePic(reqs, request));
		return model;
	}
}
