# vue架构梳理

## 1.vue数据绑定

>https://blog.csdn.net/m0_47323674/article/details/121816439

	1.使用 {{}}
	2.使用 v-model，绑定一个对象之后，后续可以使用这个对象的bean。
	3.使用 v-text
	4.使用 v-bind
	5.使用 :title
	6.使用 `${}`

## 2.控制view显示，隐藏：

	:visible.sync="dialogFormVisible" //---->绑定data。
    控制、显示dialog，竟然是这么写的。
    首先布局一个button，然后布局一个dialog，然后 @click="showDiloag = true"

## 3.统一封装网络请求：axois

>https://blog.51cto.com/u_15302032/3067691

## 4.vuex：状态缓存，store/index.js

## 5.路由跳转：（传参以及接收参数的方法）

  >https://blog.csdn.net/jiandan1127/article/details/86170336
  >https://blog.csdn.net/XH_jing/article/details/118334533
  >https://blog.csdn.net/xz182838/article/details/107465708
	
	1.<router-link :to="{name:'home'}"> 
	  <router-link :to="{name:'home', params: {id:1}}">  
	2.this.$router.push()
	3.this.$router.replace()
	4.this.$router.go(n) //向前向后n个页面。

## 6.const, var, let的区别：

	1.const定义的变量不可以修改，而且必须初始化。
	2.var定义的变量可以修改，如果不初始化会输出undefined，不会报错。
	3.let是块级作用域，函数内部使用let定义后，对函数外部无影响。 

## 7.怎么理解vue是单页面应用：

>https://juejin.cn/post/6844903961288245262


	new Vue({
	  el: '#app',
	  render: h => h(App),
	  router,
	  store,
	  components: {App},
	  template: '<App/>'
	})

	整个vue的核心就是这个，main.js里面，创建了一个新的vue，然后通过el挂载在app id上，
	通过build之后，会生成一个 index.html，然后进行挂载。后续的跳转都是在这个index.html上。


## 8.使用vue获取token进行登录：

>https://blog.csdn.net/weixin_48255917/article/details/110622736


登录流程：

	1.首先在rouetr里面配置是否需要登录认证。
	2.然后在main.js里面配置，路由跳转的时候，如果需要登录需要验证token。
	3.登录获取token
	4.token通过store.js以及localStorage保存到本地。
	5.在axois里面配置拦截器，将token放到后续所有请求中。
	6.后端验证token。


## 9.vue项目架构

>https://blog.csdn.net/m0_56349322/article/details/123600139

	1.入口是index.html
	2.使用main.js进行挂载
	3.main.js创建了App.vue
	4.app.vue引入了<router-view/>
	5.通过router-view才真正引入了各个页面。
	6.核心的页面vue都会在router.js里面进行声明。
	7.然后各个vue页面都可以包含其他vue组件。
	8.在vue里的script里面进行引入其他组件，然后在template里面使用。
	9.引入一个vue，直接在template模板里面写即可，然后在script里面进行import from
	  然后在components里面进行声明：    components: {Books, SideMenu},
	  然后引用子组件的地方：
	  <edit-form @onSubmit="loadBooks()" ref="edit"></edit-form>
	  下面可以通过这个edit获取里面的数据进行改变。
	  （一般组件只有样式，真正的逻辑写在逻辑里面）

demo

	<!DOCTYPE html>
	<html>
	 <head>
	  <meta charset="utf-8" />
	  <meta name="viewport" content="width=device-width,initial-scale=1" />
	  <title>wj-vue</title>
	  <link href="/static/css/app.f3139533f7f70daf82ad391af90e47b3.css" rel="stylesheet" />
	 </head>
	 <body>
	  <div id="app"></div>
	  <script type="text/javascript" src="/static/js/manifest.2ae2e69a05c33dfc65f8.js"></script>
	  <script type="text/javascript" src="/static/js/vendor.7df22419f8c7f84fd938.js"></script>
	  <script type="text/javascript" src="/static/js/app.50b480ab8e94eecc7b81.js"></script>
	 </body>
	</html>
	
	<template>
	  <div id="app">
	    <!-- <img src="./assets/logo.png"> -->
	    <router-view/>
	  </div>
	</template>
	
	<script>
	  import SearchBar from './SearchBar'
	  import ViewSwitch from './ViewSwitch'