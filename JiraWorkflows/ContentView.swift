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

struct ContentView: View {
    let hours = 1
    let tickets = 1
    let logStatus = Status.below
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("You logged \(hours) hours in \(tickets) tickets today")
                .font(Font.system(size: 20.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16.0)
//                .padding(.vertical, 12.0)
                .frame(width: 360.0, height: 80.0, alignment: .topLeading)
            Text("You are on \"\(logStatus.rawValue)\" status")
                .font(Font.system(size: 20.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16.0)
//                .padding(.vertical, 12.0)
                .frame(width: 360.0, height: 80, alignment: .topLeading)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
