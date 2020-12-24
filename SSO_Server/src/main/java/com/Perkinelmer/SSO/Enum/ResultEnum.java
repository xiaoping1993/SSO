package com.Perkinelmer.SSO.Enum;

/**
 * http请求返回的code对应值
 *
 * @author wangjiping
 */
public enum ResultEnum {
    UNKONW_ERROR(-1, "未知错误"),
    SUCCESS(0, "成功"),
    FAILDELEDATA(1, "数据删除失败！"),
    FAILUPDATEDATA(2, "数据更新失败"),
    FAILADDATA(3, "数据添加失败!"),
    UpDateFail(4, "数据更新失败"),
    DeleDateFail(5, "数据删除失败！"),
    PassWordFail(7, "密码错误"),
    HasNoUser(6, "没有此用户"),
    HasNoPermissionForThisApplication(7, "此用户没有此应用的权限"), HasNoPermissionForThisFunction(8, "此用户没有此功能权限");

    private Integer code;

    private String msg;

    ResultEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
