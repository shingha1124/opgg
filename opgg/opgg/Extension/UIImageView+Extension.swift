//
//  UIImageView+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(_ url: URL) {
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        kf.setImage(with: resource)
    }
    
    func setImageWithIndicator(_ url: URL, time: CGFloat) {
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        kf.indicatorType = .activity
        kf.setImage(
            with: resource,
            options: [.transition(.fade(1.2))]
        )
    }
}
