//跳转到指定页面同时自动登录
function autoLogin(applicationUrl, userName, passWord) {
    chrome.tabs.create({
        'url': applicationUrl,
        'selected': true
    }, async tab => {
        chrome.tabs.onUpdated.addListener(function listener(tabId, info) {
            if (info.status === 'complete' && tabId === tab.id) {
                chrome.tabs.onUpdated.removeListener(listener);
                //传送消息
                chrome.tabs.sendMessage(tab.id, {userName: userName, passWord: passWord}, function (response) {
                    console.log(response.farewell);
                });
            }
        })
    });
};
chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
    var applicationUrl = request.applicationUrl,
        userName = request.userName,
        passWord = request.passWord
    autoLogin(applicationUrl, userName, passWord)
    sendResponse('已处理');//做出回应
});
