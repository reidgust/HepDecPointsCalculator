//
//  EnterResultsForm.swift
//  Points Calculator
//
//  Created by Reid on 2018-11-01.
//  Copyright © 2018 Reid. All rights reserved.
//

import Foundation
import Eureka
import MediaPlayer
import SnapKit

/*// MusicRow
public final class MusicRow : SelectorRow<MPMediaItemCollection, PushSelectorCell<MPMediaItemCollection>, AddMusicViewController>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .Show(controllerProvider: ControllerProvider.Callback { return AddMusicViewController(){ _ in } }, completionCallback: { vc in vc.navigationController?.popViewControllerAnimated(true) })
        displayValueFor = {
            guard var musicTitle = $0 else { return "" }
            musicTitle = musicTemp!
            let representativeItem = musicTitle.representativeItem
            print("representativeItem = \(representativeItem)")
            let representativeItemTitle = representativeItem?.title
            return  "\(representativeItemTitle)"
        }
    }
}

// MusicViewController
public class AddMusicViewController : UIViewController, TypedRowControllerType, MPMediaPickerControllerDelegate {
    
    public var row: RowOf<MPMediaItemCollection>!
    public var completionCallback : ((UIViewController) -> ())?
    
    lazy var musicPicker : MPMediaPickerController = { [unowned self] in
        let mediaPicker = MPMediaPickerController.self(mediaTypes:.Music)
        return mediaPicker
        }()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience public init(_ callback: (UIViewController) -> ()){
        self.init(nibName: nil, bundle: nil)
        completionCallback = callback
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(musicPicker.view)
        
        musicPicker.delegate = self
        musicPicker.allowsPickingMultipleItems = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    // After selection, store the data into a temporary variable
    public func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        musicTemp = nil
        musicTemp = mediaItemCollection
        if musicTemp == nil {
            noMusic = true
        } else {
            noMusic = false
            row.value? = musicTemp!
        }
        completionCallback?(self)
    }
    
    // Cancel mediaPickerController
    public func mediaPickerDidCancel(mediaPicker: MPMediaPickerController){
        // Dismiss the picker if the user canceled
        noMusic = true
        completionCallback?(self)
    }
}
*/
class CalculatorViewController: FormViewController {
    var isDec : Bool = false
    var decResult : DecResult?
    var hepResult : HepResult? = HepResult()
    var day1 : LabelRow?
    var day2 : LabelRow?
    var overall : LabelRow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form
            +++ Section()
            <<< SegmentedRow<String>("Hep Or Dec") { row in
                row.tag = "DecToggle"
                row.options = ["Heptathlon", "Decathlon"]
                row.value = self.isDec ? "Decathlon" : "Heptathlon"
                }.onChange{ (row) in
                    self.isDec = row.options?[0] == row.value ? false : true
                    if self.isDec && self.decResult == nil {self.decResult = DecResult()}
                    if !self.isDec && self.hepResult == nil {self.hepResult = HepResult()}
                    self.updateVisibleSections()
                    self.updateLabels()
                }
            +++ makeEventsSec("Day 1", tag:"Day 1 Dec",decimalEvents: [.hundy,.LJ,.SP,.HJ], textEvents: [.fourHundy])
            +++ makeEventsSec("Day 1", tag:"Day 1 Hep", decimalEvents: [.hundyHurdles,.HJ,.SP,.twoHundy], textEvents: [])
            +++ Section()
            <<< LabelRow("Day 1")

            +++ makeEventsSec("Day 2", tag: "Day 2 Dec", decimalEvents: [.hurdles,.disc,.PV,.Jav], textEvents: [.fifteen])
            +++ makeEventsSec("Day 2", tag: "Day 2 Hep",decimalEvents: [.LJ,.Jav], textEvents: [.eightHundy])
            +++ Section()
            <<< LabelRow("Day 2")
            <<< LabelRow("Overall")
            +++ Section()
            <<< AthleteRow() {
                $0.options = AthleteList
                $0.value = nil
                }/*.onPresent({ (_, presenterViewController) -> () in
                    AthleteListViewController.selectableRowCellUpdate = { cell, row in
                        cell.contentView.backgroundColor = .orangeColor()
                    }
                })*/
            <<< PushRow<Athlete>() {
                $0.title = "Athlete"
                $0.options = AthleteList
                $0.displayValueFor = { value in
                    if value == nil {return nil}
                    return value!.fullName()
                }
                $0.value = nil
                $0.selectorTitle = "Choose an Athlete"
                $0.tag = "AthleteSelect"
                $0.onPresent({ (from, to) in
                    to.dismissOnSelection = false
                    to.dismissOnChange = false
                })
            }
        
    }
