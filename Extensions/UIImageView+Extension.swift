//
//  UIImageView+Extension.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import UIKit

extension UIImageView   {
    func downloadImage(urlString: String) {
        let url = URL(string: urlString)
        guard let urlUnwrapped = url else {return}
        URLSession.shared.dataTask(with: urlUnwrapped) { (data, response, error) in
            guard let data = data, error == nil  else {return}
            mainQueue({
                self.image = UIImage(data: data)
            })
        }.resume()
    }
}
