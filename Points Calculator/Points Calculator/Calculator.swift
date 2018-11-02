//
//  Calculator.swift
//  Points Calculator
//
//  Created by Reid on 2018-11-01.
//  Copyright © 2018 Reid. All rights reserved.
//

import Foundation

enum Event : String {
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

    func getHepPoints(result: Double) -> Int {
        var pointsDouble : Double = 0
        switch self {
        case .hundyHurdles:
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
        default:
            fatalError("Events overlapping")
        }
        return checkPoints(pointsDouble)
    }

    func getHepPoints(result: String) -> Int {
        return getPoints(result: result, isDec: false)
    }

    func getDecPoints(result: Double) -> Int {
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
        default:
            fatalError("Events overlapping")
        }
        return checkPoints(pointsDouble)
    }

    func getDecPoints(result: String) -> Int {
        return getPoints(result: result, isDec: true)
    }

    func getPoints(result: String, isDec: Bool) -> Int {
        if result == "" { return -1 }
        // Check for result in minute format (ex. 4:20 for 4m20s)
        if result.contains(":") {
            var time = result.split(separator: ":")
            if time.count == 2 {
                if let minutes = Double(time[0]), let seconds = Double(time[1]) {
                    if isDec {
                        return getDecPoints(result: minutes * 60 + seconds)
                    } else {
                        return getHepPoints(result: minutes * 60 + seconds)
                    }
                }
            }
            return -1
        }
        // Check for time in second format (ex. 11.13 for 11s130ms
        if let result = Double(result) {
            if isDec {
                return getDecPoints(result: result)
            } else {
                return getHepPoints(result: result)
            }
        }
        return -1
    }

    private func checkPoints(_ points: Double) -> Int {
        if points.isNaN || points.isInfinite || points > Double(Constants.Points.MaxPoints) {
            return -1
        } else {
            return max(Int(points),0)
        }
    }
}

