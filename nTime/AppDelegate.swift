//
//  AppDelegate.swift
//  nTime
//
//  Created by Nirav Shah on 03/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    

    /// Variable responsible for handling the menubar icon and actions
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    /// Variable  to handle the popover screen of timezones
    let popover = NSPopover()
    /// Variable to handle any window based view controller
    let window = NSWindow()
    /// Variable to handle the status bar / menubar icon context menu
    @IBOutlet weak var statusMenu: NSMenu!
    
    let googleAPIKey = Bundle.main.infoDictionary?["GoogleAPIKey"] as? String
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = NTCore.shared // Ensures NTCore is initialized and ready with data
        self.setupStatusItem()
        self.setupPopover()
    }
    
    fileprivate func setupPopover() {
        popover.behavior = .transient
        popover.contentViewController = TimeZonesVC.shared
    }
    
    /// Setup  function to configure the status item element
    fileprivate func setupStatusItem() {
        // Init status bar / menubar icon and configure actions
        guard let statusBtn = statusItem.button else {
            fatalError("Status item button not found")
        }
        
        statusBtn.image = NSImage.init(named: "MenuBarIcon")
        statusBtn.image!.isTemplate = true
        //statusBtn.title = "nTime" //TODO: Implement a icon for the application's menubar
        statusBtn.target = self
        statusBtn.action = #selector(statusButtonAction(_:))
        statusBtn.sendAction(on: [.leftMouseUp, .rightMouseUp]) // Capture left and right mouse click
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    /// Function to handle the status bar / menubar icon actions (left or right mouse click)
    /// - Parameter sender: The status item itself
    @objc func statusButtonAction(_ sender:NSStatusItem) {
        let evt = NSApp.currentEvent!
        if evt.type == NSEvent.EventType.rightMouseUp {
            // Right mouse button clicked
            self.showContextMenu()
        }
        else {
            // Left button or any other mouse button clicked
            self.openTimeZonesVC()
        }
    }
    
    /// Create / open the TimeZoneVC from the storyboard and display it on screen
    func openTimeZonesVC() {
        guard let button = statusItem.button else {
            fatalError("Status button not found")
        }
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
    }
    
    /// Show the context menu for the application
    func showContextMenu() {
        statusItem.menu = statusMenu
        statusItem.button?.performClick(nil)
        statusItem.menu = nil
    }
    
    @IBAction func showPreferences(_ sender: Any) {
        let win = PreferenceVC.shared
        win.showWindow(nil)
    }
    
    
    @IBAction func showAbout(_ sender: Any) {
        let win = AboutVC.shared
        win.showWindow(nil)
    }
    
    @IBAction func visitGithubRepo(_ sender: Any) {
        NTCore.openGithubPage()
    }
    
    @IBAction func importData(_ sender: Any) {
        guard let data = ENCFuncs.readDictFromPath(path: ENCFuncs.showOpenDialog(allowedFileTypes: ["ntime"], title: "Import Data", prompt: "Import Data")) else {
            _ = ENCFuncs.alert(title: "Invalid Data File",message: "Could not load data, please ensure it is the correct file")
            return
        }
        if let data = data as? NSDictionary {
            TimeZonesVC.shared.entries = NSArray.init(object: data)
            _ = ENCFuncs.alert(title: "Import Successful", message: "Data successfully imported")
        }
    }
    
    @IBAction func exportData(_ sender: Any) {
        let data: NSDictionary = [
            "date_created": "hello world"
        ]
        if ENCFuncs.writeDictToPath(dictionary: data, path: ENCFuncs.showSaveDialog(defFilename: "data.ntime", allowedFileTypes: ["ntime"], prompt: "Export Data")) {
            _ = ENCFuncs.alert(title: "Export Successful", message: "Data successfully exported")
        }
    }
    
}

