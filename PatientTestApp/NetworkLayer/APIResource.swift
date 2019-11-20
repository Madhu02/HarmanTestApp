//
//  APIResource.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

struct Resource<A: Decodable> {
    let url: URL
    let method: HttpMethod<Data>
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, method: HttpMethod<Data> = .get, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method.map { json in
            json
        }
        self.parse = { data in
            do{
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(A.self, from: data)
                return responseData
            } catch {
                print(error)
            }
            return nil
        }
    }
}

enum Result<A> {
    case success(A, Data)
    case error(Error?, Data?)
    ///Intializer for Result
    init(_ value: A, data: Data) {
        self = .success(value, data)
    }
    init(error: Error, data: Data?) {
        self = .error(error, data)
    }

}

extension Result {
    func map<B>(_ transform: (A) -> B) -> Result<B> {
        switch self {
        case .success(let value, let data): return .success(transform(value), data)
        case .error(let error, let data): return .error(error, data)
        }
    }
}