/*
    @objc func createNewAthlete() {
        let athVC = NewAthleteViewController()
        athVC.title = "New Athlete"
        navigationController?.pushViewController(athVC, animated: true)
    }

    @objc func createNewMeet() {
        let meetVC = NewMeetViewController()
        meetVC.title = "New Meet"
        navigationController?.pushViewController(meetVC, animated: true)
    }
*/
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
                let index = tag.contains("1") ? i : i + (tag.contains("Dec") ?  5 : 4)
                setupEvent(row:row, event:decimalEvents[i], index:index)
            }
            sec.append(decRow)
        }
        for i in 0..<textEvents.count {
            let textRow = TextRow(){ row in
                var index = i + decimalEvents.count
                index = tag.contains("1") ? index : index + (tag.contains("Dec") ?  5 : 4)
                setupEvent(row: row, event:textEvents[i], index:index)
            }
            sec.append(textRow)
        }
        return sec
    }

    func loadResult(result: HepResult) {
        hepResult = result
        isDec = false
        (form.rowBy(tag: "DecToggle") as! SegmentedRow).value = "Heptathlon"
        self.updateVisibleSections()
        self.updateLabels()
        for row in form.sectionBy(tag: "Day 1 Hep")! {
            row.isHighlighted = true
            row.isHighlighted = false
        }
        for row in form.sectionBy(tag: "Day 2 Hep")! {
            row.isHighlighted = true
            row.isHighlighted = false
        }
    }

    func loadResult(result: DecResult) {
        decResult = result
        (form.rowBy(tag: "DecToggle") as! SegmentedRow).value = "Decathlon"
        self.updateVisibleSections()
        self.updateLabels()
        for row in form.sectionBy(tag: "Day 1 Dec")! {
            row.isHighlighted = true
            row.isHighlighted = false
        }
        for row in form.sectionBy(tag: "Day 2 Dec")! {
            row.isHighlighted = true
            row.isHighlighted = false
        }
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
        let day1 = self.isDec ? decResult!.getDayOne() : hepResult!.getDayOne()
        let day2 = self.isDec ? decResult!.getDayTwo() : hepResult!.getDayTwo()
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
        row.onCellHighlightChanged({ (cell,timeRow) in
            var points : Int = -1
            if let time = timeRow.value  {
                let timeRounded = round(time * 100) / 100
                if self.isDec {
                    self.decResult!.updateResult(event:event, measure: timeRounded)
                    points = self.decResult!.getEventResult(event: event).getPoints()
                } else {
                    self.hepResult!.updateResult(event:event,measure: timeRounded)
                    points = self.hepResult!.getEventResult(event: event).getPoints()
                }
                timeRow.value = timeRounded
            }
            timeRow.title = points > 0 ? "\(event.rawValue)   (\(points))" : "\(event.rawValue)"
            self.updateLabels()
        })
    }
    
    private func setupEvent(row: TextRow, event:Event, index:Int) {
        row.title = event.rawValue
        row.onCellHighlightChanged({ (cell, timeRow) in
            var points : Int = -1
            if let time = timeRow.value  {
                let timeRounded = self.stringTimeToDouble(time)
                if self.isDec {
                    self.decResult!.updateResult(event:event, measure: timeRounded)
                    points = self.decResult!.getEventResult(event: event).getPoints()
                } else {
                    self.hepResult!.updateResult(event:event,measure: timeRounded)
                    points = self.hepResult!.getEventResult(event: event).getPoints()
                }
                timeRow.value = self.decimalTimeToText(timeRounded)
            }
            timeRow.title = points > 0 ? "\(event.rawValue)   (\(points))" : "\(event.rawValue)"
            self.updateLabels()
        })
    }
    
    private func decimalTimeToText(_ time : Double?) -> String? {
        if let time = time {
            let time100 = Int(time*100)
            if time < 60 {
                let secs = time100 / 100
                let fracs = time100 % 100
                return String(format: "%02d.%02d",secs, fracs)
            }
            let mins = time100 / 6000
            let secs = (time100 % 6000) / 100
            let fracs = time100 % 100
            return String(format:"%d:%02d.%02d",mins,secs,fracs)
        }
        return nil
    }
    
    private func stringTimeToDouble(_ time : String) -> Double? {
        let minSecs = time.split(separator: ":")
        if time == "" || minSecs.count > 2 {return nil}
        if minSecs.count == 2, let mins = Double(minSecs[0]), let secs = Double(minSecs[1]) {
            return round((60.0 * mins + secs) * 100) / 100
        }
        if let secs = Double(minSecs[0]) {
            return round(secs * 100) / 100
        }
        return nil
    }
    
}
