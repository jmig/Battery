//
//  ViewController.swift
//  Battery
//
//  Created by Jerome Miglino on 6/18/15.
//  Copyright © 2015 jmig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var batteryLevelLabel: UILabel?
    @IBOutlet weak var batteryStateLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateBatteryLevel()
        updateBatteryState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Private

    func numberPercentFormatter() -> NSNumberFormatter {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var numberFormatter: NSNumberFormatter!
        }
        dispatch_once(&Static.onceToken) {
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.PercentStyle
            numberFormatter.maximumFractionDigits = 1
            Static.numberFormatter = numberFormatter;
        }
        return Static.numberFormatter;
    }

    func updateBatteryLevel() {
        let batteryLevel = UIDevice.currentDevice().batteryLevel
        let batteryLevelString = batteryLevel < 0.0 ? "Unknown" : numberPercentFormatter().stringFromNumber(NSNumber(float: batteryLevel))
        if let label = batteryLevelLabel {
            label.text = batteryLevelString
        }
    }

    func updateBatteryState() {
        let batteryStateString: String
        switch UIDevice.currentDevice().batteryState {
        case .Full:
            batteryStateString = "(Full)"
        case .Unplugged:
            batteryStateString = "(Unplugged)"
        case .Charging:
            batteryStateString = "(Charging)"
        case .Unknown:
            batteryStateString = ""
        }

        if let label = batteryStateLabel {
            label.text = batteryStateString
        }
    }
}
