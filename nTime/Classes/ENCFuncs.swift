//
//  ENCFuncs.swift
//  nTime
//
//  Created by Nirav Shah on 05/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa

final class ENCFuncs {
    private init() { }
    
    static func showSaveDialog(defFilename:String, allowedFileTypes:NSArray, placeholder:String = "Enter a file name", title:String = "Save File", prompt:String = "Save to a file") -> URL? {
        let savePanel = NSSavePanel()
        savePanel.title = title
        savePanel.prompt = prompt
        savePanel.nameFieldLabel = placeholder
        savePanel.nameFieldStringValue = defFilename
        savePanel.isExtensionHidden = false
        //savePanel.canSelectHiddenExtension = true
        savePanel.allowedFileTypes = allowedFileTypes as? [String]
        let res = savePanel.runModal()
        switch res {
        case .OK:
                return savePanel.url
            
        default:
                return nil
        }
    }
    
    static func showOpenDialog(allowedFileTypes:NSArray, title:String = "Open File", prompt:String = "Select a file to open") -> URL? {
        let openPanel = NSOpenPanel()
        openPanel.title = title
        openPanel.prompt = prompt
        openPanel.allowedFileTypes = allowedFileTypes as? [String]
        openPanel.isExtensionHidden = false
        let res = openPanel.runModal()
        switch res {
        case .OK:
                return openPanel.url
            
        default:
                return nil
        }
    }
    
    
    static func alert(title: String, message: String) -> NSApplication.ModalResponse {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        //alert.addButton(withTitle: "Cancel")
        let resp = alert.runModal()
        return resp
    }
    
    
    static func confirmation(title: String, message: String, buttonTextArray:[String] = ["Ok"]) -> NSApplication.ModalResponse {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .warning
        buttonTextArray.forEach { (title) in
            alert.addButton(withTitle: title)
        }
        let resp = alert.runModal()
        return resp
    }
    
    
    static func writeDictToPath(dictionary:NSDictionary, path:URL?) -> Bool {
        if let path = path {
            return dictionary.write(to: path, atomically: true)
        }
        else {
            return false
        }
    }
    
    static func readDictFromPath(path:URL?) -> Any? {
        if let path = path {
            return NSDictionary.init(contentsOf: path)
        }
        else{
            return false
        }
    }
    
    
}
