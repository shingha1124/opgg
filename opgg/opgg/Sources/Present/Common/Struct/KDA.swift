//
//  KDA.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import SwiftUI

protocol KDA { }

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
}

extension MatchKDA {    
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
