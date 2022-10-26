# spring boot模块总结一

看 ruoyi 项目：

## 总结今天晚上看的ruoyi demo:

	1.项目采用了多module的形式，但是整体部署一个spring cloud项目，是一个单服务项目。
	
	2.模块划分：
	  
	  	1. system模块：包含了bean, dao, service。
	  	2. quartz模块：任务调度框架，这个里面没有使用rabbitmq或者kafka。
	  	3. framework模块：配置了config，拦截器，过滤器，shiro的配置，全局异常处理，
	  	   缓存处理，权限处理，重复提交处理，aspectJ配置。
	  	4. common模块：配置了常量类，工具类，异常定义类，状态参数，权限状态，注解配置。
	  	5. admin模块，定义了全部的controller。
	
	3. 配置相关：
	
	  	1.系统pom.xml，添加了各种依赖，举例：shiro（登录，权限认证)[https://github.com/apache/shiro], druid(阿里巴巴数据库连接池)，kaptcha（二维码生成器），pagehelper（分页相关）
	  	2.然后看admin模块里面的resource目录下的配置
	  	  1.application.yml:
	   		1.这里面是可以配置一些参数，然后在代码里面能够获取到的，通过注解@Value
	   		2.核心配置：server配置（端口号、tomcat连接等）
	   		           logging日志配置
	   		           spring配置
	   		           mybatis配置 （有一个configLocation属性，可以指定mybatis具体配置）
	   		           shiro配置
	   		           xss配置
	   		           swagger配置
	   		3.引入其他yml配置：[参考文档]('https://blog.csdn.net/xiaorui51/article/details/108452181')
	   		    profiles: 
	    			active: druid ---> 这个是因为druid的配置实在太多了，单独拆分一下
	   	   2.resource目录下可以新建config.xml
	   	     比如shiro.xml，然后在代码里面可以通过ResourceUtils去读取，获取配置。
	
	4. 入口类 application
	
	5. 核心类 controller，然后 通过@Autowired注解动态注入service，然后service通过mapper查数据，最后再经过业务处理返回。
	
	6. 数据库相关：
	   1.left join, right join, inner join的区别： https://www.cnblogs.com/pcjim/articles/799302.html
	
	   2.mybatis常用标签：https://blog.csdn.net/tiguer/article/details/80812232
	   	 常用的标签是if where include foreach标签：https://www.cnblogs.com/yhgn/p/11187304.html
	
	7. AspectJ使用：
	
		1.声明@Aspect， @Component注解
		2.@Pointcut 织入点 
		3.常用方法 doBefore, around, doAfterReturning。
	
	8. intercepoter使用
	
	9. @Service, @RestControllerAdvice (@ExceptionHandler) 常用注解处理。
		
	10. config配置类
	    
	    1.集成 springwebmvcconfig
	    2.https://blog.csdn.net/javaloveiphone/article/details/52182899
	    3.
	   
	

