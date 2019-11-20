//
//  DataManager.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

class DataManager : NSObject {
    
    
    static let shared = DataManager()
    private override init() {}
    
    var authToken: AuthToken?
    
}
