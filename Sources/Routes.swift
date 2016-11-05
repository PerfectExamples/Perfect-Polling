//
//  Routes.swift
//  Poll
//
//  Created by Jonathan Guthrie on 2016-11-05.
//
//

import PerfectHTTP

public func makePollRoutes() -> Routes {
	var routes = Routes()

	routes.add(method: .get, uri: "/poll/vote", handler: displayVote)
	routes.add(method: .post, uri: "/poll/vote", handler: processVote)
	routes.add(method: .get, uri: "/poll/results", handler: getResults)

	return routes
}
