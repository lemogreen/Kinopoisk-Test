//
//  DetailFilmInfoVC.swift
//  Kinopoisk
//
//  Created by Антон Коваленко on 21/10/2018.
//  Copyright © 2018 Антон Коваленко. All rights reserved.
//

import UIKit

class DetailFilmInfoVC: UIViewController {
    
    var filmData: Films.Film = Films.Film()
    
    @IBOutlet weak var topNavigationController: UINavigationItem!
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        
    }
    

    
    
    func setupView() {
        if let unwrappedFilmImage = filmData.image_url {
            filmImage.setImage(from: URL(string: unwrappedFilmImage)!, withPlaceholder: UIImage(named: "No_Image_Available"))
        } else {
            filmImage.image = UIImage(named: "No_Image_Available.png")
        }
        nameLbl.text = filmData.name
        topNavigationController.title = filmData.localized_name
        yearLbl.text = String(filmData.year)
        if let unwrappedRating = filmData.rating {
            ratingLbl.text = String(unwrappedRating)
        }
        if let unwrappedDescription = filmData.description {
            descriptionLbl.text = unwrappedDescription
        } else {
            descriptionLbl.text = "нет описания"
            descriptionLbl.sizeToFit()
        }
    }
    
    
    func setupData(filmData: Films.Film) {
        self.filmData = filmData

    }
        


}
