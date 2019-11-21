//
//  APINetwork.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation
///HTTP Mesthods
enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    /// returns String for respective HttpMethod
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
    /// Maps body with HTTP Method
    func map<B>(f: (Body) -> B) -> HttpMethod<B> {
        switch self {
        case .get: return .get
        case .post(let body):
            return .post(f(body))
        }
        
    }
}

final class WebService {
    
    /**
    This makes an async call to server to load data.
    - Parameters:
       - resource: Takes a resource of Type.A which contains the HTTP Method and the URL.
       - completion: A escaping closure which returns the Result which contain the Model of Type.A or Error if any.
    */
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
                completion(.error(error, data))
            }
            return
        }).resume()
    }
}
///Extension of URLRequest

extension URLRequest{
    /**
    Initializer which create the URLRequest by assigning URL, HTTPMethod, and other HTTPHeaderField.
    - Parameters:
       - resource: Takes a resource of Type.A and assigns the URL, Method type from Resource.
    */
    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        self.httpMethod = resource.method.method
        if case let .post(data) = resource.method {
            self.httpBody = data
        }
        self.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        if let token = DataManager.shared.authToken?.token {
            self.setValue(token, forHTTPHeaderField: "token")
        }
    }
}
