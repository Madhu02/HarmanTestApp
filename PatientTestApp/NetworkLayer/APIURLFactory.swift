//
//  APIURLFactory.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

class URLFactory {
    
    let baseURL = "https://swsopendev.pythonanywhere.com"
    
    static let shared = URLFactory()
    private init() { }
    
    class func GetPatientsURL() -> URL {
        let urlString = "\(URLFactory.shared.baseURL)/androidtest/patients"
        return URL(string: urlString)!
    }
    class func GetAuthTokenURL() -> URL {
        let urlString = "\(URLFactory.shared.baseURL)/androidtest/auth"
        return URL(string: urlString)!
    }

    class func prepareAuthTokenResource() -> Resource<AuthToken>? {
        let url = URLFactory.GetAuthTokenURL()
        let userCred = [
            "EmailAddress": "swsinterviewcandidate@shearwatersystems.com",
            "Password" : "Test1234!"
        ]
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(userCred)
        return Resource(url: url, method: .post(jsonData)) { (data) in
            do {
                    let decoder = JSONDecoder()
                let responseData = try decoder.decode(AuthToken.self, from: data as! Data)
                    return responseData
                } catch {
                    print(error)
                }
                return nil

            }
        
        }
    
//    class func preparePatientsResource() -> Resource<PatientsModel> {
//        
//    }
    
}
