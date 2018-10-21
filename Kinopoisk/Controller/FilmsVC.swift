//
//  ViewController.swift
//  Kinopoisk
//
//  Created by Антон Коваленко on 21/10/2018.
//  Copyright © 2018 Антон Коваленко. All rights reserved.
//

import UIKit

class FilmsVC: UITableViewController {
    
    var films: [Films.Film] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        JSONDownloader()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    func JSONDownloader() {
        URLSession.shared.dataTask(with: SOURCE_URL) { (data, response, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            
            guard response != nil else {
                print("no response JSON")
                return
            }
            
            guard let data = data else {
                print("no JSON data")
                return
            }
            
            do {
                let JSONString = String(data: data, encoding: .utf8)!
                let decodedData = JSONString.data(using: .utf8)!
                let decoder = JSONDecoder()
                let films = try decoder.decode(Films.self, from: decodedData)
                self.films = films.films
                print(films.films[0].description)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error as Any)
                
            }
        }.resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell") as? FilmCell else {
            return UITableViewCell()
        }
        let filmForRow = films[indexPath.row]
        cell.configureCell(localisedName: filmForRow.localized_name, originalName: filmForRow.name, rating: filmForRow.rating)
        return cell
        
    }

    
    
    
    

}


