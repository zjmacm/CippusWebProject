package cn.com.cippus.web.service.impl;

import java.awt.Image;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cn.com.cippus.web.common.IdUtil;
import cn.com.cippus.web.dao.SimpleDao;
import cn.com.cippus.web.service.ProjectService;

@Service("projectService")
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private SimpleDao projectSimpleDao;

	public SimpleDao getProjectSimpleDao() {
		return projectSimpleDao;
	}

	public void setProjectSimpleDao(SimpleDao projectSimpleDao) {
		this.projectSimpleDao = projectSimpleDao;
	}

	@Override
	public List<Map<String, Object>> getProjectByType(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Integer page = Integer.parseInt(reqs.remove("page").toString());
		int start = 10*(page-1);
		
		String sql = "select * from db_project where project_status=:type order by update_time desc limit "+start+",8";
		return projectSimpleDao.queryForList(sql, reqs);
	}
	
	@Override
	public Integer getProjectNumByType(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Integer type = Integer.parseInt(reqs.get("type").toString());
		String sql = new String();
		
		sql = "select * from db_project where project_status="+type+"";
		return projectSimpleDao.queryForList(sql, new HashMap<String, Object>()).size();
	}

	@Override
	public void delete(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/project_temporary/";
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
	public String makeProjectId(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String idString = IdUtil.uuid();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/project_temporary/" + "\\" + idString;
		File file = new File(path);
		if(file.mkdirs()==false)
			return "failed";
		else
			return idString;
	}
	
	@Override
	public String uploadPic(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 得到上传的文件
		MultipartFile mFile = multipartRequest.getFile(reqs.get("file_select").toString());
		String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
		String project_id = reqs.get("project_id").toString();
		String pic_name = project_id + "_" + reqs.get("i").toString();
		String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/project_temporary") + "\\" + project_id + "\\" + pic_name + suffix;
		File file = new File(path1);
		if (file.exists()) {
			file.delete();
		}
		InputStream inputStream;
		try {
			inputStream = mFile.getInputStream();
			byte[] b = new byte[10485760];
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
	public String uploadProjectWithoutFile(Map<String, Object> reqs,
			HttpServletRequest request) {
		// TODO Auto-generated method stub
		String result = "success";
		if(null==reqs.get("project_id") || 0==reqs.get("project_id").toString().length()) {
			try {
				String project_id = IdUtil.uuid();
				reqs.put("project_id", project_id);
				reqs.put("update_time", new Date(new java.util.Date().getTime()));
				String realPath = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
				File file = new File(realPath);
				file.mkdirs();
				projectSimpleDao.create("db_project", reqs);
				String[] author = reqs.get("author").toString().split("#");
				for(int i=0;i<author.length;i++) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("name", author[i]);
					String sql = "select user_id, month_score from db_user where name=:name";
					Double month_score = (Double) projectSimpleDao.queryForList(sql, map).get(0).get("month_score");
					String user_id = (String) projectSimpleDao.queryForList(sql, map).get(0).get("user_id");
					Integer type = Integer.parseInt(reqs.get("project_status").toString());
					if(type==3)
					    month_score += 1;
					else if(type==2)
						month_score += 5;
					else if(type==1)
						month_score += 10;
					Map<String, Object> row = new HashMap<String, Object>();
					Map<String, Object> conds = new HashMap<String, Object>();
					row.put("month_score", month_score);
					conds.put("user_id", user_id);
					projectSimpleDao.update("db_user", row, conds);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				result = "failed";
			}
		}
		else {
			try {
				String project_id = reqs.get("project_id").toString();
				reqs.put("update_time", new Date(new java.util.Date().getTime()));
				String xmlRealPath = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id;
				String oldpath = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/project_temporary" + "\\" + project_id;
				copyFolder(oldpath, xmlRealPath);
				deleteFile(oldpath);
				projectSimpleDao.create("db_project", reqs);
				String[] author = reqs.get("author").toString().split("#");
				for(int i=0;i<author.length;i++) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("name", author[i]);
					String sql = "select user_id, month_score from db_user where name=:name";
					Double month_score = (Double) projectSimpleDao.queryForList(sql, map).get(0).get("month_score");
					String user_id = (String) projectSimpleDao.queryForList(sql, map).get(0).get("user_id");
					Integer type = Integer.parseInt(reqs.get("project_status").toString());
					if(type==3)
					    month_score += 1;
					else if(type==2)
						month_score += 5;
					else if(type==1)
						month_score += 10;
					Map<String, Object> row = new HashMap<String, Object>();
					Map<String, Object> conds = new HashMap<String, Object>();
					row.put("month_score", month_score);
					conds.put("user_id", user_id);
					projectSimpleDao.update("db_user", row, conds);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				result = "failed";
			}
		}
		return result;
	}
	
	@Override
	public String uploadProjectWithFile(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String result = "success";
		if(null==reqs.get("project_id") || 0==reqs.get("project_id").toString().length()) {
			try {
				String project_id = IdUtil.uuid();
				reqs.put("project_id", project_id);
				reqs.put("update_time", new Date(new java.util.Date().getTime()));
				String realPath = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
				File file = new File(realPath);
				file.mkdirs();
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
				// 得到上传的文件
				MultipartFile mFile = multipartRequest.getFile(reqs.remove("file_select").toString());
				String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
				String file_name = project_id + "_" + "all";
	
				String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\" + file_name + suffix;
				File file2 = new File(path1);
				if (file2.exists()) {
					file2.delete();
				}
				InputStream inputStream;
				inputStream = mFile.getInputStream();
				byte[] b = new byte[1048576];
				int length = inputStream.read(b);
				// 文件流写到服务器端
				FileOutputStream outputStream = new FileOutputStream(path1);
				outputStream.write(b, 0, length);
				inputStream.close();
				outputStream.close();
				projectSimpleDao.create("db_project", reqs);
				String[] author = reqs.get("author").toString().split("#");
				for(int i=0;i<author.length;i++) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("name", author[i]);
					String sql = "select user_id, month_score from db_user where name=:name";
					Double month_score = (Double) projectSimpleDao.queryForList(sql, map).get(0).get("month_score");
					String user_id = (String) projectSimpleDao.queryForList(sql, map).get(0).get("user_id");
					Integer type = Integer.parseInt(reqs.get("project_status").toString());
					if(type==3)
					    month_score += 1;
					else if(type==2)
						month_score += 5;
					else if(type==1)
						month_score += 10;
					Map<String, Object> row = new HashMap<String, Object>();
					Map<String, Object> conds = new HashMap<String, Object>();
					row.put("month_score", month_score);
					conds.put("user_id", user_id);
					projectSimpleDao.update("db_user", row, conds);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				result = "failed";
			}
		}
		else {
			try {
				String project_id = reqs.get("project_id").toString();
				reqs.put("update_time", new Date(new java.util.Date().getTime()));
				String xmlRealPath = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id;
				String oldpath = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/project_temporary" + "\\" + project_id;
				copyFolder(oldpath, xmlRealPath);
				deleteFile(oldpath);
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
				// 得到上传的文件
				MultipartFile mFile = multipartRequest.getFile(reqs.remove("file_select").toString());
				String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
				String file_name = project_id + "_" + "all";
				String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\" + file_name + suffix;
				File file2 = new File(path1);
				if (file2.exists()) {
					file2.delete();
				}
				InputStream inputStream;
				inputStream = mFile.getInputStream();
				byte[] b = new byte[1048576];
				int length = inputStream.read(b);
				// 文件流写到服务器端
				FileOutputStream outputStream = new FileOutputStream(path1);
				outputStream.write(b, 0, length);
				inputStream.close();
				outputStream.close();
				projectSimpleDao.create("db_project", reqs);
				String[] author = reqs.get("author").toString().split("#");
				for(int i=0;i<author.length;i++) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("name", author[i]);
					String sql = "select user_id, month_score from db_user where name=:name";
					Double month_score = (Double) projectSimpleDao.queryForList(sql, map).get(0).get("month_score");
					String user_id = (String) projectSimpleDao.queryForList(sql, map).get(0).get("user_id");
					Integer type = Integer.parseInt(reqs.get("project_status").toString());
					if(type==3)
					    month_score += 1;
					else if(type==2)
						month_score += 5;
					else if(type==1)
						month_score += 10;
					Map<String, Object> row = new HashMap<String, Object>();
					Map<String, Object> conds = new HashMap<String, Object>();
					row.put("month_score", month_score);
					conds.put("user_id", user_id);
					projectSimpleDao.update("db_user", row, conds);
				}
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
	public void getProjectImg(Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		File file;
		// 得到上传服务器的路径
		String project_suffix = "";
		String project_id = reqs.get("project_id").toString();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
		File[] arrayFiles = new File(path).listFiles();
	    for(int i=0;i<arrayFiles.length;i++) {
	    	String file_name = arrayFiles[i].getName();
			if(arrayFiles[i].getName().split("_")[1].subSequence(0, 1).equals("1")) {
				String suffix = file_name.substring(file_name.lastIndexOf(".") + 1);
				project_suffix = suffix;
				break;
			}
		}
	     path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\" + project_id + "_1." + project_suffix;
		try {
			file = new File(path);
			// 文件不存在
			if (!file.exists()) {
				path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + "none.jpg";
				file = new File(path);
			}
			/* 读取图片信息 */
			Image srcFile = ImageIO.read(file);
			/*
			 * 宽高设定 BufferedImage tag = new BufferedImage(200, 200,
			 * BufferedImage.TYPE_INT_RGB); tag.getGraphics().drawImage(srcFile,
			 * 0, 0, 200, 200, null);
			 */

			// response.setContentType("image/*"); // 设置返回的文件类型
			// OutputStream out = response.getOutputStream(); //
			// 得到向客户端输出二进制数据的对象
			// JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			// JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tag);

			/* 压缩质量 */
			// jep.setQuality(1, true);
			// encoder.encode(tag, jep);

			// out.close();
			FileInputStream hFile = new FileInputStream(file);
			// 得到文件大小
			int i = hFile.available();
			byte data[] = new byte[i];
			// 读数据
			hFile.read(data);

			// 得到向客户端输出二进制数据的对象
			OutputStream out = response.getOutputStream();
			// 输出数据
			out.write(data);

			out.flush();
			out.close();
			hFile.close();
			srcFile.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public Map<String, Object> getProjectInfo(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		return projectSimpleDao.retrieve("db_project", reqs);
	}

	@Override
	public String getProjectDownload(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String project_id = reqs.get("project_id").toString();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id;
		File file = new File(path);
		File[] array = file.listFiles();
		for(int i=0;i<array.length;i++) {
			String name = array[i].getName().split("_")[1];
			if(name.substring(0, 3).equals("all")) {
				return "success";
			}
		}
		return "failed";
	}
	
	@Override
	public List<Map<String, Object>> searchProject(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String project_group = reqs.get("project_group").toString();
		String project_name = reqs.get("project_name").toString();
		Integer page = Integer.parseInt(reqs.get("page").toString());
		int start = 10*(page-1);
		String sql = "select * from db_project where 1=1";
		if(!"0".equals(project_group))
			sql += " and project_group='" + project_group + "'";
		if(project_name.length()>0)
			sql += " and project_name like '%" + project_name + "%'";
		sql += " order by update_time desc limit "+start+",10";
		return projectSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public Integer getSearchNum(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String project_group = reqs.get("project_group").toString();
		String project_name = reqs.get("project_name").toString();
		Integer page = Integer.parseInt(reqs.get("page").toString());
		int start = 10*(page-1);
		String sql = "select * from db_project where 1=1";
		if(!"0".equals(project_group))
			sql += " and project_group='" + project_group + "'";
		if(project_name.length()>0)
			sql += " and project_name like '%" + project_name + "%'";
		return projectSimpleDao.queryForList(sql, new HashMap<String, Object>()).size();
	}

	@Override
	public String getFileRealName(String project_id, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
		String project_suffix = "";
		File[] files = new File(path).listFiles();
		for(int i=0;i<files.length;i++) {
			String name = files[i].getName();
			if(name.split("_")[1].subSequence(0, 1).equals("a")) {
				String file_name = files[i].getName();
				String suffix = file_name.substring(file_name.lastIndexOf(".") + 1);
				project_suffix = suffix;
				break;
			}
		}
		return project_id + "_all." + project_suffix;
	}

	@Override
	public void getProjectDetail(Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		File file;
		// 得到上传服务器的路径
		String project_suffix = "";
		String project_id = reqs.get("project_id").toString();
		String name = reqs.get("name").toString();
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\" + name;
		try {
			file = new File(path);
			// 文件不存在
			if (!file.exists()) {
				path = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + "none.jpg";
				file = new File(path);
			}
			/* 读取图片信息 */
			Image srcFile = ImageIO.read(file);
			/*
			 * 宽高设定 BufferedImage tag = new BufferedImage(200, 200,
			 * BufferedImage.TYPE_INT_RGB); tag.getGraphics().drawImage(srcFile,
			 * 0, 0, 200, 200, null);
			 */

			// response.setContentType("image/*"); // 设置返回的文件类型
			// OutputStream out = response.getOutputStream(); //
			// 得到向客户端输出二进制数据的对象
			// JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			// JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tag);

			/* 压缩质量 */
			// jep.setQuality(1, true);
			// encoder.encode(tag, jep);

			// out.close();
			FileInputStream hFile = new FileInputStream(file);
			// 得到文件大小
			int i = hFile.available();
			byte data[] = new byte[i];
			// 读数据
			hFile.read(data);

			// 得到向客户端输出二进制数据的对象
			OutputStream out = response.getOutputStream();
			// 输出数据
			out.write(data);

			out.flush();
			out.close();
			hFile.close();
			srcFile.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<Map<String, Object>> getProjectByGroup(Map<String, Object> reqs, String user_id) {
		// TODO Auto-generated method stub
		Integer page = Integer.parseInt(reqs.remove("page").toString());
		int start = 10*(page-1);
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("user_id", user_id);
		String project_group = projectSimpleDao.retrieve("db_user", conds).get("user_group").toString();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("project_group", project_group);
		String sql = "select * from db_project where project_group='"+project_group+"' order by update_time desc limit "+start+",8";
		return projectSimpleDao.queryForList(sql, map);
	}
	
	@Override
	public Integer getProjectNumByGroup(Map<String, Object> reqs, String user_id) {
		// TODO Auto-generated method stub
		String sql = new String();
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("user_id", user_id);
		String project_group = projectSimpleDao.retrieve("db_user", conds).get("user_group").toString();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("project_group", project_group);
		sql = "select * from db_project where project_group='"+project_group+"'";
		return projectSimpleDao.queryForList(sql, map).size();
	}
	
	@Override
	public Map<String, Object> getProjectInfoDetail(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		return projectSimpleDao.retrieve("db_project", reqs);
	}

	@Override
	public String updatePic(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 得到上传的文件
		MultipartFile mFile = multipartRequest.getFile(reqs.get("file_select").toString());
		String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
		String project_id = reqs.get("project_id").toString();
		String pic_name = project_id + "_" + reqs.get("i").toString();
		String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
		String path2 = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\" + pic_name + suffix;
		File[] files = new File(path1).listFiles();
		for(int i=0;i<files.length;i++) {
			String name = files[i].getName();
			if(!name.split("_")[1].substring(0, 1).equals("a"))
			    files[i].delete();
		}
		InputStream inputStream;
		try {
			inputStream = mFile.getInputStream();
			byte[] b = new byte[10485760];
			int length = inputStream.read(b);
			// 文件流写到服务器端
			FileOutputStream outputStream = new FileOutputStream(path2);
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
	public String updateProjectWithoutFile(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String result = "success";
		reqs.put("update_time", new Date(new java.util.Date().getTime()));
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("project_id", reqs.remove("project_id").toString());
		Integer prev_status = (Integer) projectSimpleDao.retrieve("db_project", conds).get("project_status");
		Integer curr_status = Integer.parseInt(reqs.get("project_status").toString());
		
		try {
			projectSimpleDao.update("db_project", reqs, conds);
			
			
			
			Double score = (double) 0;
			if(prev_status==3 && curr_status==2)
				score = (double) 4;
			else if(prev_status==3 && curr_status==1)
				score = (double) 9;
			else if(prev_status==2 && curr_status==1)
				score = (double) 5;
			String[] authors = reqs.get("author").toString().split("#");
			for(int i=0;i<authors.length;i++) {
				String name = authors[i];
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("name", name);
				String user_id = projectSimpleDao.queryForList("select user_id from db_user where name=:name", params).get(0).get("user_id").toString();
				Map<String, Object> conds2 = new HashMap<String, Object>();
				conds2.put("user_id", user_id);
				Map<String, Object> row = new HashMap<String, Object>();
				Double month_score = (Double) projectSimpleDao.retrieve("db_user", conds2).get("month_score");
				month_score += score;
				row.put("month_score", month_score);
				projectSimpleDao.update("db_user", row, conds2);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	@Override
	public String updateProjectWithFile(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String result = "success";
		reqs.put("update_time", new Date(new java.util.Date().getTime()));
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("project_id", reqs.remove("project_id").toString());
		Map<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("file_select", reqs.remove("file_select"));
		Integer prev_status = (Integer) projectSimpleDao.retrieve("db_project", conds).get("project_status");
		Integer curr_status = Integer.parseInt(reqs.get("project_status").toString());
		try {
			projectSimpleDao.update("db_project", reqs, conds);
			String project_id = conds.get("project_id").toString();
			String realPath = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\";
			File[] files = new File(realPath).listFiles();
			for(int i=0;i<files.length;i++) {
				String name = files[i].getName();
				if(name.split("_")[1].subSequence(0, 1).equals("a")) {
					files[i].delete();
					break;
				}
			}
			File file = new File(realPath);
			file.mkdirs();
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			// 得到上传的文件
			MultipartFile mFile = multipartRequest.getFile(fileMap.remove("file_select").toString());
			String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
			String file_name = project_id + "_" + "all";

			String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/project") + "\\" + project_id + "\\" + file_name + suffix;
			File file2 = new File(path1);
			if (file2.exists()) {
				file2.delete();
			}
			InputStream inputStream;
			inputStream = mFile.getInputStream();
			byte[] b = new byte[1048576];
			int length = inputStream.read(b);
			// 文件流写到服务器端
			FileOutputStream outputStream = new FileOutputStream(path1);
			outputStream.write(b, 0, length);
			inputStream.close();
			outputStream.close();
			
			Double score = (double) 0;
			if(prev_status==3 && curr_status==2)
				score = (double) 4;
			else if(prev_status==3 && curr_status==1)
				score = (double) 9;
			else if(prev_status==2 && curr_status==1)
				score = (double) 5;
			String[] authors = reqs.get("author").toString().split("#");
			for(int i=0;i<authors.length;i++) {
				String name = authors[i];
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("name", name);
				String user_id = projectSimpleDao.queryForList("select user_id from db_user where name=:name", params).get(0).get("user_id").toString();
				Map<String, Object> conds2 = new HashMap<String, Object>();
				conds2.put("user_id", user_id);
				Map<String, Object> row = new HashMap<String, Object>();
				Double month_score = (Double) projectSimpleDao.retrieve("db_user", conds2).get("month_score");
				month_score += score;
				row.put("month_score", month_score);
				projectSimpleDao.update("db_user", row, conds2);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
}
