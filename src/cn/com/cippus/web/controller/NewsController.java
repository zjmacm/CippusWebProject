package cn.com.cippus.web.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tools.ant.taskdefs.Mkdir;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cn.com.cippus.web.common.IdUtil;
import cn.com.cippus.web.service.NewsService;
import cn.com.cippus.web.view.Model;

@Controller("newsController")
public class NewsController {

	@Autowired
	private NewsService newsService;

	public NewsService getNewsService() {
		return newsService;
	}

	public void setNewsService(NewsService newsService) {
		this.newsService = newsService;
	}
	
	@RequestMapping(value="/news_public", method=RequestMethod.GET)
	public String getNewsPublicPage() {
		return "admin/news_public";	
	}
	
	@RequestMapping(value="/upload_json")
	public String upload_json() {
		return "kindEditor/kindeditor-4.1.7/jsp/upload_json";	
	}
	
	@RequestMapping(value="/file_manager_json")
	public String file_manager_json() {
		return "kindEditor/kindeditor-4.1.7/jsp/file_manager_json";	
	}
	
	@RequestMapping(value="/getNewsInfo", method=RequestMethod.POST)
	public Model getNewsInfo(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("result", newsService.saveNews(reqs));
		return model;
	}
	
	@RequestMapping(value="/news_info", method=RequestMethod.GET)
	public String getNewsInfoPage() {
		return "news/news_info";
	}
	
	@RequestMapping(value="/news", method=RequestMethod.GET)
	public String getNewsPage() {
		return "news/news_center";
	}
	
	@RequestMapping(value="/makeNewsId", method=RequestMethod.POST)
	public Model makeNewsId(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		model.set("id", newsService.makeNewsId(request));
		return model;
	}
	
	@RequestMapping(value="/delete_news_temporary", method=RequestMethod.POST)
	public Model deleteNewsTempory(HttpServletRequest request) {
		Model model = new Model();
		newsService.delete(request);
		return model;
	}
	
	@RequestMapping(value="/upload_attach", method=RequestMethod.POST)
	public Model uploadAttach(@RequestParam Map<String, Object> reqs, HttpServletRequest request) {
		Model model = new Model();
		System.out.println(reqs);
		model.set("result", newsService.uploadAttach(reqs, request));
		return model;
	}
	
	@RequestMapping(value="/publishNews", method=RequestMethod.POST)
	public Model publishNews(@RequestParam Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		Model model = new Model();
		model.set("result", newsService.publishNews(reqs, session, request));
		return model;
	}
	
	@RequestMapping(value="/getNewsList", method=RequestMethod.POST)
	public Model getNewsList(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.set("list",newsService.getNewsList(reqs));
		model.set("num", newsService.getNewsNum(reqs));
		return model;
	}
	
	@RequestMapping(value="/getNewsInfo", method=RequestMethod.GET)
	public String getNewsInfo2(@RequestParam Map<String, Object> reqs) {
		newsService.updateFocus(reqs);
		return "news/news_info";
	}
	
	@RequestMapping(value="/getNewsDetail", method=RequestMethod.POST)
	public Model getNewsDetail(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.setRow(newsService.getNewsDetail(reqs));
		return model;
	}
	
	
	@RequestMapping(value = "/getFileDetail")
	public HttpServletResponse getImage(@RequestParam Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response){
		String news_id = reqs.get("news_id").toString();
		String name = reqs.get("name").toString();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/news") + "\\" + news_id + "\\" + name;
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
	
	@RequestMapping(value="/news_game", method=RequestMethod.GET)
	public String getNewsGamePage() {
		System.out.println("I am here!!!");
		return "news/news_center2";
	}
	
	@RequestMapping(value="/news_team", method=RequestMethod.GET)
	public String getNewsTeamPage() {
		return "news/news_center3";
	}
	
	@RequestMapping(value="/news_search", method=RequestMethod.GET)
	public String getNewsSearchPage() {
		return "news/news_search";
	}
	
	@RequestMapping(value="/newsSearch", method=RequestMethod.POST)
	public Model newsSearch(@RequestParam Map<String, Object> reqs) {
		Model model = new Model();
		model.setList(newsService.newsSearch(reqs));
		return model;
	}
}
