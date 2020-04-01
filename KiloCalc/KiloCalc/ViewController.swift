//
//  ViewController.swift
//  KiloCalc
//
//  Created by Sydney Lin on 10/16/19.
//  Copyright © 2019 BroGains Brothers. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //Label for the kilogram and pound text
    @IBOutlet weak var lbs: UILabel!
    @IBOutlet weak var kgs: UILabel!
    @IBOutlet weak var collarButton: UIButton!
    @IBOutlet weak var visual: UIView!
    
    // Default weight does not need to be changed
    let defaultWeight: Double = 20.0
    
    // Collar weight constant
    let collarWeight: Double = 2.5
    
    // List of weights on the bar
    var weightList: [Double] = [20.0]
    var plateList: [PlateNode] = []
    
    let maxPlates: Int = 10
    
    // Indicates if the collars are on
    var hasCollar: Bool = false
    
    // Initialize the calculator
    override func viewDidLoad() {
        super.viewDidLoad()
        lbs.font = UIFont.monospacedDigitSystemFont(ofSize: 36, weight: UIFont.Weight.regular)
        kgs.font = UIFont.monospacedDigitSystemFont(ofSize: 36, weight: UIFont.Weight.regular)
        updateText()
        generatePlateVisual()
    }
    
    // Override the status bar text color to white
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    // Button send event
    @IBAction func handleButtonPress(_ sender: UIButton) {
        
        if plateList.count >= 10 {
            print("Cannot add any more plates!")
            return
        }
        
        let addString: String = (sender.titleLabel?.text)!
        let addDouble: Double = Double(addString)!
        switch addDouble {
        case 25.0:
            plateList.append(PlateNode(weight: 25.0, color: UIColor.red))
        case 20.0:
            plateList.append(PlateNode(weight: 20.0, color: UIColor.blue))
        case 15.0:
            plateList.append(PlateNode(weight: 15.0, color: UIColor.systemYellow))
        case 10.0:
            plateList.append(PlateNode(weight: 10.0, color: UIColor.green))
        case 5.0:
            plateList.append(PlateNode(weight: 5.0, color: UIColor.white, textColor: UIColor.black))
        case 2.5:
            plateList.append(PlateNode(weight: 2.5, color: UIColor.black))
        case 1.25:
            plateList.append(PlateNode(weight: 1.25, color: UIColor.systemGray))
        case 0.5:
            plateList.append(PlateNode(weight: 0.5, color: UIColor.systemGray2))
        case 0.25:
            plateList.append(PlateNode(weight: 0.25, color: UIColor.systemGray3))
        default:
            print("Error creating plate node!")
        }
        updateText()
        generatePlateVisual()
    }
    
    // Clear out the calculator - reset to 20 kg
    @IBAction func clearCalculator(_ sender: UIButton) {
        // Reset to just the bar
        plateList = []
        hasCollar = false
        updateText()
        
        // Clear out the super view
        for sub in visual.subviews {
            sub.removeFromSuperview()
        }
    }
    
    // Remove the last element of the list
    @IBAction func removeButton(_ sender: UIButton) {
        //If there are no collars and only 1 plate
        if plateList.count == 0 {
            print("Cannot remove any more plates.")
            return
        }
        print("Removing last element.")
        plateList.removeLast()
        updateText()
    }
    
    // Call function when collar is clicked
    @IBAction func onCollarClicked(_ sender: UIButton){
        if !hasCollar {
            weightList.insert(collarWeight, at: 1)
        }
        else {
            weightList.remove(at: 1) //Remove at index 1
        }
        hasCollar = !hasCollar
        updateText()
    }
    
    // Create the plates indicator
    func generatePlateVisual() {
        if plateList.count <= 0 {
            return // prevent errors
        }
        
        // Sort in descending order
        plateList.sort(by: { $0.weight > $1.weight })
        
        let plateWidth = visual.layer.frame.width / 10
        let plateHeight = visual.layer.frame.height
        var xCenter = plateWidth / 2
        let yCenter = plateHeight / 2
        
        for plate in plateList {
            let frame: CGRect = CGRect(x: 0, y: 0, width: plateWidth, height: plateHeight)
            let tile: UILabel = UILabel(frame: frame)
            
            // Style label
            tile.layer.backgroundColor = plate.color.cgColor
            //tile.layer.borderColor = UIColor.black.cgColor
            tile.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
            tile.layer.cornerRadius = 5.0
            tile.layer.masksToBounds = true
            tile.layer.borderWidth = 2.0
            
            // Create text for label
            tile.text = String(plate.weight)
            tile.textColor = plate.textColor
            tile.textAlignment = .center

            // Add via center
            tile.center = CGPoint(x: xCenter, y: yCenter)
            visual.addSubview(tile)
            xCenter += plateWidth
        }
    }
    
    // Update the text of both labels
    func updateText() {
        let total = calculateList(list: weightList)
        let totalKg = String(format: "%.2f", total)
        let totalLbs = String(format: "%.2f", total * 2.2)
        kgs.text = "\(totalKg) kg"
        lbs.text = "\(totalLbs) lbs"
    }
    
    // Iterate through a list and sum it up into a double
    func calculateList(list: [Double]) -> Double {
        var total: Double = 0.0
        total += list[0] //Add the bar at index 0
        for plate in plateList {
            total += 2 * plate.weight
        }
        return total
    }
    
}

