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

// Create HTTP server.
let server = HTTPServer()

// Register your own routes and handlers
var routes = Routes()
routes.add(method: .get, uri: "/", handler: {
		request, response in
		response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
		response.completed()
	}
)

// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**
server.documentRoot = "./webroot"

// Gather command line options and further configure the server.
// Run the server with --help to see the list of supported arguments.
// Command line arguments will supplant any of the values set above.
configureServer(server)

do {
	// Launch the HTTP server.
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