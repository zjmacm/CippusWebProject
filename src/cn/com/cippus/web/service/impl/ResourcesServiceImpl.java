package cn.com.cippus.web.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jdk.nashorn.internal.runtime.regexp.joni.ast.ConsAltNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lowagie.tools.handout_pdf;

import cn.com.cippus.web.common.IdUtil;
import cn.com.cippus.web.dao.SimpleDao;
import cn.com.cippus.web.mail.MailSender;
import cn.com.cippus.web.service.ResourcesService;

@Service("resourcesService")
public class ResourcesServiceImpl implements ResourcesService{

	@Autowired
	private SimpleDao resourcesSimpleDao;

	public SimpleDao getResourcesSimpleDao() {
		return resourcesSimpleDao;
	}

	public void setResourcesSimpleDao(SimpleDao resourcesSimpleDao) {
		this.resourcesSimpleDao = resourcesSimpleDao;
	}

	@Override
	public Integer getResourcesNum(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Integer resources_type = Integer.parseInt(reqs.get("resources_type").toString());
		String sql = new String();
		if(resources_type==0)
			return resourcesSimpleDao.listAll("db_resources").size();
		else
		    sql = "select * from db_resources where resources_type1='"+resources_type+"'";
		return resourcesSimpleDao.queryForList(sql, new HashMap<String, Object>()).size();
	}
	/**
	 * 这个没太懂
	 */
	@Override
	public List<Map<String, Object>> getResources(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Integer resources_type = Integer.parseInt(reqs.get("resources_type").toString());
		Integer page = Integer.parseInt(reqs.get("page").toString());
		String sql = new String();
		if(resources_type==0) {
			int start = 10*(page-1);
			sql = "select * from db_resources where resources_status=1 order by upload_time desc limit "+start+",10";
		}
		else {
			int start = 10*(page-1);
			sql = "select * from db_resources where resources_status=1 and resources_type1="+resources_type+" order by upload_time desc limit "+start+",10";
		}
		return resourcesSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public String addResourcesLink(Map<String, Object> reqs, HttpSession session) {
		// TODO Auto-generated method stub
		String result = "success";
		String user_type = session.getAttribute("user_type").toString();
		if(user_type.equals("0")) {
			reqs.put("resources_status", 0);
			result = "success_1";
		}
		else {
			reqs.put("resources_status", 1);
		}
		reqs.put("upload_user", session.getAttribute("name"));
		reqs.put("resources_id", IdUtil.uuid());
		reqs.put("upload_time", new Date(new java.util.Date().getTime()));
		reqs.put("upload_group", getUserGroup(session.getAttribute("user_id").toString()));
		reqs.put("link_file", 0);
		try {
			resourcesSimpleDao.create("db_resources", reqs);
			if(user_type.equals("1")) {
				String user_id = session.getAttribute("user_id").toString();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("user_id", user_id);
				Double score = (Double) resourcesSimpleDao.retrieve("db_user", map).get("month_score");
				score+=0.5;
				System.out.println(score);
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("month_score", score);
				System.out.println(resourcesSimpleDao.update("db_user", map2, map));
			}
			else {
				String user_id = session.getAttribute("user_id").toString();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("user_id", user_id);
				String user_group = resourcesSimpleDao.retrieve("db_user", map).get("user_group").toString();
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("user_group", user_group);
				String sql = "select email from db_user where user_type=1 and user_group=:user_group";
				String email = resourcesSimpleDao.queryForList(sql, map2).get(0).get("email").toString();
				String content = "你的组员发布了新的学习资源、请尽快进行审核";
				MailSender.sendMail(email, content);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}

	private String getUserGroup(String user_id) {
		// TODO Auto-generated method stub
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("user_id",user_id);
		return resourcesSimpleDao.retrieve("db_user", conds).get("user_group").toString();
	}

	@Override
	public String addResourcesFile(Map<String, Object> reqs, HttpSession session, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String result = "success";
		String user_type = session.getAttribute("user_type").toString();
		if(user_type.equals("0")) {
			reqs.put("resources_status", 0);
			result = "success_1";
		}
		else {
			reqs.put("resources_status", 1);
		}
		String resources_id = IdUtil.uuid();
		reqs.put("upload_user", session.getAttribute("name"));
		reqs.put("resources_id", resources_id);
		reqs.put("upload_time", new Date(new java.util.Date().getTime()));
		reqs.put("upload_group", getUserGroup(session.getAttribute("user_id").toString()));
		reqs.put("link_file", 1);
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			// 得到上传的文件
			MultipartFile mFile = multipartRequest.getFile(reqs.remove("file_select").toString());
			String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
			Random r = new Random();
			Double d = r.nextDouble();
			String s = d + "";
			s=s.substring(3,3+6);
			
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
			String new_name = df.format(new java.util.Date())+"_"+s+suffix;
			
			String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/resources") + "\\" + resources_id + "\\" + new_name;

			File file2 = new File(request.getSession().getServletContext().getRealPath("/WEB-INF/resources") + "\\" + resources_id + "\\");
			if(file2.exists()==false)
				file2.mkdirs();
			InputStream inputStream;
			inputStream = mFile.getInputStream();
			byte[] b = new byte[1048576];
			int length = inputStream.read(b);
			// 文件流写到服务器端
			FileOutputStream outputStream = new FileOutputStream(path1);
			outputStream.write(b, 0, length);
			inputStream.close();
			outputStream.close();
			reqs.put("real_name", new_name);
			resourcesSimpleDao.create("db_resources", reqs);
			//1为管理员
			if(user_type.equals("1")) {
				String user_id = session.getAttribute("user_id").toString();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("user_id", user_id);
				Double score = (Double) resourcesSimpleDao.retrieve("db_user", map).get("month_score");
				score+=0.5;
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("month_score", score);
				resourcesSimpleDao.update("db_user", map2, map);
			}
			else {
				String user_id = session.getAttribute("user_id").toString();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("user_id", user_id);
				String user_group = resourcesSimpleDao.retrieve("db_user", map).get("user_group").toString();
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("user_group", user_group);
				String sql = "select email from db_user where user_type=1 and user_group=:user_group";
				String email = resourcesSimpleDao.queryForList(sql, map2).get(0).get("email").toString();
				String content = "你的组员发布了新的学习资源、请尽快进行审核";
				MailSender.sendMail(email, content);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> search(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String upload_group = reqs.get("upload_group").toString();
		String resources_name = reqs.get("resources_name").toString().trim();
		Integer page = Integer.parseInt(reqs.get("page").toString());
		int start = 10*(page-1);
		String sql = "select * from db_resources where 1=1";
		if(!"0".equals(upload_group))
			sql += " and upload_group='" + upload_group + "'";
		if(resources_name.length()>0)
			sql += " and resources_name like '%" + resources_name + "%'";
		sql += " order by upload_time desc limit "+start+",10";
		return resourcesSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public Integer searchNum(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String upload_group = reqs.get("upload_group").toString();
		String resources_name = reqs.get("resources_name").toString().trim();
		String sql = "select * from db_resources where 1=1";
		if(!"0".equals(upload_group))
			sql += " and upload_group='" + upload_group + "'";
		if(resources_name.length()>0)
			sql += " and resources_name like '%" + resources_name + "%'";
		return resourcesSimpleDao.queryForList(sql, new HashMap<String, Object>()).size();
	}

	@Override
	public Map<String, Object> getResourcesInfo(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		return resourcesSimpleDao.retrieve("db_resources", reqs);
	}
	
	@Override
	public String getFileRealName(String resources_id) {
		// TODO Auto-generated method stub
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("resources_id", resources_id);
		return resourcesSimpleDao.queryForList("select real_name from db_resources where resources_id=:resources_id", paramsMap).get(0).get("real_name").toString();
	}
	
	public Integer getRegisterNum(String user_id) {
		// TODO Auto-generated method stub
		String sql = "select count(resources_id) from db_resources where resources_status=0 and upload_group=(select user_group from db_user"
				+ " where user_id='"+user_id+"')";
		return (int) resourcesSimpleDao.count(sql);
	}

	@Override
	public List<Map<String, Object>> getAllRegister(String user_id) {
		// TODO Auto-generated method stub
		String sql = "select resources_id,resources_name,upload_user,upload_time,resources_type1,resources_type2 from db_resources where resources_status=0 and upload_group=(select user_group from db_user"
				+ " where user_id='"+user_id+"')";
		return resourcesSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public String resourcesRegisterDelete(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		try {
			resourcesSimpleDao.delete("db_resources", reqs);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public String resourcesRegisterAccept(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		Map<String,Object> row = new HashMap<String, Object>();
		row.put("resources_status", 1);
		try{
			resourcesSimpleDao.update("db_resources", row, reqs);
		}catch(Exception e){
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	@Override
	public String acceptResources(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("resources_status", 1);
		try {
			resourcesSimpleDao.update("db_resources",  row, reqs);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}

	
}
