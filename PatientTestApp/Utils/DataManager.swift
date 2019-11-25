//
//  DataManager.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation
//Singleton Class
class DataManager : NSObject {
    
    /**
     This Class stores the Auth Token
        - shared: Shared instance of DataManager
        - authToken: Stores the instance of AuthToken model class.
    */
    static let shared = DataManager()
    private override init() {}
    
    var authToken: AuthToken?
    
}
