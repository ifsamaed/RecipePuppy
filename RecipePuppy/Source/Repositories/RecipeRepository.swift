//
//  RecipeRepository.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol RecipeRepositoryInputProtocol: class {
    
    var recipeRequestHandler: RecipeRepositoryOutputProtocol? { get set }
    
    func findListRecipes(ingredients:[String], query: String?, page:Int?, format:String?)
}

protocol RecipeRepositoryOutputProtocol: class {
    
    func foundRecipe(recipe: RecipePuppy)
    func foundError()
}

// MARK: - Class Implementation

class RecipeRepository: RecipeRepositoryInputProtocol {
    
    var recipeRequestHandler: RecipeRepositoryOutputProtocol?
    
    func findListRecipes(ingredients:[String], query: String?, page:Int?, format:String?) {
        
        var recipe_URL = "\(APIConstants.URL_BASE)\(APIConstants.URL_RECIPE)"
        
        if !ingredients.isEmpty {
            recipe_URL += "i=\(ingredients.joined(separator: ","))"
        }
        if let q = query,
            q != "" {
            recipe_URL += "&q=\(q)"
        }
        
        if let p = page {
            recipe_URL += "&p=\(p)"
        }
        
        if let f = format,
            f != "" {
            recipe_URL += "&format=\(f)"
        }
        
        if let url = URL(string: recipe_URL) {
            
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                
                if response != nil && data != nil {
                    
                    guard let data = data else {
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    DispatchQueue.main.async {
                        
                        var error: Bool = false
                        
                        if data.count < 1 {
                            
                            error = true
                        } else {
                            
                            if let recipePuppy = try? decoder.decode(RecipePuppy.self, from: data) {
                                
                                self.recipeRequestHandler?.foundRecipe(recipe: recipePuppy)
                            } else {
                                
                                error = true
                            }
                        }
                        if error {
                            self.recipeRequestHandler?.foundError()
                        }
                    }
                }
                }.resume()
        } else {
            
            self.recipeRequestHandler?.foundError()
        }
    }
}
