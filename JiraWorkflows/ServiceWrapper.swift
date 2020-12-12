//
//  ServiceWrapper.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 17/11/2020.
//

import Foundation

class ServiceWrapper {
    
    let jiraService = JiraService(jarPath: ".m2/repository/com/github/juanmougan/jira/worklogs_collector/0.0.1-SNAPSHOT/worklogs_collector-0.0.1-SNAPSHOT.jar")
    
    func refreshData(data: JiraData) {
        let worklog = self.jiraService.getWorklog()
        print("Now mocked is: \(worklog)")
        data.timeAndTicketsMsg = "You logged \(String(format: "%.2f", Double(worklog.minutesLogged) / 60.0)) hours in \(worklog.totalTickets) tickets today"
        print(data.timeAndTicketsMsg)
        data.statusMsg = "You are on \"\(worklog.status.rawValue)\" status"
        print(data.statusMsg)
    }
}
