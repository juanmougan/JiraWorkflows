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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create the SwiftUI view that provides the contents
        let contentView = ContentView()
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.contentViewController = NSHostingController(rootView: contentView)
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        // Create the Status Bar Item with the above Popover
        statusBar = StatusBarController.init(popover)
        
        // Schedule an Activity to get JIRA's data
        //scheduleJiraRefreshData()
        setUpCron()
    }
    
    func setUpCron() {
        _ = try? CronJob(pattern: "* * 17 * * *") { () -> Void in
            self.runTask()
        }   // TODO catch cron failure?
    }
    
    func runTask() {
        // Run JAR
        let service = MockedService()
        // TODO handle stderr from service somehow
        let worklog = service.getCounter(tickets: Int.random(in: 3..<5), minutes: 390, status: "OK")
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
