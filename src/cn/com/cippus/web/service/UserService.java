package cn.com.cippus.web.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface UserService {

	public Map<String, Object> userLogin(Map<String, Object> reqs);

	public String userRegister(Map<String, Object> reqs);

	public Integer getUserType(String user_id);

	public Map<String, Object> getUserInfo(Map<String, Object> reqs);

	public void get_pic(Map<String, Object> reqs, HttpServletRequest request,
			HttpServletResponse response);

	public void delete(HttpServletRequest request);

	public String upload_pic(Map<String, Object> reqs, HttpServletRequest request);

	public String saveUserPic(Map<String, Object> reqs, HttpServletRequest request);

	public String saveUserInfo(Map<String, Object> reqs);

	public String isPasswordCorrect(Map<String, Object> reqs);

	public String passwordCorrect(Map<String, Object> reqs);

	public Map<String, Object> getUserBasicInfo(String string);

	public String publishContribute(Map<String, Object> reqs);

}
