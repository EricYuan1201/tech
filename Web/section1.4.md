# vue指令和路由理解


### 前提：

	感觉整个概念都狠混沌：/

	现在的阶段处于基本能看懂，但是没有系统学习过，没有框架的概念。
	包括html, css 也是这样。 基础概念都知道，看代码也能看出来，但是写不出来。
	
	
	基础是基础，
	但是基础很繁杂，我觉得不用看全部的基础，理解其中的架构就行，这个需要熟记且清晰的。
	
### vue指令学习：

vue指令学习：
https://juejin.cn/post/7035822541386022920#heading-4
https://www.tangyuxian.com/2021/07/13/%E5%89%8D%E7%AB%AF/vue/vue-vue%E5%B8%B8%E7%94%A8%E6%8C%87%E4%BB%A4/
https://segmentfault.com/a/1190000016763522

	1.一定是以v-开头，都是修饰到<>某个标签里。
	2.最核心的是 v-bind:xxx= 和 v-on:xx=
	  v-bind用于修饰 html属性，可以缩写为:
	  v-on可以缩写为 @
	3.数据绑定比较常用的 
	  v-if=""
	  v-for="item in items"
	4.v-model="" ---> 表单的双向绑定。
	
### vue路由学习（组件）

vue路由学习：
https://cn.vuejs.org/guide/essentials/component-basics.html#dom-template-parsing-caveats
https://juejin.cn/post/7096520622557102111

	1.路由的基础是组件，component，需要单独注册进入，其实就是安卓的自定义view。
	2.只有一个html，通过组件的切换展示不同的“页面”。router是vue的必须依赖项。
	  通过路由跳转，让某个组件对用户可见，之前的组件隐藏。
	  核心是：conpnent, router-linker
	3.组件的使用：
	  1.import, 导入 route.js里面，定义path和component。其实是注册映射关系。
	  2.import, 注册到component里面 （js代码中）
	  3.然后在template里面就可以以view的形式引入组件了。
	4.路由的使用：
	  $router === 安卓里面的intent概念。
	  对应query， params参数获取。
	5.路由嵌套