//
//  FoodViewController.swift
//  FoodyCookBook
//
//  Created by Admin on 26/04/21.
//  Copyright © 2021 Rajeev Kalangi. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, MealsManagerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var food: Food? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var mealsManager = MealsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Random Meals"
        
        mealsManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        mealsManager.randomMeal()
        tableView.separatorStyle = .none
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let querytext = searchController.searchBar.text {
            mealsManager.searchMeal(for: querytext)
        }
    }
    
    func didUpdateMeals(food: Food) {
        OperationQueue.main.addOperation {
            self.food = food
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension FoodViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.text = food?.meals[indexPath.row].strMeal
        cell.detailTextLabel?.text = food?.meals[indexPath.row].strInstructions
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.food?.meals.count ?? 0
    }
    
    
}

extension FoodViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


