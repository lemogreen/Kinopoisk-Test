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
    }
    let films: [Film]
}
