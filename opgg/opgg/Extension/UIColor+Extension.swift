//
//  UIColor+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import UIKit
import SwiftUI

extension Color {
    static let coolGrey = color(r: 152, g: 160, b: 167)
    static let greenBlue = color(r: 10, g: 197, b: 142)
    static let darkishPink = color(r: 232, g: 64, b: 87)
    static let steelGrey = color(r: 123, g: 133, b: 142)
    static let paleGrey = color(r: 247, g: 247, b: 249)
    static let paleGrey2 = color(r: 235, g: 238, b: 241)
    static let orangeYellow = color(r: 255, g: 169, b: 5)
    static let gunmetal = color(r: 82, g: 89, b: 95)
    static let periwinkle = color(r: 139, g: 104, b: 255)
    static let charcoalGrey = color(r: 51, g: 56, b: 60)
    static let softBlue = color(r: 83, g: 131, b: 232)
    static let darkgrey = color(r: 30, g: 32, b: 34)
    
    private static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> Color {
        Color(.sRGB, red: r / 255, green: g / 255, blue: b / 255, opacity: a)
    }
}

extension UIColor {
    static let coolGrey = color(r: 152, g: 160, b: 167)
    static let greenBlue = color(r: 10, g: 197, b: 142)
    static let darkishPink = color(r: 232, g: 64, b: 87)
    static let steelGrey = color(r: 123, g: 133, b: 142)
    static let paleGrey = color(r: 247, g: 247, b: 249)
    static let paleGrey2 = color(r: 235, g: 238, b: 241)
    static let orangeYellow = color(r: 255, g: 169, b: 5)
    static let gunmetal = color(r: 82, g: 89, b: 95)
    static let periwinkle = color(r: 139, g: 104, b: 255)
    static let charcoalGrey = color(r: 51, g: 56, b: 60)
    static let softBlue = color(r: 83, g: 131, b: 232)
    static let darkgrey = color(r: 30, g: 32, b: 34)
    
    private static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
