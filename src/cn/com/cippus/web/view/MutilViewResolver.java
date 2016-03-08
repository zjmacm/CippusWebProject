package cn.com.cippus.web.view;

import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.Ordered;
import org.springframework.http.MediaType;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationObjectSupport;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;

/**
 * 多视图解析器; 解决Spring的多视图集成配置中的问题�? 先查找视图再进行类型匹配顺序; VelocityViewResolver
 * 找不到指定视图会记录�?条ERROR日志;
 * 
 * @author chenr
 * @version 2.0.1, 2011-7-5
 * 
 * @ses {@link org.springframework.web.servlet.view.ContentNegotiatingViewResolver}
 */
public class MutilViewResolver extends WebApplicationObjectSupport implements
		ViewResolver, Ordered {

	private static final Log logger = LogFactory
			.getLog(MutilViewResolver.class);

	private int order = Ordered.HIGHEST_PRECEDENCE;

	private String parameterName = "format";

	public void setOrder(int order) {
		this.order = order;
	}

	public int getOrder() {
		return this.order;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}

	public String getParameterName() {
		return this.parameterName;
	}

	public View resolveViewName(String viewName, Locale locale)	throws Exception {

		View view = null;

		// 先看看是否有format参数�?
		RequestAttributes attrs = RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = ((ServletRequestAttributes) attrs).getRequest();
		String format = (String) request.getParameter(parameterName);

		if (format != null && format.length() > 0) {
			if ("json".equals(format)) {
				return (View) getApplicationContext().getBean("jsonView");
			} else if ("download".equals(format)) {
				return (View) getApplicationContext().getBean("downloadView");
			} else if ("xml".equals(format)) {
				return (View) getApplicationContext().getBean("xmlView");
			} else if ("excel".equals(format)) {
				return (View) getApplicationContext().getBean("excelView");
			}
		}
		
		//2013/12/20修改，系统最多的交互就是json, 返回json数据是最多的调用
		//即使format是空，但是viewName是默认的路径，那么也派发到jsonView
		if(viewName.equals("common/data")) {
			System.out.println("-------json view");
			return (View) getApplicationContext().getBean("jsonView");
		}
		
		 // 先使用jsp解析，如果没有则使用velocity
		ViewResolver jspViewResolver = (ViewResolver) getApplicationContext().getBean("jspViewResolver");
		view = jspViewResolver.resolveViewName(viewName, locale);
		if (view != null) {
			return view;
		}
		
		ViewResolver velocityViewResolver = (ViewResolver) getApplicationContext().getBean("velocityViewResolver");
		view = velocityViewResolver.resolveViewName(viewName,locale);
		if (view != null) {
			return view;
		}
		
		return NOT_ACCEPTABLE_VIEW;

	}

	private static final View NOT_ACCEPTABLE_VIEW = new View() {

		public String getContentType() {
			return null;
		}

		public void render(Map<String, ?> model, HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
		}
	};
}
