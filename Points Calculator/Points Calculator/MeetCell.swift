//
//  MeetCell.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-09.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
import Eureka


class MeetCell : UITableViewCell {
    var meet : Meet?
    var nameLbl = CellLabel.makeLabel()
    var cityLbl = CellLabel.makeLabel()
    var countryLbl = CellLabel.makeLabel()
    var dateLbl = CellLabel.makeLabel()
    
    convenience init(){
        self.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "MeetCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(nameLbl)
        self.addSubview(cityLbl)
        self.addSubview(countryLbl)
        self.addSubview(dateLbl)
        makeNameLabel()
        makeCityLabel()
        makeDateLabel()
        makeCountryLabel()
    }
    
    func setMeet(meet : Meet) { self.meet = meet}
    
    func labelsForMeet() {
        nameLbl.text = meet!.name
        cityLbl.text = meet!.city
        let calendar = Calendar.current
        let year = calendar.component(.year, from: (meet?.date)!) % 100
        dateLbl.text = "'" + String(format: "%02d", year)
        countryLbl.text = meet!.country
    }
    
    func makeNameLabel() {
        nameLbl.snp.makeConstraints{ row in
            row.left.top.height.equalToSuperview()
            row.width.equalTo(self.bounds.width * 0.8)
        }
    }
    
    func makeDateLabel() {
        dateLbl.snp.makeConstraints{ row in
            row.right.top.equalToSuperview()
            row.left.equalTo(self.nameLbl.snp.right)
            row.top.equalTo(0)
            row.height.equalTo(self.bounds.height/3)
        }
    }
    
    func makeCityLabel() {
        cityLbl.snp.makeConstraints{ row in
            row.right.equalToSuperview()
            row.left.equalTo(self.nameLbl.snp.right)
            row.top.equalTo(self.dateLbl.snp.bottom)
            row.height.equalTo(self.bounds.height/3)
        }
    }
    
    func makeCountryLabel() {
        countryLbl.snp.makeConstraints{ row in
            row.right.equalToSuperview()
            row.left.equalTo(self.nameLbl.snp.right)
            row.top.equalTo(self.cityLbl.snp.bottom)
            row.height.equalTo(self.bounds.height/3)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if meet != nil {
            labelsForMeet()
        }
    }
}
