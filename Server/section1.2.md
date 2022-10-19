# rabbitMQ使用

## 参考文档

1.Mac安装rabbitmq:

https://cloud.tencent.com/developer/article/1791567

2.rabbitmq查看host，添加host

https://blog.csdn.net/yaomingyang/article/details/102752971

3.页面其实也可以添加host

https://www.macrozheng.com/mall/architect/mall_arch_09.html#rabbitmq

4.rabbitmq查看消息，以及在后台发消息

https://blog.csdn.net/qq_34004088/article/details/122069357

## 基础使用

>查看homebrew安装路径：/opt/homebrew/Cellar

开启rabbitmq: 

启用插件：

rabbitmq-plugins enable rabbitmq_management

rabbitmq-plugins disable rabbitmq_management

项目一直启动不了，现在开始看mongoDB 


>rabbitmq，服务启动之后，spring boot无法启动，端口问题，应该改为5672，现在已经能链接上了。
  https://blog.csdn.net/weixin_44004649/article/details/111565690

看到log了，rabbitmq真🐂🍺

	2022-10-19 15:17:57.521  INFO 60781 --- [nio-8080-exec-3] c.m.m.t.s.i.OmsPortalOrderServiceImpl    : process generateOrder
	2022-10-19 15:17:57.529  INFO 60781 --- [nio-8080-exec-3] c.m.m.tiny.component.CancelOrderSender   : send delay message orderId:11
	
	2022-10-19 15:18:07.654  INFO 60781 --- [cTaskExecutor-1] c.m.m.t.component.CancelOrderReceiver    : receive delay message orderId:11
	2022-10-19 15:18:07.661  INFO 60781 --- [cTaskExecutor-1] c.m.m.t.s.i.OmsPortalOrderServiceImpl    : process cancelOrder orderId:11


## rabbitmq的核心

1.发送消息到交换机

2.交换机根据不同的route-key入到不同的队列

3.队列分发消息

## 总结：

	1.安装rabbitmq，启动plugin, 15672
	2.添加依赖
	3.设置virtual host, 用户，密码
	4.spring boot配置这些,注意端口号是5672
	5.配置枚举类：1.队列name, 2.交换机name, 3.routekey
	6.配置config:
	  1.构建directChange(交换机)
	  2.构建队列 （可以构建死信队列）
	  3.将队列绑定到交换机上，绑定routeKey
	7.controller ---> service ---> sender ---> receiver
	8.sender: 动态注入 AmqpTemplate，进行 convertAndSendMessage
	  传入参数，交换机，routeKey, orderId, MessageProcessor处理message
	  这样消息就发送到了rabbitMq的消息队列
	9.receiver:
	  @RabbitListener(queues = "xxx")
	  因为之前队列已经绑定了交换机和routeKey，如果有消息，会通过回调，自动接收消息。
	  （这一步可能不是100%准确）

