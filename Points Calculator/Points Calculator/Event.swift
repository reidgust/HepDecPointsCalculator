//
//  Event.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-11.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation

enum Event : String{
    case hundy = "100m"
    case LJ = "Long Jump"
    case SP = "Shot Put"
    case HJ = "High Jump"
    case fourHundy = "400m"
    case hurdles = "110mH"
    case disc = "Discus"
    case PV = "Pole Vault"
    case Jav = "Javelin"
    case fifteen = "1500m"
    case hundyHurdles = "100mH"
    case twoHundy = "200m"
    case eightHundy = "800m"
    
    static func getHepDayOneEvents() -> [Event] {
        return [.hundyHurdles,.HJ,.SP,.twoHundy]
    }
    
    static func getHepDayTwoEvents() -> [Event] {
        return [.LJ,.Jav,.eightHundy]
    }
    
    static func getDecDayOneEvents() -> [Event] {
        return [.hundy,.LJ,.SP,.HJ,.fourHundy]
    }
    
    static func getDecDayTwoEvents() -> [Event] {
        return [.hurdles,.disc,.PV,.Jav,.fifteen]
    }
    
    func getShortName() -> String {
        switch self {
        case .hundyHurdles:
            return "100mH"
        case .HJ:
            return "HJ"
        case .SP:
            return "SP"
        case .twoHundy:
            return "200m"
        case .LJ:
            return "LJ"
        case .Jav:
            return "JT"
        case .eightHundy:
            return "800m"
        case .hundy:
            return "100m"
        case .fourHundy:
            return "400m"
        case .hurdles:
            return "110mH"
        case .disc:
            return "DT"
        case .PV:
            return "PV"
        case .fifteen:
            return "1500m"
        }
    }
}

