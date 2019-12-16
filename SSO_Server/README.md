# 一：项目简介
	项目是SSO单点登录服务端代码，提供对注册应用的管理，组织的管理，给SSO_Client提供服务
	测试地址：
# 二：技术选型
	springboot+springsecurity+sqlserver
# 三：部署手册
	0）初始化数据库SSO:SSO\resource\SSO.sql
	1）cd 项目根目录
	2）mvn clean package->得到jar包
	3）运行后：访问http:localhost:8080/SSO/login.html成功访问说明运行成功
	4）google浏览器加载好插件项目SSO_Client
	5）整个就安装好了
# 四：注意事项