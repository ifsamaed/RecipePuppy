//
//  RecipePresenter.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol RecipePresenterInputProtocol: class {
    
    var view: RecipeViewControllerInputProtocol? { get set }
    var wireframe: RecipeWireframeInputProtocol? { get set }
    var recipeInteractor: RecipeInteractorInputProtocol? { get set }

    func onViewDidLoad()
    func searchRecipe(ingredients: String, page: Int?)
}

// MARK: - Class Implementation

class RecipePresenter: RecipePresenterInputProtocol {
    
    // MARK: Properties

    weak var view: RecipeViewControllerInputProtocol?
    var wireframe: RecipeWireframeInputProtocol?
    var recipeInteractor: RecipeInteractorInputProtocol?
    
    // Mark: - RecipePresenterInputProtocol
    
    func onViewDidLoad() {
        self.recipeInteractor?.findListRecipes(ingredients: ["onions","garlic"], query: nil, page: nil, format: nil)
    }
    
    func searchRecipe(ingredients: String, page: Int? = nil) {
        self.view?.showActivityIndicator()
        self.recipeInteractor?.findListRecipes(ingredients: [ingredients], query: nil, page: page ?? 0 + 1, format: nil)
    }

}

extension RecipePresenter: RecipeInteractorOutputProtocol {
    
    func foundRecipe(recipe: RecipePuppy) {
        
        if let results = recipe.results {
            self.view?.hiddenActivityIndicator()
            self.view?.showResults(result: results)
        }
    }
    
    func foundError() {
        self.view?.foundError()
    }
}
