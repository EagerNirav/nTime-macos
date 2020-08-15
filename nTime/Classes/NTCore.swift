//
//  ENCommon.swift
//  nTime
//
//  Created by Nirav Shah on 04/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Foundation
import Cocoa

typealias ObjectDictionary = Dictionary<String, Any>
typealias ArrayOfEntryObjects = Array<EntryObject>
typealias ArrayOfObjectDictionaries = Array<ObjectDictionary>

final class NTCore {
    
    static private var _shared: NTCore? = nil
    static var shared: NTCore {
        get {
            if let _ = _shared { return _shared! }
            _shared = NTCore.init()
            return _shared!
        }
    }
    
    init() {
        self.loadDataFromStorage()
    }
    
    
    static let defEntry: ObjectDictionary = [
        "entryid": UUID().uuidString,
        "name": "Unknown",
        "location": "",
        "timezone": "",
        "image": NSImage.init(named: "DefaultEntryImage")!.tiffRepresentation!,
    ]
    
    
    static let defAccount: ObjectDictionary = [
        "accountid": UUID().uuidString,
        "name": "Anonymous",
        "location": "",
        "timezone": "",
        "profileimage": NSImage.init(named: "DefaultProfileImage")!.tiffRepresentation!,
        "entries": ArrayOfObjectDictionaries.init()
    ]
    
    static let defPreferences: ObjectDictionary = [
        "keeptimezoneslistopen": false,
        "showlivetimeinmenubar": false,
        "livetimeentryid": 0,
        "datetimeformat": "E d MMM, yyyy hh:mm a",
    ]
    
    private let ud = UserDefaults.standard
    
    var account:ObjectDictionary = NTCore.defAccount
    
    var preferences:ObjectDictionary = NTCore.defPreferences
    
    func clearUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        ud.removePersistentDomain(forName: domain)
        ud.synchronize()
    }
    
    static func openGithubPage() {
        if let url = URL(string: Bundle.main.infoDictionary?["GithubUrl"] as! String) {
            NSWorkspace.shared.open(url)
        }
    }
    func saveDataToStorage() {
        self.savePreferencesToStorage()
        self.saveAccountToStorage()
    }
    
    func loadDataFromStorage() {
        self.loadPreferencesFromStorage()
        self.loadAccountFromStorage()
    }
    
    func resetData(presistent:Bool = false) {
        self.resetPreferences()
        self.resetAccount()
        if (presistent) {
            self.saveDataToStorage()
        }
    }
    
    func resetPreferences() {
        preferences = NTCore.defPreferences
    }
    
    func resetAccount() {
        account = NTCore.defAccount
    }
    
    func savePreferencesToStorage() {
        ud.setValue(preferences, forKey: "preferences")
    }
    func saveAccountToStorage() {
        ud.setValue(account, forKey: "account")
    }
    
    func loadPreferencesFromStorage() {
        if let _preferences = ud.value(forKey: "preferences") as? ObjectDictionary {
            preferences = _preferences
        }
        else {
            preferences = NTCore.defPreferences
        }
    }
    
    func loadAccountFromStorage() {
        if let _account = ud.value(forKey: "account") as? ObjectDictionary {
            account = _account
        }
        else {
            account = NTCore.defAccount
        }
    }
    
}
