//
//  Matchs.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import SwiftUI
import UIKit

struct Matches: Decodable {
    let games: [Game]
    let champions: [Champion]
    let positions: [Position]
    let summary: Summary
}

struct Champion: Decodable, Equatable {
    let imageUrl: URL
    let kills, deaths, assists: Int
    let wins, losses: Int
}

struct Game: Decodable {
    let champion: GameChampion
    let spells, items: [Item]
    let createDate, gameLength: Int
    let gameType: GameType
    let stats: Stats
    let peak: [URL]
    let isWin: Bool
}

struct GameChampion: Decodable {
    let imageUrl: URL
    let level: Int
}

@frozen
enum GameType: String, Decodable {
    case aram = "무작위 총력전"
    case rank = "솔랭"
    case normal = "일반"
    case flex = "자유 5:5 랭크"
    
    var name: String {
        switch self {
        case .aram:
            return "Aram".localized()
        case .rank:
            return "RankSolo".localized()
        case .normal:
            return "Normal".localized()
        case .flex:
            return "RankFlex".localized()
        }
    }
}

struct Item: Decodable, Equatable {
    let imageUrl: URL
}

struct Stats: Decodable {
    let general: General
}

struct General: Decodable {
    let kill, death, assist: Int
    let contributionForKillRate: String
    let largestMultiKillString: LargestMultiKillString
    let opScoreBadge: OpScoreBadge
}

@frozen
enum LargestMultiKillString: String, Decodable {
    case doubleKill = "Double Kill"
    case empty = ""
    
    var name: String {
        switch self {
        case .doubleKill:
            return "DoubleKill".localized()
        case .empty:
            return ""
        }
    }
    
    var uiColor: UIColor {
        switch self {
        case .doubleKill:
            return .darkishPink
        case .empty:
            return .clear
        }
    }
    
    var color: Color {
        switch self {
        case .doubleKill:
            return .darkishPink
        case .empty:
            return .clear
        }
    }
}

@frozen
enum OpScoreBadge: String, Decodable {
    case ace = "ACE"
    case mvp = "MVP"
    case empty = ""
    
    var name: String {
        rawValue
    }
    
    var uiColor: UIColor {
        switch self {
        case .ace:
            return .periwinkle
        case .mvp:
            return .orangeYellow
        case .empty:
            return .clear
        }
    }
    
    var color: Color {
        switch self {
        case .ace:
            return .periwinkle
        case .mvp:
            return .orangeYellow
        case .empty:
            return .clear
        }
    }
}

struct Position: Decodable, Equatable {
    let games, wins, losses: Int
    let type: PositionType
    
    enum CodingKeys: String, CodingKey {
        case games, wins, losses
        case type = "position"
    }
}

@frozen
enum PositionType: String, Decodable {
    case top = "TOP"
    case jungle = "JNG"
    case middle = "MID"
    case bottom = "ADC"
    case support = "SUP"
    
    var imageName: String {
        switch self {
        case .top:
            return "iconLolTop"
        case .jungle:
            return "iconLolJng"
        case .middle:
            return "iconLolMid"
        case .bottom:
            return "iconLolBot"
        case .support:
            return "iconLolSup"
        }
    }
}

struct Summary: Decodable {
    let wins, losses, kills, deaths: Int
    let assists: Int
}
