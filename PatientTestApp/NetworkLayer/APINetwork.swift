//
//  APINetwork.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
    
    func map<B>(f: (Body) -> B) -> HttpMethod<B> {
        switch self {
        case .get: return .get
        case .post(let body):
            return .post(f(body))
        }
        
    }
}

final class WebService {
    
    func load<A>(_ resource: Resource<A>, completion: @escaping (Result<A>) -> ()) {
        let request = URLRequest(resource: resource)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else{
                completion(.error(error!, data))
                return
            }
            /// Get response headers
            guard let data = data else {
                completion(.error(error!, nil))
                return
            }
            /// Success
            if 200...299 ~= httpResponse.statusCode{
                if let parseResult = resource.parse(data) {
                    completion(Result(parseResult, data: data))
                } else {
                    completion(Result(error:error!, data: data))
                }
            }else{
                /// Prepare error dictionary
                let errorDict = [kErrCode: httpResponse.statusCode, kErrMessage: kErrMsgServer] as [String : Any]
                debugPrint(errorDict)
                completion(.error(error!, data))
            }
            return
        }).resume()
    }
}

extension URLRequest{
    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        self.httpMethod = resource.method.method
        if case let .post(data) = resource.method {
            self.httpBody = data
        }
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.setValue("O", forHTTPHeaderField: "X-OB-Channel")
    }
}
