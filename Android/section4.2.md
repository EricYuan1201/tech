# SurfaceView TextureView对比

## 参考文章

1.今天完成任务的主要文章：（只记住了一行代码关键字）
https://mp.weixin.qq.com/s?__biz=MzAxMTI4MTkwNQ==&mid=2650830283&idx=1&sn=bb0bcebfd025805ddda7bb2c36f7231e&chksm=80b7a155b7c028437cffc35a62003f7dfcc00a275b52fe98aa3c1aa9034a6fc74b16f5f18910&cur_album_id=1374912898463776768&scene=189#wechat_redirect

2.看到的大佬文章：
https://zhuanlan.zhihu.com/p/75458539

3.systrace文章合集：
https://androidperformance.com/2019/11/06/Android-Systrace-MainThread-And-RenderThread/#/%E6%AD%A3%E6%96%87

4.SurfaceView 与 TextureView对比：
https://cloud.tencent.com/developer/article/1771629

## 背景知识：

主线程
渲染线程 RenderThread

1.渲染线程，是安卓后续加的，是利用GPU的能力减轻主线程的负担。

![2022-11-15_e53d78285e0b.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_e53d78285e0b.jpg)

2.渲染线程从bufferQueue里面获取数据，然后等GPU处理之后再交给bufferQueue，然后通过
surfaceFlinger去真正进行渲染。

## SurfaceView 和 TextureView区别:

### 1.surfaceView的基础：

![2022-11-15_b7402787452e.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_b7402787452e.jpg)


1.surface才是真正绘制的地方，surface持有canvas，我们一般调用canvas，其实是在surface上进行绘画。

2.surface View的核心是双缓冲技术，frontCanvas, backCanvaer，可以有单独的线程进行绘制。

![2022-11-15_b46a82842afb.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_b46a82842afb.jpg)

3.核心api: SurfaceHolder

### 2.TextureView:

背景：
	
	也是因为surfaceView不能做动画，所以引入了 TextureView。

核心：

	TextureView 是一个可以把内容流作为外部纹理输出在上面的 View, 它本身需要是一个硬件加速层。

	Android 5.0之后引入渲染线程，textureView也是在渲染线程进行初始化。
    内部维护一个缓冲队列。
    
## 今天问题解决


![2022-11-15_3d0987dd57c6.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_3d0987dd57c6.jpg)

	记录surfaceView setLayerType导致视频无法播放的问题：
	1.首先搜关键字：一行代码，找到了之前的文章
	2.从上到下的路子走不通，考虑从下到上。
	3.还是对系统api不熟，没有找到dispatchDraw(), drawChild()这个方法。