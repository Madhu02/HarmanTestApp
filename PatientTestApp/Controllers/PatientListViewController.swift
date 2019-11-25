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
    
    var viewModel = PatientViewModel()
    var searchActive : Bool = false
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.]
        self.navigationItem.title = "Patients List"
                
        viewModel.fetchPatientsList { [weak self] (arrPatients, error) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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
}
//MARK: UITableview and UISearchBar Delegate and DataSource Methods
extension PatientListViewController : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if (viewModel.isSearched) {
            return viewModel.getFilteredPatientData()
        }
        return viewModel.getNoOfRowsForSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let patientVM = viewModel.getPatientAtIndex(atIndex: indexPath.row)
        if (searchBar.text!.count > 0) {
            cell.textLabel?.text = "Name: \(patientVM.firstName)"
            cell.detailTextLabel?.text = "Id: \(patientVM.id)"
            return cell
        }
        else {
            cell.textLabel?.text = "Name: \(patientVM.firstName)"
            cell.detailTextLabel?.text = "Id: \(patientVM.id)"
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let patientDetialVC = storyboard?.instantiateViewController(withIdentifier: "DetailController") as! PatientDetailViewController
        let patientDetails = viewModel.getPatientAtIndex(atIndex: indexPath.row)
        if (searchBar.text!.count > 0) {
            let patientID = String(patientDetails.id)
            patientDetialVC.patientId = patientID
            
        } else {
            let patientID = String(patientDetails.id)
            patientDetialVC.patientId = patientID
        }
        self.navigationController?.pushViewController(patientDetialVC, animated: true)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
        viewModel.filteredArray.removeAll()
        let filteredArrModelTemp = viewModel.dataSourceArray.filter { ($0.firstName.contains(textSearched))}
        viewModel.filteredArray = filteredArrModelTemp
        viewModel.isSearched = true
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.isSearched = false
        self.tableView.reloadData()
    }
    
}
