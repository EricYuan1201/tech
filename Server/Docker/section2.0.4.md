# docker构建图床服务

##参考文档：

1.centos安装docker:

https://www.myfreax.com/how-to-install-gradle-on-centos-7/

2.gradle-docker官方文档：（值得看很多遍）

https://github.com/palantir/gradle-docker

3.1集成docker plugin(idea用的)，这个能看远程的镜像和容器：

https://blog.csdn.net/Ajekseg/article/details/123936557

3.2如果按照这种，其实也能部署，不过每次都需要改版本号，我一时没有找到简单的办法：

https://blog.csdn.net/xhtchina/article/details/126436348

https://blog.csdn.net/boling_cavalry/article/details/100051325

https://www.cnblogs.com/dw3306/p/14047445.html，这个文档比较细。

4.文件上传服务器

https://blog.csdn.net/qq_40298902/article/details/125294163

5.构建nginx图床服务器：

https://cloud.tencent.com/developer/article/2059698

##项目分解：

1.需要上传图片服务。

2.需要能够访问图片。

其实也可以构建一个服务，不过需要写一些逻辑了，拆分一下反而容易一些，毕竟是自己的demo工程。


###1.构建图床服务：

其实就是一个nginx，然后把图片放到nginx目录下，然后就能够直接访问了。

使用docker，再次感受到了docker的厉害。

写dockerFile:

	FROM nginx:latest
	MAINTAINER username
	COPY default.conf /etc/nginx/conf.d/default.conf
	EXPOSE 80

2.配置nginx.conf：

	server {
	    listen       80;
	    server_name  localhost;

	    #(5)
	    #charset koi8-r;
	    #access_log  /var/log/nginx/host.access.log  main;

	    location / {
	        root   /usr/share/nginx/html;
	        index  index.html index.htm;
	    }

	    #(1)
	    location /images/ {
	        root  /mnt/;
	        autoindex on; #(2)
	        autoindex_exact_size off; #(3)
	        autoindex_localtime on; #(4)
	        charset utf-8,gbk; #(5)
	    }

	    #error_page  404              /404.html;

	    # redirect server error pages to the static page /50x.html
	    #
	    error_page   500 502 503 504  /50x.html;
	    location = /50x.html {
	        root   /usr/share/nginx/html;
	    }
	}

然后构建镜像，启动容器：

docker run -d --name image  -p 8089:80 -v  images:/mnt/images image:v1

-v是挂载配置，前面是本地路径，后面的docker容器里面的路径，做一个映射，能够写入到本地文件中。

###2.需要上传图片服务。

这个就是一个纯粹的spring boot项目，里面只声明了一个controller，就是fileUploadController

核心点：

>文件上传之后，开启docker服务，volums本地路径和上面的图床服务器配置为1个，这样这边上传之后，另外一边可以访问。

最后的策略：

	1. 创建git项目
	2. 本地写好代码之后提交
	3. 服务器拉git项目
	4. 配置platfrom, volum配置
	5. 执行 ./gradlew dockerBuildAndRun

## 其他：端口放开问题：

	尝试本地服务放到docker上，扫描端口一直不通
	https://tool.chinaz.com/port
	有两种可能：
	1.端口确实没放开
	2.端口放开了，但是没有服务，使用 netstat -nlpt 查看当前所有放开的端口。

