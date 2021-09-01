//
//  CountriesViewModel.swift
//  Know Your Country
//
//  Created by Abilash Francis on 29/8/21.
//

import UIKit

class CountriesViewModel {
    
    let apiService: APIServiceProtocol
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var countries: [Country]?
    
    var groups: [String : [Country]]?
    
    var sections: [(letter: String, countries: [Country])]?
    
    var numberOfSections: Int {
        return sections?.count ?? 0
    }
    
    var sectionIndexTitles: [String]? {
        return groups?.keys.sorted()
    }
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchAllCountries { [weak self] (success, countries, error) in

            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.localizedDescription
            } else {
                
                guard let countries = countries else {
                    self?.alertMessage = "Error in fetching Countries."
                    return
                }
                self?.countries = countries
                
                self?.groupCountriesByAlphabets(countries)
            }
        }
    }
    
    func groupCountriesByAlphabets(_ countries: [Country]) {
        let groups = Dictionary(grouping: countries) { (country) -> String in
            return String(country.name.first!)
        }
        self.groups = groups
        
        self.sections = groups.map { (key: String, value: [Country]) -> (letter: String, countries: [Country]) in
            (letter: key, countries: value)
        }
        .sorted { (left, right) -> Bool in
            left.letter < right.letter
        }
            
        DispatchQueue.main.async {
            self.reloadTableViewClosure?()
        }
    }
    
    func numberOfRowsIn(_ section: Int) -> Int {
        return sections?[section].countries.count ?? 0
    }
    
    func sectionTitle(_ section: Int) -> String? {
        if let sectionTitle = sections?[section].letter {
            return String(sectionTitle)
        }
        return nil
    }
    
    func getCountryFrom(_ section: Int, for index: Int) -> Country? {
        return sections?[section].countries[index]
    }
    
    func getCountryFlagFor(_ code: String) -> UIImage? {
        return UIImage(named: code.lowercased())
    }
    
    func filterCountriesWith(_ searchText: String) {
        
        guard let filteredCountries = countries?.filter({ (country) -> Bool in
            return country.name.lowercased().contains(searchText.lowercased())
        }) else { return }
        
        groupCountriesByAlphabets(filteredCountries)
    }
    
    func clearFilter() {
        if let countries = countries {
            groupCountriesByAlphabets(countries)
        }
    }
}
