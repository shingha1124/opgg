//
//  Matchs.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import UIKit

struct Matches: Decodable {
    let games: [Game]
    let champions: [Champion]
    let positions: [Position]
    let summary: Summary
}

struct Champion: Decodable, Equatable {
    let id: Int
    let key, name: String
    let imageURL: URL
    let games, kills, deaths, assists: Int
    let wins, losses: Int

    enum CodingKeys: String, CodingKey {
        case id, key, name
        case imageURL = "imageUrl"
        case games, kills, deaths, assists, wins, losses
    }
}

struct Game: Decodable {
    let mmr: Int?
    let champion: GameChampion
    let spells, items: [Item]
    let needRenew: Bool
    let gameID: String
    let createDate, gameLength: Int
    let gameType: GameType
    let summonerID: String
    let summonerName: String
    let tierRankShort: TierRankShort
    let stats: Stats
    let peak: [URL]
    let isWin: Bool

    enum CodingKeys: String, CodingKey {
        case mmr, champion, spells, items, needRenew
        case gameID = "gameId"
        case createDate, gameLength, gameType
        case summonerID = "summonerId"
        case summonerName, tierRankShort, stats, peak, isWin
    }
}

struct GameChampion: Decodable {
    let imageURL: URL
    let level: Int

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case level
    }
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

struct Item: Decodable {
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}

struct Stats: Decodable {
    let general: General
    let ward: Ward
}

struct General: Decodable {
    let kill, death, assist: Int
    let kdaString: String
    let cs: Int
    let csPerMin: Double
    let contributionForKillRate: String
    let goldEarned, totalDamageDealtToChampions: Int
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
    
    var color: UIColor {
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
    
    var color: UIColor {
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

struct Ward: Codable {
    let sightWardsBought, visionWardsBought: Int
}

enum TierRankShort: String, Decodable {
    case c1 = "C1"
}

struct Position: Decodable, Equatable {
    let games, wins, losses: Int
    let type: PositionType
    let positionName: String
    
    enum CodingKeys: String, CodingKey {
        case games, wins, losses, positionName
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
