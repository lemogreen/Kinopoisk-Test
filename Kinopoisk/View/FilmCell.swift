//
//  FilmCell.swift
//  Kinopoisk
//
//  Created by Антон Коваленко on 21/10/2018.
//  Copyright © 2018 Антон Коваленко. All rights reserved.
//

import UIKit

class FilmCell: UITableViewCell {
    
    
    
    @IBOutlet weak var localisedNameLbl: UILabel!
    @IBOutlet weak var originalNameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
    
    func configureCell(localisedName: String, originalName: String, rating: Double?) {
        self.localisedNameLbl.text = localisedName
        self.originalNameLbl.text = originalName
        if let unwrappedRating = rating {
            self.ratingLbl.text = String(unwrappedRating)
        }
    }

}
