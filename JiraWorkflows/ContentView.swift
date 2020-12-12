//
//  ContentView.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var jiraData = JiraData()
    let serviceWrapper = ServiceWrapper()
    
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
                serviceWrapper.refreshData(data: jiraData)
                print("In button action: \(jiraData.timeAndTicketsMsg)")
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
