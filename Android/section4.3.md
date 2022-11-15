# 打包、签名、对齐

## 参考文章：

1.cdn忽然又挂了，搜了一圈找到这个自动cdn的网站，也许就好了。
https://www.jsdelivr.com/github
默认地址，需要加一个 @main，感觉能快很多

2.参考的是这篇文章：（主要还是n多工具的问题）
https://zhuanlan.zhihu.com/p/348198783

3.加密，解密：
https://www.jianshu.com/p/de50d1489359

4.看到一篇不错的文章：
https://juejin.cn/post/7035911159362371597

5.大佬的文章：
https://zhuanlan.zhihu.com/p/75458539
https://juejin.cn/post/7035911159362371597

6.签名详解：
https://www.jianshu.com/p/286d2b372334
https://www.jianshu.com/p/f1ae1081d0ee （重要）

7.对齐操作：
https://www.jianshu.com/p/13d6fbad49f6
https://blog.csdn.net/eydwyz/article/details/62893842

## 打包流程

![2022-11-14_91687e179599.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-14_91687e179599.jpg)

aapt: android asset packaging tool
resource.arsc: association record for resource center.

		1.aapt: 生成资源索引，其实主要是R.java文件
		2.aidl(也是工具)：解析aidl接口文件，生成java文件。
		3.Java编译器: java ---> class
		4.dx工具：class ---> dex (java字节码变成Dalvik字节码，压缩常量池等)
		5.apkbuilder: 资源文件，dex文件 ---> apk
		6.jarsigner: 签名
		7.zipalign: 对齐。


## 签名

![2022-11-14_ba461be6f8aa.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-14_ba461be6f8aa.jpg)

![2022-11-15_8b39d342fb1a.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_8b39d342fb1a.jpg)


签名作用：

	1.保证apk不被修改。（修改之后，摘要验证不通过，安装不成功）
	2.升级的时候验证证书是否一致，一致才允许升级。

证书内容：

	1.证书机构名称
	2.证书机构的签名
	3.加密算法
	4.公钥

![2022-11-15_67b6e1dd793a.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_67b6e1dd793a.jpg)


### v1签名：

![2022-11-15_33a06de745ba.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_33a06de745ba.jpg)

	1.获取每个文件的摘要 ----》 manifest.mf
	2.获取manifest的摘要，manifest每一块的摘要: cert.sf
	3.获取cert.sf的摘要，cert.rsa

v1签名的问题：

	1.慢
	2.只会校验zip文件中的部分文件，像meta-info文件夹就不会参与。

### v2签名：

背景：

	1.解决v1签名慢的问题
	2.解决不会校验某些部分的问题
	3.zip解压流程：

![2022-11-15_d56b7328bd31.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_d56b7328bd31.jpg)

v2签名就是在文件内容区和目录区中间插入签名，不影响解压流程
核心是分块，chunk的形式，1M级别，提升速度。

![2022-11-15_8dbeef4a0937.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_8dbeef4a0937.jpg)

![2022-11-15_c65e8299338e.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-11-15_c65e8299338e.jpg)


### v3签名：

其实是基于v2签名的，支持了签名的升级替换，记录了新旧签名信息。


### 对齐：

对齐一般是4字节对齐，为什么是4字节，4字节32位，在32位cpu上，寄存器一次性处理32位数据，刚好处理完，能够提升效率。

对齐会导致体积略大。




