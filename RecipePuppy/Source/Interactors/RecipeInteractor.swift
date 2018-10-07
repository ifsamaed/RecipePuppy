//
//  RecipeInteractor.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol RecipeInteractorInputProtocol: class {
    var presenter: RecipeInteractorOutputProtocol? { get set}
    var recipeRepository: RecipeRepositoryInputProtocol? { get set}

    func findListRecipes(ingredients:[String], query: String?, page:Int?, format:String?)
}

protocol RecipeInteractorOutputProtocol: class {
    
    func foundRecipe(recipe: RecipePuppy)
    func foundError()
}

// MARK: - Class Implementation

class RecipeInteractor: RecipeInteractorInputProtocol {
    
    weak var presenter: RecipeInteractorOutputProtocol?
    var recipeRepository: RecipeRepositoryInputProtocol?

    func findListRecipes(ingredients:[String], query: String?, page:Int?, format:String?) {
        
        self.recipeRepository?.findListRecipes(ingredients: ingredients, query: query, page: page, format: format)
    }
}

extension RecipeInteractor : RecipeRepositoryOutputProtocol {

    func foundRecipe(recipe: RecipePuppy) {        
        self.presenter?.foundRecipe(recipe: recipe)
    }
    
    func foundError() {
        self.presenter?.foundError()
    }

}
