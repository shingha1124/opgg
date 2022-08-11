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
        self.kf.setImage(with: resource)
    }
}
