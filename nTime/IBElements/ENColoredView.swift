//
//  ENColoredView.swift
//  nTime
//
//  Created by Nirav Shah on 04/08/20.
//  Copyright © 2020 Nirav Shah. All rights reserved.
//

import Cocoa
@IBDesignable class ENColoredView: NSView {
    @IBInspectable var backgroundColor: NSColor = .clear
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        backgroundColor.set()
        dirtyRect.fill()
    }
}
