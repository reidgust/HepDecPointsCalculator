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

    func getEventsSec(_ title: String, decimalEvents: [Event], textEvents: [Event]) -> Section {
        let sec = Section(title)
        for i in 0..<decimalEvents.count {
            let decRow = DecimalRow(){ row in
                setupEvent(row: row, event: decimalEvents[i], index: i)
            }
            sec.append(decRow)
        }
        for i in 0..<textEvents.count {
            let textRow = TextRow(){ row in
                setupEvent(row: row, event: textEvents[i], index: i + decimalEvents.count)
            }
            sec.append(textRow)
        }
        return sec
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form
            //<<< SegmentedRow
            +++ getEventsSec("Day1Dec",decimalEvents: [Event.hundy, Event.LJ,Event.SP,Event.HJ], textEvents: [Event.fourHundy])
            +++ getEventsSec("Day1Hep",decimalEvents: [Event.hundyHurdles, Event.HJ,Event.SP,Event.twoHundy], textEvents: [])
            <<< LabelRow("Day 1")

            +++ getEventsSec("Day2Dec",decimalEvents: [Event.hurdles, Event.disc,Event.PV,Event.Jav], textEvents: [Event.fifteen])
            +++ getEventsSec("Day2Hep",decimalEvents: [Event.LJ, Event.Jav], textEvents: [Event.eightHundy])
            <<< LabelRow("Day2")
            <<< LabelRow("Overall")

        form.sectionBy(tag: "Day1Dec")?.hidden = true
        form.sectionBy(tag: "Day2Hep")?.hidden = true
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
    
    private func setupEvent(row:DecimalRow,event: Event, index:Int) {
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

    private func setupEvent(row:TextRow,event: Event, index: Int) {
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
