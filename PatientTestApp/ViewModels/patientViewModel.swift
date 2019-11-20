//
//  patientViewModel.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation

class PatientViewModel {
    
    var id: Int
    var firstName: String
    
    init(patientlist: PatientList) {
        self.id = patientlist.id
        self.firstName = patientlist.firstName
    }
    
    
    
    class func fetchAuthToken(username:String, password:String, completion: @escaping (_ tokenResponse: AuthToken?,_ error: Error?) -> ()) {
        guard let resource = URLFactory.prepareAuthTokenResource(username: username, password: password) else { return }
        WebService().load(resource) { (result) in
            switch result{
            case .error(let error, _):
                completion(nil, error)
            case .success(let response, _):
                print(response)
                completion(response,nil)
            }
        }
    }
    
}
