//
//  JiraData.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 17/11/2020.
//

import Foundation


final class JiraData: ObservableObject {
    
    @Published var timeAndTicketsMsg: String
    @Published var statusMsg: String
    
    init() {
        let service = MockedService()
        let worklog = service.getCounter(tickets: 1, minutes: 60, status: Status.below.rawValue)
        self.timeAndTicketsMsg = "You logged \(String(format: "%.2f", Double(worklog.minutesLogged) / 60.0)) hours in \(worklog.totalTickets) tickets today"
        self.statusMsg = "You are on \"\(worklog.status.rawValue)\" status"
    }
    
}
