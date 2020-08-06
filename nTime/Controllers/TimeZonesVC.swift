//
//  TimeZonesVC.swift
//  nTime
//
//  Created by Nirav Shah on 03/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa

class TimeZonesVC: NSViewController {
    
    var entries: NSArray = NSArray.init()
    
    @IBOutlet weak var srlTimeZones: NSScrollView!
    @IBOutlet weak var viwGetStarted: NSView!
    @IBOutlet weak var tblTimeZones: NSTableView!
    @IBOutlet weak var btnSystemTime: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        srlTimeZones.isHidden = true
        viwGetStarted.isHidden = false
        /*
        var entry = UserAccount.Entries.getEmptyEntry()
        entry.Name = "Test 1"
        entry.Location = "Mumbai"
        entry.TimeZone = "+5:30 GMT"
        entry.Image = NSImage.init(named: "DefaultProfileImage")!
        
        _ = UserAccount.Entries.addEntry(entry: entry)
        
        entry = UserAccount.Entries.getEmptyEntry()
        entry.Name = "Test 2"
        entry.Location = "New York"
        entry.TimeZone = "-12:00 GMT"
        
        _ = UserAccount.Entries.addEntry(entry: entry)
        */
        //print(UserAccount.Entries.getAllEntries())
    }
    
    @IBAction func btnAdd_Tapped(_ sender: Any) {
    }
    
    @IBAction func btnSearch_Tapped(_ sender: Any) {
    }
    
    @IBAction func btnSystemTime_Tapped(_ sender: Any) {
    }
}

extension TimeZonesVC {
    static private var _shared: TimeZonesVC? = nil
    static var shared: TimeZonesVC {
        get {
            if let _ = _shared {
                return _shared!
            }
            let story = NSStoryboard(name: "Main", bundle: nil)
            guard let vc = story.instantiateController(withIdentifier: "TimeZonesVC") as? TimeZonesVC else {
              fatalError("Time zone view controller not found in story board")
            }
            _shared = vc
            return vc
        }
    }
    
}
