//
//  CountriesViewController.swift
//  Know Your Country
//
//  Created by Abilash Francis on 29/8/21.
//

import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var countriesTableView: UITableView!
    
    lazy var viewModel: CountriesViewModel = {
        return CountriesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    func initViewModel() {
        
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.countriesTableView.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.countriesTableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.countriesTableView.reloadData()
            }
        }
        
        viewModel.initFetch()

    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CountryDetailViewController,
           let selectedRow = sender as? CountryTableViewCell,
           let indexPath = countriesTableView.indexPath(for: selectedRow){
            destination.viewModel.selectedCountry = viewModel.getCountryFrom(indexPath.section, for: indexPath.row)
        }
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionIndexTitles
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell else {
            fatalError("Cell does not exist in Storyboard !!")
        }
        
        if let country = viewModel.getCountryFrom(indexPath.section, for: indexPath.row) {
            cell.countryLabel.text = country.name
            cell.imageView?.image = viewModel.getCountryFlagFor(country.alpha2Code)
            cell.imageView?.layer.borderColor = UIColor.black.cgColor
            cell.imageView?.layer.borderWidth = 1
            cell.imageView?.layer.cornerRadius = 4
            cell.imageView?.clipsToBounds = true
        }
        return cell
    }

}


extension CountriesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), searchText.count > 0 else {
            viewModel.clearFilter()
            return
        }
        viewModel.filterCountriesWith(searchText)
    }
}
