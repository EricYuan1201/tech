# idea无法执行docker task趟坑

## 参考文档

1.官方github文档，为啥docker task 在idea里面执行不了:
https://github.com/Transmode/gradle-docker/issues/65

2.折腾了2个小时，在一个人的回答里面看到了提示，可能是路径空格问题：
https://github.com/Transmode/gradle-docker/issues/83

3.升级docker，docker_run 版本号：
https://plugins.gradle.org/plugin/com.palantir.docker-run

4.每次拉取jdk都非常慢，替换镜像：
https://blog.csdn.net/whatday/article/details/86770609

## 过程

	1.配置环境又折腾了两个小时。
	2.终端能够执行docker task，但是idea里面无法执行，一直报no such file error。
	3.看完了所有的链接。
	4.终端启动
	5.大概率是路径问题，项目路径包含了一个空格。