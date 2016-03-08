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
import cn.com.cippus.web.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired
	private SimpleDao userSimpleDao;

	public SimpleDao getUserSimpleDao() {
		return userSimpleDao;
	}

	public void setUserSimpleDao(SimpleDao userSimpleDao) {
		this.userSimpleDao = userSimpleDao;
	}

	@Override
	public Map<String, Object> userLogin(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Map<String, Object> result = new HashMap<String, Object>();
		String sql = "select user_id,name,number,user_type,user_group,register_time from db_user where number=:number and password=:password and user_status=1";
		List<Map<String, Object>> user = userSimpleDao.queryForList(sql, reqs);
		if(user.size()==1) {
			result.put("result", "success");
			result.put("user_id", user.get(0).get("user_id"));
			result.put("number", reqs.get("number"));
			result.put("name", user.get(0).get("name"));
			result.put("user_type", user.get(0).get("user_type"));
			result.put("user_group", user.get(0).get("user_group"));
			result.put("register_time", user.get(0).get("register_time"));
		}
		else {
			result.put("result", "failed");
		}
		return result;
	}

	@Override
	public String userRegister(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String number = reqs.get("number").toString();
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("number", number);
		String result = "success";
		String sql = "select * from db_user where number='"+number+"'";
		//sql语句传入了一个HashMap对象，所以number要转换成Object;
		if(userSimpleDao.queryForList(sql, new HashMap<String, Object>()).size()>0)
			result = "repeat";
		else {
			try {
				Date date = new Date(new java.util.Date().getTime());
				reqs.put("user_id", IdUtil.uuid());
				reqs.put("user_type", 0);
				reqs.put("user_status", 0);
				reqs.put("register_time", date);
				userSimpleDao.create("db_user", reqs);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				result = "failed";
			}
		}
		return result;
	}
	
	@Override
	public Integer getUserType(String user_id) {
		// TODO Auto-generated method stub
		String sql = "select user_type from db_user where user_id='"+user_id+"'";
		return (Integer) userSimpleDao.queryForList(sql, new HashMap<String, Object>()).get(0).get("user_type");
	}
	
	@Override
	public Map<String, Object> getUserInfo(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Map<String, Object> conds = new HashMap<String, Object>();
		
		conds.put("user_id", reqs.get("user_id"));
		System.out.println("user_id:"+reqs.get("user_id"));
		System.out.println("helloworld!");
		System.out.println("user_id:" + conds.get("user_id"));
		System.out.println(userSimpleDao.retrieve("db_user", conds));
		return userSimpleDao.retrieve("db_user", conds);
	}
	
	public void updateToTemp(Map<String, Object> reqs, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		File file;
		// 得到上传服务器的路径
		String path = "";
		String user_pic_suffix = "";
		String user_id = reqs.get("group_id").toString();
        String type = reqs.get("type").toString();
        try {
        	if(type.equals("0")) {
    		    path = request.getSession().getServletContext().getRealPath("/WEB-INF/work") + "\\";
    		    File[] arrayFiles = new File(path).listFiles();
    		    for(int i=0;i<arrayFiles.length;i++) {
    		    	String file_name = arrayFiles[i].getName();
    				if(arrayFiles[i].getName().substring(0, 32).equals(user_id)) {
    					String suffix = file_name.substring(file_name.lastIndexOf(".") + 1);
    					user_pic_suffix = suffix;
    					break;
    				}
    			}
    		    path = request.getSession().getServletContext().getRealPath("/WEB-INF/work") + "\\" + user_id + "." + user_pic_suffix;
            }
            
            else {
            	path = request.getSession().getServletContext().getRealPath("/WEB-INF/temporary") + "\\";
    		    File[] arrayFiles = new File(path).listFiles();
    		    for(int i=0;i<arrayFiles.length;i++) {
    		    	String file_name = arrayFiles[i].getName();
    				if(arrayFiles[i].getName().substring(0, 32).equals(user_id)) {
    					String suffix = file_name.substring(file_name.lastIndexOf(".") + 1);
    					user_pic_suffix = suffix;
    					break;
    				}
    			}
    		    path = request.getSession().getServletContext().getRealPath("/WEB-INF/temporary") + "\\" + user_id + "." + user_pic_suffix;
            }
		} catch (Exception e) {
			// TODO: handle exception
			path = request.getSession().getServletContext().getRealPath("/WEB-INF/user_pic") + "\\" + "user_pic.png";
		}
		

		try {
			file = new File(path);
			// 文件不存在
			if (!file.exists()) {
				path = request.getSession().getServletContext().getRealPath("/WEB-INF/user_pic") + "\\" + "user_pic.png";
				file = new File(path);
			}
			/* 读取图片信息 */
			//Image srcFile = ImageIO.read(file);
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
			//srcFile.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void delete(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF") + "/temporary";
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
	
	// 图片上传到临时文件夹
	@Override
	public String upload_pic(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// 得到上传的文件
		MultipartFile mFile = multipartRequest.getFile("file_select");
		String suffix = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf("."));
		// 得到上传服务器的路径
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF")+ "/temporary";
		(new File(path)).mkdirs(); // 如果文件夹不存在,则建立临时文件夹
		String path1 = request.getSession().getServletContext().getRealPath("/WEB-INF/temporary") + "\\" + reqs.get("user_id") + suffix;
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
	public String saveUserPic(Map<String, Object> reqs, HttpServletRequest request) {
		// TODO Auto-generated method stub
		String result = "success";
		String user_id = reqs.get("user_id").toString();
		try {
			String user_pic_suffix = new String();
			String oldpath = request.getSession().getServletContext().getRealPath("/WEB-INF/temporary") + "\\";
			File[] arrayFiles = new File(oldpath).listFiles();
//			for(int i=0;i<arrayFiles.length;i++) {
//				if(arrayFiles[i].getName().substring(0, 32).equals(user_id)) {
//					String suffix = arrayFiles[i].getName().substring(arrayFiles[i].getName().lastIndexOf("."));
//					oldpath += user_id + suffix;
//					user_pic_suffix = suffix;
//					break;
//				}
//			}
		    for(int i=0;i<arrayFiles.length;i++) {
		    	String file_name = arrayFiles[i].getName();
				if(arrayFiles[i].getName().substring(0, 32).equals(user_id)) {
					String suffix = file_name.substring(file_name.lastIndexOf(".") + 1);
					user_pic_suffix = suffix;
					oldpath += user_id + "." + suffix;
					break;
				}
			}
			String imagepath = request.getSession().getServletContext().getRealPath("/WEB-INF/user_pic") + "\\" + user_id + "." + user_pic_suffix;
//			String imagepath = request.getSession().getServletContext()
//					.getRealPath("/WEB-INF/user_pic")
//					+ "\\" + user_id + ".jpg";
//			String oldpath = request.getSession().getServletContext()
//					.getRealPath("/WEB-INF/temporary")
//					+ "\\" + user_id + ".jpg";
			File file = new File(request.getSession().getServletContext().getRealPath("/WEB-INF/user_pic") + "\\");
			if(file.exists()==false)
				file.mkdirs();
			copy(oldpath, imagepath);
			deleteFile(oldpath);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	private void copy(String fileFrom, String fileTo) {  
        try {  
            FileInputStream in = new java.io.FileInputStream(fileFrom);  
            FileOutputStream out = new FileOutputStream(fileTo);  
            byte[] bt = new byte[1024];  
            int count;  
            while ((count = in.read(bt)) > 0) {  
                out.write(bt, 0, count);  
            }  
            in.close();  
            out.close();   
        } catch (IOException ex) {  
            ex.printStackTrace();
        }  
    }
	
	@Override
	public String saveUserInfo(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("user_id", reqs.remove("user_id"));
		try {
			userSimpleDao.update("db_user", reqs, conds);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}
	
	@Override
	public String isPasswordCorrect(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String old_password = reqs.remove("password").toString();
	    String password = userSimpleDao.retrieve("db_user", reqs).get("password").toString();
	    if(old_password.endsWith(password))
	    	return "success";
	    else {
			return "failed";
		}
	}
	
	@Override
	public String passwordCorrect(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("password", reqs.remove("password"));
		String result = "success";
		try {
			userSimpleDao.update("db_user", row, reqs);
		} catch (Exception e) {
			// TODO: handle exception
			result = "failed";
		}
		return result;
	}
	
	@Override
	public Map<String, Object> getUserBasicInfo(String user_id) {
		// TODO Auto-generated method stub
		Map<String, Object> conds = new HashMap<String, Object>();
		conds.put("user_id", user_id);
		return userSimpleDao.retrieve("db_user", conds);
	}
	
	@Override
	public String publishContribute(Map<String, Object> reqs) {
		// TODO Auto-generated method stub
		String result = "success";
		reqs.put("news_id", IdUtil.uuid());
		reqs.put("publish_time", new Date(new java.util.Date().getTime()));
		reqs.put("focus", 0);
		reqs.put("type", 9);
		reqs.put("attachment", 0);
		try {
			userSimpleDao.create("db_news", reqs);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = "failed";
		}
		return result;
	}

	@Override
	public void get_pic(Map<String, Object> reqs, HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		File file;
		// 得到上传服务器的路径

        String path = "";
		String user_id = reqs.get("user_id").toString();
		String type = reqs.get("type").toString();
		if(type.equals("0")) {
			path = request.getSession().getServletContext().getRealPath("/WEB-INF/user_pic") + "\\";
			File[] arrayFiles = new File(path).listFiles();
			System.out.println(path);
		    for(int i=0;i<arrayFiles.length;i++) {
		    	String file_name = arrayFiles[i].getName();
				if(arrayFiles[i].getName().substring(0, 32).equals(user_id)) {
					String suffix = file_name.substring(file_name.lastIndexOf(".") + 1);
					path += user_id + "." + suffix;
					break;
				}
			}
		    
		}
		else if(type.equals("1")) {
			path = request.getSession().getServletContext().getRealPath("/WEB-INF/temporary") + "\\";
			File[] arrayFiles = new File(path).listFiles();

		    for(int i=0;i<arrayFiles.length;i++) {
		    	String file_name = arrayFiles[i].getName();
				if(arrayFiles[i].getName().substring(0, 32).equals(user_id)) {
					String suffix = file_name.substring(file_name.lastIndexOf(".") + 1);
					path += user_id + "." + suffix;
					break;
				}
			}
		}
		System.out.println("path:" + path);
		try {
			file = new File(path);
			// 文件不存在
			if (!file.exists()) {
				path = request.getSession().getServletContext()
						.getRealPath("/WEB-INF/user_pic")
						+ "\\" + "user_pic.png";
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
}
