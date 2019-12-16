var baseUrl = "http://152.136.68.76:8080";
var init = function(){
	initOrganization().then(function(flag){
		if(flag){//有权限
			$(".hasLogin").show();
			$(".beforeLogin").hide();
			initApplicationList();
			$("html").css("height","auto")
		}else{
			$(".hasLogin").hide();
			$(".beforeLogin").show();
			$("html").css("height","100px")
		}
	});
};
var bind = function(){
	$("#login").click(function(){
		//跳转新的url
		chrome.tabs.create({
		  'url':baseUrl+'/SSO/login.html',
		  'selected':true
		});
	});
	$("#logout").click(function(){
		$.ajax({
			type:'get',
			url:baseUrl+'/SSO/logout',
			dataType:'json',
			async:true,
			success:function(res){
				$(".beforeLogin").show();
				$(".hasLogin").hide();
				$("html").css("height","100px")
			},
			error:function(e){
			}
		});
	});
	$("#applicationLists").on("click",".applicationId",function(){
		var applicationId = $(this).attr("value");
		//自动登录指定应用
		//获得应用信息
		$.ajax({
			type:'get',
			async:true,
			dataType:'json',
			url:baseUrl+'/SSO/Api/getApplicationInfo?ApplicationId='+applicationId,
			success:function(res){
				//调到主页面
				 if(res.code==0){
					 var applicationInfo = res.data;
					 var applicationUrl = applicationInfo.applicationUrl;
					 var userName = applicationInfo.userName==null||applicationInfo.userName==undefined?"":applicationInfo.userName;
					 var passWord = applicationInfo.password==null||applicationInfo.password==undefined?"":applicationInfo.password;
					 //跳转到指定应用并附上用户名密码
					 var bg = chrome.extension.getBackgroundPage();
					 bg.autoLogin(applicationUrl,userName,passWord);
				 }else{
					 console.log(res.msg);
				 }
			},
			error:function(){
				console.log("未知错误");
			}
		});
	})
};
//初始化组织信息
var initOrganization = function(){
	var promise = new Promise(function(resolve, reject) {
		$.ajax({
				type:'post',
				url:baseUrl+'/SSO/Api/getUserInfo',
				async:true,
				dataType:'json',
				success:function(res){
					//调到主页面
					 if(res.code==0){
						 data = res.data;
						 	organizationName = data.organizationName;
						 $(".organization>.name").text(organizationName);
						 resolve(true);
					 }else{
						 resolve(false);
						 console.log(res.msg);
					 }
				},
				error:function(){
					resolve(false)
				}
			})
	});
	return promise;
}
/**
 * 初始化应用列表
 */
var initApplicationList = function(){
	$.ajax({
		type:'get',
		url:baseUrl+'/SSO/Api/getApplicationList',
		dataType:'json',
		async:true,
		success:function(res){
			if(res.code==0){
				var data = res.data;
				var applicationLists = "";
				for(var i=0;i<data.length;i++){
					var icon
					 if(data[i].icon){
						 icon = data[i].icon;
					 }else{
						 icon = "default.png"
					 }
					 applicationLists += "<div class='applicationId' value = '"+data[i].applicationId+"'><div class='content'><img alt='' src='"+baseUrl+"/SSO/images/appsIcon/"+icon+"'><p>"+data[i].applicationName+"</p></div></div>";
					//initContainer += "<button class = 'applicationId' value = '"+data[i].applicationId+"'>"+data[i].applicationName+"</button/></br>"
				}
				$("#applicationLists").empty();
				$("#applicationLists").append(applicationLists);
			}
		},
		error:function(e){
		}
	});
};
(function(){
	init();
	bind();
}());