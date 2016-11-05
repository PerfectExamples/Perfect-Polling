//
//  Polling.swift
//  Poll
//
//  Created by Jonathan Guthrie on 2016-11-05.
//
//

import StORM
import SQLiteStORM
import PerfectLib

class Polling: SQLiteStORM {
	var id = 0
	var userid = ""
	var option = ""

	override open func table() -> String {
		return "pollresults"
	}

	override func to(_ this: StORMRow) {
		id          = this.data["id"] as? Int ?? 0
		if let u = this.data["userid"] {
			userid		= u as! String
		}
		if let o = this.data["option"] {
			option		= o as! String
		}
	}

	func rows() -> [Polling] {
		var rows = [Polling]()
		for i in 0..<self.results.rows.count {
			let row = Polling()
			row.to(self.results.rows[i])
			rows.append(row)
		}
		return rows
	}

}
