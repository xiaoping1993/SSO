package com.Perkinelmer.SSO.Controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.Perkinelmer.SSO.Entity.Result;
import com.Perkinelmer.SSO.Enum.ResultEnum;
import com.Perkinelmer.SSO.Mapper.CommonMapper;
import com.Perkinelmer.SSO.Utils.PasswordUtil;
import com.Perkinelmer.SSO.Utils.ResultUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

@RestController
@RequestMapping("/Api")
public class ApiController {
	protected static final Logger log = LoggerFactory.getLogger(ApiController.class);
	@Autowired
	private CommonMapper commonMapper;
	@RequestMapping("getApplicationInfo")
	public Result getApplicationInfo(String ApplicationId,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//后期你可以增加密码的编码加密
		//Base64.Decoder decoder = Base64.getDecoder();
		JSONObject jo = new JSONObject();
		HttpSession session = request.getSession(false);
		if(session==null){
			response.sendRedirect("/SSO/login.html");
			return null;
		}
		String userId = session.getAttribute("userId").toString();
		//判断这个应用是否是这个用户的，防止别人瞎调用其他应用信息，保证信息安全
		String isUserApplicationSql = "select * from user_application where userId='"+userId+"' and applicationId='"+ApplicationId+"'";
		List<Map<String, Object>> user_applications = commonMapper.select(isUserApplicationSql);
		if(user_applications.size()<1){//说明这个用户没有获得这个应用用户名密码的权限
			return ResultUtil.error(ResultEnum.HasNoPermissionForThisApplication.getCode(), ResultEnum.HasNoPermissionForThisApplication.getMsg());
		}
		String getApplicationInfoSql = "select * from ApplicationInfo where applicationId='"+ApplicationId+"'";
		List<Map<String, Object>> applicationLists = commonMapper.select(getApplicationInfoSql);
		if(applicationLists.size()>0){
			Map<String,Object> application = applicationLists.get(0);
			String applicationUrl = application.get("applicationUrl").toString();
			String userName = application.get("userName").toString();
			String password = application.get("passWord").toString();
			//String passWord = new String(decoder.decode(password), "UTF-8");
			jo.put("applicationUrl",applicationUrl);
			jo.put("userName",userName);
			jo.put("password",password);
		}
		return ResultUtil.success(jo);
	}
	@RequestMapping("getApplicationList")
	public Result getApplicationList(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession(false);
		if(session==null){
			response.sendRedirect("/SSO/login.html");
			return null;
		}
		String userId = session.getAttribute("userId").toString();
		String getAllApplicationsSql = "select a.applicationId,applicationName,icon from user_application a left join ApplicationInfo b on a.applicationId=b.applicationId where a.userId='"+userId+"'";
		List<Map<String,Object>> applications = commonMapper.select(getAllApplicationsSql);
		JSONArray ja = new JSONArray();
		ja.addAll(applications);
		return ResultUtil.success(ja);
	}
	@RequestMapping("registerUser")
	public Result registerUser(String username,String password,HttpServletRequest request, HttpServletResponse response){
		String userName = request.getSession(false).getAttribute("userName").toString();
		if("admin".equals(userName)){
			String pwd = PasswordUtil.encrypt(username, password, PasswordUtil.getStaticSalt());
			String addUserSql = "insert into UserInfo(UserName,PassWord) values('"+username+"','"+pwd+"')";
			int count = commonMapper.insert(addUserSql);
			if(count>0){
				return ResultUtil.success("注册用户成功");
			}else{
				return ResultUtil.error(ResultEnum.FAILADDATA.getCode(),ResultEnum.FAILADDATA.getMsg());
			}
		}else{
			return ResultUtil.error(ResultEnum.HasNoPermissionForThisFunction.getCode(), ResultEnum.HasNoPermissionForThisFunction.getMsg());
		}
	}
	@RequestMapping("getUserInfo")
	public Result getUserInfo(HttpServletRequest request, HttpServletResponse response){
		JSONObject jo = new JSONObject();
		HttpSession session = request.getSession(false);
		String userId = session.getAttribute("userId").toString();
		String userInfoSql = "select * from UserInfo a left join Organization b on a.OrganizationId=b.organizationId where UserId = '"+userId+"'";
		List<Map<String,Object>> userInfos = commonMapper.select(userInfoSql);
		if(userInfos.size()<1){
			return ResultUtil.error(ResultEnum.HasNoUser.getCode(), ResultEnum.HasNoUser.getMsg());
		}else{
			Map<String,Object> userInfo = userInfos.get(0);
			jo.putAll(userInfo);
			return ResultUtil.success(userInfo);
		}
	}
}
