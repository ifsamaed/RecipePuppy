//
//  WebViewWireframe.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 7/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol WebViewWireframeInputProtocol: class {
    // Input functions from presenter to wireframe

    static func createModule(result: Result) -> UIViewController
    
    func close(view : WebViewViewControllerInputProtocol)
}

// MARK: - Class Implementation

final class WebViewWireframe: WebViewWireframeInputProtocol {
    
    // Implementations for input functions from presenter to wireframe

    static func createModule(result: Result) -> UIViewController {
        
        let viewController = Utils.mainStoryboard.instantiateViewController(withIdentifier: "WebViewViewController")

        if let view = viewController as? WebViewViewController {

            let wireframe: WebViewWireframeInputProtocol = WebViewWireframe()
            let presenter: WebViewPresenterInputProtocol = WebViewPresenter()

            view.presenter = presenter

            presenter.view = view
            presenter.wireframe = wireframe
            presenter.result = result

            return view
        }

        return UIViewController()
    }
    
    func close(view : WebViewViewControllerInputProtocol) {
        
        if let vc = view as? WebViewViewController {
            
            vc.dismiss(animated: true, completion: nil)
        }
    }

    
}
