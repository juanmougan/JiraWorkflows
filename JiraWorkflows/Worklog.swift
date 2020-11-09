//
//  Worklog.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 09/11/2020.
//

import Foundation


enum Status: String, Codable {
    case below = "below"
    case ok = "ok"
    case overtime = "overtime"
}

// This is the expected object
struct Worklog: Codable {
    var minutesLogged: Int
    var totalTickets: Int
    var status: Status
}

// Parse JSON from the JAR's stdout
func parse(json: String) -> Worklog {
    let decoder = JSONDecoder()

    let data = Data(json.utf8)
    if let jsonWorklogs = try? decoder.decode(Worklog.self, from: data) {
        return jsonWorklogs
    }
    // TODO maybe handle error differently
    return Worklog(minutesLogged: 0, totalTickets: 0, status: Status.below)
}
