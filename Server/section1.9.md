# @configuration, @Bean理解

## 参考文档

1.最简单的shiro教程：
  https://zebinh.github.io/2020/03/SimpleShiro/

2.今天datagrip的代理又不行了，然后我取消了电脑本身的代理。
然后设置http代理就好了：
https://segmentfault.com/a/1190000041549741

3.@Component 和 @Configuration的区别：
https://blog.csdn.net/isea533/article/details/78072133

4.大白话@Bean注解：
https://blog.csdn.net/qq_44543508/article/details/103718958

5.IOC的基础，一大堆BeanDefinition, BeanFactory的东西：
https://www.jianshu.com/p/91be8713ba1d

6.cache加载： （核心）
https://www.jianshu.com/p/8a953cd0b265

7.自定义cache配置： （核心）
https://blog.csdn.net/weixin_44577106/article/details/122074164

## 记录一次设置@Bean的逻辑：

起源是看了一个项目，使用的是shiro+redis+jwtToken进行登录认证以及授权的。

里面有很多的配置，比如 keygenerator, redisCacheConfiguration 很多方法前面都被声明了
@Bean注解，产生了两个疑问：

>1.注解有什么用
>
>2.他们怎么知道设置这些注解的。

于是跟从源码，看了一系列文章：

### 定义

	1.@Component: 是一个向spring IOC容器提供bean的组件。
	2.@Configuration: 有点类似@Component，但是还是有区别的。
	  一句话概括就是 @Configuration 中所有带 @Bean 注解的方法都会被动态代理，因此调用该方法返回的都是同一个实例。
	3.@Bean，基础使用：https://www.hangge.com/blog/cache/detail_2506.html

### 他们怎么知道要使用这些属性的，以RedisCacheConfiguration为例。

1.首先加载application

2.把component里面的@Bean注解全都解析构建出来，放到IOC容器中。

3.configuration parse里面：解析configuration
  
    String[] importClassNames = selector.selectImports(currentSourceClass.getMetadata());
    Collection<SourceClass> importSourceClasses = asSourceClasses(importClassNames, exclusionFilter);
    processImports(configClass, currentSourceClass, importSourceClasses, exclusionFilter, false);

4.CacheConfigurationImportSelector 选择config配置

    static class CacheConfigurationImportSelector implements ImportSelector {
        @Override
        public String[] selectImports(AnnotationMetadata importingClassMetadata) {
          CacheType[] types = CacheType.values();
          String[] imports = new String[types.length];
          for (int i = 0; i < types.length; i++) {
            imports[i] = CacheConfigurations.getConfigurationClass(types[i]);
          }
          return imports;
        }
    }


5.CacheType，一个枚举类：


    public enum CacheType {
          GENERIC,
          JCACHE,
          EHCACHE,
          HAZELCAST,
          INFINISPAN,
          COUCHBASE,
          REDIS,
          CAFFEINE,
          SIMPLE,
          NONE;
      }

6.找到了redis config:
   

    mappings.put(CacheType.REDIS, RedisCacheConfiguration.class.getName());


7.redisConfiguration里面：


	  private org.springframework.data.redis.cache.RedisCacheConfiguration determineConfiguration(
	      CacheProperties cacheProperties,
	      ObjectProvider<org.springframework.data.redis.cache.RedisCacheConfiguration> redisCacheConfiguration,
	      ClassLoader classLoader) {
	    return redisCacheConfiguration.getIfAvailable(() -> createConfiguration(cacheProperties, classLoader));
	  }

8.核心就在那个getIfAvaliable里面：

       @Nullable
    public T getIfAvailable() throws BeansException {
        try {
            return DefaultListableBeanFactory.this.resolveBean(requiredType, (Object[])null, false);
        } catch (ScopeNotActiveException var2) {
            return null;
        }
    }

9.先去beanfactory去获取对象了，如果我们动态注入了，这里就直接拿到了。

10.其他的也类似，获取很多配置性的东西，都是会先去ioc里面看看有没有，这是配置的理解。
