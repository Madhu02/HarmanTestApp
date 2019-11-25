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
    var viewModel = PatientDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Patient Details"
        MakeAPICall()
    }
    
    func MakeAPICall(){
        createSpinnerView()
        
        let customViewModel = PatientDetailsViewModel(patientId: patientId)
        viewModel = customViewModel
        viewModel.fetchPatientDetails { [weak self](patientDetailsData, error) in
            DispatchQueue.main.async {
                self?.hideSpinnerView()
                let patientData = self?.viewModel.getPatientDetails()
                if let firstname = patientData?.FirstName, let lastname = patientData?.LastName {
                    self?.nameLabel.text = "Name: \(lastname.uppercased()), \(firstname)"
                }
                if let address = patientData?.Address,let nhsNumer = patientData?.NhsNumber  {
                    self?.addressLAbel.text = "Address: \(address)"
                    self?.NHSNumber.text = "NSHNumber: \(nhsNumer)"
                }
            }
        }
        
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
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
}
