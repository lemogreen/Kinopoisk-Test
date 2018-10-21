//
//  WebImageDownloaderExtension.swift
//  Kinopoisk
//
//  Created by Антон Коваленко on 21/10/2018.
//  Copyright © 2018 Антон Коваленко. All rights reserved.
//

import UIKit



extension UIImageView {
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            
            guard response != nil else {
                print("image no response")
                return
            }
            
            guard let data = data else {
                print("no image data")
                return
            }
            
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
            }
        }.resume()
    }
}
