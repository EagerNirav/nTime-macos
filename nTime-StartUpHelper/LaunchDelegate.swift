//
//  AppDelegate.swift
//  nTime-StartUpHelper
//
//  Created by Nirav Shah on 06/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa

@NSApplicationMain
class LaunchDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = runningApps.contains {
            $0.bundleIdentifier == Bundle.main.infoDictionary?["nTimeBundleId"] as! String
        }

        if !isRunning {
            var path = Bundle.main.bundlePath as NSString
            for _ in 1...4 {
                path = path.deletingLastPathComponent as NSString
            }
            NSWorkspace.shared.launchApplication(path as String)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

