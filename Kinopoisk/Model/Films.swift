//
//  Films.swift
//  Kinopoisk
//
//  Created by Антон Коваленко on 21/10/2018.
//  Copyright © 2018 Антон Коваленко. All rights reserved.
//

import Foundation


struct Films: Codable {
    struct Film: Codable {
        let id: Int
        let localized_name: String
        let name: String
        let year: Int
        let rating: Double?
        let image_url: String?
        let description: String?
        
        init() {
            self.id = 0
            self.localized_name = ""
            self.name = ""
            self.year = 0
            self.rating = 0
            self.image_url = ""
            self.description = ""
        }
    }
    let films: [Film]
}
