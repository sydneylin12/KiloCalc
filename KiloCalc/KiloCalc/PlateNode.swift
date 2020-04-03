//
//  PlateNode.swift
//  KiloCalc
//
//  Created by Sydney Lin on 3/31/20.
//  Copyright © 2020 BroGains Brothers. All rights reserved.
//

import Foundation
import UIKit

enum ActionType {
    case ADD
    case REMOVE
    case CLEAR
    case TOGGLE
    case ERROR
}

class PlateNode {
    var weight: Double
    var color: UIColor
    var textColor: UIColor
    
    // Use white as the default color
    init(weight: Double, color: UIColor) {
        self.weight = weight
        self.color = color
        self.textColor = UIColor.white
    }
    
    // Class for the weight objects in the list
    init(weight: Double, color: UIColor, textColor: UIColor) {
        self.weight = weight
        self.color = color
        self.textColor = textColor
    }
}
