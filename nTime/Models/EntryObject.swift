//
//  EntryObject.swift
//  nTime
//
//  Created by Nirav Shah on 06/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Foundation
import Cocoa

fileprivate struct EntryFields {
    static let EntryId:String = "entrtyid"
    static let Name:String = "name"
    static let Location:String = "location"
    static let TimeZone:String = "timezone"
    static let Image:String = "image"
    static let DSTOffset:String = "dstoffset"
    static let RawOffset:String = "rawoffset"
    static let TimeZoneId:String = "timezoneid"
}

struct EntryObject:Codable {
    fileprivate typealias EF = EntryFields
    
    var _entry:ObjectDictionary = ObjectDictionary.init()
    
    init(entry:ObjectDictionary) {
        _entry = entry
    }
    
    var OriginalObject:ObjectDictionary {
        get {
            return _entry
        }
        set {
            _entry = newValue
        }
    }
    
    var EntryId:String {
        get {
            return _entry[EF.EntryId] as! String
        }
        set {
            _entry[EF.EntryId] = newValue
        }
    }
    
    var Name:String {
        get {
            return _entry[EF.Name] as! String
        }
        set {
            _entry[EF.Name] = newValue
        }
    }
    
    var Location:String {
        get {
            return _entry[EF.Location] as! String
        }
        set {
            _entry[EF.Location] = newValue
        }
    }
    
    var TimeZone:String {
        get {
            return _entry[EF.TimeZone] as! String
        }
        set {
            _entry[EF.TimeZone] = newValue
        }
    }
    
    var DSTOffset:Int {
        get {
            return _entry[EF.DSTOffset] as! Int
        }
        set {
            _entry[EF.DSTOffset] = newValue
        }
    }
    
    var RawOffset:Int {
        get {
            return _entry[EF.RawOffset] as! Int
        }
        set {
            _entry[EF.RawOffset] = newValue
        }
    }
    
    var TimeZoneId:String {
        get {
            return _entry[EF.TimeZoneId] as! String
        }
        set {
            _entry[EF.TimeZoneId] = newValue
        }
    }
    
    
    var Image: NSImage {
        get {
            guard let imageData = _entry[EF.Image] as? Data else {
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
            _entry[EF.Image] = newValue.tiffRepresentation
        }
    }
    
    
    func encode(to encoder: Encoder) throws {
        print("encode")
    }
    
    init(from decoder: Decoder) throws {
        print("decode")
    }
    
}
