//
//  Typealias.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import SwiftUI

struct WinRate {
    let wins: Int
    let losses: Int
    let rate: Int
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
        let totalGame = wins + losses
        if wins == 0 || totalGame == 0 {
            rate = 0
        } else {
            rate = Int((Float(wins) / Float(totalGame)) * 100)
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

extension WinRate {
    var rateColor: Color {
        rate >= 60 ? .darkishPink : .steelGrey
    }
}
