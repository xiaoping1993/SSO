package com.Perkinelmer.SSO.AOP;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import com.Perkinelmer.SSO.Mapper.CommonMapper;
import com.alibaba.fastjson.JSONObject;

@Component
@Aspect
public class Aop {
	@Autowired
	private CommonMapper commonMapper;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		private static Logger logger = LoggerFactory.getLogger(Aop.class);
		 @Around("execution(* com.Perkinelmer.SSO.Controller.LoginController.*(..)) || execution(* com.Perkinelmer.SSO.Controller.ApiController.*(..))")
		    public Object aroundMethod(ProceedingJoinPoint pjd){
			 	String userId = "";
			 	HttpServletRequest request=((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
				HttpSession session = request.getSession(false);//执行方法前的用户ID
				if(session!=null){//这样就确保了方法执行前后只要一个位置有就能拿到值
					userId = session.getAttribute("userId").toString();
				}
		        Object result = null;
		        String time = sdf.format(new Date());
		        try {
		            //执行目标方法
		            result = pjd.proceed();
		        } catch (Throwable e) {
		            throw new RuntimeException(e);
		        }
		        try {
		        	//获取方法名编号
					String functionName = pjd.getSignature().getName();
					Object[] args = pjd.getArgs();
					String param="";
					for (int i = 0; i < args.length; i++) {
						param+="第" + (i+1) + "个参数为:";
						param+=(args[i]==null||args[i]=="")?null:args[i].toString();
						param+=";";
				    }
					if(userId ==""){
						session = request.getSession(false);
						if(session!=null){//这样就确保了方法执行前后只要一个位置有就能拿到值
							userId = session.getAttribute("userId").toString();
						}
					}
					//参数
					String requestMessage = param;
					//结果
					String reponseMessage = JSONObject.toJSONString(result);
					//添加数据库
					String insertLog = "insert into operateLog(operateMethod,operateUserId,operateTime,operateRequest,operateResponse) values('"+functionName+"','"+userId+"','"+time+"','"+requestMessage+"','"+reponseMessage+"')";
					commonMapper.insert(insertLog);
		        } catch (Exception e) {
					logger.error(e.toString());
				}
		        return result;
		    }
}
