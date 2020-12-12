//
//  JiraService.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import Foundation


struct JiraService {
    
    let jarPath: String
    
    init(jarPath path: String) {
        self.jarPath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(path).path
        print("IN JiraService: \(self.jarPath)")
//        jarPath = path
    }
    
    func getWorklog() -> Worklog {
        // Create a task with the command to run
        let task = Process()
        let fileExists : Bool = FileManager.default.fileExists(atPath: self.jarPath)
        if !fileExists {
            print("file not found!")
            // TODO halt?
        }
        let BASH_PATH = "/bin/sh"
        let javaCommand = "/usr/bin/java -jar \(self.jarPath)"
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
