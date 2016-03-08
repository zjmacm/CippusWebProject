package cn.com.cippus.web.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import cn.com.cippus.web.view.Model;



/**
 * Controller层的异常处理�?
 * @author chenr
 * @version 2.0.0, 2011-6-23
 * 
 * @modify by chenr, 2011-07-19, 
 * 在使用了cn.com.higinet.rapid.web.view.MutilViewResolver之后�?
 * Model可以被一致的处理了，而不�?要单独调用MessageConverter去转�?
 * 
 * 
 * @see org.springframework.web.servlet.HandlerExceptionResolver
 * 
 */
public class ControllerHandlerExceptionResolver implements HandlerExceptionResolver {

	private static final Log logger = LogFactory.getLog(ControllerHandlerExceptionResolver.class);
	
//	/**
//	 * 消息转化（HTTP报体内容转化�?
//	 */
//	private HttpMessageConverter<?>[] messageConverters =
//		new HttpMessageConverter[0];
//
//	public void setMessageConverters(HttpMessageConverter<?>[] messageConverters) {
//		this.messageConverters = messageConverters;
//	}
	
	/* (non-Javadoc)
	 * 处理异常
	 * @see org.springframework.web.servlet.HandlerExceptionResolver#resolveException(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, java.lang.Exception)
	 */
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		
//		String contentType = request.getContentType();
		if(logger.isDebugEnabled())
			logger.debug("contentType: "+ request.getContentType());
		Model model = new Model();
		model.addError(ex + ": " + ex.getMessage());
		//打印更多信息,帮助定位错误
		String msg = "uri: "+request.getRequestURI();
		msg = msg + ", handler: "+handler;
		logger.error(msg, ex);
		
//		try{
//			HttpInputMessage inputMessage = new ServletServerHttpRequest(request);
//			List<MediaType> acceptedMediaTypes = inputMessage.getHeaders().getAccept();
//			if (acceptedMediaTypes.isEmpty()) {
//				acceptedMediaTypes = Collections.singletonList(MediaType.ALL);
//			}
//			MediaType.sortByQualityValue(acceptedMediaTypes);
//			HttpOutputMessage outputMessage = new ServletServerHttpResponse(response);
//			if (this.messageConverters != null) {
//				for (MediaType acceptedMediaType : acceptedMediaTypes) {
//					for ( HttpMessageConverter messageConverter : this.messageConverters) {
//						if (messageConverter.canWrite(Model.class, acceptedMediaType)) {
//							messageConverter.write(model.getModel(), acceptedMediaType, outputMessage);
//							return new ModelAndView();
//						}
//					}
//				}
//			}
//		}catch(Exception e){
//			e.printStackTrace();
//		}
		return model;
	}

}
