# Perfect模板[English](README.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>

Perfect空启动项目

这个库有一个空白的Perfect项目，可以克隆来作为新工程，它通过Swift Package Manager编译，并产生一个独立的HTTP可执行文件。

###与Swift的兼容性
此工程通过[Swift.org](http://swift.org/)获取Swift 3.0工具，在Xcode 8.0+ 或在Linux系统中使用

## Swift version note:

由于最近Xcode 8的bug，如果你想直接在Xcode运行，我们建议安装swiftenv和Swift 3.0.1预览版工具。

```
# after installing swiftenv from https://swiftenv.fuller.li/en/latest/
swiftenv install https://swift.org/builds/swift-3.0.1-preview-1/xcode/swift-3.0.1-PREVIEW-1/swift-3.0.1-PREVIEW-1-osx.pkg
```
另外，在"Project Settings"的"Library Search Paths"中添加 $(PROJECT_DIR)递归

## 编译&运行

以下命令将会克隆并编译一个空的初始项目，并通过端口8181启动服务。

```
git clone https://github.com/PerfectlySoft/PerfectTemplate.git
cd PerfectTemplate
swift build
.build/debug/PerfectTemplate
```

**如果您看见编译有关于OpenSSL的错误，请参阅关于Swift版本，或Library Search Paths的建议.**

如果一切顺利，您会看见如下的输出:

```
Starting HTTP server on 0.0.0.0:8181 with document root ./webroot
```

这意味着服务器已经运行起来了并正等待连接。通过[http://localhost:8181/](http://127.0.0.1:8181/)来问个好吧~，按下control-c组合键可以关闭服务。

## 开始内容

模板文件包含了一个非常简单的"hello, world!"例子。

```swift
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

// 创建HTTP服务器.
let server = HTTPServer()

// 注册自定义路由和页面句柄
var routes = Routes()
routes.add(method: .get, uri: "/", handler: {
		request, response in
		response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
		response.completed()
	}
)

// 将路由注册到服务器.
server.addRoutes(routes)

// 监听8181端口
server.serverPort = 8181

// 设置文档根目录。
// 这个操作是可选的，如果没有静态页面内容则可以忽略这一步。
// 设置文档根目录后，对于其他所有未经过滤器或已注册路由来说的其他路径“/**”，都会指向这个根目录下的文件。
server.documentRoot = "./webroot"

// 逐个检查命令行参数和服务器配置
// 如果用命令行执行带 --help 参数的服务器可执行程序，就可以看到所有可以选择的参数。
// 如果调用时在命令行参数，而且该参数在配置文件中也有说明，则命令行参数的值会取代配置文件。
configureServer(server)

do {
	// 启动HTTP服务器
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
```


## 问题

我们正在使用JIRA来收集所有错误和支持相关的问题，因此，GitHub的问题已被禁用。</br>

如果您发现了错误，bug，或者任何建议，您可以移步[http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1) 并提交它。

在[http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues) 可以找到一个全面的开放问题列表。


## 更多信息
欲了解更多关于Perfect项目的信息，请访问 [perfect.org](http://perfect.org).
