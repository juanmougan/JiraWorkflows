//
//  AppDelegate.swift
//  JiraWorkflows
//
//  Created by Juan Mougan on 28/10/2020.
//

import Cocoa
import SwiftUI

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
        scheduleJiraRefreshData()
    }
    
    // TODO maybe stop this with activity.invalidate() on applicationWillTerminate() ?
    func scheduleJiraRefreshData() {
        let activity = NSBackgroundActivityScheduler(identifier: "com.github.juanmougan.JiraWorkflows.refreshJira")
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        let day:TimeInterval = 24 * hour
        activity.interval = TimeInterval(day)
        activity.repeats = true
        activity.schedule() { (completion: NSBackgroundActivityScheduler.CompletionHandler) in
            // Run JAR
            let service = MockedService()
            let worklog = service.getCounter(tickets: Int.random(in: 3..<5), minutes: 390, status: "OK")
            print("GOT: \(worklog)")
            self.showNotification(worklog: worklog)
            completion(NSBackgroundActivityScheduler.Result.finished)
        }
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
