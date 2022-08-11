//
//  NetworkRepository.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation

class NetworkRepository<Target: BaseTarget> {
    let provider = Provider<Target>()
}
