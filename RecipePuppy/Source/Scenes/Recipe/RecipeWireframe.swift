    //
//  RecipeWireframe.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol RecipeWireframeInputProtocol: class {
    // Input functions from presenter to wireframe

    static func createModule() -> UIViewController
    
    func openWebView(result: Result, view: RecipeViewControllerInputProtocol)
}

// MARK: - Class Implementation

class RecipeWireframe: RecipeWireframeInputProtocol {
    // Implementations for input functions from presenter to wireframe

    static func createModule() -> UIViewController {
        let viewController = Utils.mainStoryboard.instantiateViewController(withIdentifier: "RecipeViewController")

        if let view = viewController as? RecipeViewController {
            
            let presenter: RecipePresenterInputProtocol & RecipeInteractorOutputProtocol = RecipePresenter()
            let recipeInteractor: RecipeInteractorInputProtocol & RecipeRepositoryOutputProtocol = RecipeInteractor()
            let recipeRepository: RecipeRepositoryInputProtocol = RecipeRepository()
            let wireframe: RecipeWireframeInputProtocol = RecipeWireframe()
            
            view.presenter = presenter

            presenter.view = view
            presenter.wireframe = wireframe
            presenter.recipeInteractor = recipeInteractor
            
            recipeInteractor.presenter = presenter
            recipeInteractor.recipeRepository = recipeRepository
            recipeRepository.recipeRequestHandler = recipeInteractor

            return view
        }

        return UIViewController()
    }
    
    func openWebView(result: Result, view: RecipeViewControllerInputProtocol) {
        
        let webView = WebViewWireframe.createModule(result: result)
        
        if let source = view as? UIViewController {
            
            source.present(webView, animated: true, completion: nil)
        }
    }

}
