//
//  BaseTarget.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Alamofire
import Foundation

protocol BaseTarget {
    var baseURL: URL? { get }
    var path: String { get }
    var parameter: [String: Any]? { get }
    var method: HTTPMethod { get }
}

extension BaseTarget {
    var baseURL: URL? {
        URL(string: "https://codingtest.op.gg")
    }

    var headers: [String: String]? {
        nil
    }

    var encoding: ParameterEncoding {
        (method == .get) ? URLEncoding.default : JSONEncoding.default
    }
}
