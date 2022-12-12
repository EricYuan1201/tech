# vue + ts 2

## 参考文档：
1.ts相关
https://zhuanlan.zhihu.com/p/99343202
https://juejin.cn/post/6860703641037340686

2.async, await 异步函数语法：
https://juejin.cn/post/6913393501262577672

3.async, await 异步函数语法：
https://juejin.cn/post/6913393501262577672

4.export属性 ++ import属性：
https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/export

## vue项目总结：

1.安装electron一直失败，后来设置单独taobao源/electron才好。

### 新建ts项目


	新建一个Vue是这样。
		
	<script>
	export default {
	  name: 'HelloWorld',
	  props: {
	    msg: String
	  }
	}
	</script>
		
	项目中直接继承vue了：
		
	export default class SwiperCard extends Vue {}
		
	参考文档：
	https://blog.csdn.net/weixin_44867717/article/details/125080795
		
		不用写name了。


### 2.vue.extend()语法：

https://juejin.cn/post/6982558712149835790
https://juejin.cn/post/6844904190255300615

挂载元素，本质是替换。
![2022-11-23_cec8a200ddfe.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-23_cec8a200ddfe.jpg)


### 3. vue快速实现loading，可以作为组件，也可以作为插件：

https://madewith.cn/34
https://www.php.cn/website-design-ask-486449.html

![2022-11-23_9d593b93f40e.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-23_9d593b93f40e.jpg)


### 4. vue事件传递：

正常的父子传递，可以使用原生的 props, emit进行传递，如果两个页面没关联，需要使用eventbus:
https://zhuanlan.zhihu.com/p/72777951


### 5. css中rem的概念：

https://www.freecodecamp.org/news/what-is-rem-in-css-rem-unit-font-size-padding-height-and-more/
一般使用rem吧，能够显示比例大小。


h5的语法糖比kotlin还狠。

![2022-11-23_f7571be7a5a1.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-23_f7571be7a5a1.jpg)

### 6. axios使用

排查axios一直不对的问题：（提升了一点点效率）

https://blog.csdn.net/u013591605/article/details/109832994

遇到这个问题：org.springframework.web.bind.MissingServletRequestParameterException:
搜了一大堆文章，没一个有用的，后面根据stackoverflow改好了。

axios提交数据的格式：
https://segmentfault.com/a/1190000015261229

### 7. css 100%不生效：

这个地方其实卡了比较久了，就是需要从根布局开始设置。
https://blog.csdn.net/yanchenxi313761/article/details/79437541

### 8. 自己写的json格式化：

	1.vue的热编译实在是太方便了，比安卓的方便太多了。
	2.核心是package.json，使用npm install 的时候会自动添加进去。
	3.然后核心的是App.vue，挂载router-view，设置了跟布局，以后写base样式的时候就在这写。
	4.main.js 导入通用组件，比如router
	5.router.js 声明页面，开启history模式，所有的页面都需要在这注册。
	  name的属性可以传递参数，配合router-link属性。
	6.然后开始写组件了，也就是页面。
	  css布局，我比较习惯用flex布局，垂直布局实在是太方便了。
	  flex：1 设置比例
	  justify-content: space-between
	  设置高度卡了一会，需要从根布局100%
	  margin值学习了一会，这个需要强化一下。
	  ![2022-11-21_c5db1d97c944.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-21_c5db1d97c944.jpg)
	  border: solid 5px green; 非常常用的一个属性。
	  然后显示不全，发现是100%的问题，因为设置了border，需要要小一些。
	  overflow-y:hidden，overflow: hidden;隐藏滚动条。
	  json的时候卡了一会，发现是逻辑错误，节省了一点点点点时间吧，其实也浪费了时间。
	  监听事件 @input="", input标签，单行，textarea标签，多行展示。也可以使用watch，但是不是很方便。
	  调试一般是设置background color, 这个实在是太常用了。
	  height: calc(100% - 100px); 实时动态标签，这个应该会耗性能吧，默认width100%，height单行。
	  学习了pre标签。
	7.网络请求封装了，但是格式需要注意一下。
	8.vue获取document标签
	  https://blog.csdn.net/Wbiokr/article/details/77799291

## 其他

预感了明天这个要耗我一天的时间，fk了。
	
后来证明整整看了一周的时间。

