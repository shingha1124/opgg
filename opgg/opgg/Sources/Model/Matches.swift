//
//  Matchs.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation

struct Matches: Decodable {
    let games: [Game]
    let champions: [Champion]
    let positions: [Position]
    let summary: Summary
}

struct Champion: Decodable {
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
    let peak: [String]
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
    let imageURL: String
    let level: Int

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case level
    }
}

enum GameType: String, Decodable {
    case 무작위총력전 = "무작위 총력전"
    case 솔랭 = "솔랭"
    case 일반 = "일반"
    case 자유55랭크 = "자유 5:5 랭크"
}

struct Item: Decodable {
    let imageURL: String

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

enum LargestMultiKillString: String, Decodable {
    case doubleKill = "Double Kill"
    case empty = ""
}

enum OpScoreBadge: String, Decodable {
    case ace = "ACE"
    case empty = ""
}

struct Ward: Codable {
    let sightWardsBought, visionWardsBought: Int
}

enum TierRankShort: String, Decodable {
    case c1 = "C1"
}

struct Position: Decodable {
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
