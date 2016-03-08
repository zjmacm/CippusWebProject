package cn.com.cippus.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface NewsService {

	public String saveNews(Map<String, Object> reqs);

	public void delete(HttpServletRequest request);

	public String makeNewsId(HttpServletRequest request);

	public String uploadAttach(Map<String, Object> reqs, HttpServletRequest request);

	public String publishNews(Map<String, Object> reqs, HttpSession session, HttpServletRequest request);

	public List<Map<String, Object>> getNewsList(Map<String, Object> reqs);

	public Integer getNewsNum(Map<String, Object> reqs);

	public Map<String, Object> getNewsDetail(Map<String, Object> reqs);

	public List<Map<String, Object>> newsSearch(Map<String, Object> reqs);

	public void updateFocus(Map<String, Object> reqs);



}
