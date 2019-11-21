//
//  ViewController.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
//    var tokenViewModel = PatientViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    func fetchAuthToken(username:String, password:String, completion: @escaping (_ tokenResponse: AuthToken?,_ error: Error?) -> ()) {
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
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let usernameField = usernameTextfield.text, let passwordField = passwordTextfield.text, !usernameField.isEmpty, !passwordField.isEmpty else {
            ShowAlert()
            return
        }
        createSpinnerView()
        
        fetchAuthToken(username: self.usernameTextfield.text!, password: self.passwordTextfield.text!) { (token, errorObj) in
            DataManager.shared.authToken = token
            DispatchQueue.main.async {
                self.hideSpinnerView()
                self.performSegue(withIdentifier: "patientList", sender: self)
            }
        }
    }
    func ShowAlert() {
        let alertController = UIAlertController(title: "Alert..!!", message:
            "Username and Password is Required", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
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
        let child = SpinnerViewController()
        child.removeFromParent()
    }
    
}

extension ViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

