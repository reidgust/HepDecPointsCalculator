//
//  AthleteMeetListViewController.swift
//  Points Calculator
//
//  Created by Reid on 2019-01-19.
//  Copyright © 2019 Reid. All rights reserved.
//

import Foundation
import UIKit

class AthleteListViewController : UITableViewController {

    var heightMap : [IndexPath : CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 20
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Athlete", style: .plain, target: self, action: #selector(addAthlete))
        view.backgroundColor = .white
        tableView.register(AthleteCell.self, forCellReuseIdentifier: "athleteCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AthleteList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let athVC = NewAthleteViewController(athlete: AthleteList[indexPath.row],index: indexPath.row)
        athVC.title = "Edit Athlete"
        navigationController?.pushViewController(athVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "athleteCell") as! AthleteCell
        cell.setAthlete(athl: AthleteList[indexPath.row])
        cell.backgroundColor = .black
        heightMap[indexPath] = cell.bounds.height
        return cell
    }
    
    @objc func addAthlete() {
        let athVC = NewAthleteViewController()
        athVC.title = "New Athlete"
        navigationController?.pushViewController(athVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightMap[indexPath] ?? UITableView.automaticDimension
    }
}
