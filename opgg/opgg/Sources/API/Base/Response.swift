//
//  Response.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation

class Response {
    let statusCode: Int
    let data: Data
    let urlRequest: URLRequest?
    let response: HTTPURLResponse?
    
    init(statusCode: Int, data: Data, request: URLRequest? = nil, response: HTTPURLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.urlRequest = request
        self.response = response
    }
}

extension Response {
    func map<D: Decodable>(_ type: D.Type, using decoder: JSONDecoder = JSONDecoder()) throws -> D {
        do {
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(D.self, from: data)
        } catch {
            throw APIError.objectMapping(error: error, response: self)
        }
    }
    
    func printJson() {
#if DEBUG
        guard let json = try? JSONSerialization.jsonObject(with: data) else {
            return
        }
        debugPrint(json)
#endif
    }
}
