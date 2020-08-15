//
//  TimeZonesVC.swift
//  nTime
//
//  Created by Nirav Shah on 03/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa

class TimeZonesVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var srlTimeZones: NSScrollView!
    @IBOutlet weak var viwGetStarted: NSView!
    @IBOutlet weak var tblTimeZones: NSTableView!
    @IBOutlet weak var btnSystemTime: NSButton!
    
    @IBOutlet weak var btnSearch: NSButton!
    @IBOutlet weak var btnAddEntry: NSButton!
    
    @IBOutlet weak var lblSystemTimeLabel: NSTextField!
    
    var timSystemTime = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        srlTimeZones.isHidden = false
        viwGetStarted.isHidden = true
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
        print(UserAccount.Entries.count)
    }
    
    @objc func updateSystemTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Preferences.DateTimeFormat

        let timeString = "\(dateFormatter.string(from: Date()))"
        
        btnSystemTime.title = timeString
        
        self.updateEntriesTime()
    }
    
    @objc func updateEntriesTime() {
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "z"

        let timezone = "\(dateFormatter.string(from: Date()))"
               
        lblSystemTimeLabel.stringValue = "system time (" + timezone + ")"
        
        Timer.scheduledTimer(timeInterval: 1.0, target: TimeZonesVC.shared, selector: #selector(TimeZonesVC.shared.updateSystemTime), userInfo: nil, repeats: true)
        self.updateSystemTime()
        //tblTimeZones.reloadData()
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        timSystemTime.invalidate()
    }
    
    @IBAction func btnAdd_Tapped(_ sender: Any) {
    }
    
    @IBAction func btnSearch_Tapped(_ sender: Any) {
    }
    
    @IBAction func btnSystemTime_Tapped(_ sender: Any) {
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return UserAccount.Entries.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "entryView")
        guard let cellView = tblTimeZones.makeView(withIdentifier: cellIdentifier, owner: self) as? EntryView else { return nil }
        
        cellView.loadEntryDetails(entry: UserAccount.Entries.entryAt(index: row)!)
        return cellView
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
