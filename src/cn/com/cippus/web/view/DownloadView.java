package cn.com.cippus.web.view;

import java.util.*;
import java.io.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.View;

//调用此类，必须在model中有filename, 下载的文件名称，可以包含中文字符�?

//可以有物理路径realFilename, 路径！相对于/WEB-INF/files的绝对路�?
//也可以包括一个ByteArrayInputStream, bais对象！名称为bais

public class DownloadView implements View {

	@Override
	public String getContentType() {
		return "application/x-download; charset=utf-8";
	}

	@Override
	public void render(Map<String, ?> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		if (request.getProtocol().equals("HTTP/1.0")) {
			// HTTP 1.0
			response.setHeader("Pragma", "no-cache");
		} else {
			// HTTP 1.1 or later
			response.setHeader("Cache-Control", "no-cache");
		}
		
		String filename = (String) model.get("filename");
		String filename2 = java.net.URLEncoder.encode(filename,"utf-8");
		response.setHeader("Content-Disposition", "attachment;filename=\"" + filename2  + "\"");
		
	
		//读一个文件，然后进行下载�?
		//如果文件不存在呢�?
		//文件�?在的目录�?/WEB-INF/files为基准目�?
		boolean fileExist = false;
		String realFilename = (String) model.get("realFilename");
		if(realFilename!=null && realFilename.length()>0) {		
			String parent = request.getServletContext().getRealPath("/WEB-INF/files");
			File f = new File(parent,realFilename);
			if(f.exists()) {  	//文件存在
				long len = f.length();
				response.setHeader("Content-Length", String.valueOf((int)len));
				FileInputStream fis = new FileInputStream(f);
				BufferedInputStream bis = new BufferedInputStream(fis);
				OutputStream os = response.getOutputStream();
				int c = 0;
				byte[] buffer = new byte[8192];
				while((c=bis.read(buffer))!=-1) {
					os.write(buffer,0,c);
				}
				os.flush(); os.close();
				fileExist = true;
			}
		}
	
		if(!fileExist) {  //输出bais对象中的数据
			ByteArrayInputStream bais = (ByteArrayInputStream) model.get("bais");
			if(bais!=null) {
				int len = 0;
				ByteArrayOutputStream baos = new ByteArrayOutputStream(256*1024);
				int c = 0;
				byte[] buffer = new byte[8192];
				while((c=bais.read(buffer))!=-1) {
					baos.write(buffer,0,c);
					len += c;
				}
				
				response.setHeader("Content-Length", String.valueOf(len));
				
				response.getOutputStream().write(baos.toByteArray());
				response.getOutputStream().flush();
				response.getOutputStream().close();
				
			}
			else {
				response.setHeader("Content-Length", "0");
				response.getOutputStream().close();
			}
		}
		
		
	}

}
