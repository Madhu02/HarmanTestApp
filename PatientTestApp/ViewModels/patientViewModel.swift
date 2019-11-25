//
//  patientViewModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

class PatientViewModel {
    
    var apiHandler = WebService()
    var dataSourceArray = [PatientList]()
    var filteredArray = [PatientList]()
    var isSearched: Bool = false
    
    //API Call for fetching Patients List
    func fetchPatientsList(completion: @escaping (_ response:Patient?, _ error:Error?) -> ()){
        
        let resource = URLFactory.preparePatientsResource()
        apiHandler.load(resource!) { (result) in
            switch result{
            case .error(let error, _):
                completion(nil, error)
            case .success(let response, _):
                print(response)
                let patients = response.patients
                self.dataSourceArray = patients
                completion(response,nil)
            }
            
        }
    }
    //Returns PatientsList Count
    func getNoOfRowsForSection() -> Int {
        if !isSearched {
            return dataSourceArray.count
        }
        return filteredArray.count
    }
    //Returns Patient Data Filtered and Un-filtered.
    func getPatientAtIndex(atIndex: Int) -> PatientList {
        if !isSearched {
            let patient = dataSourceArray[atIndex]
            return patient
        } else {
            let patient = filteredArray[atIndex]
            return patient
        }
        
    }
    //Returns Patients Filtered Count.
    func getFilteredPatientData() -> Int {
        return filteredArray.count
    }
    
    
}
