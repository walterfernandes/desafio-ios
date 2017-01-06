//
//  UIImageView+Desafio.swift
//  Desafio
//
//  Created by Walter Fernandes de Carvalho on 05/01/17.
//  Copyright © 2017 Walter Fernandes de Carvalho. All rights reserved.
//

import UIKit
import AlamofireImage

class AvatarImageView: UIImageView {
    
    let downloader = ImageDownloader()
    let imageCache = AutoPurgingImageCache()

    func setImage(with url: URL) {
        
        let urlRequest = URLRequest(url: url)
        let identifier = "\(self.bounds.size.width)x\(self.bounds.size.height)"
        
        if let cachedImage = imageCache.image(for: urlRequest, withIdentifier: identifier) {
            self.image = cachedImage
        } else {
            downloader.download(urlRequest) { response in
                
                if let image = response.result.value {
                    let avatarImage = image.af_imageRoundedIntoCircle()
                    
                    self.imageCache.add(avatarImage, for: urlRequest, withIdentifier: identifier)
                    self.image = avatarImage
                }
            }
        }
    }
    
}
