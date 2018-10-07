//
//  Recipe.swift
//  RecipePuppy
//
//  Created by Lopez, Margaret on 5/10/18.
//  Copyright © 2018 Lopez, Margaret. All rights reserved.
//

import Foundation

class RecipePuppy: Codable {
    let title: String?
    let version: Double?
    let href: String?
    let results: [Result]?
    
    init(title: String?, version: Double?, href: String?, results: [Result]?) {
        self.title = title
        self.version = version
        self.href = href
        self.results = results
    }
}
