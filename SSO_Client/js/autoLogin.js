//监听popup发送来的用户名密码信息
chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
	var userName = request.userName,
		passWord = request.passWord;
	var ThreeInput = getThreeInput();
	if(ThreeInput==null){
		sendResponse({farewell: "未找到三个重要控件，自动登录失败"});
	}else{
		var changeEvent = document.createEvent("HTMLEvents");
		changeEvent.initEvent("change", true, true);//插件的触发事件方式必须这样，不能直接调用事件函数
		sendResponse({farewell: "成功"});
		$(ThreeInput.userNameInput).val(userName);
		$(ThreeInput.passWordInput).val(passWord);
		ThreeInput.userNameInput.dispatchEvent(changeEvent);
		ThreeInput.passWordInput.dispatchEvent(changeEvent);
		$(ThreeInput.submitInput).click();
	}
});

//尽可能的获得三个重要控件（username,password,submit）
var getThreeInput = function(){
	var InputTexts = findAll("input[type='text']");
	var InputPassword = find("input[type='password']");
	var InputSubmit = find("input[type='submit']");
	var buttons = findAll("button");
	//找到尽可能正确的userName,password控件
	var userNameInput=null;
	var passWordInput=null;
	var submitInput = null;
	if(InputTexts.length>0){
		//真要是一个没找到就用第一个
		userNameInput = InputTexts[0];
		for(var i=0;i<InputTexts.length;i++){
			if(InputTexts[i].outerHTML.toLowerCase().indexOf("username")){
				userNameInput = InputTexts[i]
				break;
			}else if(InputTexts[i].outerHTML.toLowerCase().indexOf("user")){
				userNameInput = InputTexts[i]
				break;
			}
		}
	}else{
		return null;
	};
	//尽可能找到password
	if(InputPassword!=null){
		passWordInput=InputPassword;
	}else{
		if(InputTexts.length>1){
			//真要是一个没找到就用第一个
			passWordInput = InputTexts[1];
			for(var i=0;i<InputTexts.length;i++){
				if(InputTexts[i].outerHTML.toLowerCase().indexOf("password")){
					passWordInput = InputTexts[i]
					break;
				}else if(InputTexts[i].outerHTML.toLowerCase().indexOf("pwd")){
					passWordInput = InputTexts[i]
					break;
				}
			}
		}else{
			return null;
		}
	};
	//找到尽可能正确的submit
	if(InputSubmit!=null){
		submitInput=InputSubmit
	}else{
		if(buttons.length>0){
			//真要是一个没找到就用第一个
			submitInput = buttons[0];
			for(var i=0;i<buttons.length;i++){
				if(buttons[i].outerHTML.toLowerCase().indexOf("submit")){
					submitInput = buttons[i]
					break;
				}
			}
		}else{
			return null;
		}
	};
	return {
		userNameInput:userNameInput,
		passWordInput:passWordInput,
		submitInput :submitInput
	};
};
var findAll = function(selector) {
	return document.querySelectorAll(selector);
};
var find = function(selector) {
	return document.querySelector(selector);
};