//
//  ViewController.swift
//  KiloCalc
//
//  Created by Sydney Lin on 10/16/19.
//  Copyright © 2019 BroGains Brothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Label for the text
    @IBOutlet weak var resultLabel: UILabel!
    // Private variables/fields equivalent
    var defaultWeight: Double = 20
    var weightOnBar: Double = 20
    var canClear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Override the status bar text color to white
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    // Button send event
    @IBAction func handleButtonPress(_ sender: UIButton) {
        // Clears the calculator
        if canClear {
            resultLabel.text = String(weightOnBar)
            weightOnBar = 20
            canClear = false
        }
        print(sender.titleLabel?.text)
        // Format the double
        var addString = sender.titleLabel?.text
        //Need the exclamation mark for some reason
        var addDouble = Double(addString!)
        weightOnBar = calculate(weightOnBar, addDouble!)
        resultLabel.text = String(weightOnBar)
    }
    
    // Clear out the calculator - reset to 20 kg
    @IBAction func clearCalculator(_ sender: UIButton) {
        weightOnBar = 20
        resultLabel.text = String(weightOnBar)
    }
    
    func calculate(_ a: Double, _ b: Double) -> Double {
        return a + b
    }
    
}

