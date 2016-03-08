package cn.com.cippus.web.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.xml.internal.bind.v2.model.core.ID;

import cn.com.cippus.web.common.IdUtil;
import cn.com.cippus.web.dao.SimpleDao;
import cn.com.cippus.web.service.NewsService;

@Service("newsService")
public class NewsServiceImpl implements NewsService{

	@Autowired
	private SimpleDao newsSimpleDao;

	public SimpleDao getNewsSimpleDao() {
		return newsSimpleDao;
	}

	public void setNewsSimpleDao(SimpleDao newsSimpleDao) {
		this.newsSimpleDao = newsSimpleDao;
	}

	@Override
	public String saveNews(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public String makeNewsId(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String idString = IdUtil.uuid();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/news_temporary/" + "\\" + idString;
		System.out.println(path);
		File file = new File(path);
		if(file.mkdirs()==false)  //判断文件夹创建是否成功
			return "failed";
		else
			return idString;
	}
	
	@Override
	public String uploadAttach(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 得到上传的文件
		MultipartFile mFile = multipartRequest.getFile(reqs.get("file_select").toString());
		String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
		String news_id = reqs.get("news_id").toString();
		String attach_name = reqs.get("attach_name").toString();
		String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/news_temporary") + "\\" + news_id + "\\" + attach_name + suffix;
		File file = new File(path1);
		if (file.exists()) {
			file.delete();
		}
		InputStream inputStream;
		try {
			inputStream = mFile.getInputStream();
			byte[] b = new byte[1048576];
			int length = inputStream.read(b);
			// 文件流写到服务器端
			FileOutputStream outputStream = new FileOutputStream(path1);
			outputStream.write(b, 0, length);
			inputStream.close();
			outputStream.close();
			return "success";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "failed";
		}
	}
	
	@Override
	public void delete(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/news_temporary/";
		deleteFile(path);
	}
	
	// 删除文件
	private void deleteFile(String path) {
		File file = new File(path);
		if (file.exists()) { // 判断文件是否存在
			if (file.isFile()) { // 判断是否是文件
				file.delete(); // delete()方法 你应该知道 是删除的意思;
			} else if (file.isDirectory()) { // 否则如果它是一个目录
				File files[] = file.listFiles(); // 声明目录下所有的文件 files[];
				for (int i = 0; i < files.length; i++) { // 遍历目录下所有的文件
					this.deleteFile(files[i].getPath()); // 把每个文件 用这个方法进行迭代
				}
			}
			file.delete();
		} else {
			System.out.println("所删除的文件不存在！" + '\n');
		}
	}
	
	@Override
	public String publishNews(Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String result = "success";
		if(reqs.containsKey("news_id")) {
			Map<String, Object> news = new HashMap<String, Object>();
			news.put("news_id", reqs.get("news_id").toString());
			news.put("publish_time", new Date(new java.util.Date().getTime()));
			news.put("publish_name", session.getAttribute("name").toString());
			news.put("focus", 0);
			news.put("title", reqs.get("title").toString());
			news.put("type", Integer.parseInt(reqs.get("type").toString()));
			news.put("attachment", 1);
			news.put("content", reqs.get("info").toString());
			try {
				
				String news_id = reqs.get("news_id").toString();
				// 将临时图片文件夹上传到正式文件夹
				String xmlRealPath = request.getSession().getServletContext().getRealPath("/WEB-INF/news") + "\\" + news_id;
				String oldpath = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/news_temporary" + "\\" + news_id;
				// 复制文件夹
				copyFolder(oldpath, xmlRealPath);
				deleteFile(oldpath);
				StringBuilder sb = new StringBuilder();
				File file = new File(xmlRealPath);
				File[] array = file.listFiles(); 
				for(int i=0;i<array.length;i++) {
					String suffix = array[i].getName().substring(array[i].getName().lastIndexOf("."));
					Random r = new Random();
					Double d = r.nextDouble();
					String s = d + "";
					s=s.substring(3,3+6);
					
					SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
					String new_name = df.format(new java.util.Date())+"_"+s+suffix;

					sb.append(array[i].getName().substring(0, array[i].getName().lastIndexOf("."))).append("=").append(new_name).append("#");
					String new_path = xmlRealPath+"/"+new_name;
					File new_file = new File(new_path);
					array[i].renameTo(new_file);
				}
				sb.substring(0, sb.length()-1);
				news.put("file", sb.toString());
				newsSimpleDao.create("db_news", news);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				result = "failed";
			}
		}
		else {
			Map<String, Object> news = new HashMap<String, Object>();
			news.put("news_id", IdUtil.uuid());
			news.put("publish_time", new Date(new java.util.Date().getTime()));
			news.put("publish_name", session.getAttribute("name").toString());
			news.put("focus", 0);
			news.put("title", reqs.get("title").toString());
			news.put("type", Integer.parseInt(reqs.get("type").toString()));
			news.put("attachment", 0);
			news.put("content", reqs.get("info").toString());
			try {
				newsSimpleDao.create("db_news", news);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				result = "failed";
			}
		}
		return result;
	}
	
	// 将临时文件夹拷贝到正式文件夹
	public boolean copyFolder(String oldPath, String newPath) {
		try {
			(new File(newPath)).mkdirs(); // 如果文件夹不存在 则建立新文件夹
			File a = new File(oldPath);
			String[] file = a.list();
			File temp = null;
			for (int i = 0; i < file.length; i++) {
				if (oldPath.endsWith(File.separator)) {
					temp = new File(oldPath + file[i]);
				} else {
					temp = new File(oldPath + File.separator + file[i]);
				}
				if (temp.isFile()) {
					FileInputStream input = new FileInputStream(temp);
					FileOutputStream output = new FileOutputStream(newPath
							+ "/" + (temp.getName()).toString());
					byte[] b = new byte[1024 * 5];
					int len;
					while ((len = input.read(b)) != -1) {
						output.write(b, 0, len);
					}
					output.flush();
					output.close();
					input.close();
				}
				if (temp.isDirectory()) {// 如果是子文件夹
					copyFolder(oldPath + "/" + file[i], newPath + "/" + file[i]);
				}
			}
		} catch (Exception e) {
			System.out.println("复制整个文件夹内容操作出错");
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Override
	public List<Map<String, Object>> getNewsList(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Integer news_type = Integer.parseInt(reqs.get("type").toString());
		Integer page = Integer.parseInt(reqs.get("page").toString());
		String sql = new String();
		int start = 10*(page-1);
		sql = "select * from db_news where type="+news_type+" order by publish_time desc limit "+start+",12";
		
		return newsSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public Integer getNewsNum(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Integer news_type = Integer.parseInt(reqs.get("type").toString());
		String sql = new String();
		
		sql = "select * from db_news where type="+news_type+"";
		return newsSimpleDao.queryForList(sql, new HashMap<String, Object>()).size();
	}

	@Override
	public Map<String, Object> getNewsDetail(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		return newsSimpleDao.retrieve("db_news", reqs);
	}
	
	@Override
	public List<Map<String, Object>> newsSearch(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String title = reqs.get("title").toString().trim();
		Integer page = Integer.parseInt(reqs.get("page").toString());
		int start = 10*(page-1);
		String sql = "select * from db_news where 1=1";
		if(title.length()>0)
			sql += " and title like '%" + title + "%'";
		sql += "order by publish_time desc limit "+start+",12";
		return newsSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public void updateFocus(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
	    Integer focus = (Integer) newsSimpleDao.retrieve("db_news", reqs).get("focus");
	    focus++;
	    Map<String, Object> row = new HashMap<String, Object>();
	    row.put("focus", focus);
	    newsSimpleDao.update("db_news", row, reqs);
	}

}
