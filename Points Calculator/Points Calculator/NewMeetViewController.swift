//
//  NewMeetViewController.swift
//  Points Calculator
//
//  Created by Reid on 2019-01-19.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
import Eureka

class NewMeetViewController: FormViewController {
    var meet : Meet = Meet()
    var currMeet : Meet?
    var index = -1
    
    convenience init(meet : Meet, index : Int) {
        self.init()
        self.index = index
        self.currMeet = meet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(completeAdd))
        form +++ Section("Section1")
            <<< TextRow(){
                $0.title = "Meet"
                $0.placeholder = "Enter Name of Competition"
                $0.value = index == -1 ? "" : currMeet!.name
                self.meet.name = $0.value!
                }.onChange{ row in
                    self.meet.name = row.value!
                }
            <<< TextRow(){
                $0.title = "City"
                $0.placeholder = "Enter City Name"
                $0.value = index == -1 ? "" : currMeet!.city
                self.meet.city = $0.value!
                }.onChange{row in
                    self.meet.city = row.value!
            }
            <<< TextRow(){ row in
                row.title = "Country"
                row.placeholder = "Enter 3-Letter Country Code"
                row.value = index == -1 ? "" : currMeet!.country
                self.meet.country = row.value!
                }.onChange{ row in
                    self.meet.country = row.value!
            }
            <<< DateRow(){
                $0.title = "Competition Date"
                $0.value = index == -1 ? Date(timeIntervalSinceReferenceDate: 0) : currMeet!.date
                self.meet.date = $0.value!
                }.onChange{ row in
                    self.meet.date = row.value!
            }
    }
    
    @objc func completeAdd() {
        if self.verifyInfo() {
            if index == -1 {
                MeetList.append(meet)
            } else {
                MeetList.remove(at: index)
                MeetList.insert(meet, at: index)
            }
            if self.isModalInPopover {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }  else {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Information Missing", message: "Make sure the meet has a name and country is 3 letters.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert,animated:true)
        }
    }
    
    func verifyInfo() -> Bool {
        if (meet.name.trimmingCharacters(in: .whitespacesAndNewlines) == "" || !(meet.country.trimmingCharacters(in: .whitespacesAndNewlines).length == 3 || meet.country.trimmingCharacters(in: .whitespacesAndNewlines).length == 0)) {return false}
        return true;
    }
}
