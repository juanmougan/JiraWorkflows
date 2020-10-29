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

    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
//    var statusItem: NSStatusItem?
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        self.statusItem?.button?.title = "WorldTime"
//    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        // Make buttons clickable
//        self.popover.contentViewController?.view.window?.becomeKey()
                
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = self.statusBarItem.button {
             button.image = NSImage(named: "Icon")
             button.action = #selector(togglePopover(_:))
        }
        NSApp.activate(ignoringOtherApps: true)
    }
    
    // Create the status item
    @objc func togglePopover(_ sender: AnyObject?) {
         if let button = self.statusBarItem.button {
              if self.popover.isShown {
                   self.popover.performClose(sender)
              } else {
                   self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
              }
         }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

