# Docker使用(一)

>折腾了一个半小时，终于在gradle上集成了docker

## 参考文档

1.docker镜像路径不对的问题终于解决了，耗时1个半小时。
https://stackoverflow.com/questions/49941955/jar-file-not-found-when-building-a-docker-container-with-palantir-gradle-plug-i

2.build.gralde集成docker, docker-run命令
https://tomgregory.com/automating-docker-builds-with-gradle/

3.docker删除之前的镜像：
https://www.thegeekdiary.com/docker-troubleshooting-conflict-unable-to-delete-image-is-being-used-by-running-container/

## 代码配置

build.gradle

```java
buildscript {
    ext {
        springBootVersion = '2.3.7.RELEASE'
        gradleDockerVersion = '1.2'
    }

    repositories {
        maven { url 'https://maven.aliyun.com/repository/public' }
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
        classpath("se.transmode.gradle:gradle-docker:${gradleDockerVersion}")
    }
}


plugins {
    id 'org.springframework.boot' version '2.3.7.RELEASE'
    id 'io.spring.dependency-management' version '1.0.10.RELEASE'
    id 'java'
    id 'org.jetbrains.kotlin.jvm' version '1.5.31'
    id "com.palantir.docker" version "0.22.1"
    id "com.palantir.docker-run" version "0.22.1"
}

group = pGroup
version = pVersion
sourceCompatibility = pSourceCompatibility

repositories {
    maven { url 'https://maven.aliyun.com/repository/public' }
    mavenCentral()
}

dependencies {
    dependencies {
        implementation 'org.springframework.boot:spring-boot-starter-web'
        testImplementation 'org.springframework.boot:spring-boot-starter-test'
        implementation 'org.springframework.boot:spring-boot-starter-actuator'
        implementation 'org.springframework.boot:spring-boot-starter-aop'
        implementation 'org.springframework.boot:spring-boot-starter-validation'
        implementation 'org.springframework.boot:spring-boot-starter-data-redis'
//        implementation 'org.springframework.boot:spring-boot-starter-security'
        implementation 'org.springframework.boot:spring-boot-configuration-processor'
        implementation 'org.projectlombok:lombok'
        annotationProcessor 'org.projectlombok:lombok'
        implementation 'com.alibaba:druid-spring-boot-starter'
        implementation 'mysql:mysql-connector-java'
        implementation 'io.springfox:springfox-swagger2'
        implementation 'io.springfox:springfox-swagger-ui'
        implementation 'io.swagger:swagger-models'
        implementation 'io.swagger:swagger-annotations'
        implementation 'cn.hutool:hutool-all'
        implementation 'io.jsonwebtoken:jjwt'
        implementation 'com.baomidou:mybatis-plus-boot-starter'
        implementation 'com.baomidou:mybatis-plus-generator'
        implementation 'org.apache.velocity:velocity-engine-core'
        implementation 'org.jetbrains.kotlin:kotlin-reflect'
        implementation 'org.jetbrains.kotlin:kotlin-stdlib-jdk8'
    }

    dependencyManagement {
        dependencies {
            dependency 'com.alibaba:druid-spring-boot-starter:1.1.10'
            dependency 'mysql:mysql-connector-java:8.0.16'
            dependency 'io.springfox:springfox-swagger2:2.9.2'
            dependency 'io.springfox:springfox-swagger-ui:2.9.2'
            dependency 'io.swagger:swagger-models:1.6.0'
            dependency 'io.swagger:swagger-annotations:1.6.0'
            dependency 'cn.hutool:hutool-all:4.5.7'
            dependency 'io.jsonwebtoken:jjwt:0.9.0'
            dependency 'com.baomidou:mybatis-plus-boot-starter:3.3.2'
            dependency 'com.baomidou:mybatis-plus-generator:3.3.2'
            dependency 'org.apache.velocity:velocity-engine-core:2.2'
        }
    }
}

docker {
    dependsOn bootJar
    name "${jar.baseName}:${version}"
    files bootJar.archivePath
    buildArgs(['JAR_FILE': "${bootJar.archiveName}"])
}

dockerRun {
    name "${jar.baseName}"
    image "${jar.baseName}:${version}"
    ports '8080:8080'
    clean true
}

task dockerBuildImageAndRun(){
    dependsOn 'clean'
    dependsOn 'docker'
    dependsOn 'dockerRun'
    docker {}
    dockerRun {}
}
```

dockerFile配置

```java
FROM openjdk:8-jdk-alpine
#VOLUME ["/tmp"]
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar","-Duser.timezone=Asia/Shanghai","--Dserver.port=8080"]
EXPOSE 8080
```

gradle.properties

```java
pGroup=com.sina
pName=spring-boot-demo
pVersion=0.0.2-SNAPSHOT
pSourceCompatibility=1.8
```