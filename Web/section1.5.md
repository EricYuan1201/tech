# vue + ts

## 语法部分：

1.@Compontent

2.export default class xxx extend Vue{
	
} 

3.data属性简单了，直接在vue里面像Java一样声明就行，而且是kotlin风格的。
之前还要写在data return里面，比较麻烦。

4.@Prop() 其实和之前的data一样，修饰属性的，不过我之前没有关注过。

5.computed属性：https://www.runoob.com/vue2/vue-computed.html
文档中讲得不清晰，其实可以用method替代，但是这个提供了缓存属性。
其实也是属性

6.method, public function aaa(): void{}, 类似kotlin。

7.@watch('') ---> 监听某个data属性变化。

	@Watch('project', { 
	  immediate: true, deep: true 
	})
	projectChanged(newVal: Person, oldVal: Person) {
	  // do something
	}

ts的语法神似kotlin

8.@Emit() 引入了注解 （现在注解真的是越来越通用了）

9.然后是生命周期函数了。

	created()
	mounted()
	
10.mixin: 混入的概念。
 本质是一个组件，用于扩展父组件的方法以及属性，有点类似继承的概念？

 https://juejin.cn/post/6844903908398071816
 https://juejin.cn/post/7121198749530980366
 ![2022-11-24_637afb15b82c.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-24_637afb15b82c.jpg)
 
 
11.vuex:

  https://vuex.vuejs.org/zh/guide/typescript-support.html#vue-%E7%BB%84%E4%BB%B6%E4%B8%AD-store-%E5%B1%9E%E6%80%A7%E7%9A%84%E7%B1%BB%E5%9E%8B%E5%A3%B0%E6%98%8E
  
  有点类似全局共享变量。
  
12.typescript ? ! ??用法：
  https://segmentfault.com/a/1190000038782759
  
13: 字面量类型：
  ![2022-11-24_c97bdcc396a0.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-24_c97bdcc396a0.jpg)
  
  typescript变成了编译型语言，和Java越来越像了，代码在融合的感觉。
  https://juejin.cn/post/7044573982061756423	  
14.import then语法