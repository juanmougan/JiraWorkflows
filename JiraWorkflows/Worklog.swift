//
//  Worklog.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 09/11/2020.
//

import Foundation


// This is the expected object
// TODO add a status supplied by the JAR, based on the rules
struct Worklog: Codable {
    var minutesLogged: Int
    var totalTickets: Int
}

// Parse JSON from the JAR's stdout
func parse(json: String) -> Worklog {
    let decoder = JSONDecoder()

    let data = Data(json.utf8)
    if let jsonWorklogs = try? decoder.decode(Worklog.self, from: data) {
        // jsonWorklogs has the data
        return jsonWorklogs
    }
    // TODO maybe handle error differently
    return Worklog(minutesLogged: 0, totalTickets: 0)
}
