//
//  PatientDetailsModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

//{
//    "Id": 2,
//    "FirstName": "Marie",
//    "LastName": "Ray",
//    "Address": "733 Bright Court\nSouth Nicole, ID 93304",
//    "NhsNumber": "2131768507"
//}

struct PatientDetails: Decodable {
    var Id: Int?
    var FirstName: String?
    var LastName: String?
    var Address: String?
    var NhsNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case FirstName = "FirstName"
        case LastName = "LastName"
        case Address = "Address"
        case NhsNumber = "NhsNumber"

    }
}
