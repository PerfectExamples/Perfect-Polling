//
//  Handlers.swift
//  Poll
//
//  Created by Jonathan Guthrie on 2016-11-05.
//
//

import PerfectHTTP
import SQLiteStORM
import StORM
import Foundation


func countAll() -> Int {
	let polling = Polling(connect!)
	try? polling.select(columns: ["COUNT(*) AS counter"], whereclause: "id > :1", params: [0], orderby: [])
	return polling.results.rows[0].data["counter"] as! Int
}

func getData(_ option: String, total: Int) -> [String: Any] {
	var r = [String: Any]()
	let polling = Polling(connect!)
	try? polling.select(columns: ["COUNT(*) AS counter"], whereclause: "option = :1", params: [option], orderby: [])
	r["option"] = option
	let counter = polling.results.rows[0].data["counter"] as! Int
	r["result"] = String(format: "%.2f", ((Double(counter) / Double(total)) * 100.0))
	return r
}



func displayVote(request: HTTPRequest, _ response: HTTPResponse) {

	let context: [String : Any] = [
		"accountID": request.user.authDetails?.account.uniqueID ?? "",
		"authenticated": request.user.authenticated
	]
	response.render(template: "vote", context: context)
	
}

func processVote(request: HTTPRequest, _ response: HTTPResponse) {

	let vote = Polling(connect!)
	if let opt = request.param(name: "option") {
		vote.option = opt
	}
	vote.userid = (request.user.authDetails?.account.uniqueID)!

	let _ = try? vote.save()

	let context: [String : Any] = [
		"accountID": request.user.authDetails?.account.uniqueID ?? "",
		"authenticated": request.user.authenticated,
		"voted": true
	]
	response.render(template: "vote", context: context)
	
}

func getResults(request: HTTPRequest, _ response: HTTPResponse) {

	let total = countAll()

	var resultArray = [[String: Any]]()
	resultArray.append(getData("CocoaPods", total: total))
	resultArray.append(getData("Carthage", total: total))
	resultArray.append(getData("SPM", total: total))
	resultArray.append(getData("Who Cares?", total: total))

	let context: [String : Any] = [
		"accountID": request.user.authDetails?.account.uniqueID ?? "",
		"authenticated": request.user.authenticated,
		"poll": resultArray
	]
	response.render(template: "pollresults", context: context)

}
