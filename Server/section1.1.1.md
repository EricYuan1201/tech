# redis使用2


##参考文档：

1.redis设置密码登录：
https://blog.csdn.net/lovemysea/article/details/70766527

2.redis默认有16个数据库，编码从0到15，可以在代码中设置链接不同的数据库：
https://blog.csdn.net/qq_42874635/article/details/118157740

3.redis使用：jedis以及lettuce对比，后来决定采用默认的lettuce。
主要还是jedis是线程不安全的，如果使用连接池会导致物理损耗增加。
https://blog.csdn.net/qq_25720801/article/details/125976659


4.下午看的最核心的文章
https://juejin.cn/post/7076244567569203208

5.再次遇到swagger无法使用的问题：
https://www.jianshu.com/p/384df66548b2

6.springCache与redis进行结合使用：
https://juejin.cn/post/6844903807646711821
使用：

##总结

	1.springboot默认集成了autoconfiguration，像平常在yml的配置以及config的配置都可以在
	autoconfiguration这个包下找到，集成了一些常用框架的配置，这样就能够注册即使用。
	然后里面使用了conditionOn进行判断加载哪些配置。
	
	
	2.redis的使用包含3个部分：
	  1.配置
	  2.config，声明template, 配置反序列化相关。
	  3.set, get方法。
	
	3.能够结合@Cacheable，自动对方法结果进行缓存，非常方便。（spring boot这个框架实在是太厉害了）

