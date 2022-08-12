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
        winRate = Int((Float(wins) / Float(wins + losses)) * 100)
    }
    
    init(_ league: League) {
        wins = league.wins
        losses = league.losses
        winRate = Int((Float(wins) / Float(wins + losses)) * 100)
    }
    
    init(_ summary: Summary) {
        wins = summary.wins
        losses = summary.losses
        winRate = Int((Float(wins) / Float(wins + losses)) * 100)
    }
    
    init(_ champion: Champion) {
        wins = champion.wins
        losses = champion.losses
        winRate = Int((Float(wins) / Float(wins + losses)) * 100)
    }
    
    init(_ position: Position) {
        wins = position.wins
        losses = position.losses
        winRate = Int((Float(wins) / Float(wins + losses)) * 100)
    }
}

extension MatchRecord {
    var winRateColor: UIColor {
        winRate >= 60 ? .darkishPink : .steelGrey
    }
    
    func text(ofSize fontSize: CGFloat) -> NSAttributedString {
        .appendAttributedString([
            .stringToOption("\(self.wins)", attributes: [.font(.systemFont(ofSize: fontSize))]),
            .stringToOption("승", attributes: [.font(.appleSDGothicNeo(ofSize: fontSize))]),
            .stringToOption(" \(self.losses)", attributes: [.font(.systemFont(ofSize: fontSize))]),
            .stringToOption("패", attributes: [.font(.appleSDGothicNeo(ofSize: fontSize))])
        ])
    }
}
