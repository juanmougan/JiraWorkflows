//
//  Worklog.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 09/11/2020.
//

import Foundation


/// This is a Worklog possible status
enum Status: String, Codable, Equatable {
    case below = "below"
    case ok = "ok"
    case overtime = "overtime"
    
    public init(from decoder: Decoder) throws {
        // If decoding fails, we default to "below"
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            self = .below
            return
        }
        self = Status(rawValue: rawValue) ?? .below
    }
}

/// This represents a Worklog on JIRA
struct Worklog: Codable {
    var minutesLogged: Int
    var totalTickets: Int
    var status: Status
}

/// Parses a JSON obtained from the JAR's stdout
func parse(json: String) -> Worklog {
    let decoder = JSONDecoder()
    
    let data = Data(json.utf8)
    if let jsonWorklogs = try? decoder.decode(Worklog.self, from: data) {
        return jsonWorklogs
    }
    // TODO maybe handle error differently
    return Worklog(minutesLogged: 0, totalTickets: 0, status: Status.below)
}
