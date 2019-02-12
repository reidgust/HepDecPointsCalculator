//
//  NewAthleteViewController.swift
//  Points Calculator
//
//  Created by Reid on 2019-01-19.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
import Eureka

class NewAthleteViewController: FormViewController {
    
    var athlete : Athlete = Athlete()
    var currAth : Athlete?
    var index = -1
    
    convenience init(athlete : Athlete, index : Int) {
        self.init()
        self.index = index
        self.currAth = athlete
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(completeAdd))
        
        form +++ Section("Enter Athlete Info")
            <<< TextRow(){ row in
                row.title = "First Name"
                row.value = self.index == -1 ? "" : currAth!.firstName
                row.placeholder = "Enter First Name"
                self.athlete.firstName = row.value ?? ""
                }.onChange{ row in
                    self.athlete.firstName = row.value ??  ""
                }
            <<< TextRow(){
                $0.title = "Last Name"
                $0.value = self.index == -1 ? "" : currAth!.lastName
                $0.placeholder = "Enter Last Name"
                self.athlete.lastName = $0.value ?? ""
                }.onChange{ row in
                    self.athlete.lastName = row.value ?? ""
                }
            <<< TextRow(){
                $0.title = "School Name"
                $0.value = self.index == -1 ? "" : currAth!.team
                $0.placeholder = "Enter Team Name"
                self.athlete.team = $0.value ?? ""
                }.onChange{ row in
                    self.athlete.team = row.value ?? ""
                }
            <<< SegmentedRow<String>("Hep Or Dec") { row in
                row.options = ["Heptathlete", "Decathlete"]
                row.value = (self.index == -1 ? self.athlete.isDec : self.currAth!.isDec) ? "Decathlete" : "Heptathlete"
                self.athlete.isDec = row.options?[0] == row.value ? false : true
                }.onChange{ (row) in
                    self.athlete.isDec = row.options?[0] == row.value ? false : true
                }
            <<< DateRow(){
                    $0.title = "Birth Date"
                    $0.value = self.index == -1 ? Date(timeIntervalSinceReferenceDate: 0) : currAth!.birthDate
                    self.athlete.birthDate = $0.value!
                }.onChange{ (row) in
                    self.athlete.birthDate = row.value!
                }
    }
    
    @objc func completeAdd() {
        if self.verifyInfo() {
            if self.index == -1 {
                AthleteList.append(athlete)
            } else {
                AthleteList.remove(at: index)
                AthleteList.insert(athlete, at: index)
            }
            if self.isModalInPopover {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }  else {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Information Missing", message: "Make sure the athlete has a first and last name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert,animated:true)
        }
    }
    
    func verifyInfo() -> Bool {
        if (athlete.firstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            athlete.lastName.trimmingCharacters(in: .whitespacesAndNewlines) == "") {return false}
        return true;
    }
}

