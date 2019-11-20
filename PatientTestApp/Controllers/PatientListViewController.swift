//
//  PatientListViewController.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 20/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import UIKit

class PatientListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let webservice = WebService()
    var patientViewModel = [PatientViewModel]()
    var filteredArrModel = [PatientViewModel]()
    var searchActive : Bool = false

    lazy var searchBar:UISearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.]
        self.navigationItem.title = "Patients List"
        fetchPatientsList { (arrPatients, error) in

            self.patientViewModel = arrPatients?.patients.map({ return PatientViewModel(patientlist: $0) }) ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        setupViewElements()
    }


    func setupViewElements(){
        
        self.navigationItem.hidesBackButton = true
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.showsCancelButton = true
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        if #available(iOS 11.0, *) {
            navigationController!.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }

    }
    
    func fetchPatientsList(completion: @escaping (_ response:Patient?, _ error:Error?) -> ()){
        
        let resource = URLFactory.preparePatientsResource()
        webservice.load(resource!) { (result) in
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

extension PatientListViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchBar.text!.count > 0) {
            return self.filteredArrModel.count
        }
        return self.patientViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if (searchBar.text!.count > 0) {
            let cellViewModel = filteredArrModel[indexPath.row]
            cell.textLabel?.text = "Name: \(cellViewModel.firstName)"
            cell.detailTextLabel?.text = "Id: \(cellViewModel.id)"
            return cell
        }
        else {
            let cellViewModel = patientViewModel[indexPath.row]
            cell.textLabel?.text = "Name: \(cellViewModel.firstName)"
            cell.detailTextLabel?.text = "Id: \(cellViewModel.id)"
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var patientDetialVC = UIViewController()
        if (searchBar.text!.count > 0) {
            let cellViewModel = self.filteredArrModel[indexPath.row]
            patientDetialVC = PatientDetailViewController.init(patientdetails: cellViewModel)
        } else {
            let cellViewModel = self.patientViewModel[indexPath.row]
            patientDetialVC = PatientDetailViewController.init(patientdetails: cellViewModel)
        }
        self.navigationController?.pushViewController(patientDetialVC, animated: true)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
        filteredArrModel.removeAll()
        let filteredArrModelTemp = patientViewModel.filter { ($0.firstName.contains(textSearched))}
        self.filteredArrModel = filteredArrModelTemp
        self.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.tableView.reloadData()
    }

}
