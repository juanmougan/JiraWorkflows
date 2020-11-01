//
//  ContentView.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    // TODO for testing only
    static var timesClicked = 0
    
    var body: some View {
//        return Text(getWorkflowText())
        return Text(getFakeText())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    func getWorkflowText() -> String {
        // TODO this should either have from a property/app parameter
        // or be placed at a "standard" location (e.g. Maven local repository)
        let jiraService = JiraService(jarPath: "/Users/juanm3/code/juan/worklogs_collector/target/worklogs_collector-0.0.1-SNAPSHOT.jar")
        let worklog = jiraService.getWorklog()
        return "You logged \(worklog.minutesLogged) minutes on \(worklog.totalTickets) tickets today"
    }
    func getFakeText() -> String {
        let fakeService = FakeService()
        ContentView.timesClicked += 1
        return "Visitors so far: \(fakeService.getCounter(tickets: ContentView.timesClicked, minutes: ContentView.timesClicked*60))"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
