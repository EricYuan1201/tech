# redis

## 学习文档
redis入门：
https://blog.csdn.net/fms5201314/article/details/108974659


redis的使用场景：
https://juejin.cn/post/7111697616320069640

查看redis的key:
https://blog.csdn.net/fms5201314/article/details/108974659

一般调试接口都是通过
http://localhost:8080/swagger-ui.html进行调试。

redis数据库的配置，类似于容器化作用
https://blog.csdn.net/whatday/article/details/100016096

## 语法使用
redis常用命令：

	1.set key value
	2.get key
	3.ttl key
	4.expire key time

***在有大量 key 的 Reids 线上系统，要在主库禁用 keys * 操作，防止卡死
***

redis的使用：

	1.配置链接数据库，端口，密码
	2.配置jredis的的一些配置（比如最大链接数，超时时间）
	3.构建redisService
	4.构建RedisServiceImpl，注入StringRedisTemplate