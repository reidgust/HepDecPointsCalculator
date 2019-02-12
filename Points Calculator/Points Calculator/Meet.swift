//
//  Meet.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-08.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation

struct Meet {
    var name : String
    var date : Date
    var country : String
    var city : String
    
    init(){
        name = ""
        date = Date(timeIntervalSince1970: 0)
        country = ""
        city = ""
    }
}

var MeetList : Array<Meet> = []
