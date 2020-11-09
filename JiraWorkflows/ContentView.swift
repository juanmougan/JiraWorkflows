//
//  ContentView.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import SwiftUI

enum Status: String {
    case below = "below"
    case ok = "ok"
    case overtime = "overtime"
}

final class JiraData: ObservableObject {
    init() {
        // TODO use real service
        self.worklog = self.jiraService.getCounter(tickets: 2, minutes: 120)
    }
    
    init(hours: Double, tickets: Int) {
//        self.hours = hours
//        self.tickets = tickets
//        self.logStatus = logStatus
        self.worklog = Worklog(minutesLogged: Int(hours) * 60, totalTickets: tickets)
    }
    
    func refresh() {
        self.worklog = self.jiraService.getCounter(tickets: 2, minutes: 120)
    }
    
    func getTimeAndTickets() -> String {
        return "You logged \(String(format: "%.2f", Double(self.worklog.minutesLogged) / 60.0)) hours in \(self.worklog.totalTickets) tickets today"
    }
    
    func getStatus() -> String {
        // TODO removed hardcoded part
        return "You are on \"\(Status.below.rawValue)\" status"
    }
    
    var jiraService = FakeService()
    @Published var worklog: Worklog
//    @Published var hours = 0.0
//    @Published var tickets = 0
//    @Published var logStatus = Status.below
}

struct ContentView: View {
    @ObservedObject var jiraData = JiraData()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(jiraData.getTimeAndTickets())
                .font(Font.system(size: 20.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16.0)
                //                .padding(.vertical, 12.0)
                .frame(width: 360.0, height: 80.0, alignment: .topLeading)
            Text(jiraData.getStatus())
                .font(Font.system(size: 20.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16.0)
                //                .padding(.vertical, 12.0)
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
//        ContentView(jiraData: JiraData(hours: 6.5, tickets: 2, logStatus: Status.ok))
        ContentView(jiraData: JiraData(hours: 6.5, tickets: 2))
    }
}
#endif
