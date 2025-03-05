////
//  FestFontAndBaseLine
//  TestView
//
//  Created by LegoEsprit on 01.03.25.
//  Copyright (c) 2025 LegoEsprit
//

import AppKit

typealias Attributes = [NSAttributedString.Key: Any]

extension NSBitmapImageRep {
    func setColorNew(_ color: NSColor, atX x: Int, y: Int) {
        guard let data = bitmapData else { return }
        
        let ptr = data + bytesPerRow * y + samplesPerPixel * x
        
        ptr[0] = UInt8(color.redComponent * 255.1)
        ptr[1] = UInt8(color.greenComponent * 255.1)
        ptr[2] = UInt8(color.blueComponent * 255.1)
        
        if samplesPerPixel > 3 {
            ptr[3] = UInt8(color.alphaComponent * 255.1)
        }
    }
}

class TestView: NSView {
    
    /// Delivers the current context even for older systems
    private var currentContext: CGContext? {
        get {
            if #available(OSX 10.10, *) {
                return NSGraphicsContext.current?.cgContext
            } else if let contextPointer = NSGraphicsContext.current?.graphicsPort {
                return Unmanaged.fromOpaque(contextPointer).takeUnretainedValue()
            }
            return nil
        }
    }

    
    override func draw(_ dirtyRect: NSRect) {
        guard let context = currentContext else {
            return
        }
        context.setFillColor(NSColor.red.cgColor)
        //context.fill(CGRect(x: 0, y: 0, width: bounds.width/2, height: bounds.height/2))
        //context.fill(CGRect(x: bounds.width/2, y: bounds.height/2, width: bounds.width/2, height: bounds.height/2))

        let attributes: Attributes = [
            .font: NSFont.systemFont(ofSize: 10.0)
            , .foregroundColor: NSColor.black
        ]

        let text = "O"
        let string = NSAttributedString(
            string: text
            , attributes: attributes
        )
        let ctLine = CTLineCreateWithAttributedString(string)
        context.textPosition = NSPoint(x: 0, y: 3)
        CTLineDraw(ctLine, context)
    }
    
    /*
    func checkBounds() -> (lower: Int, upper: Int) {
        var l = 0
        var u = -1
        
        if let bdir = self.bitmapImageRepForCachingDisplay(in: bounds) {
            cacheDisplay(in: bounds, to: bdir)
            outerLoop: for y in 0..<2*Int(bounds.height) {
                innerLoop: for x in 0..<2*Int(bounds.width) {
                    if let c = bdir.colorAt(x: x, y: y) {
                        if c.alphaComponent > 0.5 {
                            u = y
                            break outerLoop
                        }
                    }
                }
            }
            for y in stride(from: 2*Int(bounds.height)-1, to: u+1, by: -1) {
                for x in 0..<2*Int(bounds.width) {
                    var empty = true
                    if let c = bdir.colorAt(x: x, y: y) {
                        empty = empty && c.alphaComponent < 0.5
                        if !empty {
                            l = y
                            return (l, u)
                        }
                    }
                }
            }

        }
        return (l, u)
    }
     */
    
    func imageRepresentation() -> NSImage {
        let mySize = bounds.size
        
        if let bdir = self.bitmapImageRepForCachingDisplay(in: bounds) {
            
            cacheDisplay(in: bounds, to: bdir)
            print("""
                bitmapFormat:  \(bdir.bitmapFormat)
                bitsPerPixel:  \(bdir.bitsPerPixel)
                bytesPerPlane: \(bdir.bytesPerPlane)
                bytesPerRow:   \(bdir.bytesPerRow)
                isPlanar:      \(bdir.isPlanar)
                numberOfPlanes: \(bdir.numberOfPlanes)
                samplesPerPixel: \(bdir.samplesPerPixel)
                """
            )
            for y in 0..<bdir.pixelsHigh {
                var line = ""
                for x in 0..<bdir.pixelsWide {
                    if let c = bdir.colorAt(x: x, y: y) {
                        if c.alphaComponent > 0.5 {
                            line += "*"
                        }
                        else {
                            line += "-"
                        }
                    }
                }
                print(line)
            }
            
            if let ptr = bdir.bitmapData {
                let samplesPerPixel = bdir.samplesPerPixel
                let width = bdir.pixelsWide
                let height = bdir.pixelsHigh
                let rowBytes = bdir.bytesPerRow
                for row in 0..<height {
                    let rowStart = ptr + (row * rowBytes)
                    var nextChannel = rowStart
                    var line = ""
                    for _ in 0..<width {
                        let (r,g,b,a) = (nextChannel[0], nextChannel[1], nextChannel[2], nextChannel[3])
                        nextChannel += samplesPerPixel
                        //line += String(format: "%02X%02X%02X%02X", r, g, b, a)
                        line += String(format: "%02X", a)
                    }
                    print(line)
                }
            }

            
            let image = NSImage(size: mySize)
            image.addRepresentation(bdir)
            return image
        }
        else {
            return NSImage(size: .zero)
        }
    }

    
}
