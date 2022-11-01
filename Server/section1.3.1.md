# aop使用

AspectJ使用：

	1.声明@Aspect， @Component注解
	2.@Pointcut 织入点 
	3.常用方法 doBefore, around, doAfterReturning。

参考文档：
1.https://mawen.work/springboot/2020/08/18/springboot-aop/

2.https://www.macrozheng.com/mall/technology/redis_permission.html#%E9%A1%B9%E7%9B%AE%E6%BA%90%E7%A0%81%E5%9C%B0%E5%9D%80

使用：

	1.确定织入点
	2.使用常用织入注解，@Before, @After, @AfterReturning, @Around