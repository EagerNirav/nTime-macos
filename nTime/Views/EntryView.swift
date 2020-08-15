//
//  EntryView.swift
//  nTime
//
//  Created by Nirav Shah on 14/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa

class EntryView: NSView {

    @IBOutlet weak var lblName: NSTextField!
    @IBOutlet weak var lblLocation: NSTextField!
    @IBOutlet weak var lblTime: NSTextField!
    @IBOutlet weak var lblDate: NSTextField!
    @IBOutlet weak var imgProfilePic: NSImageView!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func loadEntryDetails(entry:EntryObject) {
        lblName.stringValue = entry.Name
        lblLocation.stringValue = entry.Location
        lblTime.stringValue = entry.TimeZone
        lblDate.stringValue = entry.TimeZone
        imgProfilePic.image = entry.Image
    }
}
