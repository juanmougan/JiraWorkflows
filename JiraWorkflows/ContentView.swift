//
//  ContentView.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import SwiftUI

struct ContentView: View {
    var jiraService = JiraService()
    
    var body: some View {
//        Text("Hello, World!")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
        let worklog = jiraService.getWorklog()
        let text = "You logged \(worklog.minutesLogged) minutes on \(worklog.totalTickets) tickets today"
        return Text(text)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
