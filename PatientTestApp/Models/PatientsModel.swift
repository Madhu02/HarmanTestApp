//
//  PatientsModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

// MARK: - Patient Model
struct Patient: Codable {
    
    var patients: [PatientList]
    enum CodingKeys: String, CodingKey {
        case patients = "patients"
    }
}

// MARK: - Patients List
struct PatientList: Codable {
    var id: Int
    var firstName: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case firstName = "FirstName"
    }
}
