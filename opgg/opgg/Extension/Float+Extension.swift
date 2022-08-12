//
//  Float+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import UIKit

extension Float {
    func kdaRateColor() -> UIColor {
        switch self {
        case let value where value < 3:
            return .steelGrey
        case let value where value < 4:
            return .greenBlue
        case let value where value < 5:
            return .softBlue
        default:
            return .darkishPink
        }
    }
}
