# 项目实战配置3


### 添加唯一索引
	然后发现insert or update不生效了，看了一下，是因为缺少唯一索引，于是重新加上了索引，
	但是加索引的时候又报错了，然后一直不生效，后来发现是因为表里已经有数据了，添加的唯一索引跟表里面的重复数据冲突了，于是把表里的数据清空了，然后就可以添加索引了。

### mybatis嵌套查询：
  
	https://blog.51cto.com/u_12826294/3080805
	resultType：要自定义pojo 保证sql查询列和pojo的属性对应，这种方法相对较简单，所以应用广泛。
	
	resultMap：使用association完成一对一映射需要配置一个resultMap，过程有点复杂，如果要实现延迟加载就只能用resultMap实现 ，如果为了方便对关联信息进行解析，也可以用association将关联信息映射到pojo中方便解析。
	如果没有查询结果的特殊要求建议使用resultType。


### jackson配置

  	https://cloud.tencent.com/developer/article/1795700

### springboot模块划分：
  
  	https://www.cnblogs.com/Leo_wl/p/15545866.html
    阿里巴巴开发手册：
  	https://github.com/alibaba/p3c/blob/master/Java%E5%BC%80%E5%8F%91%E6%89%8B%E5%86%8C(%E9%BB%84%E5%B1%B1%E7%89%88).pdf

### mybatis标签学习：

	https://liuyueyi.github.io/hexblog/2018/04/11/Mybatis%E6%A1%86%E6%9E%B6%E5%AD%A6%E4%B9%A0%E4%B9%8B%E4%BD%BF%E7%94%A8%E7%AF%87%E4%BA%8C%EF%BC%9A%E6%A0%87%E7%AD%BE%E8%AF%AD%E6%B3%95/

### mybatis # 和 $的区别：
  
  	一般情况下使用 # 注入参数，会自动在参数前面拼接""，能够防止sql注入。
  	$ 是不会拼接的，一般order by的时候使用这个。

### mysql varchar大小设置：

    https://www.jianshu.com/p/08eff7720c6f

### mysql date问题：
  
	1.如果mysql中使用了date类型，并且默认值为'0000-00-00',
	那么数据库中的'0000-00-00 00:00:00', '0000-00-00', '00:00:00'这三个值是相等的，都为空
	https://blog.csdn.net/sdujava2011/article/details/45503871
	

### 重新认识quartz:

    https://www.cnblogs.com/zhuchengbo/p/12722926.html

### cron定时器设置：

    https://blog.csdn.net/fengqing5578/article/details/80352561

### cron在线生成器：

    https://cron.qqe2.com/




