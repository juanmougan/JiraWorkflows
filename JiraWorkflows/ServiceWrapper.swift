//
//  ServiceWrapper.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 17/11/2020.
//

import Foundation

class ServiceWrapper {
    
    var jiraService = MockedService()
    
    func refreshData(data: JiraData) {
        let worklog = self.jiraService.getCounter(tickets: Int.random(in: 3..<5),
                                                   minutes: [360, 390, 420].randomElement()!,
                                                   status: "OK")
        print("Now mocked is: \(worklog)")
        data.timeAndTicketsMsg = "You logged \(String(format: "%.2f", Double(worklog.minutesLogged) / 60.0)) hours in \(worklog.totalTickets) tickets today"
        print(data.timeAndTicketsMsg)
        data.statusMsg = "You are on \"\(worklog.status.rawValue)\" status"
        print(data.statusMsg)
    }
}
