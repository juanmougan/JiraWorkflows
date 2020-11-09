//
//  MockedService.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 09/11/2020.
//

import Foundation


struct MockedService {
    func getCounter(tickets: Int, minutes: Int, status: String) -> Worklog {
        let json = "{\"totalTickets\":\(tickets),\"minutesLogged\":\(minutes),\"status\":\"\(status)\"}"
        print("At MockedService: \(json)")
        return parse(json: json)
    }
}
