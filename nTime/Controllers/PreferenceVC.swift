//
//  PrefViewController.swift
//  nTime
//
//  Created by Nirav Shah on 03/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa
import ServiceManagement

class PreferenceVC: NSViewController, NSComboBoxDelegate, NSTextFieldDelegate {

    let helperBundleName = Bundle.main.infoDictionary?["nTime-StartUpHelperBundleID"] as! String

    
    @IBOutlet weak var imgUserProfile: NSImageView!
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtLocation: NSTextField!
    @IBOutlet weak var txtTimeZone: NSComboBox!
    @IBOutlet weak var btnRemoveProfileImage: NSButton!
    
    @IBOutlet weak var chkLaunchOnStartUp: NSButton!
    @IBOutlet weak var chkKeepTimeZonesListOpen: NSButton!
    @IBOutlet weak var chkShowLiveTimeInMenuBar: NSButton!
    @IBOutlet weak var coLiveTimeSelector: NSComboBox!
    @IBOutlet weak var coDateTimeFormat: NSComboBox!
    @IBOutlet weak var lblDTFormatExample: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coDateTimeFormat.delegate = self
        coLiveTimeSelector.delegate = self
        
        txtName.delegate = self
        txtLocation.delegate = self
        txtTimeZone.delegate = self
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        NSApp.activate(ignoringOtherApps: true)
        
        self.refreshUserAccount()
        self.refreshPreferences()
       
    }
    
    func refreshUserAccount() {

        txtName.stringValue = UserAccount.Name
        txtLocation.stringValue = UserAccount.Location
        txtTimeZone.stringValue = UserAccount.TimeZone
        imgUserProfile.image = UserAccount.ProfileImage
        
        btnRemoveProfileImage.isHidden = self.hasDefaultProfileImage()
    }
    
    func refreshPreferences() {

         let foundHelper = NSWorkspace.shared.runningApplications.contains {
            $0.bundleIdentifier == helperBundleName
        }
        
        chkLaunchOnStartUp.state = foundHelper ? .on : .off
        
        chkKeepTimeZonesListOpen.state = Preferences.KeepTimeZonesListOpen ? .on : .off
        chkShowLiveTimeInMenuBar.state = Preferences.ShowLiveTimeInMenuBar ? .on : .off
        coDateTimeFormat.stringValue = Preferences.DateTimeFormat
    }
    
    @IBAction func chkShowLiveTimeInMenuBar_Tapped(_ sender: NSButton) {
        let state = sender.state == .on
        coLiveTimeSelector.isEnabled = state
        Preferences.ShowLiveTimeInMenuBar = state
        // TODO: Save the live entry id to preferences
    }
    
    @IBAction func chkKeepTimeZonesListOpen_Tapped(_ sender: NSButton) {
        let state = sender.state == .on
        Preferences.KeepTimeZonesListOpen = state
    }
    
    @IBAction func chkLaunchOnStartUp_Tapped(_ sender: NSButton) {
        let isAuto = sender.state == .on
        SMLoginItemSetEnabled(helperBundleName as CFString, isAuto)
    }
    @IBAction func btnRemoveProfileImage_Tapped(_ sender: Any) {
        UserAccount.ProfileImage = NSImage.init(named: "DefaultProfileImage")!
    }
    @IBAction func btnDeleteAccountData_Tapped(_ sender: Any) {
        if (ENCFuncs.confirmation(title: "Delete Account", message: "Do you really want to delete your account and all it's entries?", buttonTextArray: ["Yes","No"]) == .alertFirstButtonReturn) {
            UserAccount.reset()
            self.refreshUserAccount()
            _ = ENCFuncs.alert(title: "Delete Account Completed", message: "Successfully deleted your account and it's entries")
        }
    }
    @IBAction func btnResetApplicationPreferences_Tapped(_ sender: Any) {
        if (ENCFuncs.confirmation(title: "Reset Preferences", message: "Do you really want to reset preferences?", buttonTextArray: ["Yes","No"]) == .alertFirstButtonReturn) {
            Preferences.reset()
            SMLoginItemSetEnabled(helperBundleName as CFString, false)
            self.refreshPreferences()
            _ = ENCFuncs.alert(title: "Reset Preferences Completed", message: "Preferences reset successfully completed")
        }
    }
    @IBAction func imgProfilePicture_Tapped(_ sender: Any) {
        if (self.hasDefaultProfileImage()) {
            self.changeProfilePicture()
        }
        else if (ENCFuncs.confirmation(title: "Change Profile Picture", message: "Do you want to change your profile picture?", buttonTextArray: ["Yes","No"]) == .alertFirstButtonReturn) {
            self.changeProfilePicture()
        }
    }
    
    private func changeProfilePicture() {
        if let imageFilePath = ENCFuncs.showOpenDialog(allowedFileTypes: ["png","jpg","jpeg"], prompt: "Set as Profile Image") {
            imgUserProfile.image = NSImage.init(contentsOf: imageFilePath)
            UserAccount.ProfileImage = imgUserProfile.image!
        }
    }
    
    private func hasDefaultProfileImage() -> Bool {
        if (imgUserProfile.image?.tiffRepresentation == NSImage.init(named: "DefaultProfileImage")?.tiffRepresentation) {
            return true
        }
        else {
            return false
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let co = (notification.object as! NSComboBox)
        switch co {
        case coDateTimeFormat:
            print("DateTime " + (co.objectValueOfSelectedItem! as! String))
            break
        case coLiveTimeSelector:
            print("Live Time " + (co.objectValueOfSelectedItem! as! String))
            break
        default:
            break
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let txt = obj.object as? NSTextField {
            switch txt {
                case txtName:
                    UserAccount.Name = txt.stringValue
                break
                case txtLocation:
                    UserAccount.Location = txt.stringValue
                break
                case txtTimeZone:
                    UserAccount.TimeZone = txt.stringValue
                break
            default:
                break
            }
        }
        if let co = obj.object as? NSComboBox {
            switch co {
            case coDateTimeFormat:
                Preferences.DateTimeFormat = co.stringValue
                break
            default:
                break
            }
        }
    }
    
    
    
}

extension PreferenceVC {
    static private var _shared: NSWindowController? = nil
    static var shared: NSWindowController {
        get {
            if let _ = _shared {
                return _shared!
            }
            let story = NSStoryboard(name: "Main", bundle: nil)
            guard let vc = story.instantiateController(withIdentifier: "PreferenceWindow") as? NSWindowController else {
              fatalError("Preference window controller not found in story board")
            }
            _shared = vc
            return vc
        }
    }
}
