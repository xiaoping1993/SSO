package com.Perkinelmer.SSO.Filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 
@WebFilter(urlPatterns = {"/Api/*"},filterName = "MyFilter")
public class MyFilter implements Filter{
	
	private static final Logger log = LoggerFactory.getLogger(MyFilter.class);
	
	@Override
    public void init(FilterConfig filterConfig) throws ServletException {
 
    }

	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        /*HttpServletRequest httpServletRequest = (HttpServletRequest)request;
		Map<String, String> paramMap = servletParameterMapToMap(httpServletRequest.getParameterMap());
		String uri = httpServletRequest.getRequestURI();
		log.info("请求地址 ： " + uri + "，请求方式：" + httpServletRequest.getMethod() + "，请求的参数列表 ： " + paramMap);*/
		//验证是否有效登录，非法登录重定向到登录页面
		HttpSession session = ((HttpServletRequest) request).getSession(false);
		if(session==null){//非法登录重定向到登录页面
			((HttpServletResponse ) response).sendRedirect("/SSO/login.html");
			return;
		}
		filterChain.doFilter(request, response);
    }
 
	@Override
    public void destroy() {
 
    }
	
    // 参数处理
	@SuppressWarnings("rawtypes")
	public synchronized Map<String, String> servletParameterMapToMap(Map paramMap){
		Map<String, String> map = new HashMap<String, String>();
		if(paramMap!=null){
			Iterator<?> entrys = paramMap.entrySet().iterator();
			Map.Entry entry;
			String key = null;
			String value = null;
			while(entrys.hasNext()){
				entry = (Map.Entry)entrys.next();
				
				key = (String)entry.getKey();
				Object valueObj = entry.getValue();
				if(valueObj == null){
					value = "";
				}else if(valueObj instanceof String[]){
					String values[] = (String[])valueObj;
					for(String tval:values){
						value = tval + ",";
					}
					value = value.substring(0,value.length()-1);
				}else{
					value = valueObj.toString();
				}
				map.put(key, value);
			}
		}
		return map;
	}
}
