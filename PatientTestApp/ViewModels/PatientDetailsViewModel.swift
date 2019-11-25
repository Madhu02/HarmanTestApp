//
//  PatientDetailsViewModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import UIKit

class PatientDetailsViewModel: NSObject {
    //Holds the Patient Id
    var Id: String?
    
    var apiHandler = WebService()
    fileprivate var patientDetails = PatientDetails()
    
    //init
    override init() {
        
    }
    //Custom init for Dependency Injection
    init(patientId:String) {
        self.Id = patientId
    }
    
    //API Call for fetching Patient Details
    func fetchPatientDetails(completion: @escaping (_ response:PatientDetails?, _ error:Error?) -> ()){
        
        let resource = URLFactory.preparePatientDetailsResource(Id: self.Id!)
        apiHandler.load(resource!) { (result) in
            switch result{
            case .error(let error, _):
                completion(nil, error)
            case .success(let response, _):
                print(response)
                self.patientDetails = response
                completion(response,nil)
            }
            
        }
    }
    //Returns Patient Details
    func getPatientDetails() -> PatientDetails {
        return patientDetails
    }
    
}
