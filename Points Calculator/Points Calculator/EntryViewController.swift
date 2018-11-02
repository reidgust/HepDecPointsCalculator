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
    var isDec : Bool
    var dayOneScoresDec : [Int] = Array(repeating: 0, count: 5)
    var dayTwoScoresDec : [Int] = Array(repeating: 0, count: 5)
    var dayOneScoresHep : [Int] = Array(repeating: 0, count: 4)
    var dayTwoScoresHep : [Int] = Array(repeating: 0, count: 3)
    var day1 : LabelRow?
    var day2 : LabelRow?
    var overall : LabelRow?
    
    init(isDec:Bool) {
        self.isDec = isDec
        super.init(style: UITableView.Style.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        form
            +++ Section()
            <<< SegmentedRow<String>("Hep Or Dec") { row in
                row.options = ["Heptathlon", "Decathlon"]
                row.value = self.isDec ? "Decathlon" : "Heptathlon"
                }.onChange{ (row) in
                    self.isDec = row.options?[0] == row.value ? false : true
                    self.updateVisibleSections()
                    self.updateLabels()
                }
            +++ makeEventsSec("Day 1", tag:"Day 1 Dec",decimalEvents: [Event.hundy, Event.LJ,Event.SP,Event.HJ], textEvents: [Event.fourHundy])
            +++ makeEventsSec("Day 1", tag:"Day 1 Hep", decimalEvents: [Event.hundyHurdles, Event.HJ,Event.SP,Event.twoHundy], textEvents: [])
            +++ Section()
            <<< LabelRow("Day 1")

            +++ makeEventsSec("Day 2", tag: "Day 2 Dec", decimalEvents: [Event.hurdles, Event.disc,Event.PV,Event.Jav], textEvents: [Event.fifteen])
            +++ makeEventsSec("Day 2", tag: "Day 2 Hep",decimalEvents: [Event.LJ, Event.Jav], textEvents: [Event.eightHundy])
            +++ Section()
            <<< LabelRow("Day 2")
            <<< LabelRow("Overall")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVisibleSections()
        updateLabels()
        
    }

    func makeEventsSec(_ title: String, tag: String, decimalEvents: [Event], textEvents: [Event]) -> Section {
        let sec = Section(title)
        sec.tag = tag
        for i in 0..<decimalEvents.count {
            let decRow = DecimalRow(){ row in
                let index = tag.contains("1") ? i : i + (tag.contains("Dec") ?  dayOneScoresDec.count : dayOneScoresHep.count)
                setupEvent(row:row, event:decimalEvents[i], index:index)
            }
            sec.append(decRow)
        }
        for i in 0..<textEvents.count {
            let textRow = TextRow(){ row in
                var index = i + decimalEvents.count
                index = tag.contains("1") ? index : index + (tag.contains("Dec") ?  dayOneScoresDec.count : dayOneScoresHep.count)
                setupEvent(row:row, event:textEvents[i], index:index)
            }
            sec.append(textRow)
        }
        return sec
    }

    private func updateVisibleSections() {
        if isDec {
            form.sectionBy(tag: "Day 1 Hep")?.hidden = true
            form.sectionBy(tag: "Day 1 Hep")?.evaluateHidden()
            form.sectionBy(tag: "Day 2 Hep")?.hidden = true
            form.sectionBy(tag: "Day 2 Hep")?.evaluateHidden()
            form.sectionBy(tag: "Day 1 Dec")?.hidden = false
            form.sectionBy(tag: "Day 1 Dec")?.evaluateHidden()
            form.sectionBy(tag: "Day 2 Dec")?.hidden = false
            form.sectionBy(tag: "Day 2 Dec")?.evaluateHidden()
        } else {
            form.sectionBy(tag: "Day 1 Dec")?.hidden = true
            form.sectionBy(tag: "Day 1 Dec")?.evaluateHidden()
            form.sectionBy(tag: "Day 2 Dec")?.hidden = true
            form.sectionBy(tag: "Day 2 Dec")?.evaluateHidden()
            form.sectionBy(tag: "Day 1 Hep")?.hidden = false
            form.sectionBy(tag: "Day 1 Hep")?.evaluateHidden()
            form.sectionBy(tag: "Day 2 Hep")?.hidden = false
            form.sectionBy(tag: "Day 2 Hep")?.evaluateHidden()
        }
    }

    private func updateLabels() {
        let day1 = self.isDec ? self.dayOneScoresDec.reduce(0,+) : self.dayOneScoresHep.reduce(0,+)
        let day2 = self.isDec ? self.dayTwoScoresDec.reduce(0,+) : self.dayTwoScoresHep.reduce(0,+)
        if let label = self.form.rowBy(tag: "Day 1") as? LabelRow {
            label.value = "Day 1 Total: \(day1)"
            label.reload()
        }
        if let label = self.form.rowBy(tag: "Day 2") as? LabelRow {
            label.value = "Day 2 Total: \(day2)"
            label.reload()
        }
        if let label = (self.form.rowBy(tag: "Overall") as? LabelRow) {
            label.value = "Total: \(day1 + day2)"
            label.reload()
        }
    }
    
    private func setupEvent(row: DecimalRow, event:Event, index:Int) {
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
            self.setPoints(points, index: index)
            if points > -1 {
                timeRow.title = "\(event.rawValue)   (\(points))"
            } else {
                timeRow.title = "\(event.rawValue)"
                timeRow.value = nil
            }
            self.updateLabels()
        })
    }

   private func setupEvent(row:TextRow, event:Event, index:Int) {
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
            self.setPoints(points, index: index)
            if points > -1 {
                timeRow.title = "\(event.rawValue)  (\(points))"
            } else {
                timeRow.title = "\(event.rawValue)"
                timeRow.value = nil
            }
            self.updateLabels()
        })
    }
    
    private func setPoints(_ points: Int, index: Int) {
        if self.isDec {
            if index < self.dayOneScoresDec.count {
                self.dayOneScoresDec[index] = points > -1 ? points : 0
            } else {
                self.dayTwoScoresDec[index % self.dayOneScoresDec.count] = points > -1 ? points : 0
            }
        } else {
            if index < self.dayOneScoresHep.count {
                self.dayOneScoresHep[index] = points > -1 ? points : 0
            } else {
                self.dayTwoScoresHep[index % self.dayOneScoresHep.count] = points > -1 ? points : 0
            }
        }
    }
    
}
