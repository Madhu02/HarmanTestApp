//
//  PatientDetailViewController.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import UIKit

class PatientDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLAbel: UILabel!
    @IBOutlet weak var NHSNumber: UILabel!
    
    var patientData = PatientViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchPatientDetails { (data, error) in
            print(data)
        }
    }
    
    init(patientdetails:PatientViewModel) {
        self.patientData = patientdetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func fetchPatientDetails(completion: @escaping (_ response:PatientDetails?, _ error:Error?) -> ()){
        
        let resource = URLFactory.preparePatientDetailsResource(Id: self.patientData.id)
        WebService().load(resource!) { (result) in
            switch result{
            case .error(let error, _):
                completion(nil, error)
            case .success(let response, _):
                print(response)
                completion(response,nil)
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
