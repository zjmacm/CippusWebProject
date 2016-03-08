package cn.com.cippus.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ProjectService {

	public List<Map<String, Object>> getProjectByType(Map<String, Object> reqs);

	public void delete(HttpServletRequest request);

	public String makeProjectId(HttpServletRequest request);

	public String uploadPic(Map<String, Object> reqs, HttpServletRequest request);

	public String uploadProjectWithoutFile(Map<String, Object> reqs, HttpServletRequest request);

	public String uploadProjectWithFile(Map<String, Object> reqs, HttpServletRequest request);

	public Integer getProjectNumByType(Map<String, Object> reqs);

	public void getProjectImg(Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response);

	public Map<String, Object> getProjectInfo(Map<String, Object> reqs);

	public String getProjectDownload(Map<String, Object> reqs, HttpServletRequest request);

	public Integer getSearchNum(Map<String, Object> reqs);

	public List<Map<String, Object>> searchProject(Map<String, Object> reqs);

	public String getFileRealName(String project_id, HttpServletRequest request);

	public void getProjectDetail(Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response);

	public Integer getProjectNumByGroup(Map<String, Object> reqs, String user_id);

	public List<Map<String, Object>> getProjectByGroup(Map<String, Object> reqs, String user_id);

	public Map<String, Object> getProjectInfoDetail(Map<String, Object> reqs);

	public String updatePic(Map<String, Object> reqs, HttpServletRequest request);

	public String updateProjectWithFile(Map<String, Object> reqs, HttpServletRequest request);

	public String updateProjectWithoutFile(Map<String, Object> reqs, HttpServletRequest request);

}
