//
//  CellLabel.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-11.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
import UIKit

class CellLabel {
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines=0;
        label.clipsToBounds = true;
        label.adjustsFontSizeToFitWidth = true;
        label.textColor = .white
        return label
    }
}
