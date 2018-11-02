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

class EntryViewController: FormViewController {
    let isDec : Bool
    var scores : [Int]
    var day1 : LabelRow?
    var day2 : LabelRow?
    var overall : LabelRow?
    
    init(isDec:Bool) {
        self.isDec = isDec
        if isDec {
            scores = Array(repeating: 0, count: 10)
        } else {
            scores = Array(repeating: 0, count: 7)
        }
        super.init(style: UITableView.Style.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLabels(dayIndex:Int) {
        let start = dayIndex == 0 ? 0 : (isDec ? 5 : 4)
        let end = dayIndex == 0 ? (isDec ? 4 : 3) : (isDec ? 9 : 6)
        let val = self.scores[start...end].reduce(0,+)
        if let label = (self.form.rowBy(tag: "Day\(dayIndex+1)") as? LabelRow) {
            label.value = "Day \(1+dayIndex) Total: \(val)"
            label.reload()
        }
        let total = self.scores[0...end].reduce(0,+)
        if let label = (self.form.rowBy(tag: "Overall") as? LabelRow) {
            label.value = "Total: \(total)"
            label.reload()
        }
    }
    
    fileprivate func setupEvent(row:DecimalRow,event:DecEvent ,index:Int) {
        row.title = event.rawValue
        row.onChange({ (timeRow) in
            var points : Int = -1
            if let time = timeRow.value  {
                points = event.getPoints(result: time)
            }
            self.scores[index] = points > -1 ? points : 0
            if points > -1 {
                timeRow.title = "\(event.rawValue)   (\(points))"
            } else {
                timeRow.title = "\(event.rawValue)"
            }
            self.updateLabels(dayIndex: index/(self.isDec ? 5 : 4))
        })
    }

    fileprivate func setupEvent(row:TextRow,event:DecEvent,index:Int) {
        row.title = event.rawValue
        row.onChange({ (timeRow) in
            var points : Int = -1
            if let time = timeRow.value {
                points = event.getPoints(result: time)
            }
            self.scores[index] = points > -1 ? points : 0
            if points > -1 {
                timeRow.title = "\(event.rawValue)  (\(points))"
            } else {
                timeRow.title = "\(event.rawValue)"
            }
            self.updateLabels(dayIndex: index/(self.isDec ? 5 : 4))
        })
    }
}

class DecathlonEntryViewController: EntryViewController {
    override func viewDidLoad() {
    super.viewDidLoad()
        form +++ Section("Day 1")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.hundy, index: 0)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.LJ, index: 1)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.SP, index: 2)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.HJ, index: 3)
        }
        <<< TextRow(){ row in
            setupEvent(row: row, event: DecEvent.fourHundy, index: 4)
        }
        <<< LabelRow("Day1")
        +++ Section("Day 2")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.hurdles, index: 5)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.disc, index: 6)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.PV, index: 7)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: DecEvent.Jav, index: 8)
        }
        <<< TextRow(){ row in
            setupEvent(row: row, event: DecEvent.fifteen, index: 9)
        }
        <<< LabelRow("Day2")
        <<< LabelRow("Overall")
    }
}

/*class HeptathlonEntryViewController: EntryViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Day 1")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: HepEvent.hurdles, index: 0)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: HepEvent.HJ, index: 1)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: HepEvent.SP, index: 2)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: HepEvent.twoHundy, index: 3)
        }
        <<< LabelRow("Day1")
        +++ Section("Day 2")
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: HepEvent.LJ, index: 4)
        }
        <<< DecimalRow(){ row in
            setupEvent(row: row, event: HepEvent.Jav, index: 5)
        }
        <<< TextRow(){ row in
            setupEvent(row: row, event: HepEvent.eightHundy, index: 6)
        }
        <<< LabelRow("Day2")
        <<< LabelRow("Overall")
    }
}*/

