//
//  Typealias.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import UIKit

struct MatchRecord {
    let wins: Int
    let losses: Int
    let winRate: Int
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
        let totalGame = wins + losses
        if wins == 0 || totalGame == 0 {
            winRate = 0
        } else {
            winRate = Int((Float(wins) / Float(totalGame)) * 100)
        }
    }
    
    init(_ league: League) {
        self.init(wins: league.wins, losses: league.losses)
    }
    
    init(_ summary: Summary) {
        self.init(wins: summary.wins, losses: summary.losses)
    }
    
    init(_ champion: Champion) {
        self.init(wins: champion.wins, losses: champion.losses)
    }
    
    init(_ position: Position) {
        self.init(wins: position.wins, losses: position.losses)
    }
}

extension MatchRecord {
    var winRateColor: UIColor {
        winRate >= 60 ? .darkishPink : .steelGrey
    }
    
    func text(ofSize fontSize: CGFloat) -> NSAttributedString {
        .appendAttributedString([
            .stringToOption("\(self.wins)", attributes: [.font(.systemFont(ofSize: fontSize))]),
            .stringToOption("Wins".localized(), attributes: [.font(.appleSDGothicNeo(ofSize: fontSize))]),
            .stringToOption(" \(self.losses)", attributes: [.font(.systemFont(ofSize: fontSize))]),
            .stringToOption("Losses".localized(), attributes: [.font(.appleSDGothicNeo(ofSize: fontSize))])
        ])
    }
}
