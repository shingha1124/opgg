//
//  UIFont+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import SwiftUI

extension Font {
    static func appleSDGothicNeo(ofSize size: CGFloat, weight: Weight = .regular) -> Font {
        .custom("AppleSDGothicNeo-\(weight.stringWeight)", size: size)
    }
}

extension Font.Weight {
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
