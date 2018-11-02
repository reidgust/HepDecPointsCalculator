//
//  Calculator.swift
//  Points Calculator
//
//  Created by Reid on 2018-11-01.
//  Copyright © 2018 Reid. All rights reserved.
//

import Foundation

enum HepEvent : String {
    case hurdles = "100mH"
    case HJ = "High Jump"
    case SP = "Shot Put"
    case twoHundy = "200m"
    case LJ = "Long Jump"
    case Jav = "Javelin"
    case eightHundy = "800m"

    func getPoints(result: Double) -> Int {
        var pointsDouble : Double = 0
        switch self {
        case .hurdles:
            pointsDouble = 9.23076 * pow((26.7 - result),1.835)
        case .HJ:
            pointsDouble = 1.84523 * pow((result*100 - 75),1.348)
        case .SP:
            pointsDouble = 56.0211 * pow((result - 1.5),1.05)
        case .twoHundy:
            pointsDouble = 4.99087 * pow((42.5 - result),1.81)
        case .LJ:
            pointsDouble = 0.188807 * pow((result*100 - 210),1.41)
        case .Jav:
            pointsDouble = 15.9803 * pow((result - 3.8),1.04)
        case .eightHundy:
            pointsDouble = 0.11193 * pow((254 - result),1.88)
        }
        if pointsDouble.isNaN || pointsDouble.isInfinite {
            return -1
        } else {
            return min(max(Int(pointsDouble),0),10000)
        }
    }
    func getPoints (result: String) -> Int {
        if result == "" { return -1 }
        if result.contains(":") {
            var time = result.split(separator: ":")
            if time.count > 1 {
                if let minutes = Double(time[0]), let seconds = Double(time[1]) {
                    return getPoints(result: minutes * 60 + seconds)
                } else {
                    return -1
                }
            } else {
                return -1
            }
        } else if let result = Double(result) {
            return getPoints(result: result)
        } else {
            return -1
        }
    }
}


enum DecEvent : String {
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
    
    func getPoints(result: Double) -> Int {
        var pointsDouble : Double = 0
        switch self {
        case .hundy:
            pointsDouble = 25.4347 * pow((18 - result),1.81)
        case .LJ:
            pointsDouble = 0.14354 * pow((result*100 - 220),1.4)
        case .SP:
            pointsDouble = 51.39 * pow((result - 1.50),1.05)
        case .HJ:
            pointsDouble = 0.8465 * pow((result*100 - 75),1.42)
        case .fourHundy:
            pointsDouble = 1.53775 * pow((82 - result),1.81)
        case .hurdles:
            pointsDouble = 5.74352 * pow((28.5 - result),1.92)
        case .disc:
            pointsDouble = 12.91 * pow((result - 4),1.1)
        case .PV:
            pointsDouble = 0.2797 * pow((result*100 - 100),1.35)
        case .Jav:
            pointsDouble = 10.14 * pow((result - 7),1.08)
        case .fifteen:
            pointsDouble = 0.03768 * pow((480 - result),1.85)
        }
        if pointsDouble.isNaN || pointsDouble.isInfinite {
            return -1
        } else {
            return min(max(Int(pointsDouble),0),10000)
        }
    }
    
    func getPoints(result: String) -> Int {
        if result == "" { return -1 }
        if result.contains(":") {
            var time = result.split(separator: ":")
            if time.count > 1 {
                if let minutes = Double(time[0]), let seconds = Double(time[1]) {
                    return getPoints(result: minutes * 60 + seconds)
                } else {
                    return -1
                }
            } else {
                return -1
            }
        } else if let result = Double(result) {
            return getPoints(result: result)
        } else {
            return -1
        }
    }
}

