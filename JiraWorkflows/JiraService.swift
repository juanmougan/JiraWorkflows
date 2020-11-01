//
//  JiraService.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import Foundation

// This is the expected object
struct Worklog: Codable {
    var minutesLogged: Int
    var totalTickets: Int
}

// Parse JSON from the JAR's stdout
func parse(json: String) -> Worklog {
    let decoder = JSONDecoder()

    let data = Data(json.utf8)
    //JSONDecoder().decode(DatabaseObject.self, from: json.data(encoding: .utf8))
    //if let jsonWorklogs = try? decoder.decode(Worklog.self, from: json) {
    if let jsonWorklogs = try? decoder.decode(Worklog.self, from: data) {
        // jsonWorklogs has the data
        return jsonWorklogs
    }
    // TODO maybe handle error differently
    return Worklog(minutesLogged: 0, totalTickets: 0)
}

struct JiraService {
    
    var jarPath: String
    
    init(jarPath path: String) {
        jarPath = path
    }
    
    func getWorklog() -> Worklog {
        // Create a task with the command to run
        let task = Process()
        // TODO get the JAR from
//        let fileLocation = "/Users/juanm3/repository/com/github/juanmougan/jira/worklogs_collector/0.0.1-SNAPSHOT/worklogs_collector-0.0.1-SNAPSHOT.jar"
        let fileExists : Bool = FileManager.default.fileExists(atPath: jarPath)
        if !fileExists {
            print("file not found!")
            // TODO halt?
        }
        let BASH_PATH = "/bin/sh"
        let javaCommand = "/usr/bin/java -jar \(jarPath)"
        task.executableURL = URL(fileURLWithPath: BASH_PATH)

        // Add arguments
        let programArguments = javaCommand  // TODO maybe add other arguments?
        // https://www.hackingwithswift.com/forums/swiftui/task-run-returns-the-file-command-doesn-t-exist/851/859
        task.arguments = ["-c", programArguments]

        // Pipe stdout and stderr
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        task.standardOutput = outputPipe
        task.standardError = errorPipe

        // Run it - TODO handle errors?
        try? task.run()

        // Gather output and error
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()

        // Convert to Strings
        let output = String(decoding: outputData, as: UTF8.self)
        let error = String(decoding: errorData, as: UTF8.self)
        print("Output: \(output)")
        print("Error: \(error)")
        return parse(json: output)
    }
}
