//
//  AboutVC.swift
//  nTime
//
//  Created by Nirav Shah on 05/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa

class AboutVC: NSViewController {

    @IBOutlet weak var lblAppNameWithVersion: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func btnVisitGithubPage_Tapped(_ sender: Any) {
        NTCore.openGithubPage()
    }
    @IBAction func btnClose_Tapped(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.level = .floating
    }
}

extension AboutVC {
    static private var _shared: NSWindowController? = nil
    static var shared: NSWindowController {
        get {
            if let _ = _shared {
                return _shared!
            }
            let story = NSStoryboard(name: "Main", bundle: nil)
            guard let vc = story.instantiateController(withIdentifier: "AboutWindow") as? NSWindowController else {
              fatalError("About window controller not found in story board")
            }
            _shared = vc
            return vc
        }
    }
}
