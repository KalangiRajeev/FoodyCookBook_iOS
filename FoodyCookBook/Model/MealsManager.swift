//
//  MealsManager.swift
//  FoodyCookBook
//
//  Created by Admin on 26/04/21.
//  Copyright © 2021 Rajeev Kalangi. All rights reserved.
//

import Foundation

protocol MealsManagerDelegate {
    func didUpdateMeals(food: Food)
    func didFailWithError(error: Error)
}

struct MealsManager {
    
    var delegate : MealsManagerDelegate?
    let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    
    func searchMeal(for searchMeal : String) {
        let urlString = "\(baseUrl)search.php?s=\(searchMeal)"
        performRequest(with : urlString)
    }
    
    func randomMeal() {
        let urlString = "\(baseUrl)random.php"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    self.delegate?.didFailWithError(error: err)
                }
                
                if let safeData = data {
                    
                    if let food = self.parseJSON(safeData) {
                        self.delegate?.didUpdateMeals(food: food)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Food? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Food.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
