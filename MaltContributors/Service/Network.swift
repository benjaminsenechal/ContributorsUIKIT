//
//  Network.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 26/10/2022.
//

import Foundation
import Combine

struct Network {
    struct Response<T> {
        let value:T
        let response:URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .eraseToAnyPublisher()
    }
    
    func runRequests<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<[T]>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<[T]> in
                let value = try decoder.decode([T].self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .eraseToAnyPublisher()
    }
}
