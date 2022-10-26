# vue快速入门

##参考文档

1.elementUI:
https://element.eleme.cn/#/zh-CN/component/form

2.部署方式：
vue和spring boot一般是分开部署，vue采用nginx，减少后端服务器的压力，而且vue更改不需要后端更改。
当然如果是自己一个人全栈开发，那么可以考虑合并部署，不用考虑跨域，无需安装独立的nginx。
https://zhuanlan.zhihu.com/p/31720281


3.vue安装
https://www.jianshu.com/p/f3c5d49d6301

4.fuck了无数遍的连不上网的问题：
https://blog.csdn.net/weixin_44736522/article/details/107171397
https://www.cnblogs.com/linkenpark/p/10386937.html

5.设置iterm代理：救了我半条狗命
https://www.itfanr.cc/2021/07/15/setting-up-proxy-for-iterm-terminal-on-macos/


6.卸载重新安装了 npm
https://segmentfault.com/a/1190000039005726

7.npm重新安装之后gitbook丢了，fuck: 
https://juejin.cn/post/6866073251295002638


## vue使用总结：

	1.万恶的代理，今天终于把terminal没有代理这个问题解决了。
	
	2.解决完代理之后，剩下的安装流程久没啥问题了，不过还是先卸载了，然后重新安装。
	
	3.学习demo:https://learner.blog.csdn.net/?type=blog
	
	4.可以分别部署，也可以合并部署。如果是单项目的话完全可以合并部署，通过npm build，将打包好的东西放到 spring boot demo里面即可。不过一般是单独部署的。
	
	5.有一个很重要的概念，
	export default {
		name: "aaa", ----> 这个将当前name暴露出去。
	}
	
	6.main.js，管理所有的js，比如route.js, store.js，有点类似路由，登录处理相关。
	
	7.route.js，必须要先导入之前（5）中的name，不然会报错，然后设置Vue.use。
	  好吧，这两个都是通用配置，直接按照设置就可以了，一个设置路由，一个设置登录状态。
	
	8.然后是vue:
	  包含template, script, css。
	  template就去elementUI里面粘贴，然后改改内容即可。
	  script设置name, data, methods，以及一些声明周期方法。
	  css：样式设置。
	
	9.网络请求框架用的axios。
	
	10.vue是单页面设置，一个页面可以承接不同的内容，除非新建一个vue。
	
	11.通用组件的封装，构建子vue，然后可以在其他vue里面集成新的vue。
	
	12.el-container很好用，主页面一般使用这个。








