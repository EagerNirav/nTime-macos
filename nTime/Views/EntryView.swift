//
//  EntryView.swift
//  nTime
//
//  Created by Nirav Shah on 14/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa

protocol EntryViewDelegate {
    func removeEntry(entry:EntryObject)
    func entryClicked(entry:EntryObject)
}

class EntryView: NSView {
    
    var entry:EntryObject? = nil
    var delegate:EntryViewDelegate?

    @IBOutlet weak var lblName: NSTextField!
    @IBOutlet weak var lblLocation: NSTextField!
    @IBOutlet weak var lblTime: NSTextField!
    @IBOutlet weak var lblDate: NSTextField!
    @IBOutlet weak var imgProfilePic: NSImageView!
    
    @IBOutlet weak var btnRemove: NSButton!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func loadEntryDetails(entry:EntryObject) {
        self.entry = entry
        lblName.stringValue = entry.Name
        lblLocation.stringValue = entry.Location
        lblTime.stringValue = entry.TimeZone
        lblDate.stringValue = entry.TimeZone
        imgProfilePic.image = entry.Image
    }
    @IBAction func btnRemove_Tapped(_ sender: Any) {
        self.delegate?.removeEntry(entry: self.entry!)
    }
    
    override func mouseDown(with event: NSEvent) {
        self.delegate?.entryClicked(entry: self.entry!)
    }
}
