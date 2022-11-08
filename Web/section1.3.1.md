# vue架构梳理二

### vue布局学习：
https://juejin.cn/post/7004622232378966046

https://juejin.cn/post/6850418116741038093#heading-3

	1.首先还是布局整体，分为几个模板，然后进行布局。
	  每个模块都可以抽象为组件，然后直接引用组件。
	2.需要掌握基本的布局能力

### 1.设置居右：
  1.内联元素：
  
    给out设置 text-algin ----> 类似安卓的 layout-gravity。
  2.块级元素：
  
    1.float:right
    2.margin-left:auto :我们将块级元素的某一个水平方向的 margin 值设置为 auto，那么它就会自动填充剩余空间。
    3.绝对定位：absolute, right 0 (相对父元素进行定位，一般会用absolute吧)
    4.flex: align-self : flex-end
    
### 2.flex布局学习：

	  1.引用了这个flex布局，浏览器自动帮我们布局，有点类似一个自定义ViewGroup，决定的是子child的布局方式。
	  2.方向（direction），折行(wrap)，flow(前面二者的结合)，对齐，算是最基本的能力。
	  3.最重要的是 justify-content: center居中， space-between, space-around。
	  4.子child可以设置 order。
	  5.子child属性，最重要的是 flex-grow（设置不同item比例）， flex-shink (缩放)
	  
### 3.定位：
  
  An absolutely positioned element is an element whose computed position value is absolute or fixed . The top , right , bottom , and left properties specify offsets from the edges of the element's containing block.

### 4.怎么布局：

  1.从外到内，先构造整体，一般是header,sidebar,main区域
  2.构建组件，新建目录，下面是index.vue，然后可以直接使用目录.vue
  3.注册组件，然后import使用组件，组件作为html标签，是大小写不敏感的。
  4.router-view作为挂载项，是跟URL一块进行切换、展示组件的。
  5.就是不停的写组件。