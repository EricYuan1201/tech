# 项目实战配置1





今天学到的知识点：
0.日志格式配置：

    https://zhuanlan.zhihu.com/p/164544213
    logback配置：（可以配置不同的文件，根据过滤器进行配置）
    https://blog.csdn.net/papima/article/details/88239394
	root标签，是记录根日志的级别。
	level标签，子日志向上传递。
	
1.lombok @Data注解，

    如果有继承的时候，需要使用@EquablesAndHashCode()，声明一下不用考虑父类。

2.晚上折腾了一下redis保存乱码的问题，发现是因为集成了Spring cache，然后
  cache里面需要配置一下反序列化的参数。
  
     https://blog.csdn.net/u014481096/article/details/54134904

3.idea开启了自动集成serializableId的方式

4.spring cache需要配置不同的实效时间：

     https://blog.csdn.net/f641385712/article/details/95234347
    （可能的问题：缓存即将过期时主动刷新缓存）

5.lettuce[ 'letis ], 默认使用lettuce进行配置

  ![2022-11-02_4dd06610d4e9.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img/2022-11-02_4dd06610d4e9.jpg)

6.lettuce和jedis有什么区别：

    https://www.zhihu.com/question/53124685

7.mac下的redis命令：
  
    https://blog.csdn.net/kunAUGUST/article/details/119836319

8.redis template使用：
  
    https://blog.csdn.net/yu102655/article/details/112217778
    https://blog.csdn.net/f641385712/article/details/84679456

9.spring cache使用：

	  http://xiaqunfeng.cc/2020/02/15/java-springboot-14-redis-cache/
	  https://www.cnblogs.com/fashflying/p/6908028.html
	  https://blog.csdn.net/zl1zl2zl3/article/details/110987968
	  https://juejin.cn/post/6844903807646711821
