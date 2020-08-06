//
//  AccountFields.swift
//  nTime
//
//  Created by Nirav Shah on 05/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Foundation
import Cocoa

fileprivate struct AccountFields {
    static let Name:String = "name"
    static let Location:String = "location"
    static let TimeZone:String = "timezone"
    static let ProfileImage:String = "profileimage"
    static let Entries:String = "entries"
}

fileprivate struct EntryFields {
    static let Name:String = "name"
    static let Location:String = "location"
    static let TimeZone:String = "timezone"
    static let Image:String = "image"
}


struct UserAccount {
    fileprivate typealias AF = AccountFields

    private init() { }
    
    static var Name:String {
        get {
            return NTCore.shared.account[AF.Name] as! String
        }
        set {
            NTCore.shared.account[AF.Name] = newValue
            self.saveToStorage()
        }
    }
    
    static var Location:String {
        get {
            return NTCore.shared.account[AF.Location] as! String
        }
        set {
            NTCore.shared.account[AF.Location] = newValue
            self.saveToStorage()
        }
    }
    
    static var TimeZone:String {
        get {
            return NTCore.shared.account[AF.TimeZone] as! String
        }
        set {
            NTCore.shared.account[AF.TimeZone] = newValue
            self.saveToStorage()
        }
    }
    
    static var ProfileImage: NSImage {
        get {
            guard let imageData = NTCore.shared.account[AF.ProfileImage] as? Data else {
                return NSImage.init(named: "DefaultProfileImage")!
            }
            if imageData.count>0 {
                return NSImage.init(data: imageData)!
            }
            else {
                return NSImage.init(named: "DefaultProfileImage")!
            }
        }
        set {
            NTCore.shared.account[AF.ProfileImage] = newValue.tiffRepresentation
            self.saveToStorage()
        }
    }
    
    static func saveToStorage() {
        NTCore.shared.saveAccountToStorage()
    }
    
    static func loadFromStorage() {
        NTCore.shared.loadAccountFromStorage()
    }
    
    static func reset() {
        NTCore.shared.resetAccount()
        self.saveToStorage()
    }
    

    struct Entries {
        fileprivate typealias EF = EntryFields
        
        private init() { }
        
        fileprivate static var list = NTCore.shared.account[AF.Entries] as! ArrayOfObjectDictionaries
        
        static func entryAt(index: Int) -> ObjectDictionary? {
            if (list.count>index) {
                return list[index]
            }
            return nil
        }
        
        static func count() -> Int {
            return list.count
        }
        
        static func getEmptyEntry() -> ObjectDictionary {
            return NTCore.defEntry
        }
        
        static func addEntry(entry:ObjectDictionary) -> ArrayOfObjectDictionaries {
            list.append(entry)
            return self.getAllEntries()
        }
        
        static func removeEntryAt(index:Int) -> ObjectDictionary {
            let entry = list[index]
            list.remove(at: index)
            return entry
        }
        
        static func getAllEntries() -> ArrayOfObjectDictionaries {
            return list
        }
        
        static func saveToStorage() {
            UserAccount.saveToStorage()
        }
        
        static func loadFromStorage() {
            UserAccount.loadFromStorage()
        }
        
        static func reset() {
            NTCore.shared.account[AF.Entries] = ArrayOfObjectDictionaries.init()
            self.saveToStorage()
        }
        
    }

}
