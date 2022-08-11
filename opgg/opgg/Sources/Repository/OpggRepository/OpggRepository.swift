//
//  OpggRepository.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation
import RxSwift

protocol OpggRepository {
    func requestSummonerInfo() -> Single<Result<SummonerInfo, APIError>>
}
