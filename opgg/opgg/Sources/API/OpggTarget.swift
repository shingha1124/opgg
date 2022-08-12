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
    case requestMatches(lastMatch: Int?)
}

extension OpggTarget: BaseTarget {
    var path: String {
        switch self {
        case .requestSummonerInfo:
            return "/api/summoner/genetory"
        case .requestMatches:
            return "/api/summoner/genetory/matches"
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .requestSummonerInfo:
            return nil
        case .requestMatches(let lastMatch):
            if let lastMatch = lastMatch {
                return ["lastMatch": lastMatch]
            }
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
