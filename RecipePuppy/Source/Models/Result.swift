//
//  Result.swift
//  RecipePuppy
//
//  Created by Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import Foundation
import UIKit

class Result: Codable {
    
    let title: String?
    let href: String?
    let ingredients: String?
    let thumbnail: String?
    var url: URL?
    
    init(title: String?, href: String?, ingredients: String?, thumbnail: String?) {
        self.title = title
        self.href = href
        self.ingredients = ingredients
        self.thumbnail = thumbnail
    }
    
    func getImage() -> UIImage {
        
        if let image: UIImage = UIImage(named: "recipeBG") {
            
            if let name = self.thumbnail,
                let nameURL = URL(string: name) {

                guard let data = try? Data(contentsOf: nameURL) else { return image }
                
                return UIImage(data: data) ?? image
            }
        }
        
        return UIImage()
    }
    
    func getURL() -> URL? {
        
        if let url = href,
            let nameURL = URL(string: url) {
         
            return nameURL
        }
        
        return nil
    }
}
