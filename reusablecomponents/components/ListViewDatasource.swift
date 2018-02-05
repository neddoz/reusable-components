//
//  ListViewDatasource.swift
//  reusablecomponents
//
//  Created by kayeli dennis on 05/02/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//
import UIKit

class ListViewDatasource: NSObject, UITableViewDataSource {
    var list = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}
