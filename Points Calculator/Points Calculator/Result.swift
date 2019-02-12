//
//  Result.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-11.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation

class EventResult {
    public let event : Event
    fileprivate var measure : Double?
    fileprivate var points : Int = 0
    
    init(event : Event) {
        self.event = event
    }
    
    func getPoints() -> Int{return points}
    func getMeasure() -> Double?{return measure}
    func updateMeasure(measure : Double?){}
    
    static func checkPoints(_ points: Double) -> Int {
        if points.isNaN || points.isInfinite || points > Double(Constants.Points.MaxPoints) {
            return 0
        } else {
            return max(Int(points),0)
        }
    }
}

class HepEventResult : EventResult {

    override func updateMeasure(measure : Double?){
        if let measure = measure {
            points = HepEventResult.calculatePoints(event: event, result: measure)
            self.measure = measure
        } else {
            self.points = 0
            self.measure = nil
        }
    }
    
    static func calculatePoints(event: Event, result : Double) -> Int {
        var pointsDouble : Double = 0
        switch event {
        case .hundyHurdles:
            pointsDouble = 9.23076 * pow((26.7 - result),1.835)
        case .HJ:
            pointsDouble = 1.84523 * pow((result * 100 - 75),1.348)
        case .SP:
            pointsDouble = 56.0211 * pow((result - 1.5),1.05)
        case .twoHundy:
            pointsDouble = 4.99087 * pow((42.5 - result),1.81)
        case .LJ:
            pointsDouble = 0.188807 * pow((result * 100 - 210),1.41)
        case .Jav:
            pointsDouble = 15.9803 * pow((result - 3.8),1.04)
        case .eightHundy:
            pointsDouble = 0.11193 * pow((254 - result),1.88)
        default:
            fatalError("Events overlapping")
        }
        return checkPoints(pointsDouble)
    }
}

class DecEventResult : EventResult {
    
    override func updateMeasure(measure : Double?){
        if let measure = measure {
            points = DecEventResult.calculatePoints(event: event, result: measure)
            self.measure = measure
        } else {
            self.points = 0
            self.measure = nil
        }
    }
    
    static func calculatePoints(event: Event, result: Double) -> Int {
        var pointsDouble : Double = 0
        switch event {
        case .hundy:
            pointsDouble = 25.4347 * pow((18 - result),1.81)
        case .LJ:
            pointsDouble = 0.14354 * pow((result*100 - 220),1.4)
        case .SP:
            pointsDouble = 51.39 * pow((result - 1.50),1.05)
        case .HJ:
            pointsDouble = 0.8465 * pow((result*100 - 75),1.42)
        case .fourHundy:
            pointsDouble = 1.53775 * pow((82 - result),1.81)
        case .hurdles:
            pointsDouble = 5.74352 * pow((28.5 - result),1.92)
        case .disc:
            pointsDouble = 12.91 * pow((result - 4),1.1)
        case .PV:
            pointsDouble = 0.2797 * pow((result*100 - 100),1.35)
        case .Jav:
            pointsDouble = 10.14 * pow((result - 7),1.08)
        case .fifteen:
            pointsDouble = 0.03768 * pow((480 - result),1.85)
        default:
            fatalError("Events overlapping")
        }
        return checkPoints(pointsDouble)
    }
}

class Result {
    var events : [Event: EventResult] = [:]
    var totalPoints = 0
    var dayOne = 0
    var dayTwo = 0
    
    func getPoints() -> Int {return totalPoints}
    func getDayOne() -> Int {return dayOne}
    func getDayTwo() -> Int {return dayTwo}
    
    func updateResult(event: Event, measure: Double?) {
        totalPoints -= (events[event]?.points)!
        events[event]?.updateMeasure(measure: measure)
        totalPoints += (events[event]?.points)!
    }
    
    func getEventResult(event : Event) -> EventResult {
        if events.keys.contains(event) {return events[event]!}
        fatalError("Event In Wrong Multi-Event")
    }
}

class HepResult : Result {
    override init() {
        super.init()
        events = [
            .hundyHurdles: HepEventResult(event: .hundyHurdles),
            .HJ: HepEventResult(event: .HJ),
            .SP: HepEventResult(event: .SP),
            .twoHundy: HepEventResult(event: .twoHundy),
            .LJ: HepEventResult(event: .LJ),
            .Jav: HepEventResult(event: .Jav),
            .eightHundy: HepEventResult(event: .eightHundy)]
    }
    
    override func updateResult(event: Event, measure: Double?) {
        if Event.getHepDayOneEvents().contains(event) {
            dayOne -= (events[event]?.points)!
            super.updateResult(event: event, measure: measure)
            dayOne += (events[event]?.points)!
        } else if Event.getHepDayTwoEvents().contains(event) {
            dayTwo -= (events[event]?.points)!
            super.updateResult(event: event, measure: measure)
            dayTwo += (events[event]?.points)!
        } else {
            fatalError("Ain't that event here")
        }
        
    }
}

class DecResult : Result {
    override init() {
        super.init()
        events = [
            .hundy: DecEventResult(event: .hundy),
            .LJ: DecEventResult(event: .LJ),
            .SP: DecEventResult(event: .SP),
            .HJ: DecEventResult(event: .HJ),
            .fourHundy: DecEventResult(event: .fourHundy),
            .hurdles: DecEventResult(event: .hurdles),
            .disc: DecEventResult(event: .disc),
            .PV: DecEventResult(event: .PV),
            .Jav: DecEventResult(event: .Jav),
            .fifteen: DecEventResult(event: .fifteen)]
    }
    
    override func updateResult(event: Event, measure: Double?) {
        if Event.getDecDayOneEvents().contains(event) {
            dayOne -= (events[event]?.points)!
            super.updateResult(event: event, measure: measure)
            dayOne += (events[event]?.points)!
        } else if Event.getDecDayTwoEvents().contains(event) {
            dayTwo -= (events[event]?.points)!
            super.updateResult(event: event, measure: measure)
            dayTwo += (events[event]?.points)!
        } else {
            fatalError("Ain't that event here")
        }
    }
}


