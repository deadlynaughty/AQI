//
//  Utility.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 01/12/21.
//

import Foundation
import UIKit


enum AQICategory: Int {
    case good = 1
    case satifactory
    case moderate
    case poor
    case verypoor
    case severe
    
    var getColorFromAQI: UIColor {
        var color: UIColor
        switch self {
        case .good:
            color = UIColor.init(red: 85.0/255.0, green: 168.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        case .satifactory:
            color = UIColor.init(red: 163.0/255.0, green: 200.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        case .moderate:
            color = UIColor.init(red: 245.0/255.0, green: 248.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        case .poor:
            color = UIColor.init(red: 242.0/255.0, green: 156.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        case .verypoor:
            color = UIColor.init(red: 233.0/255.0, green: 63.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        case .severe:
            color = UIColor.init(red: 175.0/255.0, green: 45.0/255.0, blue: 36.0/255.0, alpha: 1.0)
        }
        return color
    }
}
