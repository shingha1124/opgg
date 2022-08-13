//
//  UIFont+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import UIKit

extension UIFont {
    static func appleSDGothicNeo(ofSize size: CGFloat, weight: Weight = .regular) -> UIFont {
        guard let font = UIFont(name: "AppleSDGothicNeo-\(weight.stringWeight)", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
        return font
    }
}

extension UIFont.Weight {
    var stringWeight: String {
        switch self {
        case .bold:
            return "Bold"
        case .regular:
            return "Regular"
        default:
            return "Regular"
        }
    }
}
