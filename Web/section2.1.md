# vue ts项目，swiper demo


## 架构部分：

	1.入口是app.vue，使用了ts，ts是js的超集，是编译型语言，引入很多Java的思想，现在语言在融合的感觉。
	
	2.然后是index.html，我们打开的页面就是index.html；整个index.html只有一些meta信息，以及script脚本信息，核心是 
	 <body>
	    <div id="app"></div>  ----> 核心是这一行，构建了一个app的元素。
	 </body>   
	
	3.需要把vue组件挂载到刚刚的app元素上。
	  然后要看的是index.ts。
	  new Vue({
	    el: '#app',  ----》 #id，el挂载，构建了一个vue挂载到#id上。
	    render(h) {
	      return h(App);  ----》引入的 app.vue组件。
	    }
	  });
	
	4.package.json 
	  这个是依赖文件，类似于Android build.gradle依赖 sdk
	
	5.目录划分：(项目的目录比较乱)
	  views/index
	    1.components
	    2.constants
	    3.css 
	    4.helper
	    5.types
	    6.service
	    7.mixins
	    app.vue
	    index.html
	    index.ts


## 架构解析：

	1.types.ts:
	  声明对象，用interface的形式。（js,ts的export类似Java的public，用于暴露对象）
	  这里可以看到ts语法非常简洁，比python简洁。
	  写的格式有点类似kotlin。
	
	  export interface ICertificateResponse {
	      status: 0;    ----> ts语法的默认类型推断。
	      msg: string;
	      data: {
	        status: 1 | 2;  ----》 1 ｜ 2 可以理解为类型，跟下面的 string 等效。
	        headerText: string; 
	        text: string;
	      }
	  } 
	
	2.helper目录
	  1.eventbus.ts ----> 全局通信的，用于不同组件。
	    其实是构建了一个vue对象，也是一个组件，只是没有视图的组件。
	    语法：
	        eventBus.$emit   (发事件)
	        eventBus.$on    （接收事件）
	  2.index.ts
	    1.怎么理解js，挂载到webview上，能够拿到window对象，navigator对象，document。
	      window.location
	      navigator.useragent
	    2.
	    export function xxx(autoLogin = false) : xxx {  -----> 和kotlin语法一模一样
	
	    }
	    （res） => {
	
	    }
	  3.import('xxx').then((module) => {
	
	  })
	
	3.service目录，类似都是js方法，请求网络。
	
	4.components
	  1.rules.vue:
	      1.overLay 遮罩，绑定v-model boolean
	      2.<i class="ic_clo" @click="rule = false"></i>
	        @click 直接绑定方法代码块。
	  2.Popup.vue 
	      1.依然是overlay，v-model，然后使用v-if，v-show标签。
	      2.<button v-debounce="[() => saveImg(), 500]" v-exposure="saveExposure"></button>
	        在标签里面绑定代码块。
	      3.async await语法。
	  3.SwiperCard.vue
	      就是使用swiper组件，
	      参考文档：
	      使用swiper:https://juejin.cn/post/7139774316031246367
	      swiper原理，为什么new一个就能绑定组件：
	      https://juejin.cn/post/6965743195078524941
	      https://juejin.cn/post/7102806803057999879 (导包错误，非常好的文章)
	      https://juejin.cn/post/7110108160718798856 (排查问题，很好的文章)
	      https://blog.csdn.net/weixin_42063951/article/details/121354984 (大家的问题差不多)
  4.




## 语法部分：

	1.vue.use()
	  注册插件，自动执行install方法，全局引用，防止多次引入某个插件。
	  Vue.prototype.$appSNC = appSNC（这个是引入的组件）;
	  在vue原型上增加一个变量$appSNC，这样全局就可以使用这个变量。
	  简单的理解，就是引入一个sdk的单例对象，记录到全局，后面可以直接使用这个对象。
	  参考文档：
	  https://juejin.cn/post/7138216381283205128
	
	2.mixins:
	  不用继承，也想获取其他对象的一些方法。
	  Java实现继承         I am
	  ruby语法实现mixin    I can
	  参考文档：
	  https://zh.javascript.info/mixins
	
	3.vue style less使用：
	  将style标记为预编译，能否进行复用，以及使用js的一些东西。
	  参考文章：https://www.jianshu.com/p/f620121a6ec9
	
	4.style @import属性：
	  本身就是引入其他页面的css属性。
	  https://blog.csdn.net/TL18382950497/article/details/114452577
	
	5.import属性，一直不对，大概有一点点感觉了。
	
	  项目报错：https://github.com/vitejs/vite/issues/8542
	  https://blog.csdn.net/qiqibei666/article/details/103413080
	
	6.vue options api与 composition api:
	  由于基础不牢固，这个地方坑死我了。（起码有3个小时，在这个地方被坑！！！）
	  https://programeasily.com/2021/05/16/lifecycle-hooks-in-vue-3/


## 代码：

```java

	<template>
	  <section class="banner-card">
	    <div class="swiper">
	      <div class="swiper-wrapper">
	        <div class="swiper-slide">
	          <img class="banner-image"
	               src="../image/example1.jpg"
	               alt="图片一" />
	        </div>
	        <div class="swiper-slide">
	          <img class="banner-image"
	               src="../image/example2.jpg"
	               alt="图片二" />
	        </div>
	        <div class="swiper-slide">
	          <img class="banner-image"
	               src="../image/example3.jpg"
	               alt="图片三" />
	        </div>
	        <div class="swiper-slide">
	          <img class="banner-image"
	               src="../image/example3.jpg"
	               alt="图片三" />
	        </div>
	        <div class="swiper-slide">
	          <img class="banner-image"
	               src="../image/example3.jpg"
	               alt="图片三" />
	        </div>
	        <div class="swiper-slide">
	          <img class="banner-image"
	               src="../image/example3.jpg"
	               alt="图片三" />
	        </div>
	        <div class="swiper-slide">
	          <img class="banner-image"
	               src="../image/example3.jpg"
	               alt="图片三" />
	        </div>
	      </div>
	      <!-- 如果需要分页器 -->
	      <div class="swiper-pagination"></div>
	      <div class="swiper-button-prev"></div>
	      <!--左箭头。如果放置在swiper-container外面，需要自定义样式。-->
	      <div class="swiper-button-next"></div>
	      <!--右箭头。如果放置在swiper-container外面，需要自定义样式。-->
	    </div>
	  </section>
	
	</template>
	
	<script lang="ts">
	import { Vue } from 'vue-class-component'
	import {Swiper} from 'swiper' //这个地方不能用 swiper/vue 引入的是一个对象，不是我们用的那个swiper，可以看看引入的到底是谁。
	import 'swiper/bundle' //引入js
	import 'swiper/css/bundle' //引入css
	
	export default class AboutVue extends Vue {
	  mounted() {
	    this.$nextTick(() => this.initSwiper())
	  }
	
	  initSwiper() {
	    const ss = new Swiper('.swiper', {
	      loop: true,
	      pagination: {
	        el: '.swiper-pagination',
	      },
	      navigation: {
	        nextEl: '.swiper-button-next',
	        prevEl: '.swiper-button-prev',
	        hideOnClick: true,
	      },
	    })
	  }
	}
	</script>
	
	<style scoped>
	
	.banner-card {
	  width: 500px;
	  height: 200px;
	  margin: 20px auto;
	}
	
	.swiper-container {
	  width: 500px;
	  height: 200px;
	  margin: 20px auto;
	}
	
	.swiper-slide {
	  width: 300px;
	}
	
	.banner-image {
	  width: 500px;
	  height: 200px;
	  border: solid 1px red;
	} 
	</style>
```