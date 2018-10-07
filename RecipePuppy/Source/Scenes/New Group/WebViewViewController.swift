//
//  WebViewViewController.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 7/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import UIKit
import WebKit
// MARK: - Protocols

protocol WebViewViewControllerInputProtocol: class {
    var presenter: WebViewPresenterInputProtocol? { get set }

    func openWebView(url: URL, title: String)
}

// MARK: - Class Implementation

final class WebViewViewController: UIViewController, WKNavigationDelegate {
    // MARK: Properties
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tilte: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: WebViewPresenterInputProtocol?

    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showActivityIndicator()
        self.presenter?.onViewDidLoad()
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hiddenActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showActivityIndicator()
    }
    
    // MARK: - Actions
    
    @IBAction func backAction(_ sender: Any) {
        self.presenter?.userTapBackBtn()
    }
    
    // MARK: - Utils
        
    func hiddenActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.webView.alpha = 1.0
            self.activityIndicator.alpha = 0.0
        }) { (_) in
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.webView.alpha = 0.0
            self.activityIndicator.alpha = 1.0
        }) { (_) in
            self.activityIndicator.startAnimating()
        }
    }
}

// MARK: - ViewProtocol

extension WebViewViewController: WebViewViewControllerInputProtocol {

    func openWebView(url: URL, title: String) {
        
        self.webView.navigationDelegate = self
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.load(URLRequest(url: url))
        
        self.tilte.text = title
    }
}
