package cn.com.cippus.web.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.org.apache.bcel.internal.generic.NEW;

import cn.com.cippus.web.common.IdUtil;
import cn.com.cippus.web.dao.SimpleDao;
import cn.com.cippus.web.service.AdminService;
import cn.com.cippus.web.service.UserService;

@Service("adminService")
public class AdminServiceImpl implements AdminService{

	@Autowired
	private SimpleDao adminSimpleDao;

	public SimpleDao getAdminSimpleDao() {
		return adminSimpleDao;
	}

	public void setAdminSimpleDao(SimpleDao adminSimpleDao) {
		this.adminSimpleDao = adminSimpleDao;
	}
	
	/*@Autowired
	private UserService UserService;
	
	public UserService getUserService() {
		return UserService;
	}
	
	public void setUserService(UserService userService) {
		UserService = userService;
	}*/
	
	@Override
	public Integer getRegisterNum(String user_id) {
		// TODO Auto-generated method stub
		String sql = "select count(number) from db_user where user_status=0 and user_group=(select user_group from db_user"
				+ " where user_id='"+user_id+"')";
		return (int) adminSimpleDao.count(sql);
	}

	@Override
	public List<Map<String, Object>> getAllRegister(String user_id) {
		// TODO Auto-generated method stub
		String sql = "select user_id,number,name,tel,email,register_time from db_user where user_status=0 and user_group=(select user_group from db_user"
				+ " where user_id='"+user_id+"')";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public String registerDelete(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		try {
			adminSimpleDao.delete("db_user", reqs);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	@Override
	public Map<String, Object> getRegisterDetail(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		return adminSimpleDao.retrieve("db_user", reqs);
	}
	
	@Override
	public String registerAccept(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_status", 1);
		params.put("register_time", new Date(new java.util.Date().getTime()));
		try {
			adminSimpleDao.update("db_user", params, reqs);
		} catch (Exception e) {
			// TODO: handle exception
			result = "failed";
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> getAllMembers(String user_id, Integer page) {
		// TODO Auto-generated method stub
		int start = 10*(page-1);
		String sql = "select * from db_user where user_status=1 and user_type=0 and user_group=(select user_group from db_user where user_id='"+user_id+"') order by register_time limit "+start+",12";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public String memberDelete(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		System.out.println(reqs);
		try {
			adminSimpleDao.delete("db_user", reqs);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	@Override
	public Integer getMemberNum(String user_id) {
		// TODO Auto-generated method stub
		String sql = "select count(number) from db_user where user_status=1 and user_group=(select user_group from db_user"
				+ " where user_id='"+user_id+"')";
		return (int) adminSimpleDao.count(sql);
	}
	
	@Override
	public List<Map<String, Object>> getLeaderList() {
		// TODO Auto-generated method stub
		String sql = "select * from db_user where user_type=1 and user_status=1 order by register_time desc";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}

	@Override
	public List<Map<String, Object>> getGroupMember(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String sql = "select * from db_user where user_status=1 and user_group=:group order by register_time desc";
		return adminSimpleDao.queryForList(sql, reqs);
	}
	
	// 图片上传到临时文件夹
	@Override
	public String upload_pic(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String user_id = IdUtil.uuid();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 得到上传的文件
		MultipartFile mFile = multipartRequest.getFile("file_select");
		// 得到上传服务器的路径
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF")+ "/temporary";
		(new File(path)).mkdirs(); // 如果文件夹不存在,则建立临时文件夹
		String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/temporary") + "\\" + user_id + ".jpg";
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
			return user_id;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "failed";
		}
	}
	
	@Override
	public String userAdd(Map<String, Object> reqs, HttpSession session) {
		reqs.put("user_type", 0);
		reqs.put("user_status", 1);
		reqs.put("password", "111111");
		reqs.put("user_id", IdUtil.uuid());
		reqs.put("register_time", new Date(new java.util.Date().getTime()));
		reqs.put("month_score", 0);
		String result = "success";
		try {
			adminSimpleDao.create("db_user", reqs);
		} catch (Exception e) {
			// TODO: handle exception
			result = "failed";
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> search(String user_id, Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Integer page = Integer.parseInt(reqs.get("page").toString());
		int start = 10*(page-1);
		String name = reqs.get("name").toString();
		String sql = new String();
		if(name.length()>0)
			sql = "select * from db_user where user_status=1 and user_type=0 and user_group=(select user_group from db_user where user_id='"+user_id+"') and name like '%" + name + "%' order by register_time limit "+start+",12";
		else
			sql = "select * from db_user where user_status=1 and user_type=0 and user_group=(select user_group from db_user where user_id='"+user_id+"') order by register_time limit "+start+",12";
	    return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public String addScore(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		String user_id = adminSimpleDao.queryForList("select user_id from db_user where name=:name", reqs).get(0).get("user_id").toString();
		Double month_score = (Double) adminSimpleDao.queryForList("select month_score from db_user where name=:name", reqs).get(0).get("month_score");
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("month_score", month_score+(Double)reqs.get("score"));
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("user_id", user_id);
		try {
			adminSimpleDao.update("db_user", row, conds);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> getContribute() {
		// TODO Auto-generated method stub
		String sql = "select * from db_news where type=9 order by publish_time desc";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public List<Map<String, Object>> getNews1() {
		// TODO Auto-generated method stub
		String sql = "select * from db_news where type=0 order by publish_time desc limit 0,8";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public List<Map<String, Object>> getNews2() {
		// TODO Auto-generated method stub
		String sql = "select * from db_news where type=1 order by publish_time desc limit 0,6";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public List<Map<String, Object>> getProject() {
		// TODO Auto-generated method stub
		String sql = "select * from db_project order by update_time limit 0,1";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public List<Map<String, Object>> getResources() {
		// TODO Auto-generated method stub
		String sql = "select * from db_resources order by upload_time limit 0,8";
		return adminSimpleDao.queryForList(sql, new HashMap<String, Object>());
	}
	
	@Override
	public List<Map<String, Object>> getStar() {
		// TODO Auto-generated method stub
		return null;
	}
}
