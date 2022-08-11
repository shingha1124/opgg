//
//  OpggTarget.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Alamofire
import Foundation

enum OpggTarget {
    case requestSummonerInfo
    case requestMatches(lastMatch: UInt64?)
}

extension OpggTarget: BaseTarget {
    var path: String {
        switch self {
        case .requestSummonerInfo:
            return "/api/summoner/genetory"
        case .requestMatches(let lastMatch):
            if let lastMatch = lastMatch {
                return "/api/summoner/genetory/matches?lastMatch=\(lastMatch)"
            } else {
                return "/api/summoner/genetory/matches"
            }
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .requestSummonerInfo, .requestMatches:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestSummonerInfo, .requestMatches:
            return .get
        }
    }
}
