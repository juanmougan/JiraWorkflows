//
//  ContentView.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import SwiftUI


final class JiraData: ObservableObject {
    init() {
        // TODO use real service
        self.worklog = self.jiraService.getCounter(tickets: 2, minutes: 120, status: "BELOW")
        self.timeAndTicketsMsg = "You logged \(String(format: "%.2f", Double(self.worklog.minutesLogged) / 60.0)) hours in \(self.worklog.totalTickets) tickets today"
        self.statusMsg = "You are on \"\(self.worklog.status.rawValue)\" status"
    }
    
    init(hours: Double, tickets: Int, status: Status) {
        self.worklog = Worklog(minutesLogged: Int(hours) * 60, totalTickets: tickets, status: status)
        self.timeAndTicketsMsg = "You logged \(String(format: "%.2f", Double(self.worklog.minutesLogged) / 60.0)) hours in \(self.worklog.totalTickets) tickets today"
        self.statusMsg = "You are on \"\(self.worklog.status.rawValue)\" status"
    }
    
    /// Refreshes the data in this object, by calling the underlying service again
    ///
    /// Despite SwiftUI's Observable pattern, I need the UI to toggle this interaction
    func refresh() {
        self.worklog = self.jiraService.getCounter(tickets: Int.random(in: 3..<5), minutes: 390, status: "OK")
        print("Now mocked is: \(self.worklog)")
        self.timeAndTicketsMsg = "You logged \(String(format: "%.2f", Double(self.worklog.minutesLogged) / 60.0)) hours in \(self.worklog.totalTickets) tickets today"
        print(self.timeAndTicketsMsg)
        self.statusMsg = "You are on \"\(self.worklog.status.rawValue)\" status"
        print(statusMsg)
    }
    
    var jiraService = MockedService()
    var worklog: Worklog
    @Published var timeAndTicketsMsg: String
    @Published var statusMsg: String
}

struct ContentView: View {
    @ObservedObject var jiraData = JiraData()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(jiraData.timeAndTicketsMsg)
                .font(Font.system(size: 20.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16.0)
                .frame(width: 360.0, height: 80.0, alignment: .topLeading)
            Text(jiraData.statusMsg)
                .font(Font.system(size: 20.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16.0)
                .frame(width: 360.0, height: 80, alignment: .topLeading)
            Button(action: {
                jiraData.refresh()  // TODO unneeded?
            })
            {
                Text("Refresh")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            Button(action: {
                NSApplication.shared.terminate(self)
            })
            {
                Text("Quit")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding(.trailing, 16.0)
            .frame(width: 360.0, alignment: .trailing)
        }
        .padding(0)
        .frame(width: 360.0, height: 360.0, alignment: .top)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(jiraData: JiraData(hours: 6.5, tickets: 2, status: Status.below))
    }
}
#endif
