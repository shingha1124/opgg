//
//  UIFont+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import UIKit

extension UIFont {
    static let appleSDGothicNeo: UIFont = {
        guard let font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0) else {
            return UIFont.systemFont(ofSize: 12.0)
        }
        return font
    }()
}
