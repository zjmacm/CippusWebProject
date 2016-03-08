package cn.com.cippus.web.view;

import java.util.*;
import java.io.*;

import org.dom4j.*;
import org.dom4j.io.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.support.WebApplicationObjectSupport;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;

//调用此类，必须在model中有document, XML DOM4J文档对象
//调用之前，需要设置document对象的属�?
//document.setXMLEncoding("UTF-8");

/*
 * 
 * 
 *
 * 		Document document = DocumentHelper.createDocument();
		document.setXMLEncoding("GBK");
		Element root = document.addElement("students");
		root.addNamespace("", "http://www.abc.com/ns/test"); // 添加命名空间
		root.addNamespace("t", "http://www.abc.com/ns/test");
		root.addNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance");
		root.addAttribute("xsi:schemaLocation",
				"http://www.abc.com/ns/test student.xsd");

		for (int i = 0; i < s.size(); i++) {
			Student stu = s.get(i);
			Element e1 = root.addElement("student",
					"http://www.abc.com/ns/test");
			// e1.addNamespace("", "http://www.abc.com/ns/test");

			e1.addElement("id").addText(stu.getId());
			e1.addElement("name").addText(stu.getName());
			e1.addElement("email").addText(stu.getEmail());
			e1.addElement("gender").addText(stu.getGender() ? "�?" : "�?");
			e1.addElement("age").addText("" + stu.getAge());
			e1.addElement("java").addText("" + stu.getJava());

		}
 */

public class XmlView implements View {

	@Override
	public String getContentType() {
		return "application/xml; charset=utf-8";
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
			
		Document document = (Document) model.get("document");
		
		OutputStreamWriter osw = new OutputStreamWriter(response.getOutputStream(), "UTF-8");
		OutputFormat of = new OutputFormat();
		of.setEncoding("UTF-8"); // 设置编码
		of.setIndent(true); // 设置XML元素缩进格式
		of.setIndent("    "); // 设置缩进空白字符串为4个空白符
		of.setNewlines(true); // 分行存储
		
		XMLWriter writer = new XMLWriter(osw, of);
		
		writer.write(document);
		writer.close();
		
		response.getOutputStream().close();
	}

}
