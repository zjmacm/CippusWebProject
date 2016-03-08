package cn.com.cippus.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface AdminService {

	public Integer getRegisterNum(String user_id);

	public List<Map<String, Object>> getAllRegister(String user_id);

	public String registerDelete(Map<String, Object> reqs);

	public Map<String, Object> getRegisterDetail(Map<String, Object> reqs);

	public String registerAccept(Map<String, Object> reqs);

	public List<Map<String, Object>> getAllMembers(String user_id, Integer page);

	public String memberDelete(Map<String, Object> reqs);

	public Integer getMemberNum(String user_id);

	public List<Map<String, Object>> getLeaderList();

	public List<Map<String, Object>> getGroupMember(Map<String, Object> reqs);

	public String upload_pic(Map<String, Object> reqs, HttpServletRequest request);

	public String userAdd(Map<String, Object> reqs, HttpSession session);

	public List<Map<String, Object>> search(String user_id, Map<String, Object> reqs);

	public String addScore(Map<String, Object> reqs);



	public List<Map<String, Object>> getNews1();

	public List<Map<String, Object>> getNews2();

	public List<Map<String, Object>> getStar();

	public List<Map<String, Object>> getContribute();

	public List<Map<String, Object>> getResources();

	public List<Map<String, Object>> getProject();

}
