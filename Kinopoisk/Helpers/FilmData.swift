//
//  FilmData.swift
//  Kinopoisk
//
//  Created by Антон Коваленко on 21/10/2018.
//  Copyright © 2018 Антон Коваленко. All rights reserved.
//

import Foundation

class FilmData {
    
    static let instance = FilmData()
    
    public var films: [Films.Film] = []
    public var keys: [Int] = []
    public var groupedFilms: [[Films.Film]] = [[Films.Film]]()
}
