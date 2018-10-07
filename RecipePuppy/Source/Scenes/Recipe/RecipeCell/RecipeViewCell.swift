//
//  RecipeCollectionViewCell.swift
//  RecipePuppy
//
//  Created by Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import UIKit

class RecipeViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var ImageBg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    var result: Result!

    
    static func createCell(tableView: UITableView) -> RecipeViewCell {
        let cellIdentifer = "recipeCellIdentifier"
        
        guard let cell = Bundle.main.loadNibNamed("RecipeViewCell", owner: self, options: nil)? [0] as?
            RecipeViewCell else {
                return RecipeViewCell()
        }
        
        let uiNinb = UINib(nibName: "RecipeViewCell", bundle: nil)
        tableView.register(uiNinb, forCellReuseIdentifier: cellIdentifer)
        
        return cell
    }
    
    func configureCell(result: Result) {
        self.recipeView.layer.cornerRadius = 5.0
        self.ImageBg.image = result.getImage()
        self.title.text = result.title ?? ""
        self.ingredients.text = result.ingredients ?? ""
    }
}
