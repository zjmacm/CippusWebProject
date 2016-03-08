package cn.com.cippus.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface ResourcesService {

	public Integer getResourcesNum(Map<String, Object> reqs);

	public List<Map<String, Object>> getResources(Map<String, Object> reqs);

	public String addResourcesLink(Map<String, Object> reqs, HttpSession session);

	public String addResourcesFile(Map<String, Object> reqs, HttpSession session, HttpServletRequest request);

	public List<Map<String, Object>> search(Map<String, Object> reqs);

	public Integer searchNum(Map<String, Object> reqs);

	public Map<String, Object> getResourcesInfo(Map<String, Object> reqs);

	public String getFileRealName(String resources_id);

	public Integer getRegisterNum(String user_id);

	public List<Map<String, Object>> getAllRegister(String user_id);

	public String resourcesRegisterDelete(Map<String, Object> reqs);
	
	public String resourcesRegisterAccept(Map<String,Object> reqs);

	public String acceptResources(Map<String, Object> reqs);


}
