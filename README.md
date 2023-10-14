# toj
基于Spring Boot+MyBatis+Mysql后端，React+antd前端的玩具级oj系统。

具有基本的oj功能，用户功能，后台管理以及评论区功能，使用[language server protocol](https://microsoft.github.io/language-server-protocol/)实现代码的自动补全。

- [toj](#toj)
  - [在线预览](#在线预览)
  - [功能特性](#功能特性)
  - [部署步骤](#部署步骤)
    - [环境需求](#环境需求)
    - [后端部署](#后端部署)
      - [web服务器(nginx)](#web服务器nginx)
      - [数据库部署](#数据库部署)
      - [后端](#后端)
      - [判题服务器](#判题服务器)
      - [language server](#language-server)
    - [前端部署](#前端部署)

## 在线预览
[点此在线预览项目](http://101.42.221.45/)
## 功能特性
✅ oj基础功能

✅ 管理员后台

✅ 评论区

✅ 代码自动补全

⬜ 分布式的判题端

⬜ docker快速部署

⬜ 数据分析

## 部署步骤

### 环境需求
language server对于本项目是可选的
* 建议使用**Linux**系统部署整个项目，其中判题端必须部署在**Linux**上
* Java 17+
* Mysql 5.7+
* Maven 3.8+(可选，用于打包后端项目)
* Nodejs(可选，用于language server和编译前端)
* 各个oj支持的语言所需的编译器或运行环境
* 各个oj支持的语言所对应的language server

### 后端部署
本项目采用前后端分离的架构，需要一个http服务器提供前端文件以及判题服务器所需文件的请求响应，以及提供一些反代服务。该文档使用nginx提供该服务
#### web服务器(nginx)
新建一个toj.conf文件置于nginx目录下的conf.d文件夹

[nginx参考配置](./toj.conf)

将项目内nginx目录下的各个文件夹放在配置内指定的目录

#### 数据库部署
将项目内的toj.sql放在合适的目录

执行以下命令还原toj.sql文件
```bash
mysql -u 数据库用户名 -p 数据库密码 < toj.sql文件路径
```
该备份数据包含管理员用户(用户名admin,密码adminadmin)，一个普通用户(用户名toddwu,密码toddtodd)以及少量预设数据和问题供测试

#### 后端

使用maven打包toj项目，或直接使用release内打包好的jar包
```bash
cd toj
mvn package
```

在jar包所在目录新建一个application.yml文件并按注释提示编辑配置
```yaml
#数据库配置
spring:
  datasource:
    url: jdbc:mysql://数据库地址:数据库端口/oj #修改数据库地址和端口为实际值
    username: root #数据库用户名
    password: toddwu7066 #数据库密码
    driver-class-name: com.mysql.jdbc.Driver

#无需修改
mybatis:
  configuration:
    map-underscore-to-camel-case: true #开启下划线(value_name)命名转驼峰(valueName)命名

#后端服务器地址配置（spring boot配置）
server:
  address: localhost

#判题服务器地址、端口配置
judge-server:
  address: localhost
  port: 9000
```

后台启动后端服务器jar包
```bash
nohup java -jar toj-0.0.1-SNAPSHOT.jar 1> log.out 2> error.out &
```

#### 判题服务器
安装所需的[语言环境](./language.md)

使用maven打包toj_judge项目，或直接使用release内打包好的jar包
```bash
cd toj_judge
mvn package
```

在jar包所在目录新建一个application.yml文件并按照注释提示编辑配置
```yaml
#判题服务器配置(spring boot配置)
server:
  port: 9000
  address: 0.0.0.0

#后端服务器的的地址和端口
backend-server:
  address: localhost
  port: 8080

#nginx的的地址和端口（判题端需要从此下载题目的验证和答案文件）
nginx-server:
  address: localhost
  port: 80
```

后台运行jar包
```bash
nohup java -jar Judger-0.0.1-SNAPSHOT.jar 1> log.out 2> error.out &
```
#### language server
由于每种编程语言都需要安装相应的语言服务器（Language Server），因此我们将这一部分的详细信息单独列在了[语言服务器文档](./lgs.md)中。请查阅该文档以获取更多关于语言服务器的信息。

### 前端部署
将release内的放到nginx配置的目录即可

如果需要自己编译或者调试

第一次编译或调试时，在toj_frontend目录下
```bash
npm install
```

往后，如果需要编译，则
```bash
npm run build
```
编译完成后，会在同目录下生成dist文件夹

如果需要调试，则
```bash
npm run dev
```