# css入门

## vue的数据绑定：


    data () {
      return {
        books: [], -------> 3.这个data和上面的页面进行绑定，自动进行展示。
        currentPage: 1,
        pagesize: 18
      }
    },
	mounted: function () { ---> 1.vue挂载的时候请求数据
	      this.loadBooks()
	    },
	methods: {
	  loadBooks () {
	    var _this = this
	    this.$axios.get('/books').then(resp => {
	      if (resp && resp.data.code === 200) {
	        _this.books = resp.data.result ------> 	2.请求完数据更新data
	      }
	    })
	  },
	  searchResult () {
        var _this = this
        this.$axios
          .get('/search?keywords=' + this.$refs.searchBar.keywords, {
          }).then(resp => {
          if (resp && resp.data.code === 200) {
            _this.books = resp.data.result  -----> 也是同样的数据绑定。
          }
        })
      }

## demo中css样式学习：

	witdth: auto 和 100%的区别：auto即使有margin, padding，也不会溢出父容器。
	而100%会溢出，所以一般用auto就行，就是撑满父容器的写法。
	https://www.jianshu.com/p/2f9423078ffb
	
	
	float学习，是布局中一个很好用的点。
	一般是布局图片，可以将图片紧密排列。如果是单个float的话，有点类似position的意思，我布局了之后其他的再进行布局。
	https://www.runoob.com/css/css-float.html
	
	
	el-breadcrumb，面包屑导航：涉及到element-ui了。
	https://blog.csdn.net/m0_56349322/article/details/123753381


## 然后我决定还是看一下菜鸟教程吧：

1.定位：定位的修饰符是top, bottom, left, right。
  
	  static:默认，不受top...影响
	  fixed:固定，相对于浏览器窗口，不会随着内容滚动而变化。
	  relative: 相对其正常位置进行定位。
	  absolute: 绝对定位的元素是相对最近的已定位父元素进行定位，如果没有，则相对窗口。
	            这个很好用啊，就是top, bottom, left, right是指相对这些位置的距离。
	  sticky: 粘性。

2.overflow: 这个很实用啊，就是如果是有固定宽高的，比如width, height，然后内容溢出的时候，怎么呈现内容格式，一般选择： auto/scroll，呈现滚动的效果。
优先选择auto吧。

3.float，浮动，刚刚已经看过了。

4.对齐：
  1.margin: auto, 相对外面居中
  2.padding: auto, 相对内元素居中
  3.text-align: center, 文本居中
  4.左右对齐：
  
    1.
    position: absolute; ---> 相对于已定位父容器的位置。一般包裹一个相对的布局。
    right: 0px; (可以设置top, left, bottom实现不同位置的对齐。)
    2. float
	5.垂直居中
	    line-height: 200px;
	    height: 200px;

 5.display: 
 
	   1.隐藏元素：display:none或visibility:hidden
	   2.块元素和内联元素：
	     块元素是一个元素，占用了全部宽度，在前后都是换行符。
			块元素的例子：

		<h1>
		<p>
		<div>
		内联元素只需要必要的宽度，不强制换行。

		内联元素的例子：

		<span>
		<a>
    display可以改变块元素和内联元素的属性。
    
    

6.z-index, 垂直的位置，默认是0，越高越在前面。

7.cursor: 鼠标在的时候呈现的样式：
   https://developer.mozilla.org/zh-CN/docs/Web/CSS/cursor

8.!important ----> 说明这个属性优先级非常之高，会覆盖其他的属性设置。

9.@media 属性，针对不同的宽度，一般可以设置display: none, float:none，取消一些大的内容块，优化展示：
https://www.runoob.com/cssref/css3-pr-mediaquery.html

10.height: vh, 百分比布局，动态设置。
   https://www.educative.io/answers/what-are-css-viewport-units

11.opacity 属性指定了一个元素的不透明度: 1,完全不透明，0，完全透明。

12.text-decoration 下划线配置
https://developer.mozilla.org/zh-CN/docs/Web/CSS/text-decoration

13.display: flext，弹性布局，实现居中均分配置。
https://zhuanlan.zhihu.com/p/25303493