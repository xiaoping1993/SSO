var baseUrl = "http://47.103.133.15:8881";
$(".main").on("click", ".applicationId", function () {
    var applicationId = $(this).attr("value");
    //自动登录指定应用
    //获得应用信息
    $.ajax({
        type: 'get',
        async: true,
        dataType: 'json',
        url: baseUrl + '/SSO/Api/getApplicationInfo?ApplicationId=' + applicationId,
        success: function (res) {
            //调到主页面
            if (res.code == 0) {
                var applicationInfo = res.data;
                var applicationUrl = applicationInfo.applicationUrl;
                var userName = applicationInfo.userName == null ? "" : applicationInfo.userName;
                var passWord = applicationInfo.password == null ? "" : applicationInfo.password;
                //跳转到指定应用并附上用户名密码
                chrome.runtime.sendMessage({applicationUrl: applicationUrl, userName: userName, passWord: passWord},
                    function (response) {
                        console.log("收到回复");
                    }
                );
            } else {
                alert(res.msg);
            }
        },
        error: function () {
            alert("未知错误");
        }
    });
});