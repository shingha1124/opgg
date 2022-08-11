//
//  Provider.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Alamofire
import Foundation
import RxSwift

final class Provider<Target: BaseTarget> {

    private static func createRequest(_ target: Target) throws -> URLRequest? {
        guard let url = target.baseURL?.appendingPathComponent(target.path) else {
            return nil
        }
        var request = try URLRequest(url: url, method: target.method)
        target.headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return try target.encoding.encode(request, with: target.parameter)
    }
    
    func request(_ target: Target) -> Single<Swift.Result<Response, APIError>> {
        Single.create { observer in
            guard let request = try? Self.createRequest(target) else {
                let error = APIError.custom(message: "APIError", debugMessage: "Request가 제대로 생성되지 않았습니다.")
                observer(.success(.failure(error)))
                return Disposables.create { AF.session.invalidateAndCancel() }
            }
            
            AF.request(request)
                .response { dataResponse in
                    switch (dataResponse.response, dataResponse.data, dataResponse.error) {
                    case let (.some(urlResponse), data, .none):
                        let response = Response(statusCode: urlResponse.statusCode, data: data ?? Data(), request: request, response: urlResponse)
                        observer(.success(.success(response)))

                    case let (.some(urlResponse), _, .some(error)):
                        let response = Response(statusCode: urlResponse.statusCode, data: Data(), request: request, response: urlResponse)
                        let apiError = APIError.underlying(error: error, response: response)
                        observer(.success(.failure(apiError)))

                    case let (_, _, .some(error)):
                        let apiError = APIError.underlying(error: error, response: nil)
                        observer(.success(.failure(apiError)))

                    default:
                        let apiError = APIError.underlying(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), response: nil)
                        observer(.success(.failure(apiError)))
                    }
                }
            
            return Disposables.create { AF.session.invalidateAndCancel() }
        }
    }
}
