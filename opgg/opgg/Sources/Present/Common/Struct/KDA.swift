//
//  KDA.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import SwiftUI

struct KDA {
    let kill: Float
    let death: Float
    let assist: Float
    let rate: Float
    
    init() {
        kill = 0
        death = 0
        assist = 0
        rate = 0
    }
    
    init(_ summary: Summary) {
        let total = Float(summary.wins + summary.losses)
        kill = Float(summary.kills) / total
        death = Float(summary.deaths) / total
        assist = Float(summary.assists) / total
        rate = kill + assist / death
    }
    
    init(_ general: General) {
        kill = Float(general.kill)
        death = Float(general.death)
        assist = Float(general.assist)
        rate = kill + assist / death
    }
}

extension KDA {
    var rateColor: Color {
        switch rate {
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
