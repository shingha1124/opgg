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
}

extension OpggTarget: BaseTarget {
    var path: String {
        switch self {
        case .requestSummonerInfo:
            return "/api/summoner/genetory"
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .requestSummonerInfo:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestSummonerInfo:
            return .get
        }
    }
}
