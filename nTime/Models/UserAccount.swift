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
    static let AccountId:String = "accountid"
    static let Name:String = "name"
    static let Location:String = "location"
    static let TimeZone:String = "timezone"
    static let ProfileImage:String = "profileimage"
    static let Entries:String = "entries"
}


struct UserAccount {
    fileprivate typealias AF = AccountFields

    private init() { }
    
    static var AccountId:String {
        get {
            return NTCore.shared.account[AF.AccountId] as! String
        }
        set {
            NTCore.shared.account[AF.AccountId] = newValue
            self.saveToStorage()
        }
    }
    
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
        NTCore.shared.account[AF.Entries] = self.Entries.list
        NTCore.shared.saveAccountToStorage()
    }
    
    static func loadFromStorage() {
        NTCore.shared.loadAccountFromStorage()
        self.Entries.list = NTCore.shared.account[AF.Entries] as! ArrayOfObjectDictionaries
    }
    
    static func reset() {
        NTCore.shared.resetAccount()
        self.Entries.reset()
        self.saveToStorage()
    }
    

    struct Entries {
        
        private init() { }
        
        fileprivate static var list = NTCore.shared.account[AF.Entries] as! ArrayOfObjectDictionaries
        
        static func entryAt(index: Int) -> EntryObject? {
            if (list.count>index) {
                return EntryObject.init(entry: list[index])
            }
            return nil
        }
        
        static var count:Int {
            get {
                return list.count
            }
        }
        
        static func indexOf(entryId: String) -> Int {
            var cnt = 0
            for entry in list {
                let entryObj = EntryObject.init(entry: entry)
                if(entryObj.EntryId == entryId) {
                    return cnt
                }
                cnt += 1
            }
            return -1
        }
        
        static func getEntryBy(entryId:String) -> EntryObject? {
            for entry in list {
                let entryObj = EntryObject.init(entry: entry)
                if(entryObj.EntryId == entryId) {
                    return entryObj
                }
            }
            return nil
        }
        
        static func getEmptyEntry() -> EntryObject {
            var entry = EntryObject.init(entry: NTCore.defEntry)
            entry.EntryId = UUID().uuidString
            return entry
        }
        
        static func addEntry(entry:EntryObject) -> ArrayOfEntryObjects {
            if let _ = getEntryBy(entryId: entry.EntryId) {
                let i = self.removeEntryBy(entryId: entry.EntryId)
                list.insert(entry.OriginalObject, at: i)
            }
            else {
                list.append(entry.OriginalObject)
            }
            return self.getAllEntries()
        }
        
        static func removeEntryAt(index:Int) -> EntryObject {
            let entry = list[index]
            list.remove(at: index)
            return EntryObject.init(entry: entry)
        }
        
        static func removeEntryBy(entryId:String) -> Int {
            let i = indexOf(entryId: entryId)
            _ = removeEntryAt(index: i)
            return i
        }
        
        static func getAllEntries() -> ArrayOfEntryObjects {
            var EntryObjectList = ArrayOfEntryObjects.init()
            list.forEach { (entry) in
                EntryObjectList.append(EntryObject.init(entry: entry))
            }
            return EntryObjectList
        }
        
        static func reset() {
            self.list = ArrayOfObjectDictionaries.init()
        }
        
        static func getOriginalList() -> ArrayOfObjectDictionaries {
            return list
        }
        
    }

}
