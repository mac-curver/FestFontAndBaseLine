////
//  FestFontAndBaseLine
//  ViewController
//
//  Created by LegoEsprit on 27.02.25.
//  Copyright (c) 2025 LegoEsprit
//

import AppKit


class ViewController: NSViewController {
    
    @IBOutlet weak var customView: LetterView!
    @IBOutlet weak var fontComboBox: NSComboBox!
    @IBOutlet weak var fontStepper: NSStepper!
    
    @IBOutlet weak var aField: NSTextField!
    @IBOutlet weak var bField: NSTextField!
    @IBOutlet weak var cField: NSTextField!
    @IBOutlet weak var dField: NSTextField!
    
    @IBOutlet weak var testView: TestView!
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var resultLabel: NSTextField!
    
    var stepperDictionary: [Int: NSControl] = [:]
    
    override func viewDidLoad() {
        aField.doubleValue = 200.0
        fontComboBox.removeAllItems()
        let availableFamilies = NSFontManager.shared.availableFontFamilies
        let fontFamilies = availableFamilies.filter{$0.prefix(3) != "Uc_"}
        fontComboBox.addItems(withObjectValues: fontFamilies)
        fontComboBox.selectItem(withObjectValue: customView.currentFontFamily)
        
        let withoutStepper = view.subviews.filter { !($0.self is NSStepper) }
        for subview in withoutStepper {
            if subview.tag != 0 {
                stepperDictionary[subview.tag] = subview as? NSControl
            }
        }
        //let image = testView.imageRepresentation()
        //imageView.image = image
        customView.viewController = self
    }
    
    @IBAction func nextFont(_ sender: NSStepper) {
        let fontIndex = (fontComboBox.indexOfSelectedItem + sender.integerValue
                         + fontComboBox.numberOfItems) % fontComboBox.numberOfItems
        fontComboBox.selectItem(at: fontIndex)
        fontChanged(fontComboBox)
        customView.printTextLine()
   }
    
    @IBAction func fontChanged(_ sender: NSComboBox) {
        customView.currentFontFamily = sender.stringValue
        customView.needsDisplay = true
    }
    
    
    @IBAction func stepperChange(_ sender: NSStepper) {
        if let control = stepperDictionary[sender.tag] as? NSTextField {
            control.doubleValue += sender.doubleValue
            perform(control.action, with: control)
        }
        sender.doubleValue = 0
    }

    
    @IBAction func aChanged(_ sender: NSTextField) {
    }
    
    @IBAction func bChanged(_ sender: NSTextField) {
        //customView.baseline = sender.doubleValue
    }
    
    @IBAction func cChanged(_ sender: NSTextField) {
    }
    
    @IBAction func dChanged(_ sender: NSTextField) {
    }
    
    func setA(value: Double) {
        aField.doubleValue = value
    }
    func setB(value: Double) {
        bField.doubleValue = value
    }
    func setC(value: Double) {
        cField.doubleValue = value
    }

    func setD(value: Double) {
        dField.doubleValue = value
    }
    
    @IBAction func printTextLine(_ sender: NSButton) {
        customView.printTextLine()
    }
}
