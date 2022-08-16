//
//  Summoner.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation

struct SummonerInfo: Decodable {
    let summoner: Summoner
}

struct Summoner: Decodable {
    let name: String
    let level: Int
    let profileImageURL: URL
    let profileBorderImageURL: String
    let url: String
    let leagues: [League]
    let previousTiers: [PreviousTier]
    let ladderRank: LadderRank
    let profileBackgroundImageURL: String

    enum CodingKeys: String, CodingKey {
        case name, level
        case profileImageURL = "profileImageUrl"
        case profileBorderImageURL = "profileBorderImageUrl"
        case url, leagues, previousTiers, ladderRank
        case profileBackgroundImageURL = "profileBackgroundImageUrl"
    }
}

struct LadderRank: Decodable {
    let rank, rankPercentOfTop: Int
}

struct League: Decodable, Equatable {
    let hasResults: Bool
    let wins, losses: Int
    let tierRank: PreviousTier
}

struct PreviousTier: Decodable, Equatable {
    let rankType: RankType
    let tier: String
    let imageURL: URL?
    let lp: Int

    init() {
        rankType = .solo
        tier = ""
        imageURL = nil
        lp = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case tier
        case rankType = "name"
        case imageURL = "imageUrl"
        case lp
    }
}

@frozen
enum RankType: String, Decodable {
    case solo = "솔랭"
    case flex = "자유 5:5 랭크"
    
    var text: String {
        switch self {
        case .solo:
            return "RankSolo".localized()
        case .flex:
            return "RankFlex".localized()
        }
    }
}
