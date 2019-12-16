package com.Perkinelmer.SSO.Controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.Perkinelmer.SSO.Entity.Result;
import com.Perkinelmer.SSO.Enum.ResultEnum;
import com.Perkinelmer.SSO.Mapper.CommonMapper;
import com.Perkinelmer.SSO.Utils.PasswordUtil;
import com.Perkinelmer.SSO.Utils.ResultUtil;

@RestController
public class LoginController {
	@Autowired
	private CommonMapper comonMapper;
	@RequestMapping("login")
	public Result login(String username,String password,HttpServletRequest request, HttpServletResponse response){
		String ip = request.getHeader("x-forwarded-for"); 
		ip = request.getHeader("X-FORWARDED-FOR");

				ip = request.getHeader("Proxy-Client-IP");

				ip = request.getHeader("WL-Proxy-Client-IP");
				ip = request.getHeader("HTTP_CLIENT_IP");

				ip = request.getHeader("X-Real-IP");

				ip = request.getRemoteAddr();
		System.out.println(ip);
		//做了判断，没问题就算的登录成功，将session，cookie等信息做配置
		String getUserInfo = "select * from UserInfo where userName = '"+username+"'";
		List<Map<String,Object>> userInfos = comonMapper.select(getUserInfo);
		if(userInfos.size()<1){
			return ResultUtil.error(ResultEnum.HasNoUser.getCode(), ResultEnum.HasNoUser.getMsg());
		}else{
			Map<String,Object> userInfo = userInfos.get(0);
			String pwd1 = PasswordUtil.encrypt(username, password, PasswordUtil.getStaticSalt());
			String pwd2 = userInfo.get("PassWord").toString();
			String userId = userInfo.get("UserId").toString();
			if(pwd1.equals(pwd2)){
				HttpSession session=request.getSession(true);
				session.setAttribute("userName", username);
				session.setAttribute("userId", userId);
				String JSESSIONIDID = session.getId();
				Cookie cookie=new Cookie("JSESSIONID",JSESSIONIDID);
		        cookie.setMaxAge(2*60*60);
		        response.addCookie(cookie);
		        return ResultUtil.success("登录成功");
			}else{
				return ResultUtil.error(ResultEnum.PassWordFail.getCode(), ResultEnum.PassWordFail.getMsg());
			}
		}
	}
	@RequestMapping("loginInner")
	public Result loginInner(String username,String password,HttpServletRequest request, HttpServletResponse response){
		//做了判断，没问题就算的登录成功，将session，cookie等信息做配置 
		String getUserInfo = "select * from UserInfo where userName = '"+username+"'";
		List<Map<String,Object>> userInfos = comonMapper.select(getUserInfo);
		if(userInfos.size()<1){
			return ResultUtil.error(ResultEnum.HasNoUser.getCode(), ResultEnum.HasNoUser.getMsg());
		}else{
			Map<String,Object> userInfo = userInfos.get(0);
			String pwd1 = PasswordUtil.encrypt(username, password, PasswordUtil.getStaticSalt());
			String pwd2 = userInfo.get("PassWord").toString();
			String userId = userInfo.get("UserId").toString();
			if(pwd1.equals(pwd2)){
				HttpSession session=request.getSession(true);
				session.setAttribute("userName", username);
				session.setAttribute("userId", userId);
				String JSESSIONIDID = session.getId();
				Cookie cookie=new Cookie("JSESSIONID",JSESSIONIDID);
		        cookie.setMaxAge(2*60*60);
		        response.addCookie(cookie);
		        try {
					response.sendRedirect("main.html");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		        return ResultUtil.success("登录成功");
			}else{
				return ResultUtil.error(ResultEnum.PassWordFail.getCode(), ResultEnum.PassWordFail.getMsg());
			}
		}
	}
	@RequestMapping("logout")
	public Result logout(String username,HttpServletRequest request, HttpServletResponse response){
		//做了判断，没问题就算的登录成功，将session，cookie等信息做配置
		HttpSession session=request.getSession(false);
		session.invalidate();
        return ResultUtil.success("注销成功");
	}
}
