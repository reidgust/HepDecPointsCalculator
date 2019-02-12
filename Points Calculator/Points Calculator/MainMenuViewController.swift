//
//  MainMenuViewController.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-07.
//  Copyright © 2019 Reid. All rights reserved.
//

import UIKit

class MainMenuViewController : UIViewController {
    var athleteMenuButton: UIButton?
    var meetMenuButton: UIButton?
    var pointCalculatorButton: UIButton?
    
    func makeMenuButton(title: String, yPos : CGFloat, action : Selector) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        let buttonWidth : CGFloat = AppDelegate.screenWidth/4
        let buttonHeight : CGFloat = AppDelegate.screenHeight/20
        button.setTitle(title, for: UIControl.State.normal)
        button.frame = CGRect(x: (AppDelegate.screenWidth - buttonWidth) / 2, y: yPos, width: buttonWidth, height: buttonHeight)
        button.addTarget(self, action: action, for: UIControl.Event.touchUpInside)
        view.addSubview(button)
        return button
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        athleteMenuButton = makeMenuButton(title: "Athlete List", yPos: (AppDelegate.screenHeight/20) * 5, action: #selector(presentAthleteList))
        meetMenuButton = makeMenuButton(title: "Meet List", yPos: (AppDelegate.screenHeight/20) * 9, action: #selector(presentMeetList))
        pointCalculatorButton = makeMenuButton(title: "Calculator", yPos: (AppDelegate.screenHeight/20) * 13, action: #selector(presentCalculator))
    }
    
    @objc func presentAthleteList() {
        let athListVC = AthleteListViewController()
        athListVC.title = "Athletes"
        navigationController?.pushViewController(athListVC, animated: true)
    }
    
    @objc func presentMeetList() {
        let meetListVC = MeetListViewController()
        meetListVC.title = "Meets"
        navigationController?.pushViewController(meetListVC, animated: true)
    }
    
    @objc func presentCalculator() {
        let calcVC = CalculatorViewController()
        calcVC.title = "Calculator"
        navigationController?.pushViewController(calcVC, animated: true)
    }
}
