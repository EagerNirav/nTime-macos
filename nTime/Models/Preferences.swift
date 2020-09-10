//
//  Preferences.swift
//  nTime
//
//  Created by Nirav Shah on 06/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Foundation
import Cocoa

fileprivate struct PreferencesFields {
    static let KeepTimeZonesListOpen:String = "keeptimezoneslistopen"
    static let ShowLiveTimeInMenuBar:String = "showlivetimeinmenubar"
    static let LiveTimeEntryId:String = "livetimeentryid"
    static let DateTimeFormat:String = "datetimeformat"
}

struct Preferences {
    fileprivate typealias PF = PreferencesFields

    private init() { }
    static var KeepTimeZonesListOpen:Bool {
        get {
            return NTCore.shared.preferences[PF.KeepTimeZonesListOpen] as! Bool
        }
        set {
            NTCore.shared.preferences[PF.KeepTimeZonesListOpen] = newValue
            self.saveToStorage()
        }
    }
    
    static var ShowLiveTimeInMenuBar:Bool {
        get {
            return NTCore.shared.preferences[PF.ShowLiveTimeInMenuBar] as! Bool
        }
        set {
            NTCore.shared.preferences[PF.ShowLiveTimeInMenuBar] = newValue
            self.saveToStorage()
        }
    }
    
    static var LiveTimeEntryId:String {
        get {
            return NTCore.shared.preferences[PF.LiveTimeEntryId] as! String
        }
        set {
            NTCore.shared.preferences[PF.LiveTimeEntryId] = newValue
            self.saveToStorage()
        }
    }
    
    static var DateTimeFormat: String {
        get {
            return NTCore.shared.preferences[PF.DateTimeFormat] as! String
        }
        set {
            NTCore.shared.preferences[PF.DateTimeFormat] = newValue
            self.saveToStorage()
        }
    }
    
    static func saveToStorage() {
        NTCore.shared.savePreferencesToStorage()
    }
    
    static func loadFromStorage() {
        NTCore.shared.loadPreferencesFromStorage()
    }
    
    static func reset() {
        NTCore.shared.resetPreferences()
        self.saveToStorage()
    }
}
