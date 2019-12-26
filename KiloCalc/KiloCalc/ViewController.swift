//
//  ViewController.swift
//  KiloCalc
//
//  Created by Sydney Lin on 10/16/19.
//  Copyright © 2019 BroGains Brothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Label for the kilogram and pound text
    @IBOutlet weak var kgLabel: UILabel!
    @IBOutlet weak var lbLabel: UILabel!
    @IBOutlet weak var collarButton: UIButton!
    
    // Default weight does not need to be changed
    let defaultWeight: Double = 20.0
    
    // Collar weight constant
    let collarWeight: Double = 5.0
    
    // List of weights on the bar
    var weightList: [Double] = [20.0]
    
    // Indicates if the collars are on
    var hasCollar: Bool = false
    
    // There by default
    override func viewDidLoad() {
        // Initialize the calculator
        updateText()
        super.viewDidLoad()
    }
    
    // Override the status bar text color to white
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    // Button send event
    @IBAction func handleButtonPress(_ sender: UIButton) {
        // Format the double
        let addString = sender.titleLabel?.text
        //Need the exclamation to unwrap the nullable/optional double
        let addDouble = Double(addString!)
        // Append the button click to the total list
        weightList.append(addDouble!)
        // Debug
        print(weightList)
        updateText()
    }
    
    // Clear out the calculator - reset to 20 kg
    @IBAction func clearCalculator(_ sender: UIButton) {
        // Reset to just the bar
        weightList = [defaultWeight]
        // Reset the collar
        collarButton.setImage(UIImage(named: "Collar"), for: .normal)
        hasCollar = false
        // Update text after clearing
        updateText()
    }
    
    // Remove the last element of the list
    @IBAction func removeButton(_ sender: UIButton) {
        remove()
    }
    
    // Call function when collar is clicked
    @IBAction func onCollarClicked(_ sender: UIButton){
        // If not toggled
        if(!hasCollar){
            // Update to highlighted image
            sender.setImage(UIImage(named: "DarkCollar"), for: .normal)
            weightList.insert(collarWeight, at: 1)
        }
        // If toggled
        else{
            // Update image to normal again
            sender.setImage(UIImage(named: "Collar"), for: .normal)
            weightList.remove(at: 1) //Remove at index 1
        }
        hasCollar = !hasCollar
        updateText()
    }
    
    // Update the text of both labels
    func updateText(){
        let total = calculateList(list: weightList)
        let totalKg = String(format: "%.2f", total)
        let totalLb = String(format: "%.2f", total * 2.2)
        kgLabel.text = "\(totalKg) kg"
        lbLabel.text = "\(totalLb) lbs"
    }
    
    func remove() -> Void {
        //If there are no collars and only 1 plate
        if(weightList.count == 1 && !hasCollar){
            print("Cannot remove any plates.")
            return
        }
        else if(weightList.count == 2 && hasCollar){
            print("Use toggle to remove collars!")
            return
        }
        else{
            print("Removing last element.")
            weightList.removeLast()
            updateText()
        }
    }
    
    // Iterate through a list and sum it up into a double
    func calculateList(list: [Double]) -> Double {
        var total: Double = 0.0
        total += list[0] //Add the bar at index 0
        for i in 1 ..< list.count {
            // Every plate must be added twice
            //print(list[i])
            total += 2 * list[i]
        }
        return total
    }
    
}

