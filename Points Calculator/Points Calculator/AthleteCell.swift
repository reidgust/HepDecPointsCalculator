//
//  File.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-09.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
import Eureka

final class AthleteRow: _PushRow<AthleteCell,AthleteListViewController>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = PresentationMode<AthleteListViewController>.Show(controllerProvider: ControllerProvider.Callback { return AthleteListViewController(){ _ in } }, completionCallback: { vc in vc.navigationController?.popViewControllerAnimated(true) })
    }
        
}

final class AthleteCell : Cell<Athlete>, CellType PushSelectorCell<Athlete>{
    var athlete : Athlete?
    var fullNameLbl = CellLabel.makeLabel()
    var teamLbl = CellLabel.makeLabel()
    var eventLbl = CellLabel.makeLabel()
    var birthDateLbl = CellLabel.makeLabel()
    var placeHolderLbl = CellLabel.makeLabel()
    
    /*
 let deleteAction = SwipeAction(
 style: .destructive,
 title: "Delete",
 handler: { (action, row, completionHandler) in
 //add your code here.
 //make sure you call the completionHandler once done.
 completionHandler?(true)
 })
 deleteAction.image = UIImage(named: "icon-trash")
 
 $0.trailingSwipe.actions = [deleteAction]
 $0.trailingSwipe.performsFirstActionWithFullSwipe = true
*/
    
    convenience init(){
        self.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "AthCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func setup() {
        //super.init(style: style, reuseIdentifier: reuseIdentifier)
        height = { 51.0 }
        self.addSubview(fullNameLbl)
        self.addSubview(eventLbl)
        self.addSubview(teamLbl)
        self.addSubview(birthDateLbl)
        self.addSubview(placeHolderLbl)
        makeFullNameLabel()
        makeEventLabel()
        makeBirthDateLabel()
        makeTeamLabel()
        makePlaceHolderLabel()
        backgroundColor = .black
    }
    
    override func update() {
        setAthlete(athl: row.value)
    }
    
    func setAthlete(athl : Athlete?) {
        athlete = athl
    }
    
    func labelsForAthlete() {
        placeHolderLbl.text = ""
        fullNameLbl.text = athlete!.fullName()
        eventLbl.text = athlete!.isDec ? "Dec" : "Hep"
        let calendar = Calendar.current
        let year = calendar.component(.year, from: (athlete?.birthDate)!) % 100
        birthDateLbl.text = "'" + String(format: "%02d", year)
        if athlete!.team.count < 15 {
            teamLbl.text = athlete!.team
        } else {
            var abbrev = athlete!.team[0]
            var countNext : Bool = false
            for char in athlete!.team {
                if char == " " {
                    countNext = true
                } else if countNext {
                    abbrev.append(char)
                    countNext = false
                }
            }
            teamLbl.text = abbrev.uppercased()
        }
    }

    func setLabelsToPlaceHolder() {
        birthDateLbl.text = nil
        fullNameLbl.text = nil
        teamLbl.text = nil
        eventLbl.text = nil
        placeHolderLbl.text = "Select Athlete"
    }

    func makePlaceHolderLabel() {
        placeHolderLbl.snp.makeConstraints{ row in
            row.left.top.height.width.equalToSuperview()
        }
        placeHolderLbl.textAlignment = .center
    }

    func makeFullNameLabel() {
        fullNameLbl.snp.makeConstraints{ row in
            row.left.top.height.equalToSuperview()
            row.width.equalTo(self.bounds.width * 0.8)
        }
    }
    
    func makeEventLabel() {
        eventLbl.snp.makeConstraints{ row in
            row.right.top.equalToSuperview()
            row.left.equalTo(self.fullNameLbl.snp.right)
            row.top.equalTo(0)
            row.height.equalTo(self.bounds.height/3)
        }
    }
    
    func makeTeamLabel() {
        teamLbl.snp.makeConstraints{ row in
            row.right.equalToSuperview()
            row.left.equalTo(self.fullNameLbl.snp.right)
            row.top.equalTo(self.eventLbl.snp.bottom)
            row.height.equalTo(self.bounds.height/3)
        }
    }
    
    func makeBirthDateLabel() {
        birthDateLbl.snp.makeConstraints{ row in
            row.right.equalToSuperview()
            row.left.equalTo(self.fullNameLbl.snp.right)
            row.top.equalTo(self.teamLbl.snp.bottom)
            row.height.equalTo(self.bounds.height/3)
        }
    }
    
    override func layoutSubviews() {
        if athlete != nil { labelsForAthlete() }
        else { setLabelsToPlaceHolder() }
        super.layoutSubviews()
    }
}
