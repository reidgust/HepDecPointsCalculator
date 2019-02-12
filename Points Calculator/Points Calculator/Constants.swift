//
//  Constants.swift
//  Points Calculator
//
//  Created by Reid on 2018-11-02.
//  Copyright © 2018 Reid. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct colors {
        static let background = Constants.Photon.Ink
    }
    
    struct Segues {
        static let MainToAthlete = "MainToAth"
        static let MainToCalculator = "MainToCalc"
        static let MainToMeet = "MainToMeet"
        static let AthleteToNewAthlete = "AthToNewAth"
        static let AthleteToResult = "AthToResult"
        static let MeetToNewMeet = "MeetToNewMeet"
        static let MeetToResults = "MeetToResult"
        static let ResultToCalculator = "ResultToCalc"
        static let CalculatorToNewAth = "CalcToNewAth"
        static let CalculatorToNewMeet = "CalcToNewMeet"
    }
    
    struct Photon {
        static let Magenta = UIColor(rgb: 0xff1ad9)
        static let Purple = UIColor(rgb: 0xc069ff)
        static let Blue = UIColor(rgb: 0x45a1ff)
        static let Teal = UIColor(rgb: 0x00feff)
        static let Green = UIColor(rgb: 0x003706)
        static let Yellow = UIColor(rgb: 0x3e2800)
        static let Red = UIColor(rgb: 0x3e0200)
        static let Orange = UIColor(rgb: 0x3e1300)
        static let Grey = UIColor(rgb: 0x0c0c0d)
        static let Ink = UIColor(rgb: 0x0f1126)
        static let White = UIColor(rgb: 0xffffff)
    }
    
    struct fonts {
        static let copyButton = UIFont.systemFont(ofSize: 16)
    }
    
    struct Points {
        static let MaxPoints = 4000
    }

    struct layout {
        static let browserToolbarDisabledOpacity: CGFloat = 0.3
        static let headerHeight: CGFloat = 44
    }
}

extension UIColor {
    convenience init(rgb:Int){
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
