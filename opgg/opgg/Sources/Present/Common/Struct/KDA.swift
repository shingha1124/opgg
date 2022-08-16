//
//  KDA.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import SwiftUI

protocol KDA { }

extension KDA {
    func kdaAttributedString(kill: String, death: String, assist: String, ofSize fontSize: CGFloat) -> NSAttributedString {
        .appendAttributedString([
            .stringToOption(kill,
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .bold)),
                                .foreground(color: .charcoalGrey)
                            ]),
            .stringToOption(" / ",
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .regular)),
                                .foreground(color: .charcoalGrey)
                            ]),
            .stringToOption(death,
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .bold)),
                                .foreground(color: .darkishPink)
                            ]),
            .stringToOption(" / ",
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .regular)),
                                .foreground(color: .charcoalGrey)
                            ]),
            .stringToOption(assist,
                            attributes: [
                                .font(.systemFont(ofSize: fontSize, weight: .bold)),
                                .foreground(color: .charcoalGrey)
                            ])
        ])
    }
}

struct MatchKDA: KDA {
    let kills: Float
    let deaths: Float
    let assists: Float
    let kdaRate: Float
    
    init() {
        kills = 0
        deaths = 0
        assists = 0
        kdaRate = 0
    }
    
    init(_ summary: Summary) {
        let total = Float(summary.wins + summary.losses)
        kills = Float(summary.kills) / total
        deaths = Float(summary.deaths) / total
        assists = Float(summary.assists) / total
        kdaRate = kills + assists / deaths
    }
    
    func kdaText(ofSize fontSize: CGFloat) -> NSAttributedString {
        kdaAttributedString(
            kill: String(format: "%.1f", kills),
            death: String(format: "%.1f", deaths),
            assist: String(format: "%.1f", assists),
            ofSize: fontSize
        )
    }
}

struct GameKDA: KDA {
    let kill: Int
    let death: Int
    let assist: Int
    
    init(_ general: General) {
        kill = general.kill
        death = general.death
        assist = general.assist
    }
    
    func kdaText(ofSize fontSize: CGFloat) -> NSAttributedString {
        kdaAttributedString(
            kill: "\(kill)",
            death: "\(death)",
            assist: "\(assist)",
            ofSize: fontSize
        )
    }
}

extension MatchKDA {
    var kdaRateUIColor: UIColor {
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
    
    var kdaRateColor: Color {
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
}
