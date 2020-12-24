var init = function () {
    initUserInfo();
    initApplicationList();
};
var initUserInfo = function () {
    $.ajax({
        type: 'post',
        url: 'Api/getUserInfo',
        async: true,
        dataType: 'json',
        success: function (res) {
            //调到主页面
            if (res.code == 0) {
                data = res.data;
                var userName = data.UserName,
                    organizationName = data.organizationName;
                $(".username>label").text(userName);
                $(".organization>label").text(organizationName);
            } else {
                alert(res.msg);
            }
        },
        error: function () {
            alert("您无此权限，请重新登录");
        }
    })
}
/**
 * 获得应用列表
 */
var initApplicationList = function () {
    $.ajax({
        type: 'post',
        url: 'Api/getApplicationList',
        async: true,
        dataType: 'json',
        success: function (res) {
            //调到主页面
            if (res.code == 0) {
                data = res.data;
                //初始化applicationList
                var applicationList = "";
                for (var i = 0; i < data.length; i++) {
                    var icon
                    if (data[i].icon) {
                        icon = data[i].icon;
                    } else {
                        icon = "default.png"
                    }
                    applicationList += "<div class='applicationId' value = '" + data[i].applicationId + "'><div class='content'><img alt='' src='images/appsIcon/" + icon + "'><p>" + data[i].applicationName + "</p></div></div>";
                    //applicationList += "<button class = 'applicationId' value = '"+data[i].applicationId+"'>"+data[i].applicationName+"</button/></br>"
                }
                $(".applicationLists").append(applicationList);
            } else {
                alert(res.msg);
            }
        },
        error: function () {
            alert("您无此权限，请重新登录");
        }
    })
}
var bind = function () {

};
(function () {
    init();
    bind();
}());