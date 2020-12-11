//
//  AppDelegate.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import Cocoa
import SwiftUI
import Cron

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var popover = NSPopover.init()
    var statusBar: StatusBarController?
    // This pattern means: run every business day at 5pm
    let cronPattern = "0 0 17 * * 1,2,3,4,5 *"
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create the SwiftUI view that provides the contents
        let contentView = ContentView()
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.contentViewController = NSHostingController(rootView: contentView)
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        // Create the Status Bar Item with the above Popover
        statusBar = StatusBarController.init(popover)
        
        // Set up a cron to get JIRA's data
        setUpCron()
    }
    
    func setUpCron() {
        _ = try? CronJob(pattern: cronPattern) { () -> Void in
            self.runTask()
        }   // TODO catch cron failure?
    }
    
    func runTask() {
        // Run JAR
//        let service = MockedService()
        let service = JiraService(jarPath: ".m2/repository/com/github/juanmougan/jira/worklogs_collector/0.0.1-SNAPSHOT/worklogs_collector-0.0.1-SNAPSHOT.jar")
        // TODO handle stderr from service somehow
//        let worklog = service.getCounter(tickets: Int.random(in: 3..<5), minutes: 390, status: "OK")
        let worklog = service.getWorklog()
        print("GOT: \(worklog)")
        self.showNotification(worklog: worklog)
    }
    
    func showNotification(worklog: Worklog) {
        let notification = NSUserNotification()
        notification.title = "\(worklog.minutesLogged) minutes logged today"
        notification.subtitle = "On \(worklog.totalTickets) tickets"
        notification.informativeText = "You are on \(worklog.status) status"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
}
