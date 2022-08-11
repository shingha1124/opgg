//
//  Response+Reactive.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element == Result<Response, APIError> {

    func map<T: Decodable>(_ type: T.Type) -> Single<Result<T, APIError>> {
        let response = filterSuccessStatusCode()
            .map { result -> Result<T, APIError> in
                result.flatMap { response in
                    do {
                        let item = try response.map(type)
                        return .success(item)
                    } catch {
                        let apiError = (error as? APIError) ?? APIError.underlying(error: error, response: response)
                        return .failure(apiError)
                    }
                }
            }

        return response.flatMap { result in .just(result) }
        .do(onSuccess: { result in
            if case .failure(let error) = result {
                Log.error("APIError : \(error)")
            }
        })
    }
    
    func mapVoid() -> Single<Result<Void, APIError>> {
        let response = filterSuccessStatusCode()
            .map { result -> Result<Void, APIError> in
                result.map { _ in Void() }
            }

        return response.flatMap { result in .just(result) }
        .do(onSuccess: { result in
            if case .failure(let error) = result {
                Log.error("APIError : \(error)")
            }
        })
    }
    
    private func filterSuccessStatusCode() -> Single<Result<Response, APIError>> {
        self.map { result -> Result<Response, APIError> in
            result.flatMap { response in
                if (200...299).contains(response.statusCode) {
                    return .success(response)
                }
                
                return .failure(APIError.statusCode(response: response))
            }
        }
    }
}
