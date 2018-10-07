//
//  WebViewPresenter.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 7/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol WebViewPresenterInputProtocol: class {
    var view: WebViewViewControllerInputProtocol? { get set }
    var wireframe: WebViewWireframeInputProtocol? { get set }
    var result: Result? { get set }

    func onViewDidLoad()
    
    func userTapBackBtn()
}

// MARK: - Class Implementation

final class WebViewPresenter: WebViewPresenterInputProtocol {
    
    // MARK: Properties

    weak var view: WebViewViewControllerInputProtocol?
    var wireframe: WebViewWireframeInputProtocol?
    var result: Result?

    // Implementations for input functions from view to presenter

    func onViewDidLoad() {
        
        if let r = result,
            let url = r.getURL() {
            
            self.view?.openWebView(url: url, title: result?.title ?? "")
        }
    }
    
    func userTapBackBtn() {
        
        if let from = view {
            
            self.wireframe?.close(view : from)
        }
    }
}
