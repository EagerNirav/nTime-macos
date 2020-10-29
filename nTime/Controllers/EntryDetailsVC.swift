//
//  EntryDetailsVC.swift
//  nTime
//
//  Created by Nirav Shah on 30/10/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import SwiftUI

class EntryDetailsVC: NSViewController {
    
    var entry:EntryObject = UserAccount.Entries.getEmptyEntry()

    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtLocation: NSTextField!
    @IBOutlet weak var coTimeZones: NSComboBox!
    @IBOutlet weak var imgUserProfile: NSImageView!
    @IBOutlet weak var btnRemoveProfileImage: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    public func loadEntryDetails(entry:EntryObject? = nil) {
        self.entry = UserAccount.Entries.getEmptyEntry()
        if let e = entry {
            self.entry = e
        }
        txtName.stringValue = self.entry.Name
        txtLocation.stringValue = self.entry.Location
        coTimeZones.stringValue = self.entry.TimeZone
        imgUserProfile.image = self.entry.Image
        
        btnRemoveProfileImage.isHidden = self.hasDefaultProfileImage()
        txtName.becomeFirstResponder()
    }
    
    @IBAction func imgUserProfile_Tapped(_ sender: Any) {
        if (self.hasDefaultProfileImage()) {
            self.changeProfilePicture()
        }
        else if (ENCFuncs.confirmation(title: "Change Picture", message: "Do you want to change the picture?", buttonTextArray: ["Yes","No"]) == .alertFirstButtonReturn) {
            self.changeProfilePicture()
        }
    }
    @IBAction func btnSave_Tapped(_ sender: Any) {
        self.saveEntry()
        self.view.window?.windowController?.close()
    }
    @IBAction func btnSaveAndNew_Tapped(_ sender: Any) {
        self.saveEntry()
        self.loadEntryDetails(entry: nil)
    }
    @IBAction func btnCancel_Tapped(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    func saveEntry() {
        self.entry.Name = txtName.stringValue
        self.entry.Location = txtLocation.stringValue
        self.entry.TimeZone = coTimeZones.stringValue
        
        _ = UserAccount.Entries.addEntry(entry: entry)
        UserAccount.saveToStorage()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.level = .floating
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        let app = NSApplication.shared.delegate as! AppDelegate
        app.openTimeZonesVC()
    }
    
    private func changeProfilePicture() {
        if let imageFilePath = ENCFuncs.showOpenDialog(allowedFileTypes: ["png","jpg","jpeg"], prompt: "Set as Image") {
            imgUserProfile.image = NSImage.init(contentsOf: imageFilePath)
            self.entry.Image = imgUserProfile.image!
        }
        btnRemoveProfileImage.isHidden = self.hasDefaultProfileImage()
    }
    
    private func hasDefaultProfileImage() -> Bool {
        if (imgUserProfile.image?.tiffRepresentation == NSImage.init(named: "DefaultEntryImage")?.tiffRepresentation) {
            return true
        }
        else {
            return false
        }
    }
}

extension EntryDetailsVC {
    static private var _shared: NSWindowController? = nil
    static public var entryController:EntryDetailsVC? = nil
    static var shared: NSWindowController {
        get {
            if let _ = _shared {
                return _shared!
            }
            let story = NSStoryboard(name: "Main", bundle: nil)
            guard let vc = story.instantiateController(withIdentifier: "EntryDetailsWindow") as? NSWindowController else {
              fatalError("Entry Detail window controller not found in story board")
            }
            _shared = vc
            entryController = vc.contentViewController as? EntryDetailsVC
            return vc
        }
    }
}
