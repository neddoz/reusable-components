//
//  MealsTableTableViewController.swift
//  reusablecomponents
//
//  Created by kayeli dennis on 05/02/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit

class MealsTableTableViewController: UITableViewController {

    //MARK: instance properties
    var meals = [Meal]()

    // MARK: private properties
    private let dataSource = ListViewDatasource()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        setUpMeals()
        render()
    }

    // MARK: private functions
    private func render() {
        let mealNames = meals.map { return $0.name }
        dataSource.list = mealNames
        tableView.reloadData()
    }

    private func setUpMeals () {
        let mealItemone = Meal(name: "Roasted Chicken", photo: nil, rating: nil)
        let mealItemtwo = Meal(name: "Roasted Chicken", photo: nil, rating: nil)
        let mealItemthree = Meal(name: "Roasted Chicken", photo: nil, rating: nil)
        meals.append(mealItemone)
        meals.append(mealItemtwo)
        meals.append(mealItemthree)
    }
}

extension MealsTableTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "toRatingsVc", sender: nil)
    }
}
