//
//  ResultCell.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-11.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
import UIKit

class EventResultView : UIView {
    var event = CellLabel.makeLabel()
    var measure = CellLabel.makeLabel()
    var points = CellLabel.makeLabel()
    
    init(event : String, measure : Double, points : Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.event.text = event
        placeLabel(self.event, top: nil)
        self.measure.text = String(format: "%02d", measure)
        placeLabel(self.measure, top: self.event)
        self.points.text = String(points)
        placeLabel(self.points, top: self.measure)
    }
    
    func placeLabel(_ label : UILabel, top : UILabel?) {
        self.addSubview(label)
        label.textAlignment = .center
        label.snp.makeConstraints{ make in
            if let top = top {
                make.top.equalTo(top.snp.bottom)
                make.left.right.equalToSuperview()
            } else {
                make.top.left.right.equalToSuperview()
            }
            make.height.equalTo(self.bounds.height/3)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ResultCell : UITableViewCell {
    
}

class HepResultView : UIView {
    
    
}

class DecResultView : UIView {
    
}
