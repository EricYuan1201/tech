
# MongoDB

## 参考文档

1.[安装mongodb](https://juejin.cn/post/7052585815037673479)

2.[mongodb和mysql区别：](https://developer.aliyun.com/article/630321)


3.[datagrip链接mongodb，默认端口27017](https://blog.csdn.net/weixin_43408020/article/details/113801424)
  
  
4.[mongodb 菜鸟教程](https://www.runoob.com/mongodb/mongodb-create-database.html)

5.[学习mongodb:](https://www.macrozheng.com/mall/architect/mall_arch_08.html#%E6%9F%A5%E8%AF%A2mongodb%E4%B8%AD%E7%9A%84%E5%95%86%E5%93%81%E6%B5%8F%E8%A7%88%E8%AE%B0%E5%BD%95)
  
6.[mongodb理解：](https://www.infoq.cn/article/hr3fclptdbxf9j8epo9o)


7.[什么时候选择mongodb:]()

  https://zhuanlan.zhihu.com/p/523497399

> 今天调试一直调试不通，偶然看到log才发现是mysql忘记启动了，先设置成开机启动吧。
  然后是demo的密码忘记改了。

> spring boot报红，搜了一圈方案，最后直接 file-invalidate cache and restart，重启大法好。


## 直观印象

1.非关系型数据库

2.保存json

3.映射

## 总结

	1.安装mongodb，开启服务
	2.创建database
	3.mongodb是基于json进行存储的，支持分布式，大数据。
	4.非关系型数据库，适用于快速变更字段的那种场景，不过如果非必须安全性，join查询的，也都可以歉意到mongodb
	5.文件存储。
	6.使用
	   1.创建bean，@Id, @Index
	   2.写一个接口即成MongoRepository，然后声明方法。
	   3.声明service
	   4.实现service，动态注入 autowired 2
	   5.使用2的实现类去执行方法。save, delete, find。

## 其他

	关系型数据库：
	1.Oracle数据库默认端口号为，1521； 
	2.MySQL数据库默认端口号为，3306； 
	3.SQLServer数据库默认端口号为，1433;
	
	nosql:端口占用情况
	1.MongoDB默认端口号为：27017； 
	2.Redis默认端口号为：6379； 
	3.memcached默认端口号为：11211；