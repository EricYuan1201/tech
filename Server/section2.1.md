# 授权登录

## 参考文档：

1.session, cookie, token, jwt token

https://juejin.cn/post/6844904034181070861

2.豆瓣网微信登录流程，oAuth2，有点类似一键登录。

https://blog.51cto.com/alex4dream/2740217

3.跨站伪造请求，CRSF攻击，CSRF攻击是源于WEB的隐式身份验证机制！WEB的身份验证机制虽然可以保证一个请求是来自于某个用户的浏览器，但却无法保证该请求是用户批准发送的！

https://www.cnblogs.com/hyddd/archive/2009/04/09/1432744.html

4.后端登录方式：

https://juejin.cn/post/7129298214959710244#heading-61


## jwt

	header -----> 放的是签名算法
	payload ------> 放的是用户信息
	signature -------> 签名

>解码网站：https://jwt.io/

JWT实现认证和授权

	1.用户登录，获取jwt token
	
	2.后续请求都带着这个token,放到header里面，key是 Authorization
	
	3.后台解码jwt token，获取用户信息。

集成JWT token:

	1.generateToken
	
	2.getUserNameFromToken
	
	3.validateToken

## 使用Spring secruty的步骤：

	1.写JwtUtils，构建生成jwt token，获取username的方法。
	2.配置SecurtyConfig
	  1.继承WebSecurityConfigurerAdapter
	  2.配置允许的请求，以及跨域options请求，除此之外必须要要求授权访问。
	  3.禁止crsf
	  4.禁止session
	  5.禁用缓存
	  6.配置JWT filter
	  7.配置未授权返回结果
	3.动态注入的3个核心：
	
		@Autowired
	    private UmsAdminService adminService;
	    @Autowired
	    private RestfulAccessDeniedHandler restfulAccessDeniedHandler;
	    @Autowired
	    private RestAuthenticationEntryPoint restAuthenticationEntryPoint;
	
	RestfulAccessDeniedHandler：解决的是没有访问权限
	RestAuthenticationEntryPoint：解决的是未登录或者token失效。
	JwtAuthenticationTokenFilter： (开始感受到后端配置数据库的繁杂了)
	  最后的核心是：SecurityContextHolder.getContext().setAuthentication(authentication);
	  
	  
	  

## demo


	  1.demo入口肯定是controller
	  2.然后是service，就是autowired动态注入的那些。
	  3.注册接口，直接写到数据库中
	  4.登录接口，返回token，依然是绑定Security
	
	  	 UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
	     SecurityContextHolder.getContext().setAuthentication(authentication);
	     token = jwtTokenUtil.generateToken(userDetails);
	   5.修改swagger配置，自带Authorization头。
	     //添加登录认证
	     .securitySchemes(securitySchemes())
	     .securityContexts(securityContexts());
	   6.给某些操作添加权限配置
	     @PreAuthorize("hasAuthority('pms:brand:read')")


## 一键登录流程：

	1.sdk初始化，传入appkey，appSecret
	2.点击登录，调用sdk授权接口，返回手机号掩码，请求成功，返回授权页，否则跳到手动登录页。
	3.点击同意登录，sdk请求接口，返回token
	4.客户端拿着token请求自己的服务器，服务器携带token请求运营商接口返回用户手机号，
	  获取成功再进行注册和登录操作。

oauth2也是根据临时code换取access_token，然后服务端拿着这个access_token去向资源所有者发起请求获取用户信息，然后进行注册或者登录操作，然后再返回自己的token/jwt token。