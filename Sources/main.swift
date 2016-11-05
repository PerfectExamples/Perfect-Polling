//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import SQLiteStORM
import PerfectTurnstileSQLite

connect = SQLiteConnect("./voting")

let pturnstile = TurnstilePerfectRealm()

let votetable = Polling(connect!)
try? votetable.setupTable()

// Set up the Authentication table
let auth = AuthAccount(connect!)
auth.setup()

// Connect the AccessTokenStore
tokenStore = AccessTokenStore(connect!)
tokenStore?.setup()


// Create HTTP server.
let server = HTTPServer()


let authWebRoutes = makeWebAuthRoutes()
server.addRoutes(authWebRoutes)

let pollRoutes = makePollRoutes()
server.addRoutes(pollRoutes)

// add routes to be checked for auth
var authenticationConfig = AuthenticationConfig()
authenticationConfig.include("/poll/*")

let authFilter = AuthFilter(authenticationConfig)

// Note that order matters when the filters are of the same priority level
server.setRequestFilters([pturnstile.requestFilter])
server.setRequestFilters([(authFilter, .high)])
server.setResponseFilters([pturnstile.responseFilter])


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
