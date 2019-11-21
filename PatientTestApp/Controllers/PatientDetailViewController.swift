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
    @IBOutlet weak var cardView: UIView!

    var patientId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Patient Details"

        MakeAPICall()
    }

    func createSpinnerView() {
        let child = SpinnerViewController()
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func hideSpinnerView(){
        self.children.forEach({ $0.willMove(toParent: nil); $0.view.removeFromSuperview(); $0.removeFromParent() })
    }
    func MakeAPICall(){
        createSpinnerView()
        fetchPatientDetails { (patientDetailsData, error) in
            let patientDetailViewModel = PatientDetailsViewModel(patientlist: patientDetailsData!)
            DispatchQueue.main.async {
                self.hideSpinnerView()
                
                if let firstname = patientDetailViewModel.FirstName, let lastname = patientDetailViewModel.LastName {
                    self.nameLabel.text = "Name: \(lastname.uppercased()), \(firstname)"
                }
                if let address = patientDetailViewModel.Address,let nhsNumer = patientDetailViewModel.NhsNumber  {
                    self.addressLAbel.text = "Address: \(address)"
                    self.NHSNumber.text = "NSHNumber: \(nhsNumer)"
                }
            }
        }
    }
    
    func fetchPatientDetails(completion: @escaping (_ response:PatientDetails?, _ error:Error?) -> ()){
        
        let resource = URLFactory.preparePatientDetailsResource(Id: self.patientId)
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
