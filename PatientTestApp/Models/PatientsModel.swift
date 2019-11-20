//
//  PatientsModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

struct PatientsModel: Codable {
    
    var patientID : Int?
    var patientName: String?
    
    enum CodingKeys: String, CodingKey {
        case patientID = "Id"
        case patientName = "FirstName"
    }

}

struct PatientsResultsModel {
    
    var results = [PatientsModel]()
    init(patientList: [PatientsModel]) {
        self.results = patientList
    }
}
