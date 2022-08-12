//
//  KDA.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import UIKit

struct MatchKDA {
    let kills: Float
    let deaths: Float
    let assists: Float
    let kdaRate: Float
    
    init(_ summary: Summary) {
        let totalGame = Float(summary.wins + summary.losses)
        kills = Float(summary.kills) / totalGame
        deaths = Float(summary.deaths) / totalGame
        assists = Float(summary.assists) / totalGame
        kdaRate = kills + assists / deaths
    }
}

extension MatchKDA {
    var kdaRateColor: UIColor {
        switch kdaRate {
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
    
    func kdaText(ofSize fontSize: CGFloat) -> NSAttributedString {
        .appendAttributedString([
            .stringToOption(String(format: "%.1f", kills),
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .bold)),
                                .foreground(color: .charcoalGrey)
                            ]),
            .stringToOption(" / ",
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .regular)),
                                .foreground(color: .charcoalGrey)
                            ]),
            .stringToOption(String(format: "%.1f", deaths),
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .bold)),
                                .foreground(color: .darkishPink)
                            ]),
            .stringToOption(" / ",
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .regular)),
                                .foreground(color: .charcoalGrey)
                            ]),
            .stringToOption(String(format: "%.1f", assists),
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .bold)),
                                .foreground(color: .charcoalGrey)
                            ])
        ])
    }
}
