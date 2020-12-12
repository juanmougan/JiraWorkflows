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
        let service = JiraService(jarPath: ".m2/repository/com/github/juanmougan/jira/worklogs_collector/0.0.1-SNAPSHOT/worklogs_collector-0.0.1-SNAPSHOT.jar")
        let worklog = service.getWorklog()
        self.timeAndTicketsMsg = "You logged \(String(format: "%.2f", Double(worklog.minutesLogged) / 60.0)) hours in \(worklog.totalTickets) tickets today"
        self.statusMsg = "You are on \"\(worklog.status.rawValue)\" status"
    }
    
}
