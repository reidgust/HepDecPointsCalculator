//
//  EnterResultsForm.swift
//  Points Calculator
//
//  Created by Reid on 2018-11-01.
//  Copyright © 2018 Reid. All rights reserved.
//

import Foundation
import Eureka
import SnapKit

//protocol GenericRow {}

//class MyDecimalRow : DecimalRow, GenericRow {}

//class MyTextRow : TextRow, GenericRow {}

class EntryViewController: FormViewController {
    let isDec : Bool
    var dayOneScores : [Int]
    var dayTwoScores : [Int]
    var day1 : LabelRow?
    var day2 : LabelRow?
    var overall : LabelRow?
    
    init(isDec:Bool) {
        self.isDec = isDec
        if isDec {
            dayOneScores = Array(repeating: 0, count: 5)
            dayTwoScores = Array(repeating: 0, count: 5)
        } else {
            dayOneScores = Array(repeating: 0, count: 4)
            dayTwoScores = Array(repeating: 0, count: 3)
        }
        super.init(style: UITableView.Style.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLabels(dayIndex:Int) {
        let val = dayIndex == 0 ? self.dayOneScores.reduce(0,+) : self.dayTwoScores.reduce(0,+)
        if let label = (self.form.rowBy(tag: "Day\(dayIndex+1)") as? LabelRow) {
            label.value = "Day \(1+dayIndex) Total: \(val)"
            label.reload()
        }
        let total = self.dayOneScores.reduce(0,+) + self.dayTwoScores.reduce(0,+)
        if let label = (self.form.rowBy(tag: "Overall") as? LabelRow) {
            label.value = "Total: \(total)"
            label.reload()
        }
    }
    
    fileprivate func setupEvent(row:DecimalRow,event: Event, index:Int) {
        row.title = event.rawValue
        row.onChange({ (timeRow) in
            var points : Int = -1
            if let time = timeRow.value  {
                if self.isDec {
                    points = event.getDecPoints(result: time)
                } else {
                    points = event.getHepPoints(result: time)
                }
            }
            if index < self.dayOneScores.count {
                self.dayOneScores[index] = points > -1 ? points : 0
            } else {
                self.dayTwoScores[index % self.dayOneScores.count] = points > -1 ? points : 0
            }
            if points > -1 {
                timeRow.title = "\(event.rawValue)   (\(points))"
            } else {
                timeRow.title = "\(event.rawValue)"
            }
            self.updateLabels(dayIndex: index/self.dayOneScores.count)
        })
    }

    fileprivate func setupEvent(row:TextRow,event: Event, index: Int) {
        row.title = event.rawValue
        row.onChange({ (timeRow) in
            var points : Int = -1
            if let time = timeRow.value {
                if self.isDec {
                    points = event.getDecPoints(result: time)
                } else {
                    points = event.getHepPoints(result: time)
                }
            }
            if index < self.dayOneScores.count {
                self.dayOneScores[index] = points > -1 ? points : 0
            } else {
                self.dayTwoScores[index % self.dayOneScores.count] = points > -1 ? points : 0
            }
            if points > -1 {
                timeRow.title = "\(event.rawValue)  (\(points))"
            } else {
                timeRow.title = "\(event.rawValue)"
            }
            self.updateLabels(dayIndex: index/self.dayOneScores.count)
        })
    }
    
}

class DecathlonEntryViewController: EntryViewController {
    override func viewDidLoad() {
    super.viewDidLoad()
        form +++ Section("Day 1")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.hundy, index: 0)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.LJ, index: 1)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.SP, index: 2)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.HJ, index: 3)
        }
        <<< TextRow(){ row in
            setupEvent(row: row, event: Event.fourHundy, index: 4)
        }
        <<< LabelRow("Day1")
        +++ Section("Day 2")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.hurdles, index: 5)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.disc, index: 6)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.PV, index: 7)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.Jav, index: 8)
        }
        <<< TextRow(){ row in
            setupEvent(row: row, event: Event.fifteen, index: 9)
        }
        <<< LabelRow("Day2")
        <<< LabelRow("Overall")
    }
}

class HeptathlonEntryViewController: EntryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Day 1")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.hundyHurdles, index: 0)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.HJ, index: 1)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.SP, index: 2)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.twoHundy, index: 3)
        }
        <<< LabelRow("Day1")
        +++ Section("Day 2")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.LJ, index: 4)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: Event.Jav, index: 5)
        }
        <<< TextRow(){ row in
            setupEvent(row: row, event: Event.eightHundy, index: 6)
        }
        <<< LabelRow("Day2")
        <<< LabelRow("Overall")
    }
}

