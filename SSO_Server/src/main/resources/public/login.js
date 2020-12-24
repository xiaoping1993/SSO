var init = function () {

};
var bind = function () {
    $("#login").on('click', function () {
        var userName = $("#userName").val();
        var passWord = $("#passWord").val();
        var user = {
            username: userName,
            password: passWord
        };
        $.ajax({
            type: 'post',
            url: 'login',
            data: user,
            async: true,
            dataType: 'json',
            success: function (res) {
                //调到主页面
                if (res.code == 0) {
                    window.location.href = 'main.html';
                    //window.location.href='https://www.baidu.com';
                } else {
                    alert(res.msg);
                }
            },
            error: function () {
                alert("提交消息出现错误");
            }
        })
    });
    document.onkeydown = function (event) {
        var e = event || window.event;
        if (e && e.keyCode == 13) { //回车键的键值为13
            $("#login").click(); //调用登录按钮的登录事件
        }
    };
};
(function () {
    init();
    bind();
}());