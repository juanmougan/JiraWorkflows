//
//  FakeService.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 29/10/2020.
//

import Foundation

struct FakeService {
    func getCounter(tickets: Int, minutes: Int) -> String {
        // Create a task with the command to run
        let task = Process()
        let fileLocation = "/Users/juanm3/code/juan/fake_worklogs_collector/target/fake_worklogs_collector-1.0-SNAPSHOT-jar-with-dependencies.jar"
        let fileExists : Bool = FileManager.default.fileExists(atPath: fileLocation)
        if !fileExists {
            print("file not found!")
            // TODO halt?
        }
        let BASH_PATH = "/bin/sh"
        let javaArgs = "\(tickets) \(minutes)"
        let javaCommand = "/usr/bin/java -jar \(fileLocation) \(javaArgs)"
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
        if !error.trimmingCharacters(in: .whitespaces).isEmpty {
            print("ERROR: \(error)")
            return "ERROR: \(error)"
        }
        print("Output: \(output)")
        return output
    }
}
