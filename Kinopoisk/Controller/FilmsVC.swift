//
//  ViewController.swift
//  Kinopoisk
//
//  Created by Антон Коваленко on 21/10/2018.
//  Copyright © 2018 Антон Коваленко. All rights reserved.
//

import UIKit

class FilmsVC: UITableViewController {
    
    var film = Films.Film()
    

    lazy var refreshDataStatus: UIRefreshControl = {
        let refreshDataStatus = UIRefreshControl()
        refreshDataStatus.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshDataStatus.tintColor = UIColor.black
        
        return refreshDataStatus
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        JSONDownloader {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        JSONDownloader {}
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.addSubview(self.refreshDataStatus)
    }
    
    func JSONDownloader(compleationHandler: @escaping () -> Void) {
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
            compleationHandler()
            
            do {
                let JSONString = String(data: data, encoding: .utf8)!
                let decodedData = JSONString.data(using: .utf8)!
                let decoder = JSONDecoder()
                let films = try decoder.decode(Films.self, from: decodedData)
                FilmData.instance.films = films.films
                
                let groupedByYear = Dictionary(grouping: FilmData.instance.films, by: { (film) -> Int in
                    film.year
                })
                FilmData.instance.keys = groupedByYear.keys.sorted()
                FilmData.instance.keys.forEach({ (key) in
                    FilmData.instance.groupedFilms.append(groupedByYear[key]!)
                })
                for i in 0..<FilmData.instance.groupedFilms.count {
                    FilmData.instance.groupedFilms[i].sort(by: { (first, second) -> Bool in
                        guard let firstFilmUnwrappedRating = first.rating else {return true}
                        guard let secondFilmUnwrappedRating = second.rating else {return false}
                        
                        if firstFilmUnwrappedRating > secondFilmUnwrappedRating {
                            return true
                        } else {
                            return false
                        }
                    })
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error as Any)
                
            }
            }.resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return FilmData.instance.keys.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilmData.instance.groupedFilms[section].count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FILM_CELL) as? FilmCell else {
            return UITableViewCell()
        }
        let filmForRow = FilmData.instance.groupedFilms[indexPath.section][indexPath.row]
        cell.configureCell(localisedName: filmForRow.localized_name, originalName: filmForRow.name, rating: filmForRow.rating)
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed(HEADER_VIEW, owner: self, options: nil)?.first as! HeaderView
        headerView.yearLbl.text = String(FilmData.instance.keys[section])
        return headerView
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ToDetailFilmInfoVC = storyboard?.instantiateViewController(withIdentifier: DETAIL_FILM_INFO) as? DetailFilmInfoVC else {return}
        film = FilmData.instance.groupedFilms[indexPath.section][indexPath.row]
        ToDetailFilmInfoVC.setupData(filmData: film)
        performSegue(withIdentifier: TO_DETAIL_FILM_INFO, sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailFilmInfoVC
        {
            let DetailFilmInfoVC = segue.destination as? DetailFilmInfoVC
            DetailFilmInfoVC?.filmData = film
        }
    }
    
    
}


