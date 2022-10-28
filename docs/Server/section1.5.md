# Docker部署

## 参考文档：

1. gradle-plugin官方文档: https://github.com/palantir/gradle-docker

2. 查看架构： https://stackoverflow.com/questions/48678152/how-to-detect-386-amd64-arm-or-arm64-os-architecture-via-shell-bash

3. docker架构：
    https://stackoverflow.com/questions/66662820/m1-docker-preview-and-keycloak-images-platform-linux-amd64-does-not-match-th

4. docker启动之后立马退出
   https://blog.csdn.net/fengqing5578/article/details/94554897

5. 访问docker，端口映射：
    https://yeasy.gitbook.io/docker_practice/network/port_mapping

6. 检测端口开放：
	http://coolaf.com/tool/port
	
7. 减少docker镜像的办法：
https://dockone.io/article/8163

8. docker上传到docker hub:
https://codeantenna.com/a/LqP4u7dijX

9. centos安装docker:
https://cloud.tencent.com/developer/article/1701451

## 常用命令

	1. docker image inspect xxx，可以查看image的信息，尤其是平台，os等。
	2. docker save -o xxx.tar xxximage 将image进行打包，一般是传到vps上。
	3. docker load < xxx.tar vps上解压镜像
	4. docker run -dit -p 8080:8080 xxximage -it /bin/bash --platform linux/amd64 /bin/bash
	    指定platfrom进行加载
	5. docker logs  容器ID
	6. docker ps -a 查看正在运行的容器
	7. netstat -tln 查看监听的端口
	
## 遇到的错误

1. exec format error

		这个是通过docker logs查看的，也没有其他报错了，后来发现是平台不对，打包的是Mac的平台
		信息，然后一直报错。
		
2. The requested image's platform (linux/arm64/v8) does not match the detected host platform (linux/amd64) and no specific platform was requested

		这个必须要解决，否则启动之后，镜像立马挂了。
		
3. Invalid or corrupt jarfile /app.jar

		docker命令有误，后来改为了用gradle-docker去打包

	
## 最后，终于部署到服务器上了。





















