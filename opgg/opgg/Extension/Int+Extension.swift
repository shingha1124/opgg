//
//  Int+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import UIKit

protocol Currency { }

extension Currency {
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let stringPrice = formatter.string(for: self) else {
            return ""
        }
        return stringPrice
    }
}

extension UInt: Currency { }
extension Int: Currency { }

extension Int {
    func winRateColor() -> UIColor {
        self >= 60 ? .darkishPink : .steelGrey
    }
}
