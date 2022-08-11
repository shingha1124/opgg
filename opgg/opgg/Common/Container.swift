//
//  Container.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation

class Container {
    static var shared = Container()
    
    private init() { }
    
    let opggRepository: OpggRepository = OpggRepositoryImpl()
}
