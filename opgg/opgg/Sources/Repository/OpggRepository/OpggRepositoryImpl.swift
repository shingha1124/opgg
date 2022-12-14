//
//  OpggRepositoryImpl.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation
import RxSwift

final class OpggRepositoryImpl: NetworkRepository<OpggTarget>, OpggRepository {
    func requestSummonerInfo() -> Single<Result<SummonerInfo, APIError>> {
        provider
            .request(.requestSummonerInfo)
            .map(SummonerInfo.self)
    }
    
    func requestMatches(lastMatch: Int?) -> Single<Result<Matches, APIError>> {
        provider
            .request(.requestMatches(lastMatch: lastMatch))
            .map(Matches.self)
    }
}
