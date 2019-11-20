//
//  TokenModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

struct AuthToken: Decodable {
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}
