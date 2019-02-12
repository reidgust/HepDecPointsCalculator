//
//  MeetListViewController.swift
//  Points Calculator
//
//  Created by Reid on 2019-02-07.
//  Copyright © 2019 Reid. All rights reserved.
//

import UIKit

class MeetListViewController: UITableViewController {

    var heightMap : [IndexPath : CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 20
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Meet", style: .plain, target: self, action: #selector(addMeet))
        view.backgroundColor = .black
        tableView.register(MeetCell.self, forCellReuseIdentifier: "meetCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MeetList.count
    }
    
    @objc func addMeet() {
        let meetVC = NewMeetViewController()
        meetVC.title = "New Meet"
        navigationController?.pushViewController(meetVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let athVC = NewAthleteViewController(athlete: AthleteList[indexPath.row],index: indexPath.row)
        athVC.title = "Edit Meet"
        navigationController?.pushViewController(athVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetCell") as! MeetCell
        cell.setMeet(meet: MeetList[indexPath.row])
        cell.backgroundColor = .black
        heightMap[indexPath] = cell.bounds.height
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightMap[indexPath] ?? UITableView.automaticDimension
    }

}
