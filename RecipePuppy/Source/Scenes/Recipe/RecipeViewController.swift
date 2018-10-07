//
//  RecipeViewController.swift
//  RecipePuppy
//
//  Created Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol RecipeViewControllerInputProtocol: class {
    var presenter: RecipePresenterInputProtocol? { get set }
    
    func showResults(result: [Result])
    
    func foundError()
    
    func hiddenActivityIndicator()
    
    func showActivityIndicator()
}

// MARK: - Class Implementation

class RecipeViewController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var containterTitle: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var searchBarTopConstraint: NSLayoutConstraint!
    
    var presenter: RecipePresenterInputProtocol?
    
    var results = [Result]()
    var resultFilter = [Result]()
    var inModeFilter: Bool = false
    var numberPagination: Int = 1
    var lowerSearchText: String = ""
    var downloadsInProgress: Bool = false
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        self.presenter?.onViewDidLoad()
    }
    
    func configView() {
        
        activityIndicator.startAnimating()
        tableView.alpha = 0.0
        
        searchBarTopConstraint.isActive = false
        searchBar.isHidden = true
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    // UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" {
            
            self.clearTableView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            
            if self.lowerSearchText.lowercased() != searchBar.text?.lowercased() {
                
                self.numberPagination = 1
                self.clearTableView()
            }
            
            self.lowerSearchText = searchBar.text!.lowercased()
            
            self.presenter?.searchRecipe(ingredients: lowerSearchText, page: numberPagination)
        } else {
            
            self.clearTableView()
            view.endEditing(true)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RecipeViewCell = RecipeViewCell.createCell(tableView: tableView)
        
        cell.configureCell(result: results[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let resultSelected: Result?
        resultSelected = results[indexPath.row]
        
        if let result = resultSelected {
            
            self.presenter?.openDetail(result: result)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        
        if isReachingEnd && !downloadsInProgress {
                   
            self.numberPagination += 1
            self.downloadsInProgress = true
            self.presenter?.searchRecipe(ingredients: lowerSearchText, page: numberPagination)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func searchAction(_ sender: UIButton) {
        
        searchBarTopConstraint.isActive = true
        searchBar.isHidden = false
    }
    
    // MARK: - Utils
    
    func clearTableView() {
        
        self.lowerSearchText = ""
        self.numberPagination = 1
        self.results.removeAll()
        self.tableView.reloadData()
        self.tableView.setContentOffset(.zero, animated: true)
    }

}

// MARK: - ViewProtocol

extension RecipeViewController: RecipeViewControllerInputProtocol {
    
    func showResults(result: [Result]) {
        self.results += result
        self.tableView.reloadData()
        self.tableView.tableFooterView?.isHidden = true
        self.downloadsInProgress = false
    }
    
    func foundError() {
        
        let alertController: UIAlertController = UIAlertController(title: "Oops!", message: "We found some errors in the search", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func hiddenActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.tableView.alpha = 1.0
            self.activityIndicator.alpha = 0.0
        }) { (_) in
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.tableView.alpha = 0.0
            self.activityIndicator.alpha = 1.0
        }) { (_) in
            self.activityIndicator.startAnimating()
        }
    }
}
