//
//  PatientDetailsViewModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import UIKit

class PatientDetailsViewModel: NSObject {

    var Id: Int?
    var FirstName: String?
    var LastName: String?
    var Address: String?
    var NhsNumber: String?
    
    init(patientlist: PatientDetails) {
        self.Id = patientlist.Id
        self.FirstName = patientlist.FirstName
        self.LastName = patientlist.LastName
        self.Address = patientlist.Address
        self.NhsNumber = patientlist.NhsNumber
    }

    
}
