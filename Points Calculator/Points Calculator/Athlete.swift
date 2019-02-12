//
//  Athlete.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-08.
//  Copyright © 2019 Reid. All rights reserved.
//
import Foundation

open class Athlete : Equatable{
    
    public var firstName : String
    public var lastName : String
    public var team : String
    public var isDec : Bool
    public var birthDate : Date
    
    public init() {
        firstName = ""
        lastName = ""
        team = ""
        isDec = false
        birthDate = Date.init(timeIntervalSince1970: 0)
    }
    
    open func fullName() -> String {
        return firstName + " " + lastName
    }
    
    public static func == (lhs: Athlete, rhs: Athlete) -> Bool {
        return lhs.fullName() == rhs.fullName()
    }
}

var AthleteList : Array<Athlete> = []
